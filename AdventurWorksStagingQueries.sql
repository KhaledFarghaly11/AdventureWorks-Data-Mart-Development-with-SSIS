CREATE DATABASE AdventureWorksStaging;

USE AdventureWorksStaging;

CREATE SCHEMA erp;

CREATE SCHEMA hr;

/* ERP SCHEMA */
CREATE TABLE erp.Business_Entity (
	rowguid uniqueidentifier NULL,
	ModifiedDate datetime NULL,
	BusinessEntityID int NULL,
	Created_Dt datetime NULL,
	SSISTrackId int NULL
);

CREATE TABLE erp.Currency (
	CurrencyCode nvarchar(3) NULL,
	Name nvarchar(50) NULL,
	ModifiedDate datetime NULL,
	Created_Dt datetime NULL,
	SSISTrackId int NULL
);

CREATE TABLE erp.Customer (
	CustomerID int NULL,
	PersonID int NULL,
	StoreID int NULL,
	TerritoryID int NULL,
	AccountNumber varchar(10) NULL,
	rowguid uniqueidentifier NULL,
	ModifiedDate datetime NULL
);

CREATE TABLE erp.Person (
	rowguid uniqueidentifier NULL,
	ModifiedDate datetime NULL,
	BusinessEntityID int NULL,
	PersonType nvarchar(2) NULL,
	NameStyle bit NULL,
	Title nvarchar(8) NULL,
	FirstName nvarchar(50) NULL,
	MiddleName nvarchar(50) NULL,
	LastName nvarchar(50) NULL,
	Suffix nvarchar(10) NULL,
	EmailPromotion int NULL,
	AdditionalContactInfo nvarchar(max) NULL,
	Demographics nvarchar(max) NULL,
	Created_Dt datetime NULL,
	SSISTrackId int NULL
);

CREATE TABLE erp.PersonAddress (
	BusinessEntityID int NULL,
	AddressID int NULL,
	AddressTypeID int NULL,
	rowguid uniqueidentifier NULL,
	ModifiedDate datetime NULL,
	AddressLine1 nvarchar(60) NULL,
	City nvarchar(30) NULL,
	PostalCode nvarchar(15) NULL,
	StateProvinceID int NULL,
	Created_Dt datetime NULL,
	SSISTrackId int NULL
);

CREATE TABLE erp.Product (
	ProductID int NULL,
	Name nvarchar(50) NULL,
	ProductNumber nvarchar(25) NULL,
	MakeFlag bit NULL,
	FinishedGoodsFlag bit NULL,
	Color nvarchar(15) NULL,
	SafetyStockLevel smallint NULL,
	ReorderPoint smallint NULL,
	StandardCost money NULL,
	ListPrice money NULL,
	Size nvarchar(5) NULL,
	SizeUnitMeasureCode nvarchar(3) NULL,
	WeightUnitMeasureCode nvarchar(3) NULL,
	Weight numeric(8, 2) NULL,
	DaysToManufacture int NULL,
	ProductLine nvarchar(2) NULL,
	Class nvarchar(2) NULL,
	Style nvarchar(2) NULL,
	ProductSubcategoryID int NULL,
	ProductModelID int NULL,
	SellStartDate datetime NULL,
	SellEndDate datetime NULL,
	DiscontinuedDate datetime NULL,
	rowguid uniqueidentifier NULL,
	ModifiedDate datetime NULL,
	Created_Dt datetime NULL,
	SSISTrackId int NULL
);

CREATE TABLE erp.ProductCategory (
	ModifiedDate datetime NULL,
	ProductCategoryID int NULL,
	Name nvarchar(50) NULL,
	rowguid uniqueidentifier NULL,
	Created_Dt datetime NULL,
	SSISTrackId int NULL
);

CREATE TABLE erp.ProductSubCategory (
	ProductSubcategoryID int NULL,
	ProductCategoryID int NULL,
	Name nvarchar(50) NULL
);

CREATE TABLE erp.SalesHeader (
	SalesOrderID int NULL,
	rowguid uniqueidentifier NULL,
	ModifiedDate datetime NULL,
	RevisionNumber tinyint NULL,
	OrderDate datetime NULL,
	DueDate datetime NULL,
	ShipDate datetime NULL,
	Status tinyint NULL,
	OnlineOrderFlag bit NULL,
	SalesOrderNumber nvarchar(25) NULL,
	PurchaseOrderNumber nvarchar(25) NULL,
	AccountNumber nvarchar(15) NULL,
	CustomerID int NULL,
	SalesPersonID int NULL,
	TerritoryID int NULL,
	BillToAddressID int NULL,
	ShipToAddressID int NULL,
	ShipMethodID int NULL,
	CreditCardID int NULL,
	CreditCardApprovalCode varchar(15) NULL,
	CurrencyRateID int NULL,
	SubTotal money NULL,
	TaxAmt money NULL,
	Freight money NULL,
	TotalDue money NULL,
	Comment nvarchar(128) NULL,
	SSIS_ID bigint NULL
);

CREATE TABLE erp.SalesOrderDetail (
	SalesOrderID int NULL,
	SalesOrderDetailID int NULL,
	CarrierTrackingNumber nvarchar(25) NULL,
	OrderQty smallint NULL,
	ProductID int NULL,
	SpecialOfferID int NULL,
	UnitPrice money NULL,
	UnitPriceDiscount money NULL,
	LineTotal numeric(38, 6) NULL,
	rowguid uniqueidentifier NULL,
	ModifiedDate datetime NULL,
	Created_Dt datetime NULL,
	SSISTrackId int NULL
);

CREATE TABLE erp.SalesTerritory (
	TerritoryID int NULL,
	Name nvarchar(50) NULL,
	CountryRegionCode [nvarchar](3) NULL,
	[Group] nvarchar(50) NULL
);

CREATE TABLE erp.Store (
	rowguid uniqueidentifier NULL,
	ModifiedDate datetime NULL,
	Name nvarchar(50) NULL,
	Demographics nvarchar(max) NULL,
	BusinessEntityID int NULL
);

/* HR SCHEMA */
CREATE TABLE hr.Employee (
	BusinessEntityID int NULL,
	NationalIDNumber nvarchar(15) NULL,
	LoginID nvarchar(256) NULL,
	OrganizationNode binary(892) NULL,
	OrganizationLevel smallint NULL,
	JobTitle nvarchar(50) NULL,
	BirthDate date NULL,
	MaritalStatus nvarchar(1) NULL,
	Gender nvarchar(1) NULL,
	HireDate date NULL,
	SalariedFlag bit NULL,
	VacationHours smallint NULL,
	SickLeaveHours smallint NULL,
	CurrentFlag bit NULL,
	rowguid uniqueidentifier NULL,
	ModifiedDate datetime NULL,
	Created_Dt datetime NULL,
	SSISTrackId int NULL
);

CREATE TABLE hr.EmployeeDepartmentHistory (
	BusinessEntityID int NULL,
	DepartmentID smallint NULL,
	ShiftID tinyint NULL,
	StartDate date NULL,
	EndDate date NULL,
	ModifiedDate datetime NULL,
	DepartmentName nvarchar(50) NULL,
	Created_Dt datetime NULL,
	SSISTrackId int NULL
);

CREATE TABLE hr.EmployeePayHistory (
	BusinessEntityID int NULL,
	RateChangeDate datetime NULL,
	Rate money NULL,
	PayFrequency tinyint NULL,
	ModifiedDate datetime NULL
);

/* Views */
CREATE VIEW dbo.stg_vw_erp_customer AS (
	SELECT 
		c.CustomerID,
		p.Title,
		p.FirstName,
		p.LastName,
		p.NameStyle,
		p.EmailPromotion,
		pa.AddressLine1,
		pa.City
	FROM 
		erp.Customer c
	INNER JOIN 
		erp.Person p
	ON c.PersonID = p.BusinessEntityID
	LEFT JOIN 
		erp.PersonAddress pa
	ON 
		p.BusinessEntityID = pa.BusinessEntityID
);

CREATE VIEW dbo.stg_vw_erp_employee AS (
	
	SELECT  
		NationalIDNumber,
		FirstName,
		LastName,
		null NameStyle,
		Title,
		HireDate,
		BirthDate,
		LoginID EmailAddress,
		N'' Phone,
		MaritalStatus,
		DepartmentName,
		StartDate,
		EndDate
	FROM 
		hr.Employee e
	LEFT JOIN 
		erp.Person p
	ON 
		e.BusinessEntityID = p.BusinessEntityID
	LEFT JOIN 
		hr.EmployeeDepartmentHistory d
	ON 
		e.BusinessEntityID = d.BusinessEntityID
);

CREATE VIEW dbo.stg_vw_erp_fact_InternetSales AS (
	SELECT 
		h.SalesOrderID,
		row_number() over(partition by h.SalesOrderID order by h.modifieddate) as saleLineNumber,
		p.ProductNumber,
		cast(h.OrderDate as date) OrderDate ,
		cast(h.DueDate as date) DueDate,
		cast(h.ShipDate as date) ShipDate,
		CustomerID,
		TerritoryID,
		N'USD' Currency,  
		null RevisionNumber,
		OrderQty,
		UnitPrice,
		UnitPriceDiscount,
		LineTotal,
		0 TaxAmt
	FROM 
		erp.SalesHeader h
	LEFT JOIN 
		erp.SalesOrderDetail o
	ON 
		h.SalesOrderID = o.SalesOrderID
	LEFT JOIN 
		erp.Product p 
	ON 
		o.ProductID = p.ProductID
	WHERE 
		OnlineOrderFlag = 1
);

CREATE VIEW dbo.stg_vw_erp_fact_ResellerSales AS (
	SELECT 
		h.SalesOrderID,
		row_number() over(partition by h.SalesOrderID order by h.modifieddate) as saleLineNumber,
		p.ProductNumber,
		cast(h.OrderDate as date) OrderDate,
		cast(h.DueDate as Date) DueDate,
		cast(h.ShipDate as date) ShipDate,
		cast(c.StoreID as nvarchar(15)) ResellerID,
		h.TerritoryID,
		e.NationalIDNumber,
		N'USD' Currency,  
		null RevisionNumber,
		OrderQty,
		UnitPrice,
		UnitPriceDiscount,
		LineTotal,
		0 TaxAmt
	 FROM 
		erp.SalesHeader h
	LEFT JOIN 
		erp.SalesOrderDetail o
	ON 
		h.SalesOrderID = o.SalesOrderID
	LEFT JOIN 
		erp.Product p 
	ON 
		o.ProductID = p.ProductID
	LEFT JOIN 
		erp.Customer c
	ON 
		h.CustomerID = c.CustomerID
	LEFT JOIN
		hr.Employee e
	ON 
		e.BusinessEntityID = h.SalesPersonID
	WHERE 
		OnlineOrderFlag = 0
);

Create VIEW dbo.stg_vw_erp_product AS (
	SELECT  
		p.ProductNumber,
		p.Name,
		p.StandardCost,
		p.Color,
		p.Size,
		null SizeRange,
		p.Name EnglishDescription,
		sc.Name as ProductSubcategoryCode,
		c.Name as ProductCategory
	 FROM 
		erp.Product p
	LEFT JOIN 
		erp.ProductSubCategory sc
	ON 
		p.ProductSubcategoryID = sc.ProductSubcategoryID
	LEFT JOIN 
		erp.ProductCategory c
	ON 
		sc.ProductCategoryID = c.ProductCategoryID
);

CREATE VIEW dbo.stg_vw_erp_reseller AS (
	SELECT 
		distinct StoreID,
		s.Name ResellerName,
		null  YearOpened,
		0 NumberEmployees,
		null BusinessType
	  FROM 
		erp.Customer c
	  LEFT JOIN
		erp.Store s
	  ON 
		c.StoreId = s.BusinessEntityId
	  WHERE 
		PersonID is null
);


ALTER TABLE erp.Business_Entity ADD  DEFAULT (getdate()) FOR Created_Dt;

ALTER TABLE erp.Currency ADD  DEFAULT (getdate()) FOR Created_Dt;

ALTER TABLE erp.Person ADD  DEFAULT (getdate()) FOR Created_Dt;

ALTER TABLE erp.PersonAddress ADD  DEFAULT (getdate()) FOR Created_Dt;

ALTER TABLE erp.Product ADD  DEFAULT (getdate()) FOR Created_Dt;

ALTER TABLE hr.Employee ADD  DEFAULT (getdate()) FOR Created_Dt;

ALTER TABLE hr.EmployeeDepartmentHistory ADD  DEFAULT (getdate()) FOR Created_Dt;