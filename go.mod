module github.com/rancher/k3os

go 1.23.2

require (
	github.com/docker/docker v27.3.1+incompatible
	github.com/ghodss/yaml v1.0.0
	github.com/mattn/go-isatty v0.0.20
	github.com/moby/sys/mountinfo v0.7.2
	github.com/otiai10/copy v1.14.0
	github.com/pkg/errors v0.9.1
	github.com/rancher/mapper v0.0.0-20190814232720-058a8b7feb99
	github.com/sirupsen/logrus v1.9.3
	github.com/urfave/cli v1.22.16
	golang.org/x/sys v0.26.0
	golang.org/x/term v0.25.0
	gopkg.in/freddierice/go-losetup.v1 v1.0.0-20170407175016-fc9adea44124
	pault.ag/go/modprobe v0.1.2
)

require (
	github.com/cpuguy83/go-md2man/v2 v2.0.5 // indirect
	github.com/docker/go-units v0.5.0 // indirect
	github.com/mattn/go-shellwords v1.0.12 // indirect
	github.com/rancher/wrangler/v3 v3.0.0 // indirect
	github.com/russross/blackfriday/v2 v2.1.0 // indirect
	golang.org/x/sync v0.8.0 // indirect
	gopkg.in/yaml.v2 v2.4.0 // indirect
	pault.ag/go/topsort v0.1.1 // indirect
)

replace (
	github.com/rancher/mapper => github.com/Darkness4/mapper v0.1.0
	k8s.io/api => github.com/rancher/kubernetes/staging/src/k8s.io/api v1.31.2
	k8s.io/apiextensions-apiserver => github.com/rancher/kubernetes/staging/src/k8s.io/apiextensions-apiserver v1.31.2
	k8s.io/apimachinery => github.com/rancher/kubernetes/staging/src/k8s.io/apimachinery v1.31.2
	k8s.io/apiserver => github.com/rancher/kubernetes/staging/src/k8s.io/apiserver v1.31.2
	k8s.io/client-go => github.com/rancher/kubernetes/staging/src/k8s.io/client-go v1.31.2
	k8s.io/code-generator => github.com/rancher/kubernetes/staging/src/k8s.io/code-generator v1.31.2
	k8s.io/component-base => github.com/rancher/kubernetes/staging/src/k8s.io/component-base v1.31.2
	k8s.io/kube-aggregator => github.com/rancher/kubernetes/staging/src/k8s.io/kube-aggregator v1.31.2
	k8s.io/metrics => github.com/rancher/kubernetes/staging/src/k8s.io/metrics v1.31.2
)
