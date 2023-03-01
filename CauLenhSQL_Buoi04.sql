use QuanLyDeAn2

--Câu 1:
select *
from NHANVIEN
--Câu 2:
select MaNV, HoNV, TenLot, TenNV
from NHANVIEN 
where Phong = 5
--Câu 3:
select MaNV, HoNV, TenLot, TenNV, Luong, Phong
from NHANVIEN 
where LUONG > 6000000
--Câu 4:
select MaNV, HoNV, TenLot
from NHANVIEN 
where LUONG > 6500000 and Phong = 1 or LUONG > 5000000 and Phong = 4
--Câu 5:
select MaNV, HoNV, TenLot, TenNV, Luong, Phong
from NHANVIEN, DIADIEM_PHG
where NHANVIEN.Phong = DIADIEM_PHG.MAPHG and DIADIEM_PHG.DIADIEM = 'QUANG NGAI'
--Câu 6:
select HoNV + ' ' +TenLot+ ' ' +TenNV as 'Họ Và Tên'
from NHANVIEN
where NHANVIEN.HoNV like N'N%'
--Câu 7:
select NHANVIEN.NgSinh, NHANVIEN.DiaChi
from NHANVIEN
where NHANVIEN.HoNV = N'Cao' and
		NHANVIEN.TenLot = N'Thanh' and
		NHANVIEN.TenNV = N'Huyền'
--câu 8:
SELECT * FROM NHANVIEN
WHERE NgSinh BETWEEN 1955 AND 1975;
-- câu 9:
select HoNV + ' ' +TenLot+ ' ' +TenNV as 'Họ Và Tên' , YEAR(NgSinh) as 'Năm Sinh'
from NHANVIEN
--Câu 10:
select HoNV + ' ' +TenLot+ ' ' +TenNV as 'Họ Và Tên' , (2023 - YEAR(NgSinh)) as 'Tuổi' from NHANVIEN
--Câu 11:
select HoNV + ' ' +TenLot+ ' ' +TenNV as 'Họ và tên Trưởng Phòng' from PHONGBAN,NHANVIEN
where PHONGBAN.TRPHG = NHANVIEN.MANV
--Câu 12:
select HoNV+ ' ' +TenLot+ ' ' +TenNV as 'Họ và tên', DiaChi from NHANVIEN inner join PHONGBAN on NHANVIEN.Phong = PHONGBAN.MAPHG
where PHONGBAN.MAPHG = 4
--Câu 13:
select TenDA, TenPhg, HoNV+ ' ' +TenLot+ ' ' +TenNV as 'Họ và tên', NG_NHANCHUC 
from NHANVIEN inner join PHONGBAN 
ON NHANVIEN.Phong = PHONGBAN.MAPHG 
inner join DEAN ON DEAN.Phong = PHONGBAN.MAPHG
where PHONGBAN.TRPHG = NHANVIEN.MANV and DiaChi like '%Tp Quảng Ngãi'
--Câu 14:
select HoNV+ ' ' +TenLot+ ' ' +TenNV as 'Họ và tên', TenTN as 'Tên người thân' 
from NHANVIEN inner join THANNHAN ON NHANVIEN.MANV = THANNHAN.MaNV
where NHANVIEN.PHAI = N'Nữ'
--Câu 15:
select NV.HoNV + ' ' + NV.TenLot + ' ' + NV.TenNV as 'Họ và tên nhân viên', QL.HoNV+ ' ' + QL.TenLot + ' ' + QL.TenNV as 'Họ và tên quản lí'
from NHANVIEN NV,NHANVIEN QL
where NV.MA_NQL = QL.MANV
--Câu 16:
select HoNV+ ' ' + TenLot + ' ' + TenNV as 'Họ và tên' 
from NHANVIEN inner join DEAN ON NHANVIEN.Phong = DEAN.Phong
where DEAN.TenDA= 'Xây dựng nhà máy chế biến thủy sản'
--Câu 17:
select TenDA as 'Tên đề án'
from NHANVIEN inner join DEAN ON NHANVIEN.Phong = DEAN.Phong
where NHANVIEN.HoNV = N'Trần' and NHANVIEN.TenLot = N'Thanh' and NHANVIEN.TenNV = N'Tâm'
--Câu 18:
select count(*)
from DEAN
go
--Câu 19:
select TenPhg,count(*)
from PHONGBAN,DEAN
where MaPhg = Phong
group by TenPhg
--DEAN
select*
from DEAN
--Câu 20:
select TenPhg,COUNT(*) as 'Số lượng phòng ban làm việc'
from PHONGBAN,DEAN
where MaPhg = phong
group by TenDA
--Câu 21:
select count(*)
from PHONGBAN,DEAN
where Phong=MaPhg and TenPhg like N'Nghiên cứu'
--DEAN
select *
from DEAN
--phancong
select *
from PHANCONG
--nhanvien
select*
from NHANVIEN
go
--Câu 22:
select avg(Luong) as 'Lương Trung Bình của các NV nữ'
from NHANVIEN
where Phai like N'Nữ'
go
--Câu 23:
	select count(*) as 'Số thân nhân của tiến'
	from NHANVIEN,THANNHAN
	where MaNV=MA_NVIEN and HoNV = N'Đinh' and TenLot=N'Bá' and TenNV=N'Tiến'
go
--Câu 25:
select DEAN.MADA,sum(PHANCONG.THOIGIAN) as 'Tổng giờ làm'
from PHANCONG,DEAN
where PHANCONG.MaDA = DEAN.MaDA
group by DEAN.MaDA 
--Câu 26:
select DEAN.TenDA,sum(PHANCONG.THOIGIAN) as 'Tổng giờ làm'
from PHANCONG,DEAN
where PHANCONG.MaDA = DEAN.MaDA
group by DEAN.TenDA 
--Câu 27:
select MADA, count(*)
from PHANCONG,NHANVIEN
where MaNV=MA_NVIEN
group by MaDA
go
--Câu 28:
go
select HoNV+' '+TenNV as 'Họ Và Tên',count(*) as 'Số lượng thân nhân'
from NHANVIEN,THANNHAN
where MaNV = MA_NVIEN
group by HoNV,TenNV
go
--Câu 29:
go
select HoNV, TenNV,count(*)
from NHANVIEN,PHANCONG
where MaNV=MA_NVIEN
group by HoNV,TenNV
go
--Câu 30:
select TenPhg,AVG(LUONG)
from PHONGBAN,NHANVIEN
where MaPhg = Phong
group by TenPhg
go
--Câu 31:
go
select TenPhg,COUNT(*) as 'Số lượng nhân viên làm việc'
from PHONGBAN,NHANVIEN
where MaPhg = Phong
group by TenPhg
having avg(LUONG)>5200000
go
--Câu 32:
go	
select TenPhg,count(*)
from PHONGBAN,DEAN
where MaPhg = Phong
group by TENPHG
--dean
select*
from DEAN
go
--Câu 33:
go
select TenPhg,HoNV,TenLot,TenNV,count(*) as 'Số lượng đề án'
	from PHONGBAN,NHANVIEN,DEAN
	where MaNV=TRPHG and MaPhg=Phong
	group by TenPhg,HoNV,TenLot,TenNV
go
--Câu 34:
go
	select DEAN.TenDA,count(TenNV) as 'Số lượng NV'
	from DEAN,NHANVIEN
	where DEAN.MaDA = NHANVIEN.MaNV
	group by DEAN.TenDA
go