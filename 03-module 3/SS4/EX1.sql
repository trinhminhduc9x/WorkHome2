DROP DATABASE IF EXISTS Products;
CREATE DATABASE Products;
USE Products;
CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_code INT,
    product_name VARCHAR(50),
    product_price DOUBLE,
    product_amount INT,
    product_description VARCHAR(100),
    product_status BIT
);

INSERT INTO products (
	product_code,
	product_name,
	product_price,
	product_amount,
	product_description,
	product_status)
VALUE (1,'vang',20,6,'di mua vang', 1),
(2,'bac',60,5,'di mua bac', 1),
(3,'dong',70,7,'di mua dong', 1),
(4,'da',90,8,'di mua da', 1),
(5,'sat',80,10,'di mua sat', 0);

-- Bước 3. Tạo Unique Index trên bảng Products (sử dụng cột productCode để tạo chỉ mục)
-- Tạo Composite Index trên bảng Products (sử dụng 2 cột productName và productPrice)

CREATE UNIQUE INDEX i_code 
	ON proDUCTS(pRODUCT_CODE);
CREATE  INDEX i_comPosite_producT 
	ON PRODucTS(PRoduct_name,product_coDE);
DROP INDEX i_code
	ON products;
DROP INDEX i_composite_product
	ON products;
    
EXPLAIN SELECT 
* 
FROM products 
WHERE products.product_code = 4;
   

EXPLAIN SELECT 
* 
FROM products 
WHERE products.product_name = 'bac' AND products.product_price = 60;
    
-- Bước 4: Tạo view lấy về các thông tin: productCode, productName, productPrice, productStatus từ bảng products.
-- Tiến hành sửa đổi view
-- Tiến hành xoá view

CREATE VIEW product_view AS
SELECT 
	product_code,
	product_name,
	product_price,
	product_status
FROM products;

SELECT
* 
FROM product_view;

CREATE OR REPLACE VIEW product_view AS
SELECT 
	product_code,
	product_name,
	product_price,
	product_status 
FROM products
WHERE product_name = 'bac';

DROP VIEW product_view;

-- Bước 5
-- 1. Tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product


delimiter //
	CREATE PROCEDURE find_all_products()
	BEGIN
		SELECT 
        * 
        FROM products;
	END//
delimiter ;

CALL find_all_products();


-- 2. Tạo store procedure thêm một sản phẩm mới

delimiter //
	CREATE 
		PROCEDURE add_new_produce(
        new_product_code INT, 
        new_product_name VARCHAR(50),
        new_product_price DOUBLE,
        new_product_amount INT,
        new_product_description VARCHAR(100),
        new_product_status BIT)
	BEGIN 
		INSERT INTO products (
			product_code,
			product_name,
			product_price,
			product_amount,
			product_description,
			product_status) 
	VALUE (
		new_product_code, 
		new_product_name,
		new_product_price,
		new_product_amount,
		new_product_description,
		new_product_status);
	END //
delimiter ;

CALL add_new_produce(9,'kim cuong',100,60,'mua kim cuong',1);

-- 3. Tạo store procedure sửa thông tin sản phẩm theo id

delimiter update_products//
	CREATE 
		PROCEDURE 
			update_products (
			id_find INT, 
			new_product_code INT, 
			new_product_name VARCHAR(50),
			new_product_price DOUBLE,
			new_product_amount INT,
			new_product_description VARCHAR(100),
			new_product_status INT)
	BEGIN 
		UPDATE products
		SET 
			product_code=new_product_code, 
			product_name = new_product_name, 
			product_price=new_product_price,
			product_amount= new_product_amount, 
			product_description= new_product_description,
			product_status = new_product_status
		WHERE products.id = id_find;
	END //
delimiter ;

call update_products(7,7,'tien',12.12,12,'vang 1',1);


-- 4. Tạo store procedure xoá sản phẩm theo id
delimiter //
	CREATE PROCEDURE DELETE_by_id(id_delEte INT) 
	BEGIN 
		DELETE FROM PrODUCts
		WHERE iD = Id_deLete;
	END //
DELimiter ;

CALL DELETE_by_id(5);