%dw 2.0
output application/json
---
/**
 * Test Data for MUnit Tests
 * Contains sample account data for positive and negative test scenarios
 */
{
    positiveTestData: [
        {
            "Name": "MUnit Test Account 1",
            "hc_integration_key": "MUNIT001",
            "Type": "Customer",
            "Industry": "Technology",
            "Phone": "+1-555-MUNIT-01",
            "Website": "https://www.munittest1.com",
            "BillingStreet": "123 MUnit Street",
            "BillingCity": "Test City",
            "BillingState": "TC",
            "BillingPostalCode": "12345",
            "BillingCountry": "USA",
            "AnnualRevenue": 1500000,
            "NumberOfEmployees": 75,
            "Description": "Test account created by MUnit for positive testing scenarios"
        },
        {
            "Name": "MUnit Test Account 2",
            "hc_integration_key": "MUNIT002",
            "Type": "Partner",
            "Industry": "Manufacturing",
            "Phone": "+1-555-MUNIT-02",
            "Website": "https://www.munittest2.com",
            "BillingStreet": "456 MUnit Avenue",
            "BillingCity": "Test Town",
            "BillingState": "TT",
            "BillingPostalCode": "67890",
            "BillingCountry": "USA",
            "AnnualRevenue": 2500000,
            "NumberOfEmployees": 125,
            "Description": "Second test account for MUnit batch processing tests"
        }
    ],
    negativeTestData: [
        {
            "InvalidField": "This should cause an error",
            "MissingName": null,
            "BadIntegrationKey": ""
        },
        {
            "Name": "",
            "hc_integration_key": null,
            "Type": "InvalidType",
            "AnnualRevenue": "NotANumber"
        }
    ],
    csvTestData: [
        {
            "name": "CSV Test Account",
            "integration_key": "CSV001",
            "type": "Customer",
            "industry": "Software",
            "phone": "+1-555-CSV-001",
            "website": "https://www.csvtest.com",
            "billing_street": "789 CSV Lane",
            "billing_city": "CSV City",
            "billing_state": "CS",
            "billing_postal_code": "11111",
            "billing_country": "USA",
            "annual_revenue": 750000,
            "number_of_employees": 30,
            "description": "Test account with CSV field naming convention"
        }
    ],
    updateTestData: [
        {
            "Name": "Updated MUnit Test Account",
            "hc_integration_key": "MUNIT001",
            "Type": "Partner",
            "Industry": "Technology Services",
            "Phone": "+1-555-UPDATED",
            "Website": "https://www.updated-munittest.com",
            "BillingStreet": "999 Updated Street",
            "BillingCity": "Updated City",
            "BillingState": "UC",
            "BillingPostalCode": "99999",
            "BillingCountry": "USA",
            "AnnualRevenue": 3000000,
            "NumberOfEmployees": 150,
            "Description": "Updated test account for testing upsert update functionality"
        }
    ]
}
