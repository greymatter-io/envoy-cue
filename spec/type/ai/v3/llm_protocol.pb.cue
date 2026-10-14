package v3

// Identifies the AI API contract spoken on the wire.
//
// This names request/response schemas and streaming event semantics, not the
// organization operating the backend: OpenAI, Azure OpenAI, vLLM, and any
// other OpenAI-compatible backend all speak “OPENAI_CHAT_COMPLETIONS“.
// Provider identity, when needed, must come from configuration or routing
// metadata.
//
// Response framing is separate: JSON, SSE, and streamed JSON-array variants
// of the same API share one “LLMProtocol“ value.
#LLMProtocol: "LLM_PROTOCOL_UNSPECIFIED" | "OPENAI_CHAT_COMPLETIONS" | "OPENAI_RESPONSES" | "ANTHROPIC_MESSAGES" | "GEMINI_GENERATE_CONTENT"

LLMProtocol_LLM_PROTOCOL_UNSPECIFIED: "LLM_PROTOCOL_UNSPECIFIED"
LLMProtocol_OPENAI_CHAT_COMPLETIONS:  "OPENAI_CHAT_COMPLETIONS"
LLMProtocol_OPENAI_RESPONSES:         "OPENAI_RESPONSES"
LLMProtocol_ANTHROPIC_MESSAGES:       "ANTHROPIC_MESSAGES"
LLMProtocol_GEMINI_GENERATE_CONTENT:  "GEMINI_GENERATE_CONTENT"
