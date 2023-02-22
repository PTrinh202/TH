CREATE DATABASE QLKHO
use	QLKHO

create table Ton (
    MaVT VARCHAR(10) PRIMARY KEY,
    TenVT VARCHAR(50) NOT NULL,
    SoLuongT INT NOT NULL,
);
create table Nhap (
    SoHDN INT PRIMARY KEY,
    MaVT VARCHAR(10) NOT NULL,
    SoLuongN INT NOT NULL,
    DonGiaN INT NOT NULL,
    NgayN DATE NOT NULL,
    FOREIGN KEY (MaVT) REFERENCES Ton(MaVT)
);
create table Xuat (
	SoHDX INT PRIMARY KEY,
	MaVT VARCHAR(10),
	SoLuongX INT NOT NULL,
    DonGiaX INT NOT NULL,
    NgayX DATE NOT NULL,
    FOREIGN KEY (MaVT) REFERENCES Ton(MaVT)
);

INSERT INTO Ton VALUES ('VT001', 'Vật tư 1', 10);
INSERT INTO Ton VALUES ('VT002', 'Vật tư 2', 5);
INSERT INTO Ton VALUES ('VT003', 'Vật tư 3', 15);
INSERT INTO Ton VALUES ('VT004', 'Vật tư 4', 20);
INSERT INTO Ton VALUES ('VT005', 'Vật tư 5', 25);

INSERT INTO Nhap VALUES (1, 'VT001', 10, 1000, '2020-01-01');
INSERT INTO Nhap VALUES (2, 'VT002', 5, 2000, '2020-01-02');
INSERT INTO Nhap VALUES (3, 'VT003', 15, 500, '2020-01-03');

INSERT INTO Xuat VALUES (1, 'VT001', 5, 500, '2020-02-01');
INSERT INTO Xuat VALUES (2, 'VT002', 2, 1500, '2020-02-02');
GO
--Câu 2: 
create view CAU2
as
select ton.MaVT,TenVT,sum(SoLuongX*DonGiaX) as 'Tiền Bán'
from Xuat inner join ton on Xuat.MaVT=ton.MaVT
group by ton.MaVT, TenVT
GO
--TEST
SELECT * FROM CAU2
GO
--Câu 3:
create view CAU3
as
select ton.TenVT, sum(SoLuongX) as SoLuongT
from xuat inner join ton on xuat.MaVT=ton.MaVT
group by ton.TenVT
GO
--TEST
SELECT * FROM CAU3
GO
--Câu 4:
create view CAU4
as
select ton.TenVT, SUM(SoLuongN) as SoLuongNhap
from Nhap inner join ton on Nhap.MaVT=ton.MaVT
group by ton.TenVT
GO
--TEST
SELECT * FROM CAU4
GO
--Câu 5:
create view CAU5
as
select ton.MaVT,ton.TenVT,sum(SoLuongN)-sum(SoLuongX) +
sum(SoLuongT) as tongton
from nhap inner join ton on nhap.MaVT=ton.MaVT
 inner join xuat on ton.mavt=xuat.mavt
group by ton.MaVT,ton.TenVT
GO
--TEST 
SELECT * FROM CAU5
GO
--Câu 6:
create view CAU6
as 
select TenVT
from ton
where SoLuongT = (select max(SoLuongT) from Ton)
GO
--TEST
SELECT * FROM CAU6
GO
--Câu 7:
create view CAU7
as
select ton.MaVT,ton.TenVT
from ton inner join xuat on ton.MaVT=xuat.MaVT
group by ton.MaVT,ton.TenVT
having sum(SoLuongX)>=100
GO
--TEST
SELECT * FROM CAU7
GO
--Câu 8:
CREATE VIEW CAU8
AS
SELECT MONTH(NgayX) AS "Tháng xuất", YEAR(NgayX) AS "Năm xuất", SUM(SoLuongX) AS Total_Quantity
FROM Xuat
GROUP BY MONTH(NgayX), YEAR(NgayX);
GO
--TEST
SELECT * FROM CAU8
GO
--Câu 9:
CREATE VIEW CAU9 AS
SELECT t.MaVT, t.TenVT,n.SoLuongN,x.SoLuongX, n.DonGiaN,x.DonGiaX, n.NgayN, x.NgayX
FROM Ton t
INNER JOIN Nhap n ON t.MaVT = n.MaVT
INNER JOIN Xuat x ON t.MaVT = x.MaVT;
GO
SELECT * FROM CAU9
GO 
--Câu 10:
CREATE VIEW CAU10 AS
SELECT t.MaVT, t.TenVT, SUM(n.SoLuongN-x.SoLuongX+t.SoLuongT) as "SL còn lại"
FROM Ton t
INNER JOIN Nhap n ON t.MaVT = n.MaVT
INNER JOIN Xuat x ON t.MaVT = x.MaVT
WHERE YEAR(n.NgayN) = 2015 OR YEAR(x.NgayX) = 2015
GROUP BY t.MaVT,t.TenVT;
GO
--TEST
SELECT * FROM CAU10