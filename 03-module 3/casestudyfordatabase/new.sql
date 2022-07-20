DROP DATABASE IF EXISTS furama_management;
CREATE DATABASE furama_management;
USE furama_management;


-- vị trí
CREATE TABLE position  (
    id_position  INT NOT NULL AUTO_INCREMENT,
    name_position  VARCHAR(45) NOT NULL,
    PRIMARY KEY (id_position));
-- trình độ
CREATE TABLE education_degree  (
    id_education_degree  INT NOT NULL AUTO_INCREMENT,
    name_education_degree  VARCHAR(45) NOT NULL,
    PRIMARY KEY (id_education_degree));
-- Bộ phận --
CREATE TABLE division (
    id_division INT NOT NULL AUTO_INCREMENT,
    name_division VARCHAR(45) NOT NULL,
    PRIMARY KEY (id_division));
-- Nhân viên --
CREATE TABLE employee   (
    id_employee   INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name_employee VARCHAR(45) NOT NULL,
    date_of_birth_employee  DATE NOT NULL,
    id_card_employee  VARCHAR(45) NOT NULL UNIQUE,
    salary  DOUBLE NOT NULL,
    phone_number_employee  VARCHAR(45) NOT NULL UNIQUE,
    email_employee VARCHAR(45),
    address_employee  VARCHAR(45),
    id_position INT,
    id_education_degree INT,
    id_division INT,
    FOREIGN KEY (id_position)
        REFERENCES position (id_position),
    FOREIGN KEY (id_education_degree)
        REFERENCES education_degree (id_education_degree),
    FOREIGN KEY (id_division)
        REFERENCES division (id_division));
-- Loại khách hàng --
CREATE TABLE customer_type  (
    id_customer_type  INT NOT NULL AUTO_INCREMENT,
    name_customer_type VARCHAR(45) NOT NULL,
    PRIMARY KEY (id_customer_type));
-- khách hàng --
CREATE TABLE customer  (
    id_customer  INT NOT NULL AUTO_INCREMENT,
    name_customer VARCHAR(45) NOT NULL,
    date_of_birth_customer DATE NOT NULL,
    gender_customer BIT NOT NULL,
    id_card_customer VARCHAR(45) NOT NULL,
    phone_number_customer VARCHAR(45) NOT NULL,
    email_customer VARCHAR(45),
    address_customer VARCHAR(45),
    id_customer_type INT NOT NULL,
    PRIMARY KEY (id_customer),
    FOREIGN KEY (id_customer_type)
        REFERENCES customer_type (id_customer_type));
-- loại dịch vụ --
CREATE TABLE facility_type  (
    id_facility_type INT NOT NULL AUTO_INCREMENT,
    name_facility_type VARCHAR(45) NOT NULL,
    PRIMARY KEY (id_facility_type));
-- kiểu thuê--
CREATE TABLE rengt_type  (
    id_rengt_type  INT NOT NULL AUTO_INCREMENT,
    name_rengt_type  VARCHAR(45) NOT NULL,
    PRIMARY KEY (id_rengt_type));

--  dịch vụ --

CREATE TABLE facility  (
    id_facility  INT NOT NULL AUTO_INCREMENT,
    name_facility  VARCHAR(45) NOT NULL,
    area_facility  INT,
    cost_facility double NOT NULL,
	max_people_facility INT,
    standard_room  VARCHAR(45),
    description_other_convenience  VARCHAR(45),
    pool_area  INT,
    number_of_floor  INT,
    facility_free  TEXT,
     id_facility_type INT,
    id_rengt_type INT,
    PRIMARY KEY (id_facility),
    FOREIGN KEY (id_rengt_type)
        REFERENCES rengt_type (id_rengt_type),
    FOREIGN KEY (id_facility_type)
        REFERENCES facility_type (id_facility_type));
        
-- hợp đồng --
CREATE TABLE contract  (
    id_contract INT AUTO_INCREMENT NOT NULL,
    start_date  DATETIME NOT NULL,
    end_date  DATETIME NOT NULL,
    deposit  DOUBLE NOT NULL,
    id_employee INT NOT NULL,
    id_customer INT NOT NULL,
    id_facility INT NOT NULL,
    PRIMARY KEY (id_contract),
    FOREIGN KEY (id_employee)
        REFERENCES employee (id_employee),
    FOREIGN KEY (id_customer)
        REFERENCES customer (id_customer),
    FOREIGN KEY (id_facility)
        REFERENCES facility (id_facility));
        
-- dịch vụ đi kèm  --
CREATE TABLE attach_facility (
    id_attach_facility  INT AUTO_INCREMENT NOT NULL,
    name_attach_facility  VARCHAR(45) NOT NULL,
    cost  DOUBLE NOT NULL,
    unit  VARCHAR(45) NOT NULL,
    status VARCHAR(45) NOT NULL,
    PRIMARY KEY (id_attach_facility));
    
-- hợp đồng chi tiết -- 
CREATE TABLE contract_detail  (
    id_contract_detail  INT AUTO_INCREMENT NOT NULL,
     amount  INT NOT NULL,
    id_contract INT NOT NULL,
    id_attach_facility INT NOT NULL,
    PRIMARY KEY (id_contract_detail),
    FOREIGN KEY (id_contract)
        REFERENCES contract (id_contract),
    FOREIGN KEY (id_attach_facility)
        REFERENCES attach_facility (id_attach_facility));

INSERT INTO customer_type
 VALUES (1, 'Diamond'),
(2, 'Platinium'),
(3, 'Gold'),
(4, 'Silver'),
(5, 'Member');

INSERT INTO   customer (id_customer, name_customer, date_of_birth_customer, gender_customer, id_card_customer, phone_number_customer, email_customer, address_customer,id_customer_type)
VALUES (1, 'Nguyễn Thị Hào', '1970-11-07', 0, '643431213', '0945423362', 'thihao07@gmail.com', '23 Nguyễn Hoàng, Đà Nẵng', 5),
 (2, 'Phạm Xuân Diệu', '1992-08-08', 1, '865342123', '0954333333', 'xuandieu92@gmail.com', 'K77/22 Thái Phiên, Quảng Trị', 3),
 (3, 'Trương Đình Nghệ', '1990-02-27', 1, '488645199', '0373213122', 'nghenhan2702@gmail.com', 'K323/12 Ông Ích Khiêm, Vinh', 1),
 (4, 'Dương Văn Quan', '1981-07-08', 1, '543432111', '0490039241', 'duongquan@gmail.com', 'K453/12 Lê Lợi, Đà Nẵng', 1),
 (5, 'Hoàng Trần Nhi Nhi', '1995-12-09', 0, '795453345', '0312345678', 'nhinhi123@gmail.com', '224 Lý Thái Tổ, Gia Lai', 4),
 (6, 'Tôn Nữ Mộc Châu', '2005-12-06', 0, '732434215', '0988888844' , 'tonnuchau@gmail.com', '37 Yên Thế, Đà Nẵng', '4'),
 (7, 'Nguyễn Mỹ Kim', '1984-04-08', 0, '856453123' , '0912345698', 'kimcuong84@gmail.com', 'K123/45 Lê Lợi, Hồ Chí Minh', 1),
 (8, 'Nguyễn Thị Hào', '1999-04-08', 0 , '965656433' , '0763212345' , 'haohao99@gmail.com' , '55 Nguyễn Văn Linh, Kon Tum', 3),
 (9, 'Trần Đại Danh', '1994-07-01', 1, '432341235',  '0643343433', 'danhhai99@gmail.com' , '24 Lý Thường Kiệt, Quảng Ngãi', 1),
 (10, 'Nguyễn Tâm Đắc', '1989-07-01', 1, '344343432' , '0987654321' , 'dactam@gmail.com' , '22 Ngô Quyền, Đà Nẵng', 2);

INSERT INTO position (id_position, name_position) 
VALUES ('1', 'Quản Lý'),
 ('2', 'Nhân Viên');
 
 INSERT INTO division (id_division, name_division) VALUES
 ('1', 'Sale-Marketing'),
 ('2', 'Hành chính'),
 ('3', 'Phục vụ'),
 ('4', 'Quản lý');
 
 
 INSERT INTO education_degree (id_education_degree,name_education_degree) VALUES
 ('1', 'Trung Cấp'),
 ('2', 'Cao Đẳng'),
 ('3', 'Đại Học'),
 ('4', 'Sau Đại Học');
 
INSERT INTO employee(`id_employee`, `name_employee`, `date_of_birth_employee`, `id_card_employee`, `salary`, `phone_number_employee`, `email_employee`, `address_employee`, `id_position`, `id_education_degree`, `id_division`) 
VALUES ('1', 'Nguyễn Văn An', '1970-11-07', '456231786', '10000000', '0901234121', 'annguyen@gmail.com', '295 Nguyễn Tất Thành, Đà Nẵng', '1', '3', '1'),
 ('2', 'Lê Văn Bình', '1997-04-09', '654231234', '7000000', '0934212314', 'binhlv@gmail.com', '22 Yên Bái, Đà Nẵng', '1', '2', '2'),
 ('3', 'Hồ Thị Yến', '1995-12-12', '999231723', '14000000', '0412352315', 'thiyen@gmail.com', 'K234/11 Điện Biên Phủ, Gia Lai', '1', '3', '2'),
 ('4', 'Võ Công Toản', '1980-04-04', '123231365', '17000000', '0374443232', 'toan0404@gmail.com', '77 Hoàng Diệu, Quảng Trị', '1', '4', '4'),
 ('5', 'Nguyễn Bỉnh Phát', '1999-12-09', '454363232', '6000000', '0902341231', 'phatphat@gmail.com', '43 Yên Bái, Đà Nẵng', '2', '1', '1'),
 ('6', 'Khúc Nguyễn An Nghi', '2000-11-08', '964542311', '7000000', '0978653213', 'annghi20@gmail.com', '294 Nguyễn Tất Thành, Đà Nẵng', '2', '2', '3'),
 ('7', 'Nguyễn Hữu Hà', '1993-01-01', '534323231', '8000000', '0941234553', 'nhh0101@gmail.com', '4 Nguyễn Chí Thanh, Huế', '2', '3', '2'),
 ('8', 'Nguyễn Hà Đông', '1989-09-03', '234414123', '9000000', '0642123111', 'donghanguyen@gmail.com', '111 Hùng Vương, Hà Nội', '2', '4', '4'),
 ('9', 'Tòng Hoang', '1982-09-03', '256781231', '6000000', '0245144444', 'hoangtong@gmail.com', '213 Hàm Nghi, Đà Nẵng', '2', '4', '4'),
 ('10', 'Nguyễn Công Đạo', '1994-01-08', '755434343', '8000000', '0988767111', 'nguyencongdao12@gmail.com', '6 Hoà Khánh, Đồng Nai', '2', '3', '2');

INSERT INTO rengt_type (`id_rengt_type`, `name_rengt_type`) 
VALUES ('1', 'year'),
 ('2', 'month'),
 ('3', 'day'),
 ('4', 'hour');

INSERT INTO facility_type 
(`id_facility_type`, `name_facility_type`) 
VALUES
 ('1', 'Villa'),
 ('2', 'House'),
 ('3', 'Room');
 
INSERT INTO facility (`id_facility`, `name_facility`, `area_facility`, `cost_facility`, `max_people_facility`, `standard_room`, `description_other_convenience`, `pool_area`, `number_of_floor`, `facility_free`, `id_rengt_type`, `id_facility_type`)
 VALUES
 ('1', 'Villa Beach Front', '25000', '1000000', '10', 'vip', 'Có hồ bơi', '500', '4', 'null', '3', '1'),
  ('2', 'House Princess 01', '14000', '5000000', '7', 'vip', 'Có thêm bếp nướng', null, '3', 'null', '2', '2'),
  ('3', 'Room Twin 01', '5000', '1000000', '2', 'normal', 'Có tivi', null, null, '1 Xe máy, 1 Xe đạp', '4', '3'),
  ('4', 'Villa No Beach Front', '22000', '9000000', '8', 'normal', 'Có hồ bơi', '300', '3', 'null', '3', '1'),
  ('5', 'House Princess 02', '10000', '4000000', '5', 'normal', 'Có thêm bếp nướng', null, '2', 'null', '3', '2'),
  ('6', 'Room Twin 02', '3000', '900000', '2', 'normal', 'Có tivi', null, null, '1 Xe máy', '4', '3');

INSERT INTO attach_facility (`id_attach_facility`,name_attach_facility, `cost`, `unit`, `status`) 
VALUES
 ('1', 'Karaoke', '10000', 'giờ', 'tiện nghi, hiện tại'),
 ('2', 'Thuê xe máy', '10000', 'chiếc', 'hỏng 1 xe'),
 ('3', 'Thuê xe đạp', '20000', 'chiếc', 'tốt'),
 ('4', 'Buffet buổi sáng', '15000', 'suất', 'đầy đủ đồ ăn, tráng miệng'),
 ('5', 'Buffet buổi trưa', '90000', 'suất', 'đầy đủ đồ ăn, tráng miệng'),
 ('6', 'Buffet buổi tối', '16000', 'suất', 'đầy đủ đồ ăn, tráng miệng');
 
INSERT INTO contract(`id_contract`, `start_date`, `end_date`,
 `deposit`,`id_employee`, `id_customer`,  `id_facility`) 
 VALUES
('1', '2020-12-08', '2020-12-08', '0', '3', '1', '3'),
('2', '2020-07-14', '2020-07-21', '200000', '7', '3', '1'),
('3', '2021-03-15', '2021-03-17', '50000', '3', '4', '2'),
('4', '2021-01-14', '2021-01-18', '100000', '7', '5', '5'),
('5', '2021-07-14', '2021-07-15', '0', '7', '2', '6'),
('6', '2021-06-01', '2021-06-03', '0', '7', '7', '6'),
('7', '2021-09-02', '2021-09-05', '100000', '7', '4', '4'),
('8', '2021-06-17', '2021-06-18', '150000', '3', '4', '1'),
('9', '2020-11-19', '2020-11-19', '0', '3', '4', '3'),
('10', '2021-04-12', '2021-04-14', '0', '10', '3', '5'),
('11', '2021-04-25', '2021-04-25', '0', '2', '2', '1'),
('12', '2021-05-25', '2021-05-27', '0', '7', '10', '1');

INSERT INTO contract_detail (`id_contract_detail`, `amount`, `id_contract`, `id_attach_facility`) 
VALUES
 ('1', '5', '2', '4'),
 ('2', '8', '2', '5'),
 ('3', '15', '2', '6'),
 ('4', '1', '3', '1'),
 ('5', '11', '3', '2'),
 ('6', '1', '1', '3'),
 ('7', '2', '1', '2'),
 ('8', '2', '12', '2');


-- 2.	Hiển thị thông tin của tất cả nhân viên có trong hệ thống có tên bắt đầu là một trong các ký tự “H”, “T” hoặc “K” và có tối đa 15 kí tự.


SELECT 
    *
FROM
    employee 
WHERE
    (employee.name_employee REGEXP '^[HKT]')
        AND (CHAR_LENGTH(employee.name_employee) <= 15);

-- 3.	Hiển thị thông tin của tất cả khách hàng có độ tuổi từ 18 đến 50 tuổi và có địa chỉ ở “Đà Nẵng” hoặc “Quảng Trị”.

SELECT 
    *
FROM
    customer c
WHERE
    (c.address_customer LIKE '%Quảng Trị'
        OR c.address_customer LIKE '%Đà Nẵng')
        AND ((YEAR(NOW()) - YEAR(c.date_of_birth_customer) BETWEEN 18 AND 50));
        
/*4.	Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu lần.
 Kết quả hiển thị được sắp xếp tăng dần theo số lần đặt phòng của khách hàng.
 Chỉ đếm những khách hàng nào có Tên loại khách hàng là “Diamond”.*/
 
SELECT 
    c.id_customer,
    c.name_customer,
    COUNT(ctr.id_customer) AS 'so_luong'
FROM
	contract ctr
		JOIN
    customer c
			ON c.id_customer = ctr.id_customer
		JOIN
     customer_type ct
			ON c.id_customer_type = ct.id_customer_type
WHERE
    ct.id_customer_type = 1
GROUP BY  c.name_customer
ORDER BY so_luong
;
 
 
  /*5.	Hiển thị ma_khach_hang, ho_ten, ten_loai_khach, ma_hop_dong, ten_dich_vu, ngay_lam_hop_dong, ngay_ket_thuc,
 tong_tien (Với tổng tiền được tính theo công thức như sau: 
 Chi Phí Thuê + Số Lượng * Giá, với Số Lượng và Giá là từ bảng dich_vu_di_kem,hop_dong_chi_tiet)
 cho tất cả các khách hàng đã từng đặt phòng. 
(những khách hàng nào chưa từng đặt phòng cũng phải hiển thị ra).*/


SELECT 
	c.id_customer,
    c.name_customer,
    ct.name_customer_type,
    ctr.id_contract,
    f.name_facility,
    ctr.id_facility,
    ctr.end_date,
    SUM((IFNULL(cd.amount * af.cost, 0)) + f.cost_facility) tong_tien
FROM
    contract ctr
        RIGHT JOIN customer c
			ON ctr.id_customer = c.id_customer
        LEFT JOIN facility f
			ON ctr.id_facility = f.id_facility
        LEFT JOIN customer_type ct
			ON ct.id_customer_type = c.id_customer_type
        LEFT JOIN contract_detail cd
			ON cd.id_contract = ctr.id_contract
        LEFT JOIN attach_facility af
			ON af.id_attach_facility = cd.id_attach_facility
GROUP BY ctr.id_contract
ORDER BY c.id_customer;


/*6.	Hiển thị ma_dich_vu, ten_dich_vu, dien_tich, chi_phi_thue, ten_loai_dich_vu của tất cả các loại dịch vụ 
chưa từng được khách hàng thực hiện đặt từ quý 1 của năm 2021 (Quý 1 là tháng 1, 2, 3).*/

SELECT 
f.id_facility,
f.name_facility,
f.area_facility,
f.cost_facility,
ft.name_facility_type
FROM
	contract ctr
        JOIN facility f 
			ON f.id_facility = ctr.id_facility
        JOIN facility_type ft 
			ON ft.id_facility_type = f.id_facility_type
WHERE
    ctr.id_facility NOT IN (SELECT 
            ctr.id_facility
        FROM
            contract ctr
        WHERE
            ((MONTH(ctr.start_date) BETWEEN 1 AND 3)
                AND YEAR(ctr.start_date) = '2021')
        GROUP BY ctr.id_facility)
GROUP BY ctr.id_facility
ORDER BY ft.name_facility_type;

/*7.	Hiển thị thông tin ma_dich_vu, ten_dich_vu, dien_tich, so_nguoi_toi_da, chi_phi_thue, ten_loai_dich_vu 
của tất cả các loại dịch vụ đã từng được khách hàng đặt phòng trong năm 2020 
nhưng chưa từng được khách hàng đặt phòng trong năm 2021.*/

SELECT 
   f.id_facility,
   f.name_facility,
   f.area_facility,
   f.max_people_facility,
   f.cost_facility,
   ft.name_facility_type
FROM
    contract ctr
        JOIN
    facility f ON ctr.id_facility = f.id_facility
        JOIN
    facility_type ft ON ft.id_facility_type = f.id_facility_type
WHERE
    ctr.id_customer NOT IN (SELECT 
           ctr.id_customer
        FROM
          contract ctr
        WHERE
            (ctr.start_date) BETWEEN '2021-01-01' AND '2021-12-31'
        )
        AND YEAR(ctr.start_date) = '2020'
GROUP BY ctr.id_customer;

/*8.	Hiển thị thông tin ho_ten khách hàng có trong hệ thống, 
với yêu cầu ho_ten không trùng nhau.
Học viên sử dụng theo 3 cách khác nhau để thực hiện yêu cầu trên.*/


 -- cách1 

SELECT 
    customer.name_customer
FROM
    customer
GROUP BY  customer.name_customer > 1;


/*cach2*/
SELECT 
    customer.name_customer,
    COUNT(customer.name_customer) so_nguoi_trung_ten
FROM
   customer
GROUP BY  customer.name_customer
HAVING  customer.name_customer > 1;
-- doi thanh dung union
/*cach 3*/
SELECT DISTINCT
	customer.name_customer
FROM
    customer
GROUP BY customer.name_customer > 1;


/*9.	Thực hiện thống kê doanh thu theo tháng, 
nghĩa là tương ứng với mỗi tháng trong năm 2021 thì sẽ có bao nhiêu khách hàng thực hiện đặt phòng.*/

SELECT 
    MONTH(contract.start_date) thang,
    COUNT(contract.start_date) so_luong_khach_hang
FROM
    contract
WHERE
    YEAR(contract.start_date) = '2021'
GROUP BY MONTH(contract.start_date)
ORDER BY thang;


/*10.	Hiển thị thông tin tương ứng với từng hợp đồng thì đã sử dụng bao nhiêu dịch vụ đi kèm. Kết quả hiển thị bao gồm ma_hop_dong, 
ngay_lam_hop_dong, ngay_ket_thuc, tien_dat_coc, so_luong_dich_vu_di_kem (được tính dựa trên việc sum so_luong ở dich_vu_di_kem).*/


-- c1

SELECT DISTINCT
    hd.ma_hop_dong,
    hd.ngay_lam_hop_dong,
    hd.ngay_ket_thuc,
    hd.tien_dat_coc,
    CASE
        WHEN hdct.so_luong IS NULL THEN SUM(0)
        ELSE SUM(hdct.so_luong)
    END AS 'so_luong_dich_vu_di_kem'
FROM
    hop_dong hd
        LEFT JOIN
    hop_dong_chi_tiet hdct ON hd.ma_hop_dong = hdct.ma_hop_dong
        LEFT JOIN
    dich_vu_di_kem dvdk ON hdct.ma_dich_vu_di_kem = dvdk.ma_dich_vu_di_kem
GROUP BY hd.ma_hop_dong
ORDER BY hd.ma_hop_dong ASC;

-- c2

SELECT 
    hop_dong.ma_hop_dong,
    hop_dong.ngay_lam_hop_dong,
    hop_dong.ngay_ket_thuc,
    hop_dong.tien_dat_coc,
    SUM(IFNULL(hop_dong_chi_tiet.so_luong, 0)) so_luong_dich_vu_di_kem
FROM
    hop_dong
        LEFT JOIN
    hop_dong_chi_tiet ON hop_dong_chi_tiet.ma_hop_dong = hop_dong.ma_hop_dong
GROUP BY hop_dong.ma_hop_dong;

