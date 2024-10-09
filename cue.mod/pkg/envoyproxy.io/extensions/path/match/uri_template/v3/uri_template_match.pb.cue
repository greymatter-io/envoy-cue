package v3

// If specified, the route is a template match rule meaning that the
// “:path“ header (without the query string) must match the given
// “path_template“ pattern.
//
// Path template matching types:
//
// * “*“ : Matches a single path component, up to the next path separator: /
//
// * “**“ : Matches zero or more path segments. If present, must be the last operator.
//
// * “{name} or {name=*}“ :  A named variable matching one path segment up to the next path separator: /.
//
//   - “{name=videos/*}“ : A named variable matching more than one path segment.
//     The path component matching videos/* is captured as the named variable.
//
// * “{name=**}“ : A named variable matching zero or more path segments.
//
// For example:
//
// * “/videos/*/*/*.m4s“ would match “videos/123414/hls/1080p5000_00001.m4s“
//
// * “/videos/{file}“ would match “/videos/1080p5000_00001.m4s“
//
// * “/**.mpd“ would match “/content/123/india/dash/55/manifest.mpd“
#UriTemplateMatchConfig: {
	"@type":        "type.googleapis.com/envoy.extensions.path.match.uri_template.v3.UriTemplateMatchConfig"
	path_template?: string
}
