# Salesforce Account Integration Application

A comprehensive MuleSoft application that reads account information from JSON/CSV files and performs upsert operations into Salesforce Account objects using `hc_integration_key` as the external ID.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [API Endpoints](#api-endpoints)
- [Data Mapping](#data-mapping)
- [Error Handling](#error-handling)
- [Testing](#testing)
- [Deployment](#deployment)
- [Monitoring](#monitoring)
- [Best Practices](#best-practices)
- [Troubleshooting](#troubleshooting)

## Overview

This MuleSoft application provides a robust solution for integrating account data with Salesforce. It supports both file-based processing and HTTP API endpoints, with comprehensive error handling, data validation, and monitoring capabilities.

### Key Capabilities

- **File Processing**: Automatically processes JSON and CSV files from configured directories
- **HTTP API**: RESTful endpoints for real-time account upsert operations
- **Data Transformation**: Flexible DataWeave transformations supporting multiple input formats
- **Error Handling**: Comprehensive error handling with retry mechanisms
- **Batch Processing**: Configurable batch sizes for optimal performance
- **Environment Support**: Multi-environment configuration (dev, qa, prod)
- **Testing**: Complete MUnit test suite with 80%+ code coverage

## Features

### Core Features

- ✅ **File-based Integration**: Monitors input directories for JSON/CSV files
- ✅ **HTTP API Integration**: RESTful endpoints for real-time processing
- ✅ **Salesforce Upsert**: Uses `hc_integration_key__c` as external ID for upsert operations
- ✅ **Data Validation**: Input validation and data quality checks
- ✅ **Error Handling**: Comprehensive error handling with proper logging
- ✅ **Batch Processing**: Configurable batch sizes for performance optimization
- ✅ **File Management**: Automatic file movement to processed/error directories
- ✅ **Logging**: Structured logging with correlation IDs
- ✅ **Configuration Management**: Environment-based property files

### Advanced Features

- ✅ **Retry Mechanisms**: Configurable retry logic for transient failures
- ✅ **Performance Monitoring**: Built-in performance metrics and logging
- ✅ **Security**: Secure credential management and data handling
- ✅ **Scalability**: Designed for high-volume data processing
- ✅ **Extensibility**: Modular design for easy customization

## Architecture

### High-Level Architecture

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   File System   │    │   HTTP Clients   │    │   Salesforce    │
│                 │    │                  │    │                 │
│ JSON/CSV Files  │    │  REST API Calls  │    │ Account Objects │
└─────────┬───────┘    └─────────┬────────┘    └─────────┬───────┘
          │                      │                       │
          │                      │                       │
          ▼                      ▼                       ▲
┌─────────────────────────────────────────────────────────┴───────┐
│                    MuleSoft Application                         │
│                                                                 │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐ │
│  │ File Processing │  │   HTTP API      │  │ Account Upsert  │ │
│  │     Flow        │  │     Flow        │  │     Flow        │ │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘ │
│                                                                 │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐ │
│  │ Data Transform  │  │ Error Handling  │  │    Logging      │ │
│  │   (DataWeave)   │  │   & Retry       │  │  & Monitoring   │ │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
```

### Flow Architecture

1. **File Processing Flow**: Monitors input directories and processes files automatically
2. **HTTP API Flow**: Handles real-time API requests for account upsert operations
3. **Account Upsert Flow**: Core business logic for data transformation and Salesforce integration
4. **Error Handling**: Global and flow-specific error handling with proper logging

## Prerequisites

### Software Requirements

- **MuleSoft Anypoint Studio**: 7.14.0 or later
- **Mule Runtime**: 4.10.0 or later
- **Java**: JDK 17 or later
- **Maven**: 3.8.0 or later

### Salesforce Requirements

- **Salesforce Org**: Developer, Sandbox, or Production org
- **API Access**: Salesforce API access with appropriate permissions
- **Custom Field**: `hc_integration_key__c` field on Account object (External ID)

### Permissions Required

- **Account Object**: Create, Read, Update permissions
- **API Access**: REST API and SOAP API access
- **Custom Fields**: Access to `hc_integration_key__c` field

## Installation

### 1. Clone the Repository

```bash
git clone <repository-url>
cd salesforce-account-integration
```

### 2. Import into Anypoint Studio

1. Open Anypoint Studio
2. File → Import → Anypoint Studio → Anypoint Studio project from File System
3. Select the project directory
4. Click Finish

### 3. Install Dependencies

```bash
mvn clean install
```

## Configuration

### Environment Configuration

The application supports multiple environments through property files:

- `src/main/resources/properties/dev.yaml` - Development environment
- `src/main/resources/properties/qa.yaml` - QA environment  
- `src/main/resources/properties/prod.yaml` - Production environment

### Salesforce Configuration

Update the Salesforce connection properties in your environment-specific property file:

```yaml
salesforce:
  username: "your-salesforce-username"
  password: "your-salesforce-password"
  securityToken: "your-security-token"
  url: "https://login.salesforce.com/services/Soap/u/58.0"
  timeout: 30000
```

### File Processing Configuration

Configure file processing directories and patterns:

```yaml
file:
  input:
    directory: "src/main/resources/input"
    pattern: "*.json,*.csv"
    autoDelete: false
  processed:
    directory: "src/main/resources/processed"
  error:
    directory: "src/main/resources/error"
```

### API Configuration

Configure HTTP listener settings:

```yaml
api:
  host: "0.0.0.0"
  port: 8081
  basePath: "/api/v1"
```

## Usage

### File-Based Processing

1. **Prepare Data Files**: Create JSON or CSV files with account data
2. **Place Files**: Copy files to the configured input directory
3. **Monitor Processing**: Check logs for processing status
4. **Review Results**: Processed files move to processed directory, errors to error directory

#### Sample JSON Format

```json
[
  {
    "Name": "Acme Corporation",
    "hc_integration_key": "ACME001",
    "Type": "Customer",
    "Industry": "Technology",
    "Phone": "+1-555-123-4567",
    "Website": "https://www.acme.com",
    "BillingStreet": "123 Main Street",
    "BillingCity": "San Francisco",
    "BillingState": "CA",
    "BillingPostalCode": "94105",
    "BillingCountry": "USA",
    "AnnualRevenue": 5000000,
    "NumberOfEmployees": 250,
    "Description": "Leading technology company"
  }
]
```

#### Sample CSV Format

```csv
Name,hc_integration_key,Type,Industry,Phone,Website,BillingStreet,BillingCity,BillingState,BillingPostalCode,BillingCountry,AnnualRevenue,NumberOfEmployees,Description
"Acme Corporation","ACME001","Customer","Technology","+1-555-123-4567","https://www.acme.com","123 Main Street","San Francisco","CA","94105","USA",5000000,250,"Leading technology company"
```

### API-Based Processing

Send HTTP POST requests to the API endpoint:

```bash
curl -X POST http://localhost:8081/api/v1/accounts/upsert \
  -H "Content-Type: application/json" \
  -d '[{
    "Name": "API Test Account",
    "hc_integration_key": "API001",
    "Type": "Customer",
    "Industry": "Technology"
  }]'
```

## API Endpoints

### POST /api/v1/accounts/upsert

Upserts account records into Salesforce.

**Request Body**: Array of account objects
**Response**: Processing results with success/failure details

#### Success Response

```json
{
  "timestamp": "2024-01-15T10:30:00.000Z",
  "correlationId": "12345678-1234-1234-1234-123456789012",
  "status": "SUCCESS",
  "summary": {
    "totalRecords": 1,
    "successfulRecords": 1,
    "failedRecords": 0,
    "createdRecords": 1,
    "updatedRecords": 0
  },
  "results": [
    {
      "id": "0011234567890ABC",
      "success": true,
      "created": true,
      "errors": []
    }
  ]
}
```

#### Error Response

```json
{
  "timestamp": "2024-01-15T10:30:00.000Z",
  "correlationId": "12345678-1234-1234-1234-123456789012",
  "error": {
    "code": "SALESFORCE:CONNECTIVITY",
    "message": "Connection timeout",
    "details": "Unable to connect to Salesforce"
  },
  "status": "FAILED"
}
```

## Data Mapping

The application uses DataWeave transformations to map input data to Salesforce Account format. The mapping supports multiple input formats and field naming conventions.

### Field Mapping

| Input Field | Salesforce Field | Required | Default Value |
|-------------|------------------|----------|---------------|
| Name / name / AccountName | Name | Yes | "" |
| hc_integration_key / integration_key / Id | hc_integration_key__c | Yes | "" |
| Type / type | Type | No | "Customer" |
| Industry / industry | Industry | No | "" |
| Phone / phone | Phone | No | "" |
| Website / website | Website | No | "" |
| BillingStreet / billing_street / street | BillingStreet | No | "" |
| BillingCity / billing_city / city | BillingCity | No | "" |
| BillingState / billing_state / state | BillingState | No | "" |
| BillingPostalCode / billing_postal_code / postal_code | BillingPostalCode | No | "" |
| BillingCountry / billing_country / country | BillingCountry | No | "" |
| AnnualRevenue / annual_revenue | AnnualRevenue | No | null |
| NumberOfEmployees / number_of_employees | NumberOfEmployees | No | null |
| Description / description | Description | No | "" |

### Custom Fields

The application automatically adds audit fields:

- `External_System__c`: "MuleSoft Integration"
- `Last_Integration_Date__c`: Current timestamp

## Error Handling

### Error Types

1. **Connection Errors**: Salesforce connectivity issues
2. **Authentication Errors**: Invalid credentials or expired tokens
3. **Data Validation Errors**: Invalid or missing required fields
4. **Processing Errors**: Transformation or business logic errors
5. **System Errors**: Runtime or configuration errors

### Error Handling Strategy

- **Retry Logic**: Configurable retry attempts for transient failures
- **Error Logging**: Comprehensive error logging with correlation IDs
- **File Management**: Failed files moved to error directory
- **Graceful Degradation**: Partial success handling for batch operations

### Monitoring and Alerting

- **Structured Logging**: JSON-formatted logs with correlation IDs
- **Performance Metrics**: Processing time and throughput metrics
- **Error Tracking**: Error rates and failure patterns
- **Health Checks**: Application health monitoring endpoints

## Testing

### MUnit Test Suite

The application includes comprehensive MUnit tests covering:

- **Positive Test Cases**: Successful account creation and updates
- **Negative Test Cases**: Error handling and validation
- **Data Transformation Tests**: DataWeave mapping validation
- **Integration Tests**: End-to-end flow testing

### Running Tests

```bash
# Run all tests
mvn test

# Run tests with coverage
mvn clean test

# Generate coverage report
mvn munit:coverage-report
```

### Coverage Requirements

- **Minimum Coverage**: 80%
- **Flow Coverage**: 80%
- **Resource Coverage**: 80%
- **Application Coverage**: 80%

## Deployment

### Local Deployment

```bash
# Build the application
mvn clean package

# Run locally
mvn mule:run
```

### CloudHub Deployment

```bash
# Deploy to CloudHub
mvn clean deploy -DmuleDeploy
```

### Runtime Fabric Deployment

```bash
# Deploy to Runtime Fabric
mvn clean deploy -DmuleDeploy -Denv=production
```

## Monitoring

### Application Metrics

- **Processing Volume**: Number of records processed per hour/day
- **Success Rate**: Percentage of successful operations
- **Error Rate**: Percentage of failed operations
- **Response Time**: Average processing time per record
- **Throughput**: Records processed per second

### Salesforce Metrics

- **API Usage**: Salesforce API call consumption
