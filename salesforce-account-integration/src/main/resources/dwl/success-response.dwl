%dw 2.0
output application/json
---
/**
 * Success Response Mapping
 * Creates standardized success response format for Salesforce upsert results
 */
{
    timestamp: now() as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"},
    correlationId: uuid(),
    status: "SUCCESS",
    summary: {
        totalRecords: sizeOf(payload),
        successfulRecords: sizeOf(payload filter $.success == true),
        failedRecords: sizeOf(payload filter $.success == false),
        createdRecords: sizeOf(payload filter ($.success == true and $.created == true)),
        updatedRecords: sizeOf(payload filter ($.success == true and $.created == false))
    },
    results: payload map (result, index) -> {
        id: result.id,
        success: result.success,
        created: result.created default false,
        errors: result.errors default []
    }
}
