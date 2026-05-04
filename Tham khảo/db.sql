CREATE DATABASE IF NOT EXISTS `hhhh1` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `hhhh1`;

SET NAMES utf8mb4;
SET SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO';
SET FOREIGN_KEY_CHECKS = 0;
START TRANSACTION;

DROP TABLE IF EXISTS `chamcong`;
DROP TABLE IF EXISTS `congtac`;
DROP TABLE IF EXISTS `danhgia`;
DROP TABLE IF EXISTS `kiennghi`;
DROP TABLE IF EXISTS `nghiphep`;
DROP TABLE IF EXISTS `nhanvien`;
DROP TABLE IF EXISTS `phongban`;
DROP TABLE IF EXISTS `taikhoan`;
DROP TABLE IF EXISTS `vaitro`;
DROP TABLE IF EXISTS `hopdong`;
DROP TABLE IF EXISTS `chucvu`;
DROP TABLE IF EXISTS `bangcap`;
DROP TABLE IF EXISTS `bacluong`;
DROP TABLE IF EXISTS `calamviec`;

CREATE TABLE `calamviec` (
  `MACALAMVIEC` char(36) NOT NULL COMMENT 'ID ca làm việc',
  `MACALAMVIEC_CODE` varchar(20) NOT NULL COMMENT 'Mã ca làm việc',
  `TENCALAMVIEC` varchar(50) NOT NULL COMMENT 'Tên ca làm việc',
  `THOIGIAN_BATDAU` time NOT NULL COMMENT 'Thời gian bắt đầu ca',
  `THOIGIAN_BATDAU_NGHI` time DEFAULT NULL COMMENT 'Thời gian bắt đầu nghỉ giữa ca',
  `THOIGIAN_KETTHUC` time NOT NULL COMMENT 'Thời gian kết thúc ca',
  `THOIGIAN_KETTHUC_NGHI` time DEFAULT NULL COMMENT 'Thời gian kết thúc nghỉ giữa ca',
  `THOIGIAN_LAMVIEC` decimal(5,2) NOT NULL COMMENT 'Tổng thời gian làm việc (giờ)',
  `THOIGIAN_NGHI` decimal(5,2) NOT NULL DEFAULT 0.00 COMMENT 'Tổng thời gian nghỉ (giờ)',
  `TRANGTHAIHOATDONG` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'Trạng thái: 1-Hoạt động, 0-Ngừng',
  `NGUOITAO` varchar(255) NOT NULL COMMENT 'Người tạo',
  `NGAY_TAO` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Ngày tạo',
  `NGUOISUA` varchar(255) DEFAULT NULL COMMENT 'Người sửa',
  `NGAY_SUA` datetime DEFAULT NULL COMMENT 'Ngày sửa',
  `MOTA` varchar(255) DEFAULT NULL COMMENT 'Mô tả',
  PRIMARY KEY (`MACALAMVIEC`),
  UNIQUE KEY `uix_calamviec_code` (`MACALAMVIEC_CODE`),
  KEY `ix_calamviec_tencalamviec` (`TENCALAMVIEC`)
);

CREATE TABLE `bacluong` (
  `MABACLUONG` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã bậc lương',
  `LUONGCOBAN` decimal(15,2) NOT NULL COMMENT 'Lương cơ bản',
  `PHUCAP` decimal(15,2) NOT NULL COMMENT 'Phụ cấp',
  `TENBACLUONG` varchar(45) NOT NULL COMMENT 'Tên bậc lương',
  `THAMNIEN` varchar(45) NOT NULL COMMENT 'Khoảng thâm niên',
  PRIMARY KEY (`MABACLUONG`),
  UNIQUE KEY `uix_bacluong_ten` (`TENBACLUONG`)
);

CREATE TABLE `bangcap` (
  `MABANGCAP` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã bằng cấp',
  `TENBANGCAP` varchar(100) NOT NULL COMMENT 'Tên bằng cấp',
  `MOTABANGCAP` longtext DEFAULT NULL COMMENT 'Mô tả bằng cấp',
  `NGAYTAO` date NOT NULL COMMENT 'Ngày tạo',
  `HESOLUONG` decimal(4,2) DEFAULT NULL COMMENT 'Hệ số lương',
  PRIMARY KEY (`MABANGCAP`),
  UNIQUE KEY `uix_bangcap_ten` (`TENBANGCAP`)
);

CREATE TABLE `chucvu` (
  `MACHUCVU` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã chức vụ',
  `TENCHUCVU` varchar(50) NOT NULL COMMENT 'Tên chức vụ',
  `MOTACHUCVU` longtext DEFAULT NULL COMMENT 'Mô tả chức vụ',
  `NGAYTAOCHUCVU` date NOT NULL COMMENT 'Ngày tạo',
  `PHUCAP` decimal(15,2) DEFAULT NULL COMMENT 'Phụ cấp',
  `HESOLUONG` decimal(4,2) NOT NULL COMMENT 'Hệ số lương',
  PRIMARY KEY (`MACHUCVU`),
  UNIQUE KEY `uix_chucvu_ten` (`TENCHUCVU`)
);

CREATE TABLE `hopdong` (
  `MAHOPDONG` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã hợp đồng',
  `TENHOPDONG` varchar(45) NOT NULL COMMENT 'Tên hợp đồng',
  `MOTAHOPDONG` longtext DEFAULT NULL COMMENT 'Mô tả hợp đồng',
  PRIMARY KEY (`MAHOPDONG`)
);

CREATE TABLE `vaitro` (
  `MAVAITRO` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã vai trò',
  `TENVAITRO` varchar(50) NOT NULL COMMENT 'Tên vai trò',
  PRIMARY KEY (`MAVAITRO`),
  UNIQUE KEY `uix_vaitro_ten` (`TENVAITRO`)
);

CREATE TABLE `taikhoan` (
  `MATAIKHOAN` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã tài khoản',
  `TENTAIKHOAN` varchar(45) NOT NULL COMMENT 'Tên tài khoản đăng nhập',
  `MATKHAU` varchar(255) NOT NULL COMMENT 'Mật khẩu đã mã hóa',
  `MAVAITRO` int(11) NOT NULL COMMENT 'Mã vai trò',
  `TRANGTHAI` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1-Hoạt động, 0-Khóa',
  PRIMARY KEY (`MATAIKHOAN`),
  UNIQUE KEY `uix_taikhoan_username` (`TENTAIKHOAN`),
  KEY `ix_taikhoan_mavaitro` (`MAVAITRO`),
  CONSTRAINT `fk_taikhoan_vaitro` FOREIGN KEY (`MAVAITRO`) REFERENCES `vaitro` (`MAVAITRO`)
);

CREATE TABLE `phongban` (
  `MAPHONGBAN` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã phòng ban',
  `TENPHONGBAN` varchar(50) NOT NULL COMMENT 'Tên phòng ban',
  `MOTAPHONGBAN` mediumtext DEFAULT NULL COMMENT 'Mô tả phòng ban',
  `MATRUONGPHONG` int(11) DEFAULT NULL COMMENT 'Mã trưởng phòng',
  PRIMARY KEY (`MAPHONGBAN`),
  UNIQUE KEY `uix_phongban_ten` (`TENPHONGBAN`)
);

CREATE TABLE `nhanvien` (
  `MANV` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã nhân viên',
  `TENNV` varchar(100) NOT NULL COMMENT 'Tên nhân viên',
  `GIOITINH` varchar(5) NOT NULL COMMENT 'Giới tính',
  `NGAYSINH` date NOT NULL COMMENT 'Ngày sinh',
  `DIACHI` varchar(255) NOT NULL COMMENT 'Địa chỉ',
  `SDT` varchar(20) NOT NULL COMMENT 'Số điện thoại',
  `EMAIL` varchar(100) NOT NULL COMMENT 'Email',
  `NGAYVAOLAM` date NOT NULL COMMENT 'Ngày vào làm',
  `MAPHONGBAN` int(11) DEFAULT NULL COMMENT 'Mã phòng ban',
  `MACALAMVIEC` char(36) DEFAULT NULL COMMENT 'Mã ca làm việc',
  `CMND` varchar(20) NOT NULL COMMENT 'CMND/CCCD',
  `MABANGCAP` int(11) NOT NULL COMMENT 'Mã bằng cấp',
  `MABACLUONG` int(11) DEFAULT NULL COMMENT 'Mã bậc lương',
  `MAHOPDONG` int(11) DEFAULT NULL COMMENT 'Mã hợp đồng',
  `MACHUCVU` int(11) DEFAULT NULL COMMENT 'Mã chức vụ',
  `MATAIKHOAN` int(11) DEFAULT NULL COMMENT 'Mã tài khoản',
  `ANHNV` varchar(255) NOT NULL DEFAULT 'profile.jpg' COMMENT 'Ảnh nhân viên',
  PRIMARY KEY (`MANV`),
  UNIQUE KEY `uix_nhanvien_cccd` (`CMND`),
  UNIQUE KEY `uix_nhanvien_taikhoan` (`MATAIKHOAN`),
  KEY `ix_nhanvien_maphongban` (`MAPHONGBAN`),
  KEY `ix_nhanvien_macalamviec` (`MACALAMVIEC`),
  KEY `ix_nhanvien_mabangcap` (`MABANGCAP`),
  KEY `ix_nhanvien_mabacluong` (`MABACLUONG`),
  KEY `ix_nhanvien_mahopdong` (`MAHOPDONG`),
  KEY `ix_nhanvien_machucvu` (`MACHUCVU`),
  CONSTRAINT `fk_nhanvien_phongban` FOREIGN KEY (`MAPHONGBAN`) REFERENCES `phongban` (`MAPHONGBAN`) ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT `fk_nhanvien_calamviec` FOREIGN KEY (`MACALAMVIEC`) REFERENCES `calamviec` (`MACALAMVIEC`) ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT `fk_nhanvien_bangcap` FOREIGN KEY (`MABANGCAP`) REFERENCES `bangcap` (`MABANGCAP`) ON UPDATE CASCADE,
  CONSTRAINT `fk_nhanvien_bacluong` FOREIGN KEY (`MABACLUONG`) REFERENCES `bacluong` (`MABACLUONG`) ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT `fk_nhanvien_hopdong` FOREIGN KEY (`MAHOPDONG`) REFERENCES `hopdong` (`MAHOPDONG`) ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT `fk_nhanvien_chucvu` FOREIGN KEY (`MACHUCVU`) REFERENCES `chucvu` (`MACHUCVU`) ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT `fk_nhanvien_taikhoan` FOREIGN KEY (`MATAIKHOAN`) REFERENCES `taikhoan` (`MATAIKHOAN`) ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE `chamcong` (
  `MACHAMCONG` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã chấm công',
  `MANV` int(11) NOT NULL COMMENT 'Mã nhân viên',
  `MACALAMVIEC` char(36) DEFAULT NULL COMMENT 'Ca làm việc',
  `NGAY_CHAMCONG` date NOT NULL COMMENT 'Ngày chấm công',
  `SOGIOLAM` decimal(5,2) DEFAULT 0 COMMENT 'Số giờ làm thực tế',
  `SOGIOTANGCA` decimal(5,2) DEFAULT 0 COMMENT 'Số giờ tăng ca',
  `TIENVIPHAM` decimal(15,2) DEFAULT 0 COMMENT 'Tiền phạt vi phạm',
  `THUONG` decimal(15,2) DEFAULT 0 COMMENT 'Tiền thưởng',
  `THUCLINH` decimal(15,2) DEFAULT 0 COMMENT 'Lương thực lĩnh',
  PRIMARY KEY (`MACHAMCONG`),
  UNIQUE KEY `uix_chamcong_nv_ngay_ca` (`MANV`,`NGAY_CHAMCONG`,`MACALAMVIEC`),
  KEY `ix_chamcong_macalamviec` (`MACALAMVIEC`),
  CONSTRAINT `fk_chamcong_nhanvien` FOREIGN KEY (`MANV`) REFERENCES `nhanvien` (`MANV`) ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT `fk_chamcong_calamviec` FOREIGN KEY (`MACALAMVIEC`) REFERENCES `calamviec` (`MACALAMVIEC`) ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE `congtac` (
  `MACONGTAC` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã công tác',
  `MANV` int(11) NOT NULL COMMENT 'Mã nhân viên',
  `NGAYBATDAU` date NOT NULL COMMENT 'Ngày bắt đầu',
  `NGAYKETTHUC` date NOT NULL COMMENT 'Ngày kết thúc',
  `DIADIEM` varchar(200) NOT NULL COMMENT 'Địa điểm',
  `MUCDICH` longtext NOT NULL COMMENT 'Mục đích',
  `HOTRO` decimal(15,2) DEFAULT 0 COMMENT 'Chi phí hỗ trợ',
  PRIMARY KEY (`MACONGTAC`),
  KEY `ix_congtac_manv` (`MANV`),
  CONSTRAINT `fk_congtac_nhanvien` FOREIGN KEY (`MANV`) REFERENCES `nhanvien` (`MANV`) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `danhgia` (
  `MADANHGIA` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã đánh giá',
  `MANV` int(11) NOT NULL COMMENT 'Mã nhân viên',
  `LOAIDANHGIA` varchar(50) NOT NULL COMMENT 'Loại đánh giá',
  `LYDO` longtext NOT NULL COMMENT 'Lý do',
  `SOTIEN` decimal(15,2) NOT NULL COMMENT 'Số tiền',
  `THOIGIAN` date NOT NULL COMMENT 'Ngày đánh giá',
  PRIMARY KEY (`MADANHGIA`),
  KEY `ix_danhgia_manv` (`MANV`),
  CONSTRAINT `fk_danhgia_nhanvien` FOREIGN KEY (`MANV`) REFERENCES `nhanvien` (`MANV`) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `kiennghi` (
  `MAKIENNGHI` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã kiến nghị',
  `MANV` int(11) NOT NULL COMMENT 'Mã nhân viên',
  `NOIDUNG` longtext NOT NULL COMMENT 'Nội dung',
  `TIEUDE` varchar(200) NOT NULL COMMENT 'Tiêu đề',
  `NGAYTAO` date DEFAULT NULL COMMENT 'Ngày tạo',
  PRIMARY KEY (`MAKIENNGHI`),
  KEY `ix_kiennghi_manv` (`MANV`),
  CONSTRAINT `fk_kiennghi_nhanvien` FOREIGN KEY (`MANV`) REFERENCES `nhanvien` (`MANV`) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `nghiphep` (
  `MANGHIPHEP` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã nghỉ phép',
  `MANHANVIEN` int(11) NOT NULL COMMENT 'Mã nhân viên',
  `NGAYBATDAUNGHI` date NOT NULL COMMENT 'Ngày bắt đầu nghỉ',
  `NGAYDILAMLAI` date NOT NULL COMMENT 'Ngày đi làm lại',
  `LYDO` longtext NOT NULL COMMENT 'Lý do',
  `PHEDUYET` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Trạng thái phê duyệt',
  PRIMARY KEY (`MANGHIPHEP`),
  KEY `ix_nghiphep_manhanvien` (`MANHANVIEN`),
  CONSTRAINT `fk_nghiphep_nhanvien` FOREIGN KEY (`MANHANVIEN`) REFERENCES `nhanvien` (`MANV`) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO `calamviec` (`MACALAMVIEC`, `MACALAMVIEC_CODE`, `TENCALAMVIEC`, `THOIGIAN_BATDAU`, `THOIGIAN_BATDAU_NGHI`, `THOIGIAN_KETTHUC`, `THOIGIAN_KETTHUC_NGHI`, `THOIGIAN_LAMVIEC`, `THOIGIAN_NGHI`, `TRANGTHAIHOATDONG`, `NGUOITAO`, `NGAY_TAO`, `MOTA`) VALUES
('550e8400-e29b-41d4-a716-446655440001', 'CA001', 'Ca sáng', '08:00:00', '12:00:00', '17:00:00', '13:00:00', 8.00, 1.00, 1, 'admin', CURRENT_TIMESTAMP, 'Ca làm việc buổi sáng'),
('550e8400-e29b-41d4-a716-446655440002', 'CA002', 'Ca chiều', '14:00:00', '17:00:00', '22:00:00', '18:00:00', 7.00, 1.00, 1, 'admin', CURRENT_TIMESTAMP, 'Ca làm việc buổi chiều'),
('550e8400-e29b-41d4-a716-446655440003', 'CA003', 'Ca tối', '22:00:00', '02:00:00', '06:00:00', '23:00:00', 7.00, 1.00, 1, 'admin', CURRENT_TIMESTAMP, 'Ca làm việc buổi tối');

INSERT INTO `bacluong` (`MABACLUONG`, `LUONGCOBAN`, `PHUCAP`, `TENBACLUONG`, `THAMNIEN`) VALUES
(1, 1800000, 200000, 'Lương bậc 1', '0-1 năm'),
(5, 2100000, 400000, 'Lương bậc 2', '1-3 năm'),
(6, 2500000, 700000, 'Lương bậc 3', '3-5 năm'),
(8, 2700000, 1100000, 'Lương bậc 4', '5-10 năm');

INSERT INTO `bangcap` (`MABANGCAP`, `TENBANGCAP`, `MOTABANGCAP`, `NGAYTAO`, `HESOLUONG`) VALUES
(1, 'Cử nhân', 'Trình Đại học', '2024-12-28', 2.34),
(13, 'Thạc sĩ', 'Bằng thạc sĩ', '2024-12-28', 4),
(14, 'Tiến sĩ', 'Cấp bậc trên thạc sĩ', '2024-12-28', 4.4);

INSERT INTO `chucvu` (`MACHUCVU`, `TENCHUCVU`, `MOTACHUCVU`, `NGAYTAOCHUCVU`, `PHUCAP`, `HESOLUONG`) VALUES
(18, 'Phó giám đốc', 'Uy tín', '2024-12-29', 1700000, 3.9),
(20, 'Tổng giám đốc', 'Tổng giám đốc điều hành toàn công ty', '2024-12-29', 2100000, 4.7),
(34, 'Trưởng phòng', 'Trưởng phòng, chịu trách nhiệm quản lý một phòng ban', '2024-12-29', 1300000, 3.3),
(35, 'Nhân viên', 'Nhân viên', '2024-12-29', 800000, 1.3),
(38, 'Phó phòng', 'Phó phòng', '2024-12-29', 1000000, 2.5),
(39, 'Admin', 'Quản trị hệ thống', '2024-12-29', 0, 1.0);

INSERT INTO `hopdong` (`MAHOPDONG`, `TENHOPDONG`, `MOTAHOPDONG`) VALUES
(1, 'HĐ không xác định thời hạn', 'Hợp đồng dài hạn'),
(2, 'HĐ xác định 12 tháng', 'Hợp đồng 12 tháng');

INSERT INTO `vaitro` (`MAVAITRO`, `TENVAITRO`) VALUES
(1, 'Quản trị viên'),
(2, 'Nhân viên');

INSERT INTO `taikhoan` (`MATAIKHOAN`, `TENTAIKHOAN`, `MATKHAU`, `MAVAITRO`, `TRANGTHAI`) VALUES
(1, 'admin', '$2y$10$1E56tMcl//.gL9w6QD2Z2.Jdqh8mWLDnCYHZygcvGxSM6WTvtsifq', 1, 1),
(2, 'nhanvien', '$2y$10$ExhjEfU03Pv3VwHYXjf7ZOI.1SbIA/qeO0dM.T35f5LiQFORwaMe6', 2, 1),
(3, '2024024', '$2y$10$hYq85uq2uqx9M0P8vIjBtuy/8Yfxpj1itt.W0FjY18Nj2C1Dygv5G', 2, 1),
(4, '2024028', '$2y$10$E5vdcaOQIbxkwicrVlL03uAQv2d.g/cHLQGXDwlHnwqAw7td6Sa2i', 2, 1);

INSERT INTO `phongban` (`MAPHONGBAN`, `TENPHONGBAN`, `MOTAPHONGBAN`, `MATRUONGPHONG`) VALUES
(1, 'Phòng tài chính', 'Phòng tài chính', NULL),
(2, 'Phòng kinh doanh', 'Phòng kinh doanh', NULL),
(17, 'Phòng thiết kế', 'Phòng thiết kế', NULL);

INSERT INTO `nhanvien` (`MANV`, `TENNV`, `GIOITINH`, `NGAYSINH`, `DIACHI`, `SDT`, `EMAIL`, `NGAYVAOLAM`, `MAPHONGBAN`, `MACALAMVIEC`, `CMND`, `MABANGCAP`, `MABACLUONG`, `MAHOPDONG`, `MACHUCVU`, `MATAIKHOAN`, `ANHNV`) VALUES
(2024018, 'Đặng Minh Hiếu 2', 'Nữ', '2024-11-01', 'Thanh Trì, Hà Nội', '0987654321', 'minh05@gmail.com', '2024-11-28', 2, '550e8400-e29b-41d4-a716-446655440002', '3222222222221', 14, 5, 1, 35, 2, '2024018676bc8007558a7.97595067.jpg'),
(2024024, 'Nguyễn Văn C', 'Nam', '2024-12-01', 'Thanh Trì, Hà Nội 4', '000000004', 'minh04@gmail.com', '2024-12-31', 2, '550e8400-e29b-41d4-a716-446655440001', '000000000002', 1, 5, 1, 34, 3, '2024024676bc818b18972.72374337.jpg'),
(2024027, 'Nguyễn Văn E', 'Nữ', '2024-12-06', 'Nam Từ Liêm, Hà Nội', '0987654322', '035vane@gmail.com', '2024-12-28', 1, '550e8400-e29b-41d4-a716-446655440001', '2222222222221', 13, 6, 1, 35, NULL, '2024027676bc9cd40d436.41842814.jpg'),
(2024028, 'Nguyễn Văn A', 'Nữ', '2024-12-01', 'Thanh Trì, Hà Nội 1', '0987654323', 'minh01@gmail.com', '2024-12-29', 1, '550e8400-e29b-41d4-a716-446655440001', '000000000001', 1, 8, 1, 34, 4, '2024028676f565d5ef276.66963278.jpg'),
(2024029, 'Nguyễn Thị A', 'Nữ', '2024-12-01', 'Thanh Trì, Hà Nội 4', '0987654324', 'czxczxc@gmail.com', '2024-12-29', 2, '550e8400-e29b-41d4-a716-446655440002', '000000000003', 13, 1, 2, 35, NULL, '2024029676bc9f7e5aa36.86831825.jpg'),
(2024030, 'Nguyễn Thị B', 'Nam', '2024-12-01', 'Sóc Sơn 0', '0987654325', 'minh0xoapb@gmail.com', '2024-12-28', 17, '550e8400-e29b-41d4-a716-446655440003', '2222222222222', 1, 5, 2, 34, NULL, '2024030676bca0857bbb5.14449726.jpg'),
(2024032, 'Nguyễn Mạnh Hiệp', 'Nam', '2004-12-06', 'Hà Nội', '0395093922', 'ngmanhhiep2004@gmail.com', '2009-12-22', 1, '550e8400-e29b-41d4-a716-446655440001', '1212457781814', 13, 5, 1, 35, NULL, '2024032676bca1d31e5c9.33565413.jpg'),
(2024036, 'Nguyễn Văn F', 'Nam', '2024-12-01', 'Hà Nội', '0900000001', 'nvf@example.com', '2024-12-01', 17, '550e8400-e29b-41d4-a716-446655440001', '9999999999991', 14, 6, 1, 39, 1, '2024033676b5a1e393fe1.69360163.jpg'),
(2024038, 'Nguyễn Thị Mùi', 'Nữ', '2024-12-06', 'Kim Trì, Đồng Thau', '0985432611', 'gheeelego@gmail.com', '2024-12-29', NULL, '550e8400-e29b-41d4-a716-446655440001', '035206007959', 1, 1, 2, 35, NULL, '20240376770970db0c1c0.20034078.jpg');

UPDATE `phongban` SET `MATRUONGPHONG` = 2024028 WHERE `MAPHONGBAN` = 1;
UPDATE `phongban` SET `MATRUONGPHONG` = 2024024 WHERE `MAPHONGBAN` = 2;
UPDATE `phongban` SET `MATRUONGPHONG` = 2024030 WHERE `MAPHONGBAN` = 17;

ALTER TABLE `phongban`
  ADD CONSTRAINT `fk_phongban_truongphong` FOREIGN KEY (`MATRUONGPHONG`) REFERENCES `nhanvien` (`MANV`) ON UPDATE CASCADE ON DELETE SET NULL;

INSERT INTO `chamcong` (`MACHAMCONG`, `MANV`, `MACALAMVIEC`, `NGAY_CHAMCONG`, `SOGIOLAM`, `SOGIOTANGCA`, `TIENVIPHAM`, `THUONG`, `THUCLINH`) VALUES
(15, 2024027, '550e8400-e29b-41d4-a716-446655440001', '2024-12-28', 8.00, 2.00, 0, 0, 16948317.31),
(16, 2024018, '550e8400-e29b-41d4-a716-446655440002', '2024-12-28', 7.00, 3.00, 0, 0, 15299663.46),
(17, 2024038, '550e8400-e29b-41d4-a716-446655440001', '2024-12-28', 8.00, 2.00, 600000, 100000, 7015692.31);

INSERT INTO `congtac` (`MACONGTAC`, `MANV`, `NGAYBATDAU`, `NGAYKETTHUC`, `DIADIEM`, `MUCDICH`, `HOTRO`) VALUES
(3, 2024036, '2024-12-01', '2024-12-27', 'Phú Quốc', 'Học tập', 200000),
(4, 2024032, '2024-12-01', '2025-01-01', 'Hà Nội', 'Sửa chữa', 400000),
(5, 2024018, '2024-12-26', '2025-01-01', 'Haui', 'Học tập', 200000),
(6, 2024018, '2024-12-17', '2024-12-17', 'Hà Nội', 'Xây dựng sản phẩm mới', 600000);

INSERT INTO `danhgia` (`MADANHGIA`, `MANV`, `LOAIDANHGIA`, `LYDO`, `SOTIEN`, `THOIGIAN`) VALUES
(1, 2024038, 'Vi phạm', 'Đi muộn 20p', 100000, '2024-12-18'),
(2, 2024032, 'Khen thưởng', 'Đề xuất sáng kiến cải tiến thiết kế E300.1', 1000000, '2024-12-20'),
(4, 2024038, 'Vi phạm', 'test', 500000, '2024-12-13'),
(5, 2024038, 'Khen thưởng', 'test', 100000, '2024-12-24');

INSERT INTO `kiennghi` (`MAKIENNGHI`, `MANV`, `NOIDUNG`, `TIEUDE`, `NGAYTAO`) VALUES
(1, 2024018, 'Để tiện nhu cầu giải khát nhân viên cũng như thêm một nguồn cung nhỏ cho quỹ công ty', 'Thêm cây bán nước tự động', '2024-12-29'),
(2, 2024018, 'Nghiệp vụ abc có thể hoàn thành và cải tiến như sau: xyzxyz', 'Đề xuất sáng kiến kinh nghiệm', '2024-12-29');

INSERT INTO `nghiphep` (`MANGHIPHEP`, `MANHANVIEN`, `NGAYBATDAUNGHI`, `NGAYDILAMLAI`, `LYDO`, `PHEDUYET`) VALUES
(1, 2024018, '2024-12-01', '2024-12-12', 'Lên Hà Nội bế cháu', 1),
(2, 2024018, '2024-12-01', '2024-12-19', 'đi chill thôi, làm làm gì', 2),
(3, 2024018, '2024-12-01', '2024-12-28', 'test thử cái đơn nghỉ phép', 1),
(4, 2024029, '2024-12-01', '2024-12-28', 'test toast', 2),
(5, 2024018, '2024-12-06', '2024-12-08', 'Gia đình có việc bận', 1),
(6, 2024018, '2024-12-07', '2024-12-09', 'Trùng lịch công tác', 1),
(7, 2024018, '2024-12-01', '2024-12-29', 'xin nghỉ đi chơi', 0);

SET FOREIGN_KEY_CHECKS = 1;
COMMIT;