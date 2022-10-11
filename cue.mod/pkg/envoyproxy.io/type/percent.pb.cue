package type

// Fraction percentages support several fixed denominator values.
#FractionalPercent_DenominatorType: "HUNDRED" | "TEN_THOUSAND" | "MILLION"

FractionalPercent_DenominatorType_HUNDRED:      "HUNDRED"
FractionalPercent_DenominatorType_TEN_THOUSAND: "TEN_THOUSAND"
FractionalPercent_DenominatorType_MILLION:      "MILLION"

// Identifies a percentage, in the range [0.0, 100.0].
#Percent: {
	"@type": "type.googleapis.com/envoy.type.Percent"
	value?:  float64
}

// A fractional percentage is used in cases in which for performance reasons performing floating
// point to integer conversions during randomness calculations is undesirable. The message includes
// both a numerator and denominator that together determine the final fractional value.
//
// * **Example**: 1/100 = 1%.
// * **Example**: 3/10000 = 0.03%.
#FractionalPercent: {
	"@type": "type.googleapis.com/envoy.type.FractionalPercent"
	// Specifies the numerator. Defaults to 0.
	numerator?: uint32
	// Specifies the denominator. If the denominator specified is less than the numerator, the final
	// fractional percentage is capped at 1 (100%).
	denominator?: #FractionalPercent_DenominatorType
}
