package envoycue

import (
	"embed"
)

// CueFS embeds envoyproxy.io/envoy-cue CUE definitions as a virtual filesystem.
//
//go:embed spec/**/*
var CueFS embed.FS

// CuePackageName is the cue.mod/pkg tree name
const CuePackageName = "envoyproxy.io/envoy-cue"

// GoPackageName is the go mod import name
const GoPackageName = "github.com/greymatter-io/envoy-cue"
