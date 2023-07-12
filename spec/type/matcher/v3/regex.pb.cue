package v3

// A regex matcher designed for safety when used with untrusted input.
#RegexMatcher: {
	"@type": "type.googleapis.com/envoy.type.matcher.v3.RegexMatcher"
	// Google's RE2 regex engine.
	//
	// Deprecated: Do not use.
	google_re2?: #RegexMatcher_GoogleRE2
	// The regex match string. The string must be supported by the configured engine. The regex is matched
	// against the full string, not as a partial match.
	regex?: string
}

// Describes how to match a string and then produce a new string using a regular
// expression and a substitution string.
#RegexMatchAndSubstitute: {
	"@type": "type.googleapis.com/envoy.type.matcher.v3.RegexMatchAndSubstitute"
	// The regular expression used to find portions of a string (hereafter called
	// the "subject string") that should be replaced. When a new string is
	// produced during the substitution operation, the new string is initially
	// the same as the subject string, but then all matches in the subject string
	// are replaced by the substitution string. If replacing all matches isn't
	// desired, regular expression anchors can be used to ensure a single match,
	// so as to replace just one occurrence of a pattern. Capture groups can be
	// used in the pattern to extract portions of the subject string, and then
	// referenced in the substitution string.
	pattern?: #RegexMatcher
	// The string that should be substituted into matching portions of the
	// subject string during a substitution operation to produce a new string.
	// Capture groups in the pattern can be referenced in the substitution
	// string. Note, however, that the syntax for referring to capture groups is
	// defined by the chosen regular expression engine. Google's `RE2
	// <https://github.com/google/re2>`_ regular expression engine uses a
	// backslash followed by the capture group number to denote a numbered
	// capture group. E.g., ``\1`` refers to capture group 1, and ``\2`` refers
	// to capture group 2.
	substitution?: string
}

// Google's `RE2 <https://github.com/google/re2>`_ regex engine. The regex string must adhere to
// the documented `syntax <https://github.com/google/re2/wiki/Syntax>`_. The engine is designed
// to complete execution in linear time as well as limit the amount of memory used.
//
// Envoy supports program size checking via runtime. The runtime keys ``re2.max_program_size.error_level``
// and ``re2.max_program_size.warn_level`` can be set to integers as the maximum program size or
// complexity that a compiled regex can have before an exception is thrown or a warning is
// logged, respectively. ``re2.max_program_size.error_level`` defaults to 100, and
// ``re2.max_program_size.warn_level`` has no default if unset (will not check/log a warning).
//
// Envoy emits two stats for tracking the program size of regexes: the histogram ``re2.program_size``,
// which records the program size, and the counter ``re2.exceeded_warn_level``, which is incremented
// each time the program size exceeds the warn level threshold.
#RegexMatcher_GoogleRE2: {
	"@type": "type.googleapis.com/envoy.type.matcher.v3.RegexMatcher_GoogleRE2"
	// This field controls the RE2 "program size" which is a rough estimate of how complex a
	// compiled regex is to evaluate. A regex that has a program size greater than the configured
	// value will fail to compile. In this case, the configured max program size can be increased
	// or the regex can be simplified. If not specified, the default is 100.
	//
	// This field is deprecated; regexp validation should be performed on the management server
	// instead of being done by each individual client.
	//
	// .. note::
	//
	//  Although this field is deprecated, the program size will still be checked against the
	//  global ``re2.max_program_size.error_level`` runtime value.
	//
	//
	// Deprecated: Do not use.
	max_program_size?: uint32
}
