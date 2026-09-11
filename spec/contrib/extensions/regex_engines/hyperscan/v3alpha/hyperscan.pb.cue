package v3alpha

// `Hyperscan <https://github.com/intel/hyperscan>`_ regex engine. The engine uses hybrid automata
// techniques to allow simultaneous matching of large numbers of regular expressions across streams
// of data.
//
// The engine follows PCRE pattern syntax, and the regex string must adhere to the documented
// `pattern support <https://intel.github.io/hyperscan/dev-reference/compilation.html#pattern-support>`_.
// The syntax is not compatible with the default RE2 regex engine. Depending on configured
// expressions, swapping regex engine may cause match rules to no longer be valid.
#Hyperscan: {
	"@type": "type.googleapis.com/envoy.extensions.regex_engines.hyperscan.v3alpha.Hyperscan"
}
