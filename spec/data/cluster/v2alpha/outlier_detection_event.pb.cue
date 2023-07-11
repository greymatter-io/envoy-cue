package v2alpha

// Type of ejection that took place
#OutlierEjectionType: "CONSECUTIVE_5XX" | "CONSECUTIVE_GATEWAY_FAILURE" | "SUCCESS_RATE" | "CONSECUTIVE_LOCAL_ORIGIN_FAILURE" | "SUCCESS_RATE_LOCAL_ORIGIN" | "FAILURE_PERCENTAGE" | "FAILURE_PERCENTAGE_LOCAL_ORIGIN"

OutlierEjectionType_CONSECUTIVE_5XX:                  "CONSECUTIVE_5XX"
OutlierEjectionType_CONSECUTIVE_GATEWAY_FAILURE:      "CONSECUTIVE_GATEWAY_FAILURE"
OutlierEjectionType_SUCCESS_RATE:                     "SUCCESS_RATE"
OutlierEjectionType_CONSECUTIVE_LOCAL_ORIGIN_FAILURE: "CONSECUTIVE_LOCAL_ORIGIN_FAILURE"
OutlierEjectionType_SUCCESS_RATE_LOCAL_ORIGIN:        "SUCCESS_RATE_LOCAL_ORIGIN"
OutlierEjectionType_FAILURE_PERCENTAGE:               "FAILURE_PERCENTAGE"
OutlierEjectionType_FAILURE_PERCENTAGE_LOCAL_ORIGIN:  "FAILURE_PERCENTAGE_LOCAL_ORIGIN"

// Represents possible action applied to upstream host
#Action: "EJECT" | "UNEJECT"

Action_EJECT:   "EJECT"
Action_UNEJECT: "UNEJECT"

// [#next-free-field: 12]
#OutlierDetectionEvent: {
	"@type": "type.googleapis.com/envoy.data.cluster.v2alpha.OutlierDetectionEvent"
	// In case of eject represents type of ejection that took place.
	type?: #OutlierEjectionType
	// Timestamp for event.
	timestamp?: string
	// The time in seconds since the last action (either an ejection or unejection) took place.
	secs_since_last_action?: uint64
	// The :ref:`cluster <envoy_api_msg_Cluster>` that owns the ejected host.
	cluster_name?: string
	// The URL of the ejected host. E.g., ``tcp://1.2.3.4:80``.
	upstream_url?: string
	// The action that took place.
	action?: #Action
	// If ``action`` is ``eject``, specifies the number of times the host has been ejected (local to
	// that Envoy and gets reset if the host gets removed from the upstream cluster for any reason and
	// then re-added).
	num_ejections?: uint32
	// If ``action`` is ``eject``, specifies if the ejection was enforced. ``true`` means the host was
	// ejected. ``false`` means the event was logged but the host was not actually ejected.
	enforced?:                       bool
	eject_success_rate_event?:       #OutlierEjectSuccessRate
	eject_consecutive_event?:        #OutlierEjectConsecutive
	eject_failure_percentage_event?: #OutlierEjectFailurePercentage
}

#OutlierEjectSuccessRate: {
	"@type": "type.googleapis.com/envoy.data.cluster.v2alpha.OutlierEjectSuccessRate"
	// Host’s success rate at the time of the ejection event on a 0-100 range.
	host_success_rate?: uint32
	// Average success rate of the hosts in the cluster at the time of the ejection event on a 0-100
	// range.
	cluster_average_success_rate?: uint32
	// Success rate ejection threshold at the time of the ejection event.
	cluster_success_rate_ejection_threshold?: uint32
}

#OutlierEjectConsecutive: {
	"@type": "type.googleapis.com/envoy.data.cluster.v2alpha.OutlierEjectConsecutive"
}

#OutlierEjectFailurePercentage: {
	"@type": "type.googleapis.com/envoy.data.cluster.v2alpha.OutlierEjectFailurePercentage"
	// Host's success rate at the time of the ejection event on a 0-100 range.
	host_success_rate?: uint32
}
