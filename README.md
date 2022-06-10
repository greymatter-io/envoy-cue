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

