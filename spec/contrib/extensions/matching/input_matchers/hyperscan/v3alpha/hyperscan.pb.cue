package v3alpha

// `Hyperscan <https://github.com/intel/hyperscan>`_ regex matcher. The matcher uses the Hyperscan
// engine which exploits x86 SIMD instructions to accelerate matching large numbers of regular
// expressions simultaneously across streams of data.
#Hyperscan: {
	"@type": "type.googleapis.com/envoy.extensions.matching.input_matchers.hyperscan.v3alpha.Hyperscan"
	// Specifies a set of regex expressions that the input should match on.
	regexes?: [...#Hyperscan_Regex]
}

// [#next-free-field: 11]
#Hyperscan_Regex: {
	"@type": "type.googleapis.com/envoy.extensions.matching.input_matchers.hyperscan.v3alpha.Hyperscan_Regex"
	// The regex expression.
	//
	// The expression must represent only the pattern to be matched, with no delimiters or flags.
	regex?: string
	// The ID of the regex expression.
	//
	// This option is designed to be used on the sub-expressions in logical combinations.
	id?: uint32
	// Matching will be performed case-insensitively.
	//
	// The expression may still use PCRE tokens (notably “(?i)“ and “(?-i)“) to switch
	// case-insensitive matching on and off.
	caseless?: bool
	// Matching a “.“ will not exclude newlines.
	dot_all?: bool
	// “^“ and “$“ anchors match any newlines in data.
	multiline?: bool
	// Allow expressions which can match against an empty string.
	//
	// This option instructs the compiler to allow expressions that can match against empty buffers,
	// such as “.?“, “.*“, “(a|)“. Since Hyperscan can return every possible match for an expression,
	// such expressions generally execute very slowly.
	allow_empty?: bool
	// Treat the pattern as a sequence of UTF-8 characters.
	utf8?: bool
	// Use Unicode properties for character classes.
	//
	// This option instructs Hyperscan to use Unicode properties, rather than the default ASCII
	// interpretations, for character mnemonics like “\w“ and “\s“ as well as the POSIX character
	// classes. It is only meaningful in conjunction with “utf8“.
	ucp?: bool
	// Logical combination.
	//
	// This option instructs Hyperscan to parse this expression as logical combination syntax.
	// Logical constraints consist of operands, operators and parentheses. The operands are
	// expression indices, and operators can be “!“, “&“ or “|“.
	combination?: bool
	// Don’t do any match reporting.
	//
	// This option instructs Hyperscan to ignore match reporting for this expression. It is
	// designed to be used on the sub-expressions in logical combinations.
	quiet?: bool
}
