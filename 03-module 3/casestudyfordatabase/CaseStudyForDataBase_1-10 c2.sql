USE CaseStudyforDatabase;

-- 2.	Hiển thị thông tin của tất cả nhân viên có trong hệ thống có tên bắt đầu là một trong các ký tự “H”, “T” hoặc “K” và có tối đa 15 kí tự.
-- c1
SELECT 
  *
FROM
    nhan_vien n
WHERE
    n.ho_ten REGEXP '^(\\S+(\\s\\S+)*(\\s(H|T|K)\\S+)+)$$'
        AND LENGTH(n.ho_ten) <= 15;
-- c2

SELECT 
    *
FROM
    nhan_vien n
WHERE
    (n.ho_ten REGEXP '^[HKT]')
        AND (CHAR_LENGTH(n.ho_ten) <= 15);

-- 3.	Hiển thị thông tin của tất cả khách hàng có độ tuổi từ 18 đến 50 tuổi và có địa chỉ ở “Đà Nẵng” hoặc “Quảng Trị”.

-- c1

SELECT 
    *
FROM
    khach_hang k
WHERE
    (YEAR(CURDATE()) - YEAR(ngay_sinh)) - (RIGHT(CURDATE(), 5) < RIGHT(ngay_sinh, 5)) >= 18
        AND (YEAR(CURDATE()) - YEAR(ngay_sinh)) - (RIGHT(CURDATE(), 5) < RIGHT(ngay_sinh, 5)) <= 50
        AND (k.dia_chi LIKE '%Đà Nẵng'
        OR k.dia_chi LIKE '%Quảng Trị');
        
-- c2

SELECT 
    *
FROM
    khach_hang k
WHERE
    (k.dia_chi LIKE '% Quảng Trị'
        OR k.dia_chi LIKE '% Đà Nẵng')
        AND ((YEAR(NOW()) - YEAR(ngay_sinh) BETWEEN 18 AND 50));
        
/*4.	Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu lần. Kết quả hiển thị được sắp xếp tăng dần theo số lần đặt phòng của khách hàng.
 Chỉ đếm những khách hàng nào có Tên loại khách hàng là “Diamond”.*/
 
 -- c1
 SELECT 
    ho_ten, COUNT(ho_ten) AS 'so_luong'
FROM
    khach_hang k
        INNER JOIN
    loai_khach lk ON k.ma_loai_khach = lk.ma_loai_khach
        INNER JOIN
    hop_dong hd ON k.ma_khach_hang = hd.ma_khach_hang
WHERE
    k.ma_loai_khach = 1
GROUP BY ho_ten
ORDER BY so_luong;
 
 /*5.	Hiển thị ma_khach_hang, ho_ten, ten_loai_khach, ma_hop_dong, ten_dich_vu, ngay_lam_hop_dong, ngay_ket_thuc,
 tong_tien (Với tổng tiền được tính theo công thức như sau: 
 Chi Phí Thuê + Số Lượng * Giá, với Số Lượng và Giá là từ bảng dich_vu_di_kem,hop_dong_chi_tiet)
 cho tất cả các khách hàng đã từng đặt phòng. 
(những khách hàng nào chưa từng đặt phòng cũng phải hiển thị ra).*/
 
 -- c1
 
 SELECT DISTINCT
    k.ma_khach_hang,
    k.ho_ten,
    lk.ten_loai_khach,
    hd.ma_hop_dong,
    dv.ten_dich_vu,
    hd.ngay_lam_hop_dong,
    hd.ngay_ket_thuc,
    CASE
        WHEN hdct.so_luong IS NULL THEN SUM(dv.chi_phi_thue)
        ELSE SUM(dv.chi_phi_thue + hdct.so_luong * dvdk.gia)
    END AS 'tong_tien'
FROM
    khach_hang k
        LEFT JOIN
    hop_dong hd ON k.ma_khach_hang = hd.ma_khach_hang
        LEFT JOIN
    loai_khach lk ON k.ma_loai_khach = lk.ma_loai_khach
        LEFT JOIN
    dich_vu dv ON hd.ma_dich_vu = dv.ma_dich_vu
        LEFT JOIN
    hop_dong_chi_tiet hdct ON hd.ma_hop_dong = hdct.ma_hop_dong
        LEFT JOIN
    dich_vu_di_kem dvdk ON hdct.ma_dich_vu_di_kem = dvdk.ma_dich_vu_di_kem
GROUP BY CASE
    WHEN hd.ma_hop_dong IS NULL THEN ho_ten
    ELSE hd.ma_hop_dong
END
;

-- c2

SELECT 
    k.ma_khach_hang,
    k.ho_ten,
    lk.ten_loai_khach,
    hd.ma_hop_dong,
    dv.ten_dich_vu,
    hd.ngay_lam_hop_dong,
    hd.ngay_ket_thuc,
    SUM((IFNULL(hdct.so_luong * dvdk.gia, 0)) + chi_phi_thue) tong_tien
FROM
    khach_hang k
        LEFT JOIN
    loai_khach lk ON k.ma_loai_khach = lk.ma_loai_khach
        LEFT JOIN
    hop_dong hd ON hd.ma_khach_hang = k.ma_khach_hang
        LEFT JOIN
    dich_vu dv ON hd.ma_dich_vu = dv.ma_dich_vu
        LEFT JOIN
    hop_dong_chi_tiet hdct ON hdct.ma_hop_dong = hd.ma_hop_dong
        LEFT JOIN
    dich_vu_di_kem dvdk ON hdct.ma_dich_vu_di_kem = dvdk.ma_dich_vu_di_kem
GROUP BY hd.ma_hop_dong
ORDER BY k.ma_khach_hang;
  
  /*
6.	Hiển thị ma_dich_vu, ten_dich_vu, dien_tich, chi_phi_thue, ten_loai_dich_vu của tất cả các loại dịch vụ 
chưa từng được khách hàng thực hiện đặt từ quý 1 của năm 2021 (Quý 1 là tháng 1, 2, 3).*/

-- c1 lỗi

SELECT DISTINCT
    bang2.ma_dich_vu,
    bang2.ten_dich_vu,
    bang2.dien_tich,
    bang2.chi_phi_thue,
    bang2.ten_loai_dich_vu
FROM
    (SELECT DISTINCT
        dv.ma_dich_vu,
            dv.ten_dich_vu,
            dv.dien_tich,
            dv.chi_phi_thue,
            ldv.ten_loai_dich_vu
    FROM
        dich_vu dv
    RIGHT JOIN hop_dong hd ON dv.ma_dich_vu = hd.ma_dich_vu
    RIGHT JOIN loai_dich_vu ldv ON dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
    WHERE
        NOT hd.ngay_lam_hop_dong BETWEEN '2021-01-01 00:00:00' AND '2021-03-31  23:59:59'
    GROUP BY ma_dich_vu) AS bang1
        INNER JOIN
    (SELECT DISTINCT
        dv.ma_dich_vu,
            dv.ten_dich_vu,
            dv.dien_tich,
            dv.chi_phi_thue,
            ldv.ten_loai_dich_vu
    FROM
        dich_vu dv
    RIGHT JOIN hop_dong hd ON dv.ma_dich_vu = hd.ma_dich_vu
    RIGHT JOIN loai_dich_vu ldv ON dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
    WHERE
        hd.ngay_lam_hop_dong BETWEEN '2021-01-01 00:00:00' AND '2021-03-31  23:59:59'
    GROUP BY dv.ma_dich_vu) AS bang2 ON bang1.ma_dich_vu = bang2.ma_dich_vu
;

-- cach 2 

SELECT 
    dv.ma_dich_vu,
    dv.ten_dich_vu,
    dv.dien_tich,
    dv.chi_phi_thue,
    ldv.ten_loai_dich_vu
FROM
    dich_vu dv
        JOIN
    loai_dich_vu ldv ON dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
        JOIN
    hop_dong hd ON hd.ma_dich_vu = dv.ma_dich_vu
WHERE
    dv.ma_dich_vu NOT IN (SELECT 
            dv.ma_dich_vu
        FROM
            dich_vu dv
                JOIN
            hop_dong hd ON hd.ma_dich_vu = dv.ma_dich_vu
        WHERE
            ((MONTH(hd.ngay_lam_hop_dong) BETWEEN 1 AND 3)
                AND YEAR(hd.ngay_lam_hop_dong) = '2021')
        GROUP BY dv.ten_dich_vu)
GROUP BY dv.ten_dich_vu
ORDER BY dv.dien_tich DESC;

/*7.	Hiển thị thông tin ma_dich_vu, ten_dich_vu, dien_tich, so_nguoi_toi_da, chi_phi_thue, ten_loai_dich_vu của tất cả các loại dịch 
vụ đã từng được khách hàng đặt phòng trong năm 2020 nhưng chưa từng được khách hàng đặt phòng trong năm 2021.*/

-- c1

SELECT 
    bang1.ma_dich_vu,
    bang1.ten_dich_vu,
    bang1.dien_tich,
    bang1.so_nguoi_toi_da,
    bang1.chi_phi_thue,
    bang1.ten_loai_dich_vu,
    bang1.ngay_lam_hop_dong,
    bang1.ma_hop_dong
FROM
    (SELECT 
        dv.ma_dich_vu,
            dv.ten_dich_vu,
            dv.dien_tich,
            dv.so_nguoi_toi_da,
            dv.chi_phi_thue,
            ldv.ten_loai_dich_vu,
            hd.ngay_lam_hop_dong,
            hd.ma_hop_dong
    FROM
        dich_vu dv
    RIGHT JOIN hop_dong hd ON dv.ma_dich_vu = hd.ma_dich_vu
    JOIN loai_dich_vu ldv ON dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
    WHERE
        (hd.ngay_lam_hop_dong BETWEEN '2020-01-01 00:00:00' AND '2020-12-31  23:59:59')
    GROUP BY dv.ten_dich_vu) AS bang1
        LEFT JOIN
    (SELECT 
        dv.ma_dich_vu,
            dv.ten_dich_vu,
            dv.dien_tich,
            dv.so_nguoi_toi_da,
            dv.chi_phi_thue,
            ldv.ten_loai_dich_vu,
            hd.ngay_lam_hop_dong,
            hd.ma_hop_dong
    FROM
        dich_vu dv
    RIGHT JOIN hop_dong hd ON dv.ma_dich_vu = hd.ma_dich_vu
    JOIN loai_dich_vu ldv ON dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
    WHERE
        (hd.ngay_lam_hop_dong BETWEEN '2021-01-01 00:00:00' AND '2021-12-31  23:59:59')
    GROUP BY dv.ten_dich_vu) AS bang2 ON bang1.ten_dich_vu = bang2.ten_dich_vu
WHERE
    bang2.ten_dich_vu IS NULL;
    
    
-- c2

SELECT 
    dv.ma_dich_vu,
    dv.ten_dich_vu,
    dv.dien_tich,
    dv.so_nguoi_toi_da,
    dv.chi_phi_thue,
    ldv.ten_loai_dich_vu
FROM
    dich_vu dv
        JOIN
    loai_dich_vu ldv ON dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
        JOIN
    hop_dong hd ON hd.ma_dich_vu = dv.ma_dich_vu
WHERE
    dv.ma_dich_vu NOT IN (SELECT 
            dv.ma_dich_vu
        FROM
            dich_vu dv
                JOIN
            hop_dong hd ON hd.ma_dich_vu = dv.ma_dich_vu
        WHERE
            (hd.ngay_lam_hop_dong) BETWEEN '2021-01-01' AND '2021-12-31'
        GROUP BY dv.ten_dich_vu)
        AND YEAR(hd.ngay_lam_hop_dong) = '2020'
GROUP BY dv.ten_dich_vu;

/*8.	Hiển thị thông tin ho_ten khách hàng có trong hệ thống, với yêu cầu ho_ten không trùng nhau.
Học viên sử dụng theo 3 cách khác nhau để thực hiện yêu cầu trên.*/


 -- cách1 

SELECT 
    khach_hang.ho_ten
FROM
    khach_hang
GROUP BY khach_hang.ho_ten > 1;


/*cach2*/
SELECT 
    khach_hang.ho_ten,
    COUNT(khach_hang.ho_ten) so_nguoi_trung_ten
FROM
    khach_hang
GROUP BY khach_hang.ho_ten
HAVING so_nguoi_trung_ten > 1;

/*cach 3*/
SELECT DISTINCT
    khach_hang.ho_ten
FROM
    khach_hang
GROUP BY khach_hang.ho_ten > 1;


/*9.	Thực hiện thống kê doanh thu theo tháng, nghĩa là tương ứng với mỗi tháng trong năm 2021 thì sẽ có bao nhiêu khách hàng thực hiện đặt phòng.*/


-- c1

SELECT 
    (MONTH(hop_dong.ngay_lam_hop_dong)) AS thang,
    COUNT(hop_dong.ma_khach_hang) AS so_luong_khach
FROM
    hop_dong
WHERE
    (hop_dong.ngay_lam_hop_dong BETWEEN '2021-01-01 00:00:00' AND '2021-12-31  23:59:59')
GROUP BY thang
ORDER BY thang ASC
;

-- c2

SELECT 
    MONTH(hop_dong.ngay_lam_hop_dong) thang,
    COUNT(hop_dong.ngay_lam_hop_dong) so_luong_khach_hang
FROM
    hop_dong
WHERE
    YEAR(hop_dong.ngay_lam_hop_dong) = '2021'
GROUP BY MONTH(hop_dong.ngay_lam_hop_dong)
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