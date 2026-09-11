package v3alpha

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

#KaePrivateKeyMethodConfig: {
	"@type": "type.googleapis.com/envoy.extensions.private_key_providers.kae.v3alpha.KaePrivateKeyMethodConfig"
	// Private key to use in the private key provider. If set to inline_bytes or
	// inline_string, the value needs to be the private key in PEM format.
	private_key?: v3.#DataSource
	// How long to wait before polling the hardware accelerator after a
	// request has been submitted there. Having a small value leads to
	// quicker answers from the hardware but causes more polling loop
	// spins, leading to potentially larger CPU usage. The duration needs
	// to be set to a value greater than or equal to 1 millisecond.
	poll_delay?: string
	// The number of instances to start during initialization.
	// Too many instances may create a large number of threads, increasing resource usage and potential overhead.
	// max_instances must be at least 1.
	max_instances?: uint32
}
