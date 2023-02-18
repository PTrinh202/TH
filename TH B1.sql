--Câu 1
Exec sp_addtype 'Mota', 'nvarchar(40)', 'null'
Exec sp_addtype 'IDKH', 'char(10)', 'Not null'
Exec sp_addtype 'DT', 'char(12)', 'null'

--Câu 2:
CREATE TABLE dbo.SanPham (
MaSP CHAR(6) NOT NULL,
TenSP VARCHAR(20),
NgayNhap Date,
DVT CHAR(10),
SoLuongTon INT,
DonGiaNhap money,
)

CREATE TABLE dbo.HoaDon (
MaHD CHAR(10) NOT NULL,
NgayLap Date,
NgayGiao Date,
MaKH IDKH,
DienGiai VARCHAR(20),
)

CREATE TABLE dbo.KhachHang (
MaKH IDKH,
TenKH NVARCHAR(30),
DiaCHi NVARCHAR(40),
DienThoai DT,
)

CREATE TABLE dbo.ChiTietHD (
MaHD CHAR(10) NOT NULL,
MaSP CHAR(6) NOT NULL,
SoLuong INT
)
--Câu 3: Trong Table HoaDon, sửa cột DienGiai thành nvarchar(100).
ALTER TABLE HoaDon
ALTER COLUMN DienGiai NVARCHAR(100)
--Câu 4: Thêm vào bảng SanPham cột TyLeHoaHong float
ALTER TABLE SanPham
ADD TyLeHoaHong float

--Câu 5: Xóa cột NgayNhap trong bảng SanPham
ALTER TABLE SanPham
DROP COLUMN NgayNhap

--Câu 6: Tạo các ràng buộc khóa chính và khóa ngoại cho các bảng trên
ALTER TABLE SanPham
ADD
CONSTRAINT pk_sp primary key(MASP)

ALTER TABLE HoaDon
ADD
CONSTRAINT pk_hd primary key(MaHD)

ALTER TABLE KhachHang
ADD
CONSTRAINT pk_khanghang primary key(MaKH)

ALTER TABLE HoaDon
ADD
CONSTRAINT fk_khachhang_hoadon FOREIGN KEY(MaKH) REFERENCES KhachHang(MaKH)

ALTER TABLE ChiTietHD
ADD
CONSTRAINT fk_hoadon_chitiethd FOREIGN KEY(MaHD) REFERENCES HoaDon(MaHD)

ALTER TABLE ChiTietHD
ADD
CONSTRAINT fk_sanpham_chitiethd FOREIGN KEY(MaSP) REFERENCES SanPham(MaSP)

--Câu 7: Thêm vào bảng HoaDon các ràng buộc
ALTER TABLE HoaDon
ADD CHECK (NgayGiao > NgayLap)

ALTER TABLE HoaDon
ADD CHECK (MaHD like '[A-Z][A-Z][0-9][0-9][0-9][0-9]')

ALTER TABLE HoaDon
ADD CONSTRAINT df_ngaylap DEFAULT GETDATE() FOR NgayLap
--Câu 8: Thêm vào bảng Sản phẩm các ràng buộc
ALTER TABLE SanPham
ADD CHECK (SoLuongTon > 0 and SoLuongTon < 50)

ALTER TABLE SanPham
ADD CHECK (DonGiaNhap > 0)

ALTER TABLE SanPham
ADD CONSTRAINT df_ngaynhap DEFAULT GETDATE() FOR NgayNhap

ALTER TABLE SanPham
ADD CHECK (DVT like 'KG''Thùng''Hộp''Cái')

--Câu 9: Dùng lệnh T-SQL nhập dữ liệu vào 4 table trên, dữ liệu tùy ý, chú ý các ràng buộc của mỗi Table
INSERT INTO dbo.SanPham
(MaSP, TenSP, NgayNhap, DVT, SoLuongTon, DonGiaNhap)
VALUES
('SP1', 'Bút chì', '2023-12-12', 'Cây', 1000, 50000),
('SP2', 'Bút mực', '2023-06-12', 'Cây', 560, 12000),
('SP3', 'Bút lông', '2023-12-11', 'Cây', 2300, 6000),
('SP4', 'Ngòi bút', '2023-11-11', 'Cây', 5000, 70000);

INSERT INTO dbo.HoaDon
(MaHD, NgayLap, NgayGiao, MaKH, DienGiai)
VALUES 
('HD01','2022-01-23', '2022-05-13', 'KH01',''),
('HD02','2022-02-24', '2022-05-14', 'KH02',''),
('HD03','2022-03-25', '2022-05-15', 'KH03',''),
('HD04','2022-04-26', '2022-05-16', 'KH04','');

INSERT INTO dbo.KhachHang
(MaKH, TenKH, DiaCHi, DienThoai)
VALUES 
('KH01', 'Nguyễn Lê Thảo Quyên', 'Đắk Nông', '0123456781'),
('KH02', 'Lý Thị Quế Trân', 'Tiền Giang', '0987456231'),
('KH03', 'Trương Thị Hoàng Đoang Trang', 'Bình Dương', '0564895122'),
('KH04', 'Đặng Văn Tiên', 'Bình Định', '0723541541');

INSERT INTO dbo.ChiTietHD
(MaHD, MaSP, SoLuong)
VALUES
('HD01', 'SP1', 700),
('HD02', 'SP2', 500),
('HD03', 'SP3', 800),
('HD04', 'SP4', 600);

--Câu 10: 10.Xóa 1 hóa đơn bất kỳ trong bảng HoaDon. Có xóa được không? Tại sao? Nếu 
--vẫn muốn xóa thì phải dùng cách nào?
DELETE FROM HoaDon
WHERE MaHD = 'HD04';
--Xóa được

--Câu 11: Nhập 2 bản ghi mới vào bảng ChiTietHD với MaHD = ‘HD999999999’ và MaHD=’1234567890’. 
--Có nhập được không? Tại sao?
/*Không, vì thiết lập kiểu dữ liệu dạng chuỗi quy định số ký tự quá ít nên khi chèn dữ liệu 
có độ dài lớn hơn qui định sẽ xảy ra lỗi "String or binary data would be truncated."*/
INSERT INTO dbo.ChiTietHD
VALUES
('HD999999999', 'SP5', 200),
('1234567890', 'SP6', 100);

--Câu 12: Đổi tên CSDL Sales thành BanHang
ALTER DATABASE Sales MODIFY NAME = BanHang;

--Câu 13: 

--Câu 14:
BACKUP DATABASE BanHang to disk = 'C:\BanHang.bak'

--câu 15: Xóa CSDL BanHang
DROP database BanHang

--Câu 16: Phục hồi CSDL BanHang
RESTORE DATABASE BanHang from disk = 'C:\BanHang.bak' with replace