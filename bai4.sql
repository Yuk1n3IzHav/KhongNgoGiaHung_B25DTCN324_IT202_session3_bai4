-- Phân tích: 
-- Giải pháp 1: Xoá thủ công 
-- Giải pháp 2: Tạo một bảng mới, lưu trữ dữ liệu sang bảng mới rồi xoá dữ liệu đơn bị huỷ ở bảng cũ
-- So sánh: cách 1 nhanh gọn, giải phóng dung lượng tối đa nhưng bị mất dữ liệu, không thể backup
-- cách 2 thì tuy không nhanh bằng, dung lượng giải phóng không bằng nhưng vẫn lưu lại dữ liệu, có thể dùng cho kiểm toán
-- Thực thi
-- 1. Tạo bảng archive (nếu chưa có)
CREATE DATABASE session_3_bai_4;
USE session_3_bai_4;

CREATE TABLE ORDERS (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName VARCHAR(100),
    OrderDate DATETIME,
    TotalAmount DECIMAL(18, 2),
    Status VARCHAR(20),
    IsDeleted BIT DEFAULT 0
);

INSERT INTO ORDERS (CustomerName, OrderDate, TotalAmount, Status)
VALUES
	(N'Nguyễn Văn A', '2023-01-10', 500000, 'Completed'),
	(N'Khách hàng vãng lai', '2023-02-15', 1200000, 'Canceled'),
	(N'Trần Thị B', '2023-05-20', 300000, 'Canceled'),           
	(N'Lê Văn C', '2024-01-05', 850000, 'Completed');

SELECT * FROM ORDERS WHERE Status = 'Completed';

CREATE TABLE ORDERS_ARCHIVE (
    OrderID INT,
    CustomerName VARCHAR(100),
    OrderDate DATETIME,
    TotalAmount DECIMAL(18,2),
    Status VARCHAR(20),
    IsDeleted BIT
);

INSERT INTO ORDERS_ARCHIVE
SELECT * FROM ORDERS
WHERE Status = 'Canceled';

DELETE FROM ORDERS
WHERE Status = 'Canceled';