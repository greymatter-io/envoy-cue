package v3

// The CPU utilization resource monitor reports the Envoy process the CPU Utilization of the entire host.
// Today, this only works on Linux and is calculated using the stats in the /proc/stat file.
#CpuUtilizationConfig: {
	"@type": "type.googleapis.com/envoy.extensions.resource_monitors.cpu_utilization.v3.CpuUtilizationConfig"
}
