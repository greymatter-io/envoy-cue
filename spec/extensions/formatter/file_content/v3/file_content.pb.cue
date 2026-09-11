package v3

// FileContent formatter extension implements the “%FILE_CONTENT(/path/to/file)%“ command operator
// that reads the contents of the specified file. File-based data is automatically re-read when the
// file is modified on disk.
//
// Optionally, a directory to watch for changes can be specified with a
// colon followed by the directory to watch, eg “%FILE_CONTENT(/path/to/file:/path/to/watch)%“.
// See :ref:`watched_directory <envoy_v3_api_field_config.core.v3.DataSource.watched_directory>` for
// detailed semantics.
#FileContent: {
	"@type": "type.googleapis.com/envoy.extensions.formatter.file_content.v3.FileContent"
}
