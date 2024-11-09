package enterchroot

import (
	"fmt"
	"os"
	"os/exec"
	"syscall"

	"github.com/moby/sys/mountinfo"
	"github.com/pkg/errors"
	"github.com/sirupsen/logrus"
	"golang.org/x/sys/unix"
)

func mountProc() error {
	if ok, err := mountinfo.Mounted("/proc"); ok && err == nil {
		return nil
	}
	logrus.Debug("mkdir /proc")
	if err := os.MkdirAll("/proc", 0755); err != nil {
		return err
	}
	logrus.Debug("mount /proc")
	return syscall.Mount("proc", "/proc", "proc", 0, "")
}

func mountDev() error {
	if files, err := os.ReadDir("/dev"); err == nil && len(files) > 2 {
		return nil
	}
	logrus.Debug("mkdir /dev")
	if err := os.MkdirAll("/dev", 0755); err != nil {
		return err
	}
	logrus.Debug("mounting /dev")
	return syscall.Mount("none", "/dev", "devtmpfs", 0, "")
}

func mknod(path string, mode uint32, major, minor int) error {
	if _, err := os.Stat(path); err == nil {
		return nil
	}

	dev := int((major << 8) | (minor & 0xff) | ((minor & 0xfff00) << 12))
	logrus.Debugf("mknod %s", path)
	return unix.Mknod(path, mode, dev)
}

func ensureloop() error {
	if err := mountProc(); err != nil {
		return errors.Wrapf(err, "failed to mount proc")
	}
	if err := mountDev(); err != nil {
		return errors.Wrapf(err, "failed to mount dev")
	}

	// ignore error
	exec.Command("modprobe", "loop").Run()

	if err := mknod("/dev/loop-control", 0700|unix.S_IFCHR, 10, 237); err != nil {
		return err
	}
	for i := 0; i < 7; i++ {
		if err := mknod(fmt.Sprintf("/dev/loop%d", i), 0700|unix.S_IFBLK, 7, i); err != nil {
			return err
		}
	}

	return nil
}
