

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
    SoDienThoai NVARCHAR(15))
go 

INSERT INTO KHACHHANG VALUES
(101, N'Nguyễn Văn A', N'1A Láng Hạ, Hà Nội', N'0901234567'),
(102, N'Trần Thị B', N'12 Nguyễn Trãi, TP.HCM', N'0912345678'),
(103, N'Lê Văn C', N'3 Hoàng Diệu, Đà Nẵng', N'0933456789'),
(104, N'Phạm Thị D', N'45 30/4, Cần Thơ', N'0944567890'),
(105, N'Hoàng Văn E', N'23 Cầu Đất, Hải Phòng', N'0955678901');
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

CREATE TABLE CHISODIEN (
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

INSERT INTO CHISODIEN (SoDienKe, MaNhanVien, NgayGhi, ChiSoMoi, ChiSoCu) VALUES
(1001, 201, '2025-01-01', 1300, 1200),  
(1002, 202, '2025-01-01', 1600, 1500),  
(1003, 203, '2025-01-01', 1900, 1800),  
(1004, 204, '2025-01-01', 1150, 1100),  
(1005, 205, '2025-01-01', 1350, 1300);  
SELECT * FROM CHISODIEN
go

-- Câu 1: Liệt kê tên khách hàng, địa chỉ và tên chi nhánh họ thuộc về
SELECT KH.Ten AS TenKhachHang,KH.DiaChi,CN.TenChiNhanh
FROM KHACHHANG KH
JOIN DIENKE DK ON KH.MaKhachHang = DK.MaKhachHang
JOIN TRAMDIEN TD ON DK.MaTramDien = TD.MaTramDien
JOIN CHINHANH CN ON TD.TenChiNhanh = CN.TenChiNhanh
-- Kết quả: 5 hàng

-- Câu 2: Liệt kê tên trạm điện, địa danh, và địa điểm chi nhánh tương ứng
SELECT TD.TenTram, TD.DiaDanh, CN.DiaDiem
FROM TRAMDIEN TD
JOIN CHINHANH CN ON TD.TenChiNhanh = CN.TenChiNhanh
-- Kết quả: 5 hàng

-- Câu 3: Cập nhật số điện thoại của khách hàng có mã là 101 thành '0988888888'
UPDATE KHACHHANG
SET SoDienThoai = '0988888888'
WHERE MaKhachHang = 101
-- Kết quả: 1 hàng

-- Câu 4: Cập nhật địa danh của trạm điện thuộc 'Chi nhánh Cần Thơ' thành 'Quận Ninh Kiều'
UPDATE TRAMDIEN
SET DiaDanh = N'Quận Ninh Kiều'
WHERE TenChiNhanh = N'Chi nhánh Cần Thơ'
-- Kết quả: 1 hàng

-- Câu 5: Xoá khách hàng có tên là 'Lê Văn C'
INSERT INTO CHINHANH VALUES (N'Chi nhánh Quảng Ninh', N'100 Lê Thánh Tông, Quảng Ninh')
DELETE FROM CHINHANH WHERE TenChiNhanh = N'Chi nhánh Quảng Ninh'

-- Câu 6: Xoá tất cả trạm điện thuộc những chi nhánh không còn khách hàng nào
DELETE FROM TRAMDIEN
WHERE TenChiNhanh NOT IN (
    SELECT DISTINCT TenChiNhanh FROM KHACHHANG
)

-- Câu 7: Đếm số lượng khách hàng ở mỗi chi nhánh
SELECT CN.TenChiNhanh, COUNT(KH.MaKhachHang) AS SoLuongKhachHang
FROM KHACHHANG KH
JOIN DIENKE DK ON KH.MaKhachHang = DK.MaKhachHang
JOIN TRAMDIEN TD ON DK.MaTramDien = TD.MaTramDien
JOIN CHINHANH CN ON TD.TenChiNhanh = CN.TenChiNhanh
GROUP BY CN.TenChiNhanh
-- Kết quả: 5 hàng

-- Câu 8: Đếm số lượng trạm điện theo mỗi chi nhánh
SELECT TenChiNhanh, COUNT(*) AS SoLuongTram
FROM TRAMDIEN
GROUP BY TenChiNhanh
-- Kết quả: 4 hàng

-- Câu 9: Liệt kê tên và số điện thoại khách hàng thuộc chi nhánh có địa điểm là '456 Nguyễn Trãi, TP.HCM'
SELECT KH.Ten AS TenKhachHang,KH.SoDienThoai
FROM KHACHHANG KH
JOIN DIENKE DK ON KH.MaKhachHang = DK.MaKhachHang
JOIN TRAMDIEN TD ON DK.MaTramDien = TD.MaTramDien
JOIN CHINHANH CN ON TD.TenChiNhanh = CN.TenChiNhanh
WHERE CN.DiaDiem = N'456 Nguyễn Trãi, TP.HCM'
-- Kết quả: 1 hàng

-- Câu 10: Liệt kê tê khách hàng có mức sử dụng điện nhiều nhất
SELECT KH.Ten AS TenKhachHang, CSD.SoDienKe, CSD.NgayGhi, CSD.ChiSo
FROM CHISODIEN CSD
JOIN DIENKE DK ON CSD.SoDienKe = DK.SoDienKe
JOIN KHACHHANG KH ON DK.MaKhachHang = KH.MaKhachHang
WHERE 
    CSD.ChiSo = (
        SELECT MAX(ChiSo)
        FROM CHISODIEN
    )
-- Kết quả: 1 hàng

-- Câu 11: Liệt kê tất cả các khách hàng ở Hà Nội (địa chỉ chứa 'Hà Nội')
SELECT *
FROM KHACHHANG
WHERE DiaChi LIKE N'%Hà Nội%'
-- Kết quả: 2 hàng

-- Câu 12: Tìm tên chi nhánh và tên và số điện thoại của những khách hàng tên bắt đầu bằng 'Nguyễn'
SELECT CN.TenChiNhanh, KH.SoDienThoai, KH.Ten AS TenKhachHang
FROM KHACHHANG KH
JOIN DIENKE DK ON KH.MaKhachHang = DK.MaKhachHang
JOIN TRAMDIEN TD ON DK.MaTramDien = TD.MaTramDien
JOIN CHINHANH CN ON TD.TenChiNhanh = CN.TenChiNhanh
WHERE KH.Ten LIKE N'Nguyễn%';
-- Kết quả: 1 hàng



