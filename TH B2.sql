USE AdventureWorks2008R2
--Câu 1
select d.SalesOrderID, OrderDate, SubTotal = sum(OrderQty * UnitPrice)
from sales.SalesOrderDetail d join Sales.SalesOrderHeader h on d.SalesOrderID = h.SalesOrderID
where  MONTH(OrderDate) = 6 and YEAR(OrderDate) = 2008  
group by d.SalesOrderID, OrderDate
having SUM(OrderQty * UnitPrice) > 70000

--Câu 2
select t.TerritoryID, CountofCus= COUNT(c.CustomerID) , Subtotal=SUM(d.OrderQty * d.UnitPrice)  
from Sales.SalesTerritory t join Sales.Customer  c on t.TerritoryID=c.TerritoryID
							join Sales.SalesOrderHeader h on h.CustomerID=h.CustomerID
							join Sales.SalesOrderDetail d on h.SalesOrderID=d.SalesOrderID
where CountryRegionCode = 'US' 
group by t.TerritoryID

--Câu 3
select SalesOrderID, CarrierTrackingNumber, Subtotal=SUM(OrderQty * UnitPrice) 
from Sales.SalesOrderDetail
group by SalesOrderID, CarrierTrackingNumber
having CarrierTrackingNumber like '4BD%'

--Câu 4
select pro.ProductID, pro.Name, AverageofQty=AVG(det.OrderQty) 
from Sales.SalesOrderDetail det join Production.Product pro on det.ProductID = pro.ProductID
where det.UnitPrice < 25
group by pro.ProductID, pro.Name
having AVG(det.OrderQty) > 5

--Câu 5
select JobTitle, CountofPerson=count(BusinessEntityID) 
from HumanResources.Employee 
group by JobTitle
having COUNT(BusinessEntityID) > 20

--Câu 6
select v.BusinessEntityID, v.Name, ProductID, sumofQty = SUM(OrderQty), SubTotal = SUM(OrderQty * UnitPrice)
from Purchasing.Vendor v 
	join Purchasing.PurchaseOrderHeader a on a.VendorID = v.BusinessEntityID
	join Purchasing.PurchaseOrderDetail b on a.PurchaseOrderID = b.PurchaseOrderID
where v.Name like '%Bicycles'
group by v.BusinessEntityID, v.Name, ProductID
having SUM(OrderQty * UnitPrice) > 800000

--Câu 7
select p.ProductID, p.Name, countofOrderID = COUNT(o.SalesOrderID), Subtotal = sum(OrderQty * UnitPrice) 
from Production.Product p join Sales.SalesOrderDetail o on p.ProductID = o.ProductID
						  join sales.SalesOrderHeader h on h.SalesOrderID = o.SalesOrderID
where Datepart(q, OrderDate) = 1 and YEAR(OrderDate) = 2008
group by p.ProductID, p.Name
having sum(OrderQty * UnitPrice) > 10000 and COUNT(o.SalesOrderID) > 500

--Câu 8
select PersonID, FirstName +' '+ LastName as Fullname, CountOfOrders=count(SalesOrderID)
from Person.Person p join Sales.Customer c on p.BusinessEntityID=c.CustomerID
					join Sales.SalesOrderHeader h on h.CustomerID= c.CustomerID
where YEAR(OrderDate) between 200 and 2008
group by PersonID, FirstName +' '+ LastName
having count(SalesOrderID)>25

--Câu 9
select p.ProductID, Name, CountofOrderQty=sum(OrderQty), yearofSale=year(OrderDate)
from Production.Product p join Sales.SalesOrderDetail d on p.ProductID=d.ProductID
						join Sales.SalesOrderHeader h on d.SalesOrderID=d.SalesOrderID
where name like '%Bike' or name like '%Sport'
group by p.ProductID, Name, year(OrderDate)
having sum(OrderQty)>500

--Câu 10
select d.DepartmentID, d.Name, AvgofRate=avg(Rate)
from HumanResources.Department d 
	join HumanResources.EmployeeDepartmentHistory h on d.DepartmentID=h.DepartmentID
	join HumanResources.EmployeePayHistory e on h.BusinessEntityID=e.BusinessEntityID
group by d.DepartmentID, d.Name
having avg(Rate)>30

--II/ SUBQUERY
--Câu 1: Liệt kê các sản phẩm gồm các thông tin product names và product ID có trên 100 đơn đặt hàng trong tháng 7 năm 2008
select ProductID, Name
from Production.Product
where ProductID in (
	select ProductID
	from  Sales.SalesOrderDetail d join Sales.SalesOrderHeader h on d.SalesOrderID=h.SalesOrderID
	where MONTH(OrderDate)=7 and YEAR(OrderDate)=2008
	group by  ProductID
	having COUNT(*)>100)
--Câu 2: Liệt kê các sản phẩm (ProductID, name) có số hóa đơn đặt hàng nhiều nhất trong tháng 7/2008
select p.ProductID, Name
from Production.Product p join Sales.SalesOrderDetail d on p.ProductID=d.ProductID
	                      join Sales.SalesOrderHeader h on d.SalesOrderID=h.SalesOrderID
where  MONTH(OrderDate)=7 and YEAR(OrderDate)=2008
group by p.ProductID, Name
having COUNT(*)>=all( select COUNT(*)
	from Sales.SalesOrderDetail d join Sales.SalesOrderHeader h on d.SalesOrderID=h.SalesOrderID
	where MONTH(OrderDate)=7 and YEAR(OrderDate)=2008
	group by ProductID)
