package v3alpha

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

#QatPrivateKeyMethodConfig: {
	"@type": "type.googleapis.com/envoy.extensions.private_key_providers.qat.v3alpha.QatPrivateKeyMethodConfig"
	// Private key to use in the private key provider. If set to inline_bytes or
	// inline_string, the value needs to be the private key in PEM format.
	private_key?: v3.#DataSource
	// How long to wait before polling the hardware accelerator after a
	// request has been submitted there. Having a small value leads to
	// quicker answers from the hardware but causes more polling loop
	// spins, leading to potentially larger CPU usage. The duration needs
	// to be set to a value greater than or equal to 1 millisecond.
	poll_delay?: string
}
