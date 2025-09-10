# CRM & ERP Data Warehouse Project

## 📊 Overview
This project implements a comprehensive data warehouse solution for Customer Relationship Management (CRM) and Enterprise Resource Planning (ERP) datasets using SQL Server. The solution follows industry best practices including the Medallion Architecture pattern for data processing and standardized naming conventions for maintainable and scalable data infrastructure.

## 🏗️ Architecture

### Medallion Architecture Implementation
The project follows the **Medallion Architecture** (Bronze-Silver-Gold) pattern:

- **Bronze Layer (Raw Data)**: Contains raw, unprocessed data ingested from CSV files
- **Silver Layer (Cleaned Data)**: Cleaned and standardized data with basic transformations
- **Gold Layer (Business-Ready Data)**: Aggregated, business-ready data optimized for analytics and reporting

```
Raw Data (CSV) → Bronze Layer → Silver Layer → Gold Layer → Analytics & Reporting
```

## 📁 Project Structure
```
├── schemas/
│   ├── bronze_schema.sql
│   ├── silver_schema.sql
│   └── gold_schema.sql
├── stored_procedures/
│   ├── data_ingestion/
│   ├── data_transformation/
│   └── data_loading/
├── views/
│   ├── analytical_views/
│   └── reporting_views/
├── data_pipeline/
│   └── pipeline_design.drawio
├── documentation/
│   ├── data_dictionary.md
│   ├── transformation_rules.md
│   └── business_requirements.md
└── sample_data/
    ├── crm_data.csv
    └── erp_data.csv
```

## 🎯 Key Features

### Data Processing Pipeline
- **Automated CSV Data Ingestion**: Stored procedures for loading data from CSV files
- **Data Quality Assurance**: Comprehensive data cleaning and validation processes
- **Business Logic Implementation**: Transformations aligned with business requirements
- **Incremental Data Loading**: Efficient data processing with change data capture

### Database Design
- **Standardized Naming Conventions**: Consistent table, column, and schema naming patterns
- **Optimized Table Structures**: Proper indexing and partitioning strategies
- **Data Integrity**: Comprehensive constraints and referential integrity
- **Performance Optimization**: Query optimization and efficient data access patterns

### Analytics & Reporting
- **Pre-built Analytical Views**: Ready-to-use views for common business queries
- **Reporting Infrastructure**: Optimized views for BI tools and reporting platforms
- **Data Mart Structure**: Subject-specific data marts for different business domains

## 🛠️ Technologies Used
- **Database**: Microsoft SQL Server
- **Data Processing**: T-SQL, Stored Procedures
- **Pipeline Design**: Draw.io for visual pipeline documentation
- **Version Control**: Git
- **Documentation**: Markdown

## 📋 Database Schema

### Naming Convention Standards
- **Schemas**: `{layer}_{domain}` (e.g., `bronze_crm`, `silver_erp`, `gold_analytics`)
- **Tables**: `{entity_name}_{table_type}` (e.g., `customer_dim`, `sales_fact`)
- **Columns**: `snake_case` with descriptive names
- **Stored Procedures**: `sp_{action}_{entity}` (e.g., `sp_load_customer_data`)
- **Views**: `vw_{purpose}_{entity}` (e.g., `vw_sales_summary`)

### Key Entities
- **CRM Data**: Customers, Contacts, Opportunities, Sales Activities
- **ERP Data**: Products, Orders, Inventory, Financial Transactions
- **Integrated Views**: Customer 360, Sales Performance, Inventory Analysis

## 🔧 Installation & Setup

### Prerequisites
- SQL Server 2017 or later
- SQL Server Management Studio (SSMS)
- Appropriate permissions for database creation and data loading

### Setup Instructions

1. **Clone the Repository**
   ```bash
   git clone https://github.com/yourusername/crm-erp-datawarehouse.git
   cd crm-erp-datawarehouse
   ```

2. **Database Setup**
   ```sql
   -- Execute schema creation scripts
   EXEC sp_executesql @sql = 'CREATE DATABASE CRM_ERP_DataWarehouse'
   USE CRM_ERP_DataWarehouse
   
   -- Run schema scripts in order
   -- 1. Bronze layer schemas
   -- 2. Silver layer schemas  
   -- 3. Gold layer schemas
   ```

3. **Deploy Stored Procedures**
   ```sql
   -- Execute all stored procedure scripts
   -- Located in /stored_procedures/ directory
   ```

4. **Create Views**
   ```sql
   -- Execute view creation scripts
   -- Located in /views/ directory
   ```

## 📊 Data Pipeline

The data pipeline is visually documented using Draw.io and includes:

1. **Data Ingestion**: CSV file processing and validation
2. **Data Transformation**: Cleaning, standardization, and business rule application
3. **Data Loading**: Efficient loading into respective layers
4. **Data Quality Checks**: Automated validation and error handling
5. **Reporting Layer**: View creation and optimization

### Pipeline Flow
```
CSV Files → Data Validation → Bronze Layer → Data Cleaning → Silver Layer → Business Logic → Gold Layer → Analytics Views
```

## 📈 Usage Examples

### Loading Data from CSV
```sql
-- Load customer data from CSV
EXEC sp_load_customer_data @file_path = 'C:\data\customers.csv'

-- Load sales data from CSV
EXEC sp_load_sales_data @file_path = 'C:\data\sales.csv'
```

### Analytical Queries
```sql
-- Customer 360 view
SELECT * FROM gold_analytics.vw_customer_360 
WHERE customer_status = 'Active'

-- Sales performance analysis
SELECT * FROM gold_analytics.vw_sales_performance
WHERE sales_date >= '2024-01-01'
```

## 📝 Documentation

### Available Documentation
- **Data Dictionary**: Complete field definitions and business rules
- **Transformation Rules**: Detailed data transformation logic
- **Business Requirements**: Original requirements and implementation mapping
- **Code Documentation**: Inline comments and procedure documentation

## 🔍 Data Quality & Governance

### Data Quality Measures
- **Data Validation**: Input validation and constraint checking
- **Duplicate Detection**: Automated duplicate identification and handling
- **Data Completeness**: Missing value identification and treatment
- **Referential Integrity**: Cross-table relationship validation

### Monitoring & Logging
- **ETL Logging**: Comprehensive process logging and error tracking
- **Performance Monitoring**: Query performance and resource utilization tracking
- **Data Lineage**: Complete data transformation tracking

## 🚀 Future Enhancements
- [ ] Real-time data streaming integration
- [ ] Machine learning model integration
- [ ] Advanced analytics capabilities
- [ ] Cloud migration (Azure SQL Database)
- [ ] API development for external access
- [ ] Advanced security implementation

## 🤝 Contributing
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Contact
- **Project Maintainer**: [Mohammed Sadiq Ali]
- **Email**: [sadikcp2014@gmail.com]
- **LinkedIn**: [https://www.linkedin.com/in/moh-sadiq-ali/]
- **GitHub**: [https://github.com/4TechSadiq]

## 🙏 Acknowledgments
- Thanks to the business stakeholders for providing clear requirements
- Appreciation for the data engineering community for best practices
- Recognition of open-source tools and resources used in this project

---

**Note**: This project demonstrates enterprise-level data warehousing practices and can serve as a template for similar CRM/ERP integration projects.
