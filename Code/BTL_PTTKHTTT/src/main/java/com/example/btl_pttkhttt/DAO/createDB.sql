CREATE DATABASE IF NOT EXISTS btl_pttkhttt;
USE btl_pttkhttt;

-- Bảng tblNhanVien
CREATE TABLE tblNhanVien (
                             id INT AUTO_INCREMENT PRIMARY KEY,
                             username VARCHAR(255),
                             name VARCHAR(255),
                             password VARCHAR(255),
                             birth DATE,
                             phone VARCHAR(255),
                             email VARCHAR(255)
);

-- Bảng tblQuanLy (1-1 với tblNhanVien)
CREATE TABLE tblQuanLy (
                           tblNhanVienId INT PRIMARY KEY,
                           role VARCHAR(255),
                           FOREIGN KEY (tblNhanVienId) REFERENCES tblNhanVien(id)
);

-- Bảng tblNhanVienKho (1-1 với tblNhanVien)
CREATE TABLE tblNhanVienKho (
                                tblNhanVienId INT PRIMARY KEY,
                                role VARCHAR(255),
                                FOREIGN KEY (tblNhanVienId) REFERENCES tblNhanVien(id)
);

-- Bảng tblNhaCungCap
CREATE TABLE tblNhaCungCap (
                               id INT AUTO_INCREMENT PRIMARY KEY,
                               name VARCHAR(255),
                               address VARCHAR(255),
                               phone VARCHAR(255),
                               email VARCHAR(255),
                               rate FLOAT(10),
                               note VARCHAR(255)
);

-- Bảng tblTaiKhoanNganHang (1-n với tblNhaCungCap)
CREATE TABLE tblTaiKhoanNganHang (
                                     id INT AUTO_INCREMENT PRIMARY KEY,
                                     bankName VARCHAR(255),
                                     bankAccount VARCHAR(255),
                                     tblNhaCungCapId INT,
                                     FOREIGN KEY (tblNhaCungCapId) REFERENCES tblNhaCungCap(id)
);

-- Bảng tblHopDong (1-n với tblNhaCungCap)
CREATE TABLE tblHopDong (
                            id INT AUTO_INCREMENT PRIMARY KEY,
                            startDate DATE,
                            endDate DATE,
                            tblNhaCungCapId INT,
                            FOREIGN KEY (tblNhaCungCapId) REFERENCES tblNhaCungCap(id)
);

-- Bảng tblDonHang
CREATE TABLE tblDonHang (
                            id INT AUTO_INCREMENT PRIMARY KEY,
                            importDate DATE,
                            totalAmount FLOAT(10),
                            note VARCHAR(255),
                            tblNhanVienKhoId INT,
                            tblNhaCungCapId INT,
                            FOREIGN KEY (tblNhanVienKhoId) REFERENCES tblNhanVienKho(tblNhanVienId),
                            FOREIGN KEY (tblNhaCungCapId) REFERENCES tblNhaCungCap(id)
);

-- Bảng tblTrangPhuc
CREATE TABLE tblTrangPhuc (
                              id INT AUTO_INCREMENT PRIMARY KEY,
                              name VARCHAR(255),
                              picture VARCHAR(255),
                              des VARCHAR(255),
                              price FLOAT(10)
);

-- Bảng tblTrangPhucNhap (n-1 với tblTrangPhuc và n-1 với tblDonHang)
CREATE TABLE tblTrangPhucNhap (
                                  id INT AUTO_INCREMENT PRIMARY KEY,
                                  quantity INT,
                                  amount FLOAT(10),
                                  note VARCHAR(255),
                                  tblDonHangId INT,
                                  tblTrangPhucId INT,
                                  FOREIGN KEY (tblDonHangId) REFERENCES tblDonHang(id),
                                  FOREIGN KEY (tblTrangPhucId) REFERENCES tblTrangPhuc(id)
);
