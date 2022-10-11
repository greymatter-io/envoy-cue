package v3

// Google's `RE2 <https://github.com/google/re2>`_ regex engine. The regex string must adhere to
// the documented `syntax <https://github.com/google/re2/wiki/Syntax>`_. The engine is designed
// to complete execution in linear time as well as limit the amount of memory used.
//
// Envoy emits two stats for tracking the program size of regexes: the histogram ``re2.program_size``,
// which records the program size, and the counter ``re2.exceeded_warn_level``, which is incremented
// each time the program size exceeds the warn level threshold.
#GoogleRE2: {
	"@type": "type.googleapis.com/envoy.extensions.regex_engines.v3.GoogleRE2"
}
