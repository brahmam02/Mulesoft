%dw 2.0
output application/json
---
/**
 * Error Response Mapping
 * Creates standardized error response format
 * This transformation will be used within error handlers where vars and error are available
 */
{
    timestamp: now() as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"},
    correlationId: payload.correlationId default uuid(),
    error: {
        code: payload.errorCode default "UNKNOWN_ERROR",
        message: payload.errorMessage default "An unexpected error occurred",
        details: payload.errorDetails default "",
        cause: payload.errorCause default null
    },
    request: {
        fileName: payload.fileName default "",
        recordCount: payload.recordCount default 0,
        processedCount: payload.processedCount default 0
    },
    status: "FAILED"
}
