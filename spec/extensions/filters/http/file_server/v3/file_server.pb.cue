package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/extensions/common/async_files/v3"
)

// A :ref:`file server <config_http_filters_file_server>` filter configuration.
// [#next-free-field: 6]
#FileServerConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.file_server.v3.FileServerConfig"
	// A configuration for the AsyncFileManager to be used to read from the filesystem.
	manager_config?: v3.#AsyncFileManagerConfig
	// The longest matching path_mapping takes precedence.
	path_mappings?: [...#FileServerConfig_PathMapping]
	// A map from filename suffix (in lowercase) to content type header.
	// e.g. “{"txt": "text/plain"}“
	//
	// File suffixes may not contain “.“ as the filename suffix after
	// the last “.“ is used to perform an O(1) lookup against the keys.
	//
	// An empty string suffix will only match files ending with a “.“.
	//
	// Files with no suffix (e.g. “README“) can be matched as the full string
	// in lowercase. e.g. “{"readme": "text/plain"}“
	content_types?: [string]: string
	// If “content_types“ does not contain a match for a file suffix,
	// “default_content_type“ is used.
	//
	// If there is no match and “default_content_type“ is empty, the
	// “content-type“ header will be omitted from the response.
	default_content_type?: string
	// If the requested path refers to a directory, the given behaviors are
	// tried in order until one succeeds. If the end of the list is reached
	// with no success, the result is a 403 Forbidden.
	directory_behaviors?: [...#FileServerConfig_DirectoryBehavior]
}

#FileServerConfig_PathMapping: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.file_server.v3.FileServerConfig_PathMapping"
	// If no “request_path_prefix“ is matched, the filter does not intercept a request.
	//
	// If a “request_path_prefix“ is matched, that prefix is removed from the request
	// and replaced with “file_path_prefix“ to form a filesystem path for
	// the request.
	//
	// Prefix “/“ will match all GET requests.
	request_path_prefix?: string
	// Replaces a matched “request_path_prefix“ to form a filesystem path for a
	// request. May be relative to the working directory of the envoy execution,
	// or an absolute path.
	file_path_prefix?: string
}

#FileServerConfig_DirectoryBehavior: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.file_server.v3.FileServerConfig_DirectoryBehavior"
	// Attempts to serve the given file within the directory, e.g. “index.html“.
	// Precisely one of “default_file“ and “list“ must be set per “DirectoryBehavior“.
	default_file?: string
	// Responds with an html formatted list of the files and subdirectories in the directory.
	// Precisely one of “default_file“ and “list“ must be set per “DirectoryBehavior“.
	// [#not-implemented-hide:] Directory operations currently have no async implementation.
	list?: #FileServerConfig_DirectoryBehavior_List
}

// [#not-implemented-hide:] Directory operations currently have no async implementation.
#FileServerConfig_DirectoryBehavior_List: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.file_server.v3.FileServerConfig_DirectoryBehavior_List"
}
