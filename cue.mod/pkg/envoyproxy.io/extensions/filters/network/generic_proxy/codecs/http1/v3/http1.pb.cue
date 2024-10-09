package v3

import (
	wrapperspb "envoyproxy.io/deps/protobuf/types/known/wrapperspb"
)

// Configuration for HTTP codec. This HTTP1 codec is used to parse and serialize HTTP1 messages
// for the generic proxy filter.
// Any decoding error will result in the generic proxy closing the connection.
//
// .. note::
//
//	This codec only supports HTTP1.1 messages and does not support HTTP1.0 messages. And it limits
//	part of the HTTP1.1 features, such as upgrade, connect, etc.
//	This codec is mainly designed for the features evaluation of the generic proxy filter. Please
//	be cautious when using it in production.
#Http1CodecConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.generic_proxy.codecs.http1.v3.Http1CodecConfig"
	// If true, the codec will parse and serialize HTTP1 messages in a single frame per message.
	//
	// A frame is a minimal unit of data that can be processed by the generic proxy. If false, the
	// codec will parse and serialize HTTP1 messages in a streaming way. In this case, the codec
	// will output multiple frames for a single HTTP1 message to the generic proxy.
	// If true, the codec will buffer the entire HTTP1 message body before sending it to the generic
	// proxy. This may have better performance in small message scenarios and is more friendly to
	// handle the HTTP1 message body. This also may result in higher memory usage and latency if
	// the message body is large.
	//
	// Default is true.
	single_frame_mode?: wrapperspb.#BoolValue
	// The maximum size of the HTTP1 message body in bytes. If not set, 8*1024*1024 (8MB) is used.
	// This only makes sense when single_frame_mode is true.
	// If the HTTP1 message body size exceeds this value, this will result in a decoding error
	// and the generic proxy will close the connection.
	max_buffer_size?: wrapperspb.#UInt32Value
}
