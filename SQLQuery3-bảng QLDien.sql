CREATE DATABASE QLDIEN
go
USE QLDIEN
go


CREATE TABLE CHINHANH (
    TenChiNhanh NVARCHAR(100) PRIMARY KEY,
    DiaDiem NVARCHAR(255))
go 

INSERT INTO CHINHANH VALUES
(N'Chi nhánh Hà Nội', N'123 Đường Láng, Hà Nội'),
(N'Chi nhánh TP.HCM', N'456 Nguyễn Trãi, TP.HCM'),
(N'Chi nhánh Đà Nẵng', N'789 Điện Biên Phủ, Đà Nẵng'),
(N'Chi nhánh Cần Thơ', N'321 Trần Hưng Đạo, Cần Thơ'),
(N'Chi nhánh Hải Phòng', N'654 Lê Lợi, Hải Phòng');
SELECT * FROM CHINHANH
go 

CREATE TABLE TRAMDIEN (
    MaTramDien INT PRIMARY KEY,
    TenTram NVARCHAR(100),
    DiaDanh NVARCHAR(255),
    TenChiNhanh NVARCHAR(100),
    FOREIGN KEY (TenChiNhanh) REFERENCES CHINHANH(TenChiNhanh))
go

INSERT INTO TRAMDIEN VALUES
(1, N'Trạm Hà Nội 1', N'Quận Đống Đa', N'Chi nhánh Hà Nội'),
(2, N'Trạm TP.HCM 1', N'Quận 5', N'Chi nhánh TP.HCM'),
(3, N'Trạm Đà Nẵng 1', N'Hải Châu', N'Chi nhánh Đà Nẵng'),
(4, N'Trạm Cần Thơ 1', N'Ninh Kiều', N'Chi nhánh Cần Thơ'),
(5, N'Trạm Hải Phòng 1', N'Ngô Quyền', N'Chi nhánh Hải Phòng');
SELECT * FROM TRAMDIEN
go 

CREATE TABLE KHACHHANG (
    MaKhachHang INT PRIMARY KEY,
    Ten NVARCHAR(100),
    DiaChi NVARCHAR(255),
    SoDienThoai NVARCHAR(15),
    TenChiNhanh NVARCHAR(100),
    FOREIGN KEY (TenChiNhanh) REFERENCES CHINHANH(TenChiNhanh))
go 

INSERT INTO KHACHHANG VALUES
(101, N'Nguyễn Văn A', N'1A Láng Hạ, Hà Nội', N'0901234567', N'Chi nhánh Hà Nội'),
(102, N'Trần Thị B', N'12 Nguyễn Trãi, TP.HCM', N'0912345678', N'Chi nhánh TP.HCM'),
(103, N'Lê Văn C', N'3 Hoàng Diệu, Đà Nẵng', N'0933456789', N'Chi nhánh Đà Nẵng'),
(104, N'Phạm Thị D', N'45 30/4, Cần Thơ', N'0944567890', N'Chi nhánh Cần Thơ'),
(105, N'Hoàng Văn E', N'23 Cầu Đất, Hải Phòng', N'0955678901', N'Chi nhánh Hải Phòng');
SELECT * FROM KHACHHANG
go

CREATE TABLE DIENKE (
    SoDienKe INT PRIMARY KEY,
    MaTramDien INT,
    MaKhachHang INT,
    FOREIGN KEY (MaTramDien) REFERENCES TRAMDIEN(MaTramDien),
    FOREIGN KEY (MaKhachHang) REFERENCES KHACHHANG(MaKhachHang))
go

INSERT INTO DIENKE VALUES
(1001, 1, 101),
(1002, 2, 102),
(1003, 3, 103),
(1004, 4, 104),
(1005, 5, 105);
SELECT * FROM DIENKE
go

CREATE TABLE NHANVIEN (
    MaNhanVien INT PRIMARY KEY,
    TenNhanVien NVARCHAR(100))
go 

INSERT INTO NHANVIEN VALUES
(201, N'Nguyễn Nhân Viên 1'),
(202, N'Trần Nhân Viên 2'),
(203, N'Lê Nhân Viên 3'),
(204, N'Phạm Nhân Viên 4'),
(205, N'Hoàng Nhân Viên 5');
SELECT * FROM NHANVIEN
go

CREATE TABLE SODIENKE (
    SoDienKe INT,
    MaNhanVien INT,
    NgayGhi DATE,
    ChiSoMoi INT,
    ChiSoCu INT,
    ChiSo AS (ChiSoMoi - ChiSoCu), 
    PRIMARY KEY (SoDienKe, NgayGhi),
    FOREIGN KEY (SoDienKe) REFERENCES DIENKE(SoDienKe),
    FOREIGN KEY (MaNhanVien) REFERENCES NHANVIEN(MaNhanVien))
go

INSERT INTO SODIENKE (SoDienKe, MaNhanVien, NgayGhi, ChiSoMoi, ChiSoCu) VALUES
(1001, 201, '2025-01-01', 1300, 1200),  
(1002, 202, '2025-01-01', 1600, 1500),  
(1003, 203, '2025-01-01', 1900, 1800),  
(1004, 204, '2025-01-01', 1150, 1100),  
(1005, 205, '2025-01-01', 1350, 1300);  
SELECT * FROM SODIENKE
go

BACKUP DATABASE QLDIEN
TO DISK = 'D:\Backup\QLDIEN.bak'
WITH FORMAT, INIT, NAME = 'Backup QLDIEN Database'
go


