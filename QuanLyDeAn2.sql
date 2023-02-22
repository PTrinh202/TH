USE QuanLyDeAn2
create table DEAN(
MaDA varchar(2) primary key,
TenDA nvarchar(50) null,
DiemDA varchar(20) null
);

create table PHANCONG(
MaNV varchar(9) primary key,
MaDA varchar(2) foreign key (MaDA) references DEAN(MaDA),
ThoiGian numeric(18,0) null
);

create table NHANVIEN(
MaNV varchar(9) primary key,
HoNV nvarchar(15) null,
TenLot nvarchar(30) null,
TenNV nvarchar(30) null,
NgSinh smalldatetime null,
DiaChi nvarchar(150) null,
Phai nvarchar(3) null,
Luong numeric(18,0) null,
Phong varchar(2)
);

create table PHONGBAN(
MaPhg varchar(2) primary key,
TenPhg nvarchar(20) null
);

create table THANNHAN(
MaNV varchar(9) primary key,
TenTN varchar(20) foreign key (MaNV) references NHANVIEN(MaNV),
NgaySinh smalldatetime null,
Phai varchar(3) null,
QuanHe varchar(15) null
);

--Câu 4:
alter table PHONGBAN alter column TenPhg nvarchar(30);

alter table DEAN alter column DiemDA nvarchar(20);

alter table THANNHAN alter column TenTN nvarchar(20);
alter table THANNHAN alter column Phai nvarchar(3);
alter table THANNHAN alter column QuanHe nvarchar(15);

alter table NHANVIEN add SoDienThoai varchar(15);

alter table NHANVIEN
drop column SoDienThoai;

--Câu 5:
insert into NHANVIEN 
(MaNV, HoNV, TenLot,TenNV, NgSinh, DiaChi,Phai,Luong,Phong)
values (123, 'Đinh', 'Bá', 'Tiến', 1982-02-27, 'Mộ Đức', 'Nam', '', 4),
	(234, 'Nguyễn', 'Thanh', 'Tùng', 1956-8-12, 'Sơn Tịnh','','Nam',5),
	(345, 'Bùi', 'Thúy', 'Vũ', '', 'Tư Nghĩa','Nữ','',4),
	(567, 'Nguyễn', 'Mạnh', 'Hùng', 1985-3-25, 'Sơn Tịnh', 'Nam', '', 5),
	(678, 'Trần ', 'Hồng', 'Quang', '', 'Bình Sơn', 'Nam', '',5);

insert into PHONGBAN
(MaPhg,TenPhg)
values
(1,'Quản Lý'),
(4,'Điều Hành'),
(5,'Nghiên Cứu');

insert into DEAN
(MaDA,TenDA,DiemDA)
values
(1,'Nâng cao cắp muối ','Sa Huỳnh'),
(10,'Xây dựng máu chế biến thủy sản ','Dung Quất'),
(2,'Phát triển ha tầng mạng ','Quảng Ngãi'),
(20,'Truyền tải cơ quan ','Quảng Ngãi'),
(3,'Tin học hóa trường học ','BaTo');

insert into PHANCONG
(MaNV,MaDA,ThoiGian)
values
(123,1,33),
(123,2,8),
(345,10,10),
(345,20,10),
(456,1,20),
(456,2,20);
--Câu 6
