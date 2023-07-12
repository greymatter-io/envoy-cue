package type

// Envoy uses SemVer (https://semver.org/). Major/minor versions indicate
// expected behaviors and APIs, the patch version field is used only
// for security fixes and can be generally ignored.
#SemanticVersion: {
	"@type":       "type.googleapis.com/envoy.type.SemanticVersion"
	major_number?: uint32
	minor_number?: uint32
	patch?:        uint32
}
