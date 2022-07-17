USE CaseStudyforDatabase;

	-- 2. Hiển thị thông tin của tất cả nhân viên có trong hệ thống có tên bắt đầu là một trong các ký tự “H”, “T” hoặc “K” và có tối đa 15 kí tự.
    
    
--     select 
--     * from nhan_vien n
--   where n.ho_ten regexp '^(\\w+(\\sH\\w+)+)$' ;
--   
--   
--       select 
--     * from nhan_vien n
--   where n.ho_ten regexp '^(\\S+(\\s\\S+)*(\\sT\\S+)+)$' ;
--   
  
  
  INSERT INTO `casestudyfordatabase`.`nhan_vien` ( `ho_ten`, `ngay_sinh`, `so_cmnd`, `luong`, `so_dien_thoai`, `email`, `dia_chi`, `ma_vi_tri`, `ma_trinh_do`, `ma_bo_phan`) 
VALUES ( 'Nguyễn Văn Thin', '1970-11-07', '456331786', '10000000', '0901734121', 'annguyen@gmail.com', '295 Nguyễn Tất Thành, Đà Nẵng', '1', '3', '1'),
 ( 'Lê Văn Ty', '1997-04-09', '654231534', '7020000', '0934212364', 'binhlv@gmail.com', '22 Yên Bái, Đà Nẵng', '1', '2', '2');
  
       select 
    * from nhan_vien n;
    
  -- độ dài chuỗi ký tự
      select length ('Nguyễn Văn An') ;
  -- xác định tên 
    select 
    * from nhan_vien n
  where n.ho_ten regexp '^(\\S+(\\s\\S+)*(\\s(H|T|K)\\S+)+)$';
   
      select 
    * from nhan_vien n
  where n.ho_ten regexp '^(\\S+(\\s\\S+)*(\\s(H|T|K)\\S+)+)$' and length(n.ho_ten)<=15 ;
  
  
  --   where n.ho_ten regexp '(\\w+\\sh[a-z]+|\\w+\\t[a-z]+|\\w+\\sk[a-z]+)';
  --     where n.ho_ten like '%h';
  --  --  where n.ho_ten regexp '\\w+\\sh[a-z]+';
  
  
  
  
-- 3.	Hiển thị thông tin của tất cả khách hàng có độ tuổi từ 18 đến 50 tuổi và có địa chỉ ở “Đà Nẵng” hoặc “Quảng Trị”.


SELECT * FROM casestudyfordatabase.khach_hang;

-- tinh so tuoi

-- SELECT ROUND(DATEDIFF(CURDATE(), ngay_sinh) / 365, 0) AS years
-- FROM casestudyfordatabase.khach_hang;

SELECT (YEAR(CURDATE()) - YEAR(ngay_sinh)) - (RIGHT(CURDATE(), 5) < RIGHT(ngay_sinh, 5)) AS years
FROM casestudyfordatabase.khach_hang;

/*ến đây mình giải thích 1 chút nhé. Lấy ví dụ như Thu có ngày sinh là 1996-12-12. Hàm CURDATE () được áp dụng nhằm mục đích trả về ngày hiện tại của máy tính. Giả sử là ngày 2021-06-03. Hàm YEAR () dùng để trả về năm của ngày đã chỉ định. Ở đây, (YEAR(CURDATE()) - YEAR(birthday)) sẽ trả về kết quả số năm chênh lệch giữa năm hiện tại và năm sinh của người được tính tuổi. Nghĩa là lấy 2021-1996 = 25.

Hàm RIGHT () dùng để trả về số lượng ký tự như được chỉ định trong hàm từ chuỗi hoặc ngày đã cho. Hàm right có công thức RIGHT(chuoi, so_ky_tu). Số ký tự là 5, nghĩa là giá trị mà hàm Right lấy ra là ngày và tháng của ngày hiện tại và ngày sinh nhật. Ở đây hàm RIGHT(CURDATE(), 5) lấy ra giá trị là 06-03 và hàm RIGHT(birthday, 5) lấy ra giá trị là 12-12. Trong đó, phần của biểu thức so sánh các trả về từ hàm RIGHT () ước tính 1 hoặc 0. Nghĩa là 06-03 < 11-11 nên lấy giá trị 1. Từ đó SQL sẽ tính toán được tuổi của Thu là 25-1=24 tuổi.
*/


select 
* from khach_hang k
where  (YEAR(CURDATE()) - YEAR(ngay_sinh)) - (RIGHT(CURDATE(), 5) < RIGHT(ngay_sinh, 5)) >=18 and  (YEAR(CURDATE()) - YEAR(ngay_sinh)) - (RIGHT(CURDATE(), 5) < RIGHT(ngay_sinh, 5)) <=50 and( k.dia_chi like '%Đà Nẵng' or k.dia_chi like  '%Quảng Trị');




-- 4.	Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu lần. Kết quả hiển thị được sắp xếp tăng dần theo số lần đặt phòng của khách hàng. Chỉ đếm những khách hàng nào có Tên loại khách hàng là “Diamond”.

--  Chỉ đếm những khách hàng nào có Tên loại khách hàng là “Diamond”.


select 
* from khach_hang k
inner join loai_khach lk
on k.ma_loai_khach = lk.ma_loai_khach
where k.ma_loai_khach=1;


--  Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu lần. 

select 
* from khach_hang k
left join loai_khach lk
on k.ma_loai_khach = lk.ma_loai_khach
inner join hop_dong hd
on k.ma_khach_hang= hd.ma_khach_hang
where k.ma_loai_khach=1;
-- Kết quả hiển thị được sắp xếp tăng dần theo số lần đặt phòng của khách hàng. 
SELECT  ho_ten, COUNT(ho_ten) AS "so_luong"
  from khach_hang k
inner join loai_khach lk
on k.ma_loai_khach = lk.ma_loai_khach
inner join hop_dong hd
on k.ma_khach_hang= hd.ma_khach_hang
where k.ma_loai_khach=1
GROUP BY ho_ten 
order by so_luong ;



-- 5.	Hiển thị ma_khach_hang, ho_ten, ten_loai_khach, ma_hop_dong, ten_dich_vu, ngay_lam_hop_dong, ngay_ket_thuc, tong_tien (Với tổng tiền được tính theo công thức như sau: Chi Phí Thuê + Số Lượng * Giá, với Số Lượng và Giá là từ bảng dich_vu_di_kem, hop_dong_chi_tiet) cho tất cả các khách hàng đã từng đặt phòng. (những khách hàng nào chưa từng đặt phòng cũng phải hiển thị ra).

select 
* from khach_hang k;



-- from hop_dong_chi_tiet hdct
-- left join hop_dong hd
-- on hdct.ma_hop_dong = hd.ma_hop_dong

-- join khach_hang k
-- on hd.ma_khach_hang = k.ma_khach_hang

-- join khach_hang k
-- on hd.ma_khach_hang = k.ma_khach_hang
-- join loai_khach lk
-- on k.ma_loai_khach = lk.ma_loai_khach
-- join dich_vu dv
-- on hd.ma_dich_vu= dv.ma_dich_vu
-- join dich_vu_di_kem dvdk
-- on hdct.ma_dich_vu_di_kem= dvdk.ma_dich_vu_di_kem
;


-- hien thi

select k.ma_khach_hang,k.ho_ten,lk.ten_loai_khach,hd.ma_hop_dong,dv.ten_dich_vu,hd.ngay_lam_hop_dong,hd.ngay_ket_thuc
from hop_dong_chi_tiet hdct
left join hop_dong hd
on hdct.ma_hop_dong = hd.ma_hop_dong
right join khach_hang k
on hd.ma_khach_hang = k.ma_khach_hang
join loai_khach lk
on k.ma_loai_khach = lk.ma_loai_khach
join dich_vu dv
on hd.ma_dich_vu= dv.ma_dich_vu
join dich_vu_di_kem dvdk
on hdct.ma_dich_vu_di_kem= dvdk.ma_dich_vu_di_kem
;


select k.ma_khach_hang,k.ho_ten,lk.ten_loai_khach,hd.ma_hop_dong,dv.ten_dich_vu,hd.ngay_lam_hop_dong,hd.ngay_ket_thuc,sum(dv.chi_phi_thue+hdct.so_luong*dvdk.gia) as "tong_tien"
from hop_dong_chi_tiet hdct
inner join hop_dong hd
on hdct.ma_hop_dong = hd.ma_hop_dong
join khach_hang k
on hd.ma_khach_hang = k.ma_khach_hang
join loai_khach lk
on k.ma_loai_khach = lk.ma_loai_khach
join dich_vu dv
on hd.ma_dich_vu= dv.ma_dich_vu
join dich_vu_di_kem dvdk
on hdct.ma_dich_vu_di_kem= dvdk.ma_dich_vu_di_kem

;


-- (những khách hàng nào chưa từng đặt phòng cũng phải hiển thị ra).


select k.ma_khach_hang,k.ho_ten,lk.ten_loai_khach,hd.ma_hop_dong,dv.ten_dich_vu,hd.ngay_lam_hop_dong,hd.ngay_ket_thuc ,dv.chi_phi_thue,hdct.so_luong,dvdk.gia
from khach_hang k
left join hop_dong hd
on k.ma_khach_hang = hd.ma_khach_hang
left join loai_khach lk
on k.ma_loai_khach = lk.ma_loai_khach
left join dich_vu dv
on hd.ma_dich_vu= dv.ma_dich_vu
left join hop_dong_chi_tiet hdct
on hd.ma_hop_dong = hdct.ma_hop_dong
left join dich_vu_di_kem dvdk
on hdct.ma_dich_vu_di_kem= dvdk.ma_dich_vu_di_kem

order by ma_khach_hang ;


-- cach 1

select k.ma_khach_hang,k.ho_ten,lk.ten_loai_khach,hd.ma_hop_dong,dv.ten_dich_vu,hd.ngay_lam_hop_dong,hd.ngay_ket_thuc,
case
when hdct.so_luong is null then sum(dv.chi_phi_thue)
else sum(dv.chi_phi_thue +hdct.so_luong*dvdk.gia )
end as "tong_tien" 
-- sum (is null (dv.chi_phi_thue,0)
-- 	+ is null(hdct.so_luong,0)
-- 	* COALESCE(dvdk.gia,0)
-- ) as "tong_tien" 

from khach_hang k
left join hop_dong hd
on k.ma_khach_hang = hd.ma_khach_hang
left join loai_khach lk
on k.ma_loai_khach = lk.ma_loai_khach
left join dich_vu dv
on hd.ma_dich_vu= dv.ma_dich_vu
left join hop_dong_chi_tiet hdct
on hd.ma_hop_dong = hdct.ma_hop_dong
left join dich_vu_di_kem dvdk
on hdct.ma_dich_vu_di_kem= dvdk.ma_dich_vu_di_kem

group by case
when hd.ma_hop_dong is null then ho_ten
else hd.ma_hop_dong
end

;

-- cach 2 lỗi


select k.ma_khach_hang,k.ho_ten,lk.ten_loai_khach,hd.ma_hop_dong,dv.ten_dich_vu,hd.ngay_lam_hop_dong,hd.ngay_ket_thuc,

sum (COALESCE (null,dv.chi_phi_thue,0)
	+ COALESCE(null,hdct.so_luong,0)
	* COALESCE(null,dvdk.gia,0)
) as "tong_tien" 



-- sum (COALESCE (dv.chi_phi_thue,0)
-- 	+ COALESCE(hdct.so_luong,0)
-- 	* COALESCE(dvdk.gia,0)
-- ) as "tong_tien" 

from khach_hang k
left join hop_dong hd
on k.ma_khach_hang = hd.ma_khach_hang
left join loai_khach lk
on k.ma_loai_khach = lk.ma_loai_khach
left join dich_vu dv
on hd.ma_dich_vu= dv.ma_dich_vu
left join hop_dong_chi_tiet hdct
on hd.ma_hop_dong = hdct.ma_hop_dong
left join dich_vu_di_kem dvdk
on hdct.ma_dich_vu_di_kem= dvdk.ma_dich_vu_di_kem

group by 
case
when hd.ma_hop_dong is null then ho_ten
else hd.ma_hop_dong
end
;


-- 6.	Hiển thị ma_dich_vu, ten_dich_vu, dien_tich, chi_phi_thue, ten_loai_dich_vu của tất cả các loại dịch vụ chưa từng được khách hàng thực hiện đặt từ quý 1 của năm 2021 (Quý 1 là tháng 1, 2, 3).



-- Hiển thị ma_dich_vu, ten_dich_vu, dien_tich, chi_phi_thue, ten_loai_dich_vu


select dv.ma_dich_vu,dv.ten_dich_vu,dv.dien_tich,dv.chi_phi_thue,dv.ten_dich_vu 
from dich_vu dv;

-- của tất cả các loại dịch vụ chưa từng được khách hàng thực hiện đặt từ quý 1 của năm 2021 (Quý 1 là tháng 1, 2, 3).

-- SELECT (YEAR(CURDATE()) - YEAR(ngay_sinh)) - (RIGHT(CURDATE(), 5) < RIGHT(ngay_sinh, 5)) AS years


select DISTINCT dv.ma_dich_vu,dv.ten_dich_vu,dv.dien_tich,dv.chi_phi_thue,ldv.ten_loai_dich_vu
from dich_vu dv
right join hop_dong hd
on dv.ma_dich_vu = hd.ma_dich_vu
right join loai_dich_vu ldv
on dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
where not hd.ngay_lam_hop_dong between '2021-01-01 00:00:00' and '2021-03-31  23:59:59'
group by dv.ma_dich_vu 
;

select DISTINCT dv.ma_dich_vu,dv.ten_dich_vu,dv.dien_tich,dv.chi_phi_thue,ldv.ten_loai_dich_vu
from dich_vu dv
right join hop_dong hd
on dv.ma_dich_vu = hd.ma_dich_vu
right join loai_dich_vu ldv
on dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
where  hd.ngay_lam_hop_dong between '2021-01-01 00:00:00' and '2021-03-31  23:59:59'
group by dv.ma_dich_vu  ;


select DISTINCT 
bang2.ma_dich_vu,
bang2.ten_dich_vu,
bang2.dien_tich,
bang2.chi_phi_thue,
bang2.ten_loai_dich_vu
from 
(select DISTINCT dv.ma_dich_vu,dv.ten_dich_vu,dv.dien_tich,dv.chi_phi_thue,ldv.ten_loai_dich_vu
from dich_vu dv
right join hop_dong hd
on dv.ma_dich_vu = hd.ma_dich_vu
right join loai_dich_vu ldv
on dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
where not hd.ngay_lam_hop_dong between '2021-01-01 00:00:00' and '2021-03-31  23:59:59'
 group by ma_dich_vu) as bang1
 
inner join 

(select DISTINCT dv.ma_dich_vu,dv.ten_dich_vu,dv.dien_tich,dv.chi_phi_thue,ldv.ten_loai_dich_vu
from dich_vu dv
right join hop_dong hd
on dv.ma_dich_vu = hd.ma_dich_vu
right join loai_dich_vu ldv
on dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
where  hd.ngay_lam_hop_dong between '2021-01-01 00:00:00' and '2021-03-31  23:59:59'
group by dv.ma_dich_vu) as bang2
on bang1.ma_dich_vu = bang2.ma_dich_vu
--  where bang2.ten_dich_vu is null
;






/* 7.	Hiển thị thông tin ma_dich_vu, ten_dich_vu, dien_tich, so_nguoi_toi_da, chi_phi_thue, ten_loai_dich_vu 
của tất cả các loại dịch vụ đã từng được khách hàng đặt phòng trong năm 2020 nhưng chưa từng được khách hàng đặt phòng trong năm 2021.
*/

select dv.ma_dich_vu,dv.ten_dich_vu,dv.dien_tich,dv.so_nguoi_toi_da,dv.chi_phi_thue,ldv.ten_loai_dich_vu,hd.ngay_lam_hop_dong,hd.ma_hop_dong
from dich_vu dv
right join hop_dong hd
on dv.ma_dich_vu = hd.ma_dich_vu
join  loai_dich_vu ldv
on dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
where (hd.ngay_lam_hop_dong between '2020-01-01 00:00:00' and '2020-12-31  23:59:59' ) and  not (hd.ngay_lam_hop_dong between '2021-01-01 00:00:00' and '2021-12-31  23:59:59' ) 
order by ma_dich_vu ;
;

-- hien thi bang nam 2020
select dv.ma_dich_vu,dv.ten_dich_vu,dv.dien_tich,dv.so_nguoi_toi_da,dv.chi_phi_thue,ldv.ten_loai_dich_vu,hd.ngay_lam_hop_dong,hd.ma_hop_dong
from dich_vu dv
right join hop_dong hd
on dv.ma_dich_vu = hd.ma_dich_vu
join  loai_dich_vu ldv
on dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
where (hd.ngay_lam_hop_dong between '2020-01-01 00:00:00' and '2020-12-31  23:59:59' )
order by ma_dich_vu ;
;

-- hien thi bang 2021
select dv.ma_dich_vu,dv.ten_dich_vu,dv.dien_tich,dv.so_nguoi_toi_da,dv.chi_phi_thue,ldv.ten_loai_dich_vu,hd.ngay_lam_hop_dong,hd.ma_hop_dong
from dich_vu dv
right join hop_dong hd
on dv.ma_dich_vu = hd.ma_dich_vu
join  loai_dich_vu ldv
on dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
where (hd.ngay_lam_hop_dong between '2021-01-01 00:00:00' and '2021-12-31  23:59:59' ) 
order by ma_dich_vu ;
;

-- lay phan ko giao nhau cua 2 bang

select bang1.ma_dich_vu,bang1.ten_dich_vu,bang1.dien_tich,bang1.so_nguoi_toi_da,bang1.chi_phi_thue,bang1.ten_loai_dich_vu,bang1.ngay_lam_hop_dong,bang1.ma_hop_dong
from 
(select dv.ma_dich_vu,dv.ten_dich_vu,dv.dien_tich,dv.so_nguoi_toi_da,dv.chi_phi_thue,ldv.ten_loai_dich_vu,hd.ngay_lam_hop_dong,hd.ma_hop_dong
from dich_vu dv
right join hop_dong hd
on dv.ma_dich_vu = hd.ma_dich_vu
join  loai_dich_vu ldv
on dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
where (hd.ngay_lam_hop_dong between '2020-01-01 00:00:00' and '2020-12-31  23:59:59' )
group by dv.ten_dich_vu
 ) as bang1
 
 left join  
 
 (select dv.ma_dich_vu,dv.ten_dich_vu,dv.dien_tich,dv.so_nguoi_toi_da,dv.chi_phi_thue,ldv.ten_loai_dich_vu,hd.ngay_lam_hop_dong,hd.ma_hop_dong
from dich_vu dv
right join hop_dong hd
on dv.ma_dich_vu = hd.ma_dich_vu
join  loai_dich_vu ldv
on dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
where (hd.ngay_lam_hop_dong between '2021-01-01 00:00:00' and '2021-12-31  23:59:59' ) 
group by dv.ten_dich_vu
 ) as bang2
 on bang1.ten_dich_vu = bang2.ten_dich_vu
 
 where bang2.ten_dich_vu is null;
 
-- 8.	Hiển thị thông tin ho_ten khách hàng có trong hệ thống, với yêu cầu ho_ten không trùng nhau.
-- Học viên sử dụng theo 3 cách khác nhau để thực hiện yêu cầu trên.


select DISTINCT ho_ten
from khach_hang;


-- 9.	Thực hiện thống kê doanh thu theo tháng, nghĩa là tương ứng với mỗi tháng trong năm 2021 thì sẽ có bao nhiêu khách hàng thực hiện đặt phòng.

SELECT 
    (MONTH(hop_dong.ngay_lam_hop_dong)) AS thang , COUNT(hop_dong.ma_khach_hang) AS so_luong_khach
FROM
    hop_dong
where (hop_dong.ngay_lam_hop_dong between '2021-01-01 00:00:00' and '2021-12-31  23:59:59' ) 
GROUP BY thang
ORDER BY thang ASC
;

-- 10.	Hiển thị thông tin tương ứng với từng hợp đồng thì đã sử dụng bao nhiêu dịch vụ đi kèm. Kết quả hiển thị bao gồm ma_hop_dong, ngay_lam_hop_dong, ngay_ket_thuc, tien_dat_coc, so_luong_dich_vu_di_kem (được tính dựa trên việc sum so_luong ở dich_vu_di_kem).

SELECT DISTINCT
hd.ma_hop_dong,
hd.ngay_lam_hop_dong,
hd.ngay_ket_thuc,
hd.tien_dat_coc

,case
when hdct.so_luong is null then sum(0)
else sum(hdct.so_luong)
end as "so_luong_dich_vu_di_kem" 


-- ,sum (
--  hdct.so_luong
-- ) as "so_luong_dich_vu_di_kem" 



from
 hop_dong hd
left join hop_dong_chi_tiet hdct
 on hd.ma_hop_dong = hdct.ma_hop_dong
left join dich_vu_di_kem dvdk
 on hdct.ma_dich_vu_di_kem = dvdk.ma_dich_vu_di_kem
 
  
--   where   hdct.so_luong is null = 0

 group by  hd.ma_hop_dong
-- group by case
-- when hd.ma_hop_dong is null then ho_ten
-- else hd.ma_hop_dong
-- end

ORDER BY hd.ma_hop_dong ASC
 ;