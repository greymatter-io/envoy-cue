package v3

#CpuUtilizationConfig_UtilizationComputeStrategy: "HOST" | "CONTAINER"

CpuUtilizationConfig_UtilizationComputeStrategy_HOST:      "HOST"
CpuUtilizationConfig_UtilizationComputeStrategy_CONTAINER: "CONTAINER"

// The CPU utilization resource monitor reports the Envoy process the CPU Utilization across different platforms.
#CpuUtilizationConfig: {
	"@type": "type.googleapis.com/envoy.extensions.resource_monitors.cpu_utilization.v3.CpuUtilizationConfig"
	mode?:   #CpuUtilizationConfig_UtilizationComputeStrategy
}
