# envoy-cue

CUE schemas for Envoy configurations.

## What's Included

Every Envoy config is converted to a corresponding CUE representation by a
scheduled nightly job, and committed to the **envoy** branch in this repo.
These updates are periodically merged.

## Methodology

The Envoy project defines all its config schemas as Protobuf, but right now
Protobuf to CUE conversion is difficult in the case of large trees of .proto
files. Instead, we generate CUE from the Go structs defined in
[go-control-plane](https://github.com/envoyproxy/go-control-plane), becuase
that conversion is a lot simpler, thanks to Go's built in `ast` package.

## Use as a dependency

CUE does not yet have support for package management at the scale of systems like NPM
or Go modules. To emulate the transfer and upgrading of CUE modules, 
[git submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules) are commonly used.

In the project that uses these CUE definitions:
1. Run `cue mod init` (if you haven't already done so)
    a. Edit the `cue.mod/module.cue` file to contain a module name for the project
2. Run `mkdir -p cue.mod/pkg/envoyproxy.io`
3. Run `git submodule add git@github.com:greymatter-io/envoy-cue cue.mod/pkg/envoyproxy.io/envoy-cue`

To update the submodule, run: `git submodule update --remote --init`

When importing the definitions in the module, use the prefix `"envoyproxy.io/envoy-cue"` (the module name). For exmaple, importing the 
RBAC HTTP filter definition would look like: 
```
	import "envoyproxy.io/envoy-cue/spec/extensions/filters/http/rbac/v3"
```





