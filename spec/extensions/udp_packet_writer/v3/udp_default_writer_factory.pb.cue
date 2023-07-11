package v3

// Configuration for the default UDP packet writer factory which simply
// uses the kernel's sendmsg() to send UDP packets.
#UdpDefaultWriterFactory: {
	"@type": "type.googleapis.com/envoy.extensions.udp_packet_writer.v3.UdpDefaultWriterFactory"
}
