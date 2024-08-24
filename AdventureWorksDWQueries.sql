CREATE DATABASE AdventureWorksDW;

USE AdventureWorksDW;

/* Dimensions */

CREATE TABLE dbo.DimCurrency (
	CurrencyKey int IDENTITY(1,1) NOT NULL,
	CurrencyAlternateKey nchar(3) NOT NULL,
	CurrencyName nvarchar(50) NOT NULL,
	CONSTRAINT PK_DimCurrency_CurrencyKey PRIMARY KEY CLUSTERED (CurrencyKey ASC)
);

CREATE TABLE dbo.DimCustomer (
	CustomerKey int IDENTITY(1,1) NOT NULL,
	GeographyKey int NULL,
	CustomerAlternateKey int NULL,
	Title nvarchar(8) NULL,
	FirstName nvarchar(50) NULL,
	MiddleName nvarchar(50) NULL,
	LastName nvarchar(50) NULL,
	NameStyle bit NULL,
	BirthDate date NULL,
	MaritalStatus nchar(1) NULL,
	Suffix nvarchar(10) NULL,
	Gender nvarchar(1) NULL,
	EmailAddress nvarchar(50) NULL,
	YearlyIncome money NULL,
	TotalChildren tinyint NULL,
	NumberChildrenAtHome tinyint NULL,
	NumberCarsOwned tinyint NULL,
	AddressLine1 nvarchar(120) NULL,
	AddressLine2 nvarchar(120) NULL,
	Phone nvarchar(20) NULL,
	DateFirstPurchase date NULL,
	CommuteDistance nvarchar(15) NULL,
	CONSTRAINT PK_DimCustomer_CustomerKey PRIMARY KEY CLUSTERED (CustomerKey ASC)
);

CREATE TABLE dbo.DimDate (
	DateKey int NOT NULL,
	FullDateAlternateKey date NOT NULL,
	DayNumberOfWeek tinyint NOT NULL,
	EnglishDayNameOfWeek nvarchar(10) NOT NULL,
	DayNumberOfMonth tinyint NOT NULL,
	DayNumberOfYear smallint NOT NULL,
	WeekNumberOfYear tinyint NOT NULL,
	EnglishMonthName nvarchar(10) NOT NULL,
	MonthNumberOfYear tinyint NOT NULL,
	CalendarQuarter tinyint NOT NULL,
	CalendarYear smallint NOT NULL,
	CalendarSemester tinyint NOT NULL,
	FiscalQuarter tinyint NOT NULL,
	FiscalYear smallint NOT NULL,
	FiscalSemester tinyint NOT NULL,
	CONSTRAINT PK_DimDate_DateKey PRIMARY KEY CLUSTERED  (DateKey ASC)
);

CREATE TABLE dbo.DimEmployee (
	EmployeeKey int IDENTITY(1,1) NOT NULL,
	EmployeeNationalIDAlternateKey nvarchar(15) NULL,
	FirstName nvarchar(50) NOT NULL,
	LastName nvarchar(50) NOT NULL,
	Title nvarchar(50) NULL,
	HireDate date NULL,
	BirthDate date NULL,
	EmailAddress nvarchar(50) NULL,
	Phone nvarchar(25) NULL,
	MaritalStatus nchar(1) NULL,
	Department nvarchar(100) NULL,
	StartDate date NULL,
	EndDate date NULL,
	Status nvarchar(50) NULL,
	CONSTRAINT PK_DimEmployee_EmployeeKey PRIMARY KEY CLUSTERED (EmployeeKey ASC)
);

CREATE TABLE dbo.DimProduct (
	ProductKey int IDENTITY(1,1) NOT NULL,
	ProductAlternateKey nvarchar(25) NULL,
	EnglishProductName nvarchar(50) NOT NULL,
	StandardCost money NULL,
	Color nvarchar(15) NOT NULL,
	Size nvarchar(50) NULL,
	SizeRange nvarchar(50) NULL,
	EnglishDescription nvarchar(400) NULL,
	FrenchDescription nvarchar(400) NULL,
	ArabicDescription nvarchar(400) NULL,
	ProductSubcategoryCode nvarchar(50) NULL,
	ProductcategoryCode nvarchar(50) NULL,
	Status nvarchar(7) NULL,
	CONSTRAINT PK_DimProduct_ProductKey PRIMARY KEY CLUSTERED (ProductKey ASC)
);

CREATE TABLE dbo.DimReseller (
	ResellerKey int IDENTITY(1,1) NOT NULL,
	ResellerAlternateKey nvarchar(15) NULL,
	ResellerName nvarchar(50) NOT NULL,
	NumberEmployees int NULL,
	YearOpened int NULL,
	CONSTRAINT PK_DimReseller_ResellerKey PRIMARY KEY CLUSTERED (ResellerKey ASC),
	CONSTRAINT AK_DimReseller_ResellerAlternateKey UNIQUE NONCLUSTERED  (ResellerAlternateKey ASC)
);

CREATE TABLE dbo.DimSalesTerritory (
	SalesTerritoryKey int IDENTITY(1,1) NOT NULL,
	SalesTerritoryAlternateKey int NULL,
	SalesTerritoryRegion nvarchar(50) NOT NULL,
	SalesTerritoryCountry nvarchar(50) NOT NULL,
	SalesTerritoryGroup nvarchar(50) NULL,
	SalesTerritoryImage varbinary(max) NULL,
	CONSTRAINT PK_DimSalesTerritory_SalesTerritoryKey PRIMARY KEY CLUSTERED (SalesTerritoryKey ASC), 
	CONSTRAINT AK_DimSalesTerritory_SalesTerritoryAlternateKey UNIQUE NONCLUSTERED  (SalesTerritoryAlternateKey ASC)
);

/* Facts */

CREATE TABLE dbo.FactInternetSales (
	ProductKey int NOT NULL,
	OrderDateKey int NOT NULL,
	DueDateKey int NOT NULL,
	ShipDateKey int NOT NULL,
	CustomerKey int NOT NULL,
	CurrencyKey int NOT NULL,
	SalesTerritoryKey int NOT NULL,
	SalesOrderNumber nvarchar(20) NOT NULL,
	SalesOrderLineNumber tinyint NOT NULL,
	OrderQuantity smallint NOT NULL,
	UnitPrice money NOT NULL,
	DiscountAmount float NOT NULL,
	SalesAmount money NOT NULL,
	TaxAmt money NOT NULL,
	OrderDate datetime NULL,
	DueDate datetime NULL,
	ShipDate datetime NULL,
	CONSTRAINT PK_FactInternetSales_SalesOrderNumber_SalesOrderLineNumber PRIMARY KEY CLUSTERED (SalesOrderNumber ASC, SalesOrderLineNumber ASC)
);

CREATE TABLE dbo.FactResellerSales (
	ProductKey int NOT NULL,
	OrderDateKey int NOT NULL,
	DueDateKey int NOT NULL,
	ShipDateKey int NOT NULL,
	ResellerKey int NOT NULL,
	EmployeeKey int NOT NULL,
	CurrencyKey int NOT NULL,
	SalesTerritoryKey int NOT NULL,
	SalesOrderNumber nvarchar(20) NOT NULL,
	SalesOrderLineNumber tinyint NOT NULL,
	OrderQuantity smallint NULL,
	UnitPrice money NOT NULL,
	DiscountAmount float NOT NULL,
	SalesAmount money NULL,
	OrderDate datetime NULL,
	DueDate datetime NULL,
	ShipDate datetime NULL,
	CONSTRAINT PK_FactResellerSales_SalesOrderNumber_SalesOrderLineNumber PRIMARY KEY CLUSTERED (SalesOrderNumber ASC, SalesOrderLineNumber ASC)
);

CREATE TABLE dbo.FactEmployeePay (
	EmployeeKey int NULL,
	DateKey int NULL,
	PayFrequency tinyint NOT NULL,
	Rate money NOT NULL
)



ALTER TABLE dbo.FactInternetSales  WITH CHECK ADD  CONSTRAINT FK_FactInternetSales_DimCurrency FOREIGN KEY(CurrencyKey)
REFERENCES dbo.DimCurrency (CurrencyKey);

ALTER TABLE dbo.FactInternetSales CHECK CONSTRAINT FK_FactInternetSales_DimCurrency;

ALTER TABLE dbo.FactInternetSales  WITH CHECK ADD  CONSTRAINT FK_FactInternetSales_DimCustomer FOREIGN KEY(CustomerKey)
REFERENCES dbo.DimCustomer (CustomerKey);

ALTER TABLE dbo.FactInternetSales CHECK CONSTRAINT FK_FactInternetSales_DimCustomer;

ALTER TABLE dbo.FactInternetSales  WITH CHECK ADD  CONSTRAINT FK_FactInternetSales_DimDate FOREIGN KEY(OrderDateKey)
REFERENCES dbo.DimDate (DateKey);

ALTER TABLE dbo.FactInternetSales CHECK CONSTRAINT FK_FactInternetSales_DimDate;

ALTER TABLE dbo.FactInternetSales  WITH CHECK ADD  CONSTRAINT FK_FactInternetSales_DimDate1 FOREIGN KEY(DueDateKey)
REFERENCES dbo.DimDate (DateKey);

ALTER TABLE dbo.FactInternetSales CHECK CONSTRAINT FK_FactInternetSales_DimDate1;

ALTER TABLE dbo.FactInternetSales  WITH CHECK ADD  CONSTRAINT FK_FactInternetSales_DimDate2 FOREIGN KEY(ShipDateKey)
REFERENCES dbo.DimDate (DateKey);

ALTER TABLE dbo.FactInternetSales CHECK CONSTRAINT FK_FactInternetSales_DimDate2;

ALTER TABLE dbo.FactInternetSales  WITH CHECK ADD  CONSTRAINT FK_FactInternetSales_DimProduct FOREIGN KEY(ProductKey)
REFERENCES dbo.DimProduct (ProductKey);

ALTER TABLE dbo.FactInternetSales CHECK CONSTRAINT FK_FactInternetSales_DimProduct;

ALTER TABLE dbo.FactInternetSales  WITH CHECK ADD  CONSTRAINT FK_FactInternetSales_DimSalesTerritory FOREIGN KEY(SalesTerritoryKey)
REFERENCES dbo.DimSalesTerritory (SalesTerritoryKey);

ALTER TABLE dbo.FactInternetSales CHECK CONSTRAINT FK_FactInternetSales_DimSalesTerritory;

ALTER TABLE dbo.FactResellerSales  WITH CHECK ADD  CONSTRAINT FK_Employee FOREIGN KEY(EmployeeKey)
REFERENCES dbo.DimEmployee (EmployeeKey);

ALTER TABLE dbo.FactResellerSales CHECK CONSTRAINT FK_Employee;

ALTER TABLE dbo.FactResellerSales  WITH CHECK ADD  CONSTRAINT FK_FactResellerSales_DimDate FOREIGN KEY(OrderDateKey)
REFERENCES dbo.DimDate (DateKey);

ALTER TABLE dbo.FactResellerSales CHECK CONSTRAINT FK_FactResellerSales_DimDate;

ALTER TABLE dbo.FactResellerSales WITH CHECK ADD  CONSTRAINT FK_FactResellerSales_DimDate1 FOREIGN KEY(DueDateKey)
REFERENCES dbo.DimDate (DateKey);

ALTER TABLE dbo.FactResellerSales CHECK CONSTRAINT FK_FactResellerSales_DimDate1;

ALTER TABLE dbo.FactResellerSales  WITH CHECK ADD  CONSTRAINT FK_FactResellerSales_DimDate2 FOREIGN KEY(ShipDateKey)
REFERENCES dbo.DimDate (DateKey);

ALTER TABLE dbo.FactResellerSales CHECK CONSTRAINT FK_FactResellerSales_DimDate2;

ALTER TABLE dbo.FactResellerSales  WITH CHECK ADD  CONSTRAINT FK_FactResellerSales_DimProduct FOREIGN KEY(ProductKey)
REFERENCES dbo.DimProduct (ProductKey);

ALTER TABLE dbo.FactResellerSales CHECK CONSTRAINT FK_FactResellerSales_DimProduct;

ALTER TABLE dbo.FactResellerSales  WITH CHECK ADD  CONSTRAINT FK_FactResellerSales_DimSalesTerritory FOREIGN KEY(SalesTerritoryKey)
REFERENCES dbo.DimSalesTerritory (SalesTerritoryKey);

ALTER TABLE dbo.FactResellerSales CHECK CONSTRAINT FK_FactResellerSales_DimSalesTerritory;

ALTER TABLE dbo.FactResellerSales  WITH CHECK ADD  CONSTRAINT FK_reseller FOREIGN KEY(ResellerKey)
REFERENCES dbo.DimReseller (ResellerKey);

ALTER TABLE dbo.FactResellerSales CHECK CONSTRAINT FK_reseller;

ALTER TABLE dbo.FactEmployeePay ADD CONSTRAINT FK_FactEmployeePay_emp FOREIGN KEY(EmployeeKey)
REFERENCES dbo.DimEmployee(EmployeeKey)

ALTER TABLE dbo.FactEmployeePay ADD CONSTRAINT FK_FactEmployeePay_dt FOREIGN KEY(DateKey)
REFERENCES dbo.DimDate(DateKey)

/* Procedures */

CREATE PROCEDURE dbo.Refresh_DimCurrency
AS
BEGIN

INSERT INTO dbo.DimCurrency (
	CurrencyAlternateKey, 
	CurrencyName
)

SELECT 
	CurrencyCode,
	Name  
FROM
	AdventureWorksStaging.erp.Currency stg
LEFT JOIN
	dbo.DimCurrency Dim
ON
	stg.CurrencyCode = Dim.CurrencyAlternateKey
WHERE
	Dim.CurrencyAlternateKey is null

UPDATE Dim
SET 
	CurrencyName = Name
FROM
	dbo.DimCurrency Dim
INNER JOIN
	AdventureWorksStaging.erp.Currency stg
ON
	stg.CurrencyCode = Dim.CurrencyAlternateKey
END


CREATE PROCEDURE dbo.Refresh_DimCustomer
AS
BEGIN

MERGE INTO
	dbo.DimCustomer cus
USING
	AdventureWorksStaging.dbo.stg_vw_erp_customer stg
ON
	cus.CustomerAlternateKey = stg.CustomerID
WHEN 
	MATCHED AND ( cus.EmailAddress <> stg.EmailPromotion or cus.AddressLine1 <> stg.AddressLine1 or cus.AddressLine2 <> stg.City) 
THEN
UPDATE 
SET 
	cus.EmailAddress = stg.EmailPromotion,
	cus.AddressLine1 = stg.AddressLine1,
    cus.AddressLine2 = stg.City

WHEN NOT MATCHED BY TARGET THEN
INSERT ( 
	CustomerAlternateKey,
	Title,
	FirstName,
	LastName,
	NameStyle,
	EmailAddress,
	AddressLine1,
	AddressLine2
)
Values (
	stg.CustomerID,
	stg.Title,		
	stg.FirstName,		
	stg.LastName,
	stg.NameStyle,
	stg.EmailPromotion,
	stg.AddressLine1,
	stg.City
);
END


CREATE PROCEDURE dbo.Refresh_DimDate
AS
BEGIN

DECLARE 
	@startdate date = '2005-01-01',
    @enddate date = '2019-12-31'

IF @startdate IS NULL
    BEGIN
        SELECT 
			TOP 1 @startdate = FulldateAlternateKey
        From 
			DimDate 
        Order By 
			DateKey ASC 
    END

Declare
	@datelist table (FullDate date)

WHILE
	@startdate <= @enddate

BEGIN
    INSERT INTO
		@datelist (FullDate)
    SELECT
		@startdate
    SET 
		@startdate = dateadd(dd,1,@startdate)
END 

INSERT INTO dbo.DimDate (
	DateKey, 
    FullDateAlternateKey, 
    DayNumberOfWeek, 
    EnglishDayNameOfWeek, 
      
    DayNumberOfMonth, 
    DayNumberOfYear, 
    WeekNumberOfYear, 
    EnglishMonthName, 
     
    MonthNumberOfYear, 
    CalendarQuarter, 
    CalendarYear, 
    CalendarSemester, 
    FiscalQuarter, 
    FiscalYear, 
    FiscalSemester
)

SELECT
	convert(int,convert(varchar,dl.FullDate,112)) as DateKey,
    dl.FullDate,
    datepart(dw,dl.FullDate) as DayNumberOfWeek,
    datename(weekday,dl.FullDate) as EnglishDayNameOfWeek,
    
    datepart(d,dl.FullDate) as DayNumberOfMonth,
    datepart(dy,dl.FullDate) as DayNumberOfYear,
    datepart(wk, dl.FUllDate) as WeekNumberOfYear,
    datename(MONTH,dl.FullDate) as EnglishMonthName,
   
    Month(dl.FullDate) as MonthNumberOfYear,
    datepart(qq, dl.FullDate) as CalendarQuarter,
    year(dl.FullDate) as CalendarYear,
    case datepart(qq, dl.FullDate)
        when 1 then 1
        when 2 then 1
        when 3 then 2
        when 4 then 2
    end as CalendarSemester,
    case datepart(qq, dl.FullDate)
        when 1 then 3
        when 2 then 4
        when 3 then 1
        when 4 then 2
    end as FiscalQuarter,
    case datepart(qq, dl.FullDate)
        when 1 then year(dl.FullDate)
        when 2 then year(dl.FullDate)
        when 3 then year(dl.FullDate) + 1
        when 4 then year(dl.FullDate) + 1
    end as FiscalYear,
    case datepart(qq, dl.FullDate)
        when 1 then 2
        when 2 then 2
        when 3 then 1
        when 4 then 1
    end as FiscalSemester
FROM
	@datelist dl
LEFT JOIN 
    DimDate dd
ON
	dl.FullDate = dd.FullDateAlternateKey
WHERE
	dd.FullDateAlternateKey is null 
End


CREATE PROCEDURE dbo.Refresh_DimProduct
AS
BEGIN
 
INSERT INTO dbo.DimProduct (
       ProductAlternateKey,
	   EnglishProductName,
	   StandardCost,
	   Color,
	   Size,
	   SizeRange,
	   EnglishDescription,
	   FrenchDescription,
	   ArabicDescription,
	   ProductSubcategoryCode,
	   ProductcategoryCode,
	   Status
)

SELECT 
	stg.ProductNumber,
    stg.Name,
    stg.StandardCost,
    Isnull(stg.Color,'NA'),
    stg.Size,
    stg.SizeRange,
    stg.EnglishDescription,
	null,
    null,
	stg.ProductSubcategoryCode,
    stg.ProductCategory,  
	null Status
FROM
	AdventureWorksStaging.dbo.stg_vw_erp_product stg
LEFT JOIN 
	dbo.DimProduct Dim
ON
	Dim.ProductAlternateKey = stg.ProductNumber
WHERE
	Dim.ProductAlternateKey is null

UPDATE Dim
SET 
	Dim.EnglishDescription = stg.EnglishDescription
FROM 
	dbo.DimProduct Dim
inner join
	AdventureWorksStaging.dbo.stg_vw_erp_product stg
ON
	Dim.ProductAlternateKey = stg.ProductNumber
END 


CREATE PROCEDURE dbo.Refresh_DimSalesTerritory
AS
BEGIN

INSERT INTO dbo.DimSalesTerritory (
	SalesTerritoryAlternateKey,
	SalesTerritoryRegion,
	SalesTerritoryCountry,
	SalesTerritoryGroup
)

SELECT  
	TerritoryID,
	Name,
	CountryRegionCode,
	[Group]
FROM 
	AdventureWorksStaging.erp.SalesTerritory stg
LEFT JOIN
	dbo.DimSalesTerritory Dim
ON
	Dim.SalesTerritoryAlternateKey = stg.TerritoryID
WHERE
	Dim.SalesTerritoryAlternateKey is null

UPDATE Dim
SET
	SalesTerritoryRegion = Name,
	SalesTerritoryCountry = CountryRegionCode,
	SalesTerritoryGroup = [Group]
FROM
	dbo.DimSalesTerritory Dim
INNER JOIN
	AdventureWorksStaging.erp.SalesTerritory stg
ON
	Dim.SalesTerritoryAlternateKey = stg.TerritoryID
END 


CREATE PROCEDURE dbo.Refresh_Reseller
AS
BEGIN

INSERT INTO dbo.DimReseller (
	ResellerAlternateKey,
	ResellerName,
	NumberEmployees,
	YearOpened
)

SELECT  
	stg.StoreID,
	stg.ResellerName,
	stg.NumberEmployees,
	stg.YearOpened
FROM
	AdventureWorksStaging.dbo.stg_vw_erp_reseller stg
LEFT JOIN
	dbo.DimReseller Dim
ON
	stg.StoreID = Dim.ResellerAlternateKey
WHERE
	Dim.ResellerAlternateKey is null

UPDATE Dim
SET 
	Dim.ResellerName = stg.ResellerName,
	Dim.NumberEmployees = stg.NumberEmployees
FROM
	dbo.DimReseller Dim
INNER JOIN
	AdventureWorksStaging.dbo.stg_vw_erp_reseller stg
ON
	stg.StoreID = Dim.ResellerAlternateKey
END



CREATE PROCEDURE dbo.Refresh_FactEmployeePay
AS
BEGIN

INSERT INTO AdventureWorksDW.dbo.FactEmployeePay

SELECT 
	e.EmployeeKey,
	d.DateKey,
	s.PayFrequency,
	s.Rate 
FROM
	AdventureWorksStaging.dbo.stg_vw_erp_Fact_EmployeePayHistory s
LEFT JOIN
	AdventureWorksDW.dbo.DimEmployee e   
ON
	e.EmployeeNationalIDAlternateKey = s.NationalIDNumber
LEFT JOIN
	AdventureWorksDW.dbo.DimDate d
ON
	s.SalaryMonth = d.FullDateAlternateKey
END
