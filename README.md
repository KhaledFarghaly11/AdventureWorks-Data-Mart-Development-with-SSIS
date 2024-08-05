# AdventureWorks Data Mart Development with SSIS

## Project Overview

This project aims to  data reporting for AdventureWorks2019 by creating a data mart using SQL Server Integration Services (SSIS) and Dimensional Modeling. The primary focus is on selected departments (Sales and HR).

### Key Components

1. **Staging Database:**
   - A dedicated database to hold extracted data from AdventureWorks2019.

2. **Data Mart:**
   - A structured database containing fact and dimension tables.
   - Designed for analytical purposes.

3. **SSIS Packages:**
   - ETL processes to extract, transform, and load data into the staging and data mart databases.

### Project Structure

- **SQL Scripts:**
  - Contains SQL scripts for creating staging and data mart tables, indexes, and constraints.
- **SSIS Packages:**
  - Houses SSIS packages for data movement and transformation.

### Assumptions and Limitations

- Assumes AdventureWorks2019 database is accessible and contains relevant data.
- Focuses on Sales and HR departments for data extraction and transformation.
- SSIS is the primary tool for data movement and transformation.

### Getting Started

1. **Environment Setup:**
   - Ensure SQL Server and SSIS are installed and configured.
2. **Database Creation:**
   - Create the staging and data mart databases using provided SQL scripts.
3. **SSIS Configuration:**
   - Update connection strings and parameters in SSIS packages.
4. **Execute SSIS Packages:**
   - Run the SSIS packages to populate the staging and data mart databases.

### Additional Considerations

- Implement error handling and logging in SSIS packages.
- Optimize SSIS package performance.
- Explore data quality checks and cleansing processes.
- Implement data security and access controls.

### Future Enhancements

- Expand the data mart to include additional departments and data sources.
- Incorporate data profiling and quality assessment.
- Implement incremental load for efficient data updates.
- Explore using SSIS packages for data integration with other systems.

### By following these guidelines and leveraging the provided resources, you can effectively build and maintain the AdventureWorks2019 data mart.
