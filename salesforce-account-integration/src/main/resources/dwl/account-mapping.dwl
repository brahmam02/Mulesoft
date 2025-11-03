%dw 2.0
output application/java
---
/**
 * Account Mapping Transformation
 * Maps input account data to Salesforce Account object format
 * Supports both JSON and CSV input formats
 */
payload map (account, index) -> {
    // Core Account Fields
    Name: account.Name default account.name default account.AccountName default "",
    
    // External ID for upsert operation
    hc_integration_key__c: account.hc_integration_key default account.integration_key default account.Id default "",
    
    // Account Type and Industry
    Type: account.Type default account.'type' default "Customer",
    Industry: account.Industry default account.industry default "",
    
    // Contact Information
    Phone: account.Phone default account.phone default "",
    Fax: account.Fax default account.fax default "",
    Website: account.Website default account.website default "",
    
    // Address Information
    BillingStreet: account.BillingStreet default account.billing_street default account.street default "",
    BillingCity: account.BillingCity default account.billing_city default account.city default "",
    BillingState: account.BillingState default account.billing_state default account.state default "",
    BillingPostalCode: account.BillingPostalCode default account.billing_postal_code default account.postal_code default "",
    BillingCountry: account.BillingCountry default account.billing_country default account.country default "",
    
    // Shipping Address (copy from billing if not provided)
    ShippingStreet: account.ShippingStreet default account.shipping_street default account.BillingStreet default account.billing_street default account.street default "",
    ShippingCity: account.ShippingCity default account.shipping_city default account.BillingCity default account.billing_city default account.city default "",
    ShippingState: account.ShippingState default account.shipping_state default account.BillingState default account.billing_state default account.state default "",
    ShippingPostalCode: account.ShippingPostalCode default account.shipping_postal_code default account.BillingPostalCode default account.billing_postal_code default account.postal_code default "",
    ShippingCountry: account.ShippingCountry default account.shipping_country default account.BillingCountry default account.billing_country default account.country default "",
    
    // Financial Information
    AnnualRevenue: account.AnnualRevenue default account.annual_revenue default null,
    NumberOfEmployees: account.NumberOfEmployees default account.number_of_employees default null,
    
    // Description and Notes
    Description: account.Description default account.description default "",
    
    // Ownership and Rating
    Ownership: account.Ownership default account.ownership default "",
    Rating: account.Rating default account.rating default "",
    
    // Parent Account
    ParentId: account.ParentId default account.parent_id default null,
    
    // Custom Fields
    AccountSource: account.AccountSource default account.account_source default "Data Import",
    
    // Audit Fields
    External_System__c: "MuleSoft Integration",
    Last_Integration_Date__c: now() as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"}
}
