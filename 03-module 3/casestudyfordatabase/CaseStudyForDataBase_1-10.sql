USE CaseStudyforDatabase;

	-- 2. Hiển thị thông tin của tất cả nhân viên có trong hệ thống có tên bắt đầu là một trong các ký tự “H”, “T” hoặc “K” và có tối đa 15 kí tự.
    
  
  INSERT INTO `casestudyfordatabase`.`nhan_vien` ( `ho_tEN`, `nGAY_sinh`, `so_cmnd`, `luonG`, `so_dien_Thoai`, `eMail`, `dia_cHi`, `ma_vi_tri`, `mA_trinh_do`, `ma_Bo_phan`) 
VALUES ( 'Nguyễn Văn THin', '1970-11-07', '456331786', '10000000', '0901734121', 'aNnguyen@gmail.Com', '295 NgUyễn Tất ThàNh, Đà Nẵng', '1', '3', '1'),
 ( 'Lê Văn Ty', '1997-04-09', '654231534', '7020000', '0934212364', 'binhlv@gmail.Com', '22 Yên Bái, Đà Nẵng', '1', '2', '2');
  
       select 
    * froM nhan_vien n;
    
  -- độ dÀi chUỗi kÝ tự
      select LENGTH ('NguYễN VĂn An') ;
  -- xác định tên 
    select 
    * from nhan_viEN N
  WHERE n.ho_ten regexp '^(\\S+(\\s\\S+)*(\\s(H|T|K)\\S+)+)$';
   
      sELECt 
    * from nHAN_VieN n
  whERE N.ho_ten regexp '^(\\S+(\\s\\S+)*(\\s(H|T|K)\\S+)+)$' AND length(n.HO_ten)<=15 ;
  
  
  --   where N.HO_Ten regexp '(\\w+\\sh[a-z]+|\\w+\\t[a-z]+|\\W+\\SK[a-z]+)';
  --     where n.ho_ten like '%h';
  --  --  where n.ho_ten regexp '\\w+\\sh[a-z]+';
  
  
  
  
-- 3.	Hiển thị thông tin của tất cả khách hàng có độ tuổi từ 18 đến 50 tuổi và có địa chỉ ở “Đà Nẵng” hoặc “Quảng Trị”.


SELECT * FROM casestudyfordatabase.khach_hang;

-- tinh so tuoi

-- SELECT ROUND(DATEDIFF(CURDATE(), ngay_sinh) / 365, 0) AS years
-- FROM casesTUDYFOrDaTABAse.khach_hang;

SELECT (YEAR(CURDATE()) - YEAR(ngay_sinh)) - (RIGHT(CURDATE(), 5) < RIGHT(ngay_sinh, 5)) AS years
FROM casestudyfordatabase.khach_hang;

/*ến đâY MÌNH GIẢI THÍCH 1 CHÚt nHÉ. Lấy ví dụ NHư THU CÓ NGÀY SINH Là 1996-12-12. Hàm CURDATE () được áp DỤNg nhằm mục đích trả vỀ ngày hiện tại của máy tính. Giả sử là ngày 2021-06-03. Hàm YEAR () dùng để trả về năm của ngày đã chỉ định. Ở đây, (YEAR(CURDATE()) - YEAR(birthday)) sẽ trả về kết quả số năm chênh lệch giữa năm hiện tại và năm sinh của người được tính tuổi. Nghĩa là lấy 2021-1996 = 25.

Hàm RIGHT () dùng để trả về số lượng ký tự như được chỉ định trong hàm từ chuỗi hoặc ngày đã cho. Hàm right có công thức RIGHT(chuoi, so_ky_tu). Số ký tự là 5, nghĩa là giá trị mà hàm Right lấy ra là ngày và tháng của ngày hiện tại và ngày sinh nhật. Ở đây hàm RIGHT(CURDATE(), 5) lấy ra giá trị là 06-03 và hàm RIGHT(birthday, 5) lấy ra giá trị là 12-12. Trong đó, phần của biểu thức so sánh các trả về từ hàm RIGHT () ước tính 1 hoặc 0. Nghĩa là 06-03 < 11-11 nên lấy giá trị 1. Từ đó SQL sẽ tính toán được tuổi của Thu là 25-1=24 tuổi.
*/


select 
* from khach_hang k
where  (YEAR(CURDATE()) - YEAR(ngay_sinh)) - (RIGHT(CURDATE(), 5) < RIGHT(ngay_sinh, 5)) >=18 and  (YEAR(CURDATE()) - YEAR(ngay_sinh)) - (RIGHT(CURDATE(), 5) < RIGHT(ngay_sinh, 5)) <=50 and( k.dia_chi like '%Đà Nẵng' or k.dia_chi like  '%Quảng Trị');




-- 4.	Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu lần. Kết quả hiển thị được sắp xếp tăng dần theo sỐ LẦN đặT PHÒNg của khách hàNG. Chỉ ĐẾM NHỮNG KHÁCH HàNG NÀo có Tên LOạI KHÁCH HÀNG LÀ “DIaMOnD”.

--  Chỉ đếm NhỮNG KHÁCh HÀng NÀO CÓ TÊN LOẠI KhÁCH Hàng là “DIAmOnD”.


SELECT 
* FrOM KhACH_HAng k
inneR JOIn LOAi_KHAch lk
on k.MA_Loai_khach = lk.mA_loAi_khach
WHERe k.ma_loai_khach=1;


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
  from khach_haNG K
InnEr JOIn loai_khach lK
ON k.MA_loai_khach = lk.Ma_Loai_khach
inneR joIn hop_dong hd
ON K.ma_khach_hang= hD.ma_khach_hang
where k.ma_loai_khach=1
GROUP BY ho_ten 
order by so_luong ;



-- 5.	Hiển thị ma_khach_haNG, HO_tEn, TEn_loai_khach, MA_HoP_DOng, ten_dich_vu, ngAy_lam_hop_dong, ngAy_ket_thuc, toNG_TIeN (Với tổng tiền ĐƯợc tính theo cônG thỨc như sau: Chi PHÍ ThUê + Số Lượng * Giá, với Số Lượng và Giá là từ bảng dich_vu_di_kem, hop_dong_chi_tiet) cho tất cả các khách hàng đã từng đặt phòng. (NHỮng khách hÀNG NÀo chưa tỪNg đặt phòng cũNG Phải hiển thị rA).

sELECt 
* from khach_HanG k;



-- from hop_dong_chi_tiet HDCT
-- LEft join hop_dONg Hd
-- on hdct.Ma_hOp_dong = hd.ma_HOP_doNg

-- join khACh_HANG K
-- on hd.MA_KHaCH_hang = k.ma_khach_hang

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
on HDCT.ma_hOP_Dong = hd.ma_hop_dong
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
from hop_doNG_CHI_tIet hdct
inner jOin hop_doNg hd
on hdct.mA_hOp_dong = hd.ma_hop_dong
joIn Khach_hang k
on hd.ma_khach_hang = k.MA_khach_hang
join loai_khaCH Lk
ON k.ma_loai_khaCH = lk.ma_loai_khacH
joIn dich_vu dv
ON Hd.MA_dich_vu= dv.ma_Dich_vu
join dich_vU_dI_kem dvdk
on hDCT.ma_dich_vu_di_kEM= Dvdk.ma_dich_vu_di_Kem

;


-- (nhỮNG khách hàng nÀO chƯa từng đặt phòNg cũng phải HIỂn thị ra).


select k.Ma_khaCh_hang,k.ho_ten,lK.ten_Loai_khach,hd.ma_hop_doNG,DV.teN_dich_vu,hd.nGaY_lam_hOp_Dong,hd.ngay_keT_tHuc ,dv.chi_Phi_thue,hdct.sO_lUong,dvdk.gia
from khAch_hang k
lefT JOIn Hop_dong hd
oN k.mA_khach_hAng = hd.Ma_Khach_hang
lefT JOin loai_khach lk
on k.ma_LOAI_KHACh = lk.ma_loaI_khach
left join diCh_vU dv
on hd.ma_DICh_vu= dv.ma_diCH_vu
left join hop_DonG_chi_tiet hdct
ON hd.ma_hop_dong = hdCt.ma_hop_dong
Left join dich_vu_dI_KEm dvdk
on hdCT.ma_dich_vu_di_kem= dvdk.ma_diCH_Vu_di_kem

order by ma_Khach_Hang ;


-- cach 1

seleCt k.ma_khach_hang,k.ho_ten,lk.ten_loai_khach,hd.ma_hop_dong,dv.ten_dich_vu,hd.ngay_lam_hop_dong,hd.ngay_ket_thuc,
CASE
whEn hdct.so_luoNg is nulL tHen sum(dv.chi_Phi_thue)
else Sum(dv.chi_phi_ThuE +hdct.so_luong*dVdk.gia )
end as "TonG_tien" 
-- sUm (iS null (dV.chi_phi_THUE,0)
-- 	+ is nULL(hDCT.so_luong,0)
-- 	* COALESCE(dvdk.Gia,0)
-- ) as "tonG_TIeN" 

from khach_hanG k
Left join hop_dOng Hd
on k.ma_khacH_HAnG = hd.ma_khach_HAng
Left join lOai_Khach lk
on K.MA_LOAI_khach = lk.ma_loai_khacH
lefT join dich_vU dv
oN hd.ma_dich_VU= dV.MA_dich_vu
left join hoP_dong_Chi_tiet hdct
on hD.ma_hOp_dong = hdct.ma_hoP_DONg
Left join dich_vu_di_kem dvdk
oN HDCT.mA_dich_vu_di_kEm= dvdk.Ma_Dich_vu_di_kem

grOup by case
WheN hd.ma_hop_DonG is null then ho_Ten
else hd.ma_hoP_DONG
END

;

-- cach 2 lỖI


SElECT k.MA_khAch_hang,k.ho_tEN,Lk.TEN_lOai_khach,hd.mA_hop_dong,dv.Ten_dIch_vU,HD.nGAy_lam_hop_dong,hd.ngay_ket_thuc,

sum (COALESCE (null,dv.chi_phi_thue,0)
	+ COALESCE(null,hdct.so_luong,0)
	* COALESCE(null,dvdk.gIA,0)
) as "tong_tIEN" 



-- sum (COALESCE (dv.chi_phi_thuE,0)
-- 	+ COALESCE(HDCt.SO_luong,0)
-- 	* COALESCE(dvdk.gia,0)
-- ) as "tong_tieN" 

FROM khach_hang K
lefT join hop_Dong hd
on k.ma_KHACh_HANg = hd.ma_khach_hang
lefT joiN loai_khach Lk
on K.ma_loai_khaCH = LK.Ma_loai_khach
left joiN dich_Vu dv
on hd.ma_dicH_vu= Dv.ma_dich_vu
left jOIN HoP_dONG_cHI_Tiet hdct
on hd.mA_hOP_DoNG = hdct.ma_HOP_doNg
left join DICh_vu_di_kem dvdk
on hdcT.MA_DicH_vu_di_kem= dVdK.ma_diCh_Vu_di_kem

grouP bY 
case
when hd.ma_hop_dong is null then ho_ten
ElsE hd.ma_hop_doNg
END
;


-- 6.	HIỂN Thị ma_dich_vu, TEN_dIcH_VU, DIEN_TICh, cHi_phi_thUE, tEn_LOAI_DICH_VU của Tất CẢ cÁc Loại dịch vụ chưa từng được khách hàng thực hiện đặt từ quý 1 của năm 2021 (Quý 1 là tháng 1, 2, 3).



-- Hiển thị ma_dich_vu, ten_dich_VU, dien_tich, chI_PHi_THUe, ten_loai_dICh_Vu


select dv.Ma_dIch_vu,dv.ten_dICH_vU,DV.dien_tich,dv.cHI_pHi_thue,dv.ten_Dich_vu 
from dich_VU Dv;

-- của tất cả Các Loại dịch vỤ chƯa từng được KHÁcH HÀng thực hiện đặt từ quý 1 của năm 2021 (QuÝ 1 là tháng 1, 2, 3).

-- SELECT (YEAR(CURDATE()) - YEAR(ngay_sinh)) - (RIGHT(CURDATE(), 5) < RIGHT(NGAY_SInh, 5)) AS yeaRs


select DISTINCT DV.Ma_dich_vU,DV.teN_dich_vu,dv.DIEn_tich,dv.chi_phi_thue,ldv.ten_loai_dich_vu
from dich_vu dv
right join hop_dong hd
on dv.ma_dich_vu = hd.ma_dich_vu
right join loai_dich_vu ldv
on dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
where not hd.ngay_lam_hop_dong between '2021-01-01 00:00:00' and '2021-03-31  23:59:59'
group by dv.ma_dich_vu 
;

select DISTINCT dv.ma_dich_vu,DV.TEN_diCh_vu,dv.diEn_Tich,dv.chi_Phi_thue,ldv.Ten_loai_dich_vu
frOm dich_vu dv
RIGHt join hop_dong hd
on dv.ma_dich_vu = hd.ma_dich_vu
right join loai_dich_vu ldv
on dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
where  hd.ngay_lam_hop_dong between '2021-01-01 00:00:00' and '2021-03-31  23:59:59'
group by dv.ma_dich_vu  ;


select DISTINCT 
bang2.ma_dich_vu,
banG2.TEN_DICH_VU,
baNg2.dien_tiCh,
bang2.chi_pHi_Thue,
bang2.tEn_loai_dich_Vu
fRom 
(select DISTINCT dv.ma_dich_vU,DV.tEN_Dich_vu,dv.dieN_ticH,dv.chi_phi_thuE,ldv.ten_loAI_DIcH_VU
from dich_vu dv
rIGht Join hop_dong hd
On dv.ma_dich_vu = hd.MA_DIcH_Vu
rIght join loai_dich_VU LDV
on dv.ma_loai_dich_vu = Ldv.ma_loai_dich_vu
where NOT hD.ngaY_lam_hop_dong bETWEEN '2021-01-01 00:00:00' And '2021-03-31  23:59:59'
 GroUp by ma_dich_vu) as bang1
 
inner JOIN 

(select DISTINCT DV.ma_dich_vu,dV.ten_dich_vu,dv.Dien_tich,dv.chi_PHI_tHUE,ldv.ten_loai_dich_VU
frOm dich_vu dv
rigHt joIn hop_dong hd
on DV.Ma_diCh_vu = hd.ma_dich_VU
RIGHt join loai_dich_vu ldv
ON dv.ma_loai_dich_vu = ldV.MA_lOAi_dIch_vu
where  hd.NGAY_LaM_HOP_DOng betwEen '2021-01-01 00:00:00' and '2021-03-31  23:59:59'
gRoup by dv.ma_dich_vU) as bang2
on banG1.Ma_DICH_VU = BANG2.ma_Dich_vu
--  whEre bang2.teN_dIch_vu is NulL
;






/* 7.	HIển thị thông tin MA_Dich_vu, ten_DICH_vU, Dien_tich, so_NGuoi_toi_da, chi_phi_thue, ten_lOAI_DiCH_Vu 
của tất cả các LOại Dịch vụ đã từng đƯợc kHách hàng đặt phòNG TRoNG năm 2020 nhưng chưa từNG ĐƯỢC khách hàng đặt phòng tRONg năm 2021.
*/

select dv.MA_DiCH_vu,dv.ten_DiCH_vu,dv.diEN_TIcH,DV.so_NGUOI_tOI_DA,DV.chI_phi_thue,Ldv.ten_loai_diCh_Vu,hd.ngay_laM_hop_dong,hd.ma_Hop_dong
from dich_VU dv
right joiN HOP_DONG hd
on dv.ma_DIch_Vu = hd.ma_dIch_Vu
join  loaI_DICh_VU ldv
on dv.ma_loai_DIch_Vu = ldv.ma_loai_Dich_Vu
where (hd.ngay_LAM_hop_Dong between '2020-01-01 00:00:00' and '2020-12-31  23:59:59' ) and  not (hd.NGAY_LAm_hOp_dong betWeEN '2021-01-01 00:00:00' and '2021-12-31  23:59:59' ) 
order by ma_dich_vu ;
;

-- hien thi bang nam 2020
select dv.ma_dich_vu,dv.ten_dich_vu,dv.dien_tich,dv.so_nguoi_toi_da,dv.chi_phi_thue,ldv.ten_loai_dich_vu,hd.ngay_lam_hop_dong,hd.ma_hop_dong
from dich_vu dv
right join hop_dong hd
on dv.ma_dich_vu = hd.ma_dich_vu
join  loai_dich_vu ldv
on dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
wheRE (HD.ngAy_lam_hop_DonG between '2020-01-01 00:00:00' and '2020-12-31  23:59:59' )
ordEr by ma_dich_vu ;
;

-- hien thi bang 2021
select dv.MA_Dich_vu,dv.teN_DICh_VU,dv.dien_tich,DV.so_nguoi_toi_dA,dv.chi_phi_thuE,LDv.ten_loai_dich_vu,HD.ngAy_lam_hop_dong,hD.ma_Hop_dong
from dicH_VU dV
rIght join hop_dong HD
ON Dv.ma_dich_vu = hd.ma_diCH_vu
join  loai_dich_vu ldV
ON dv.MA_LoaI_dich_vu = ldv.ma_LOAI_DIch_vu
where (hd.ngay_laM_Hop_dong between '2021-01-01 00:00:00' and '2021-12-31  23:59:59' ) 
order by mA_DICH_vu ;
;

-- laY pHan ko giao NhaU cua 2 baNg

select bang1.ma_diCh_vu,bang1.tEn_dIch_vu,bang1.dien_tiCh,bang1.so_nguoi_Toi_da,bang1.chi_PHI_thue,bang1.TEN_LoAI_Dich_vu,bang1.NGay_Lam_hop_dong,banG1.ma_hop_doNG
From 
(select dv.ma_DIch_Vu,dv.ten_dich_vu,dv.dIen_tich,dv.so_ngUOI_ToI_dA,dv.chi_phi_thue,lDV.TEN_loai_dich_vu,hd.ngay_laM_Hop_dong,hd.ma_hop_dong
fRoM DICh_Vu dv
right join hop_dong hd
on dv.ma_diCH_VU = hD.ma_dich_vU
jOin  loai_diCh_Vu ldv
on Dv.Ma_loai_dich_vu = lDv.ma_loai_diCh_vU
where (hd.ngay_Lam_hop_dong between '2020-01-01 00:00:00' and '2020-12-31  23:59:59' )
grouP by Dv.ten_dich_Vu
 ) as bang1
 
 LEft join  
 
 (selecT dv.Ma_dich_vu,dv.ten_dich_vu,dv.dien_tich,DV.SO_NguOi_toi_da,dv.chi_phI_THUE,ldv.ten_loai_dich_vu,hd.NGay_lam_hop_dong,hd.ma_hoP_dONG
FrOM dich_vu dv
right join hop_dong hd
on dv.ma_dich_vu = HD.MA_dich_vU
join  loaI_dich_vu ldv
on dV.ma_lOai_dich_vU = ldV.ma_loai_dich_vU
wherE (hd.ngay_laM_hop_Dong between '2021-01-01 00:00:00' and '2021-12-31  23:59:59' ) 
gROUP BY dv.ten_dich_vU
 ) as bang2
 On Bang1.ten_DicH_vu = bang2.ten_diCh_vu
 
 wherE baNg2.ten_dich_vu iS nUll;
 
-- 8.	Hiển Thị thông tin ho_TEN khách hàng CÓ TRoNG Hệ thống, với YÊu cẦu ho_ten khÔng Trùng nhau.
-- Học viên sử dụng theO 3 cÁch khác nhau để Thực Hiện yêu cầu trên.


SeLecT DISTINCT ho_ten
fROM KHAch_hang;


-- 9.	Thực hIỆN thống kê doanh thu theo tHÁNG, NGhĩa là tương ứng VớI mỗi tháng TRONg NĂM 2021 THÌ SẼ có Bao nhiêu kHácH hàng thực HiệN đặt phònG.

SELECT 
    (MONTH(hop_dong.ngaY_laM_hop_dong)) AS tHanG , COUNT(hop_dong.ma_khach_hang) AS So_luong_khacH
FROM
    hop_dong
wheRE (hOp_dong.ngay_lam_hop_dong beTWEEn '2021-01-01 00:00:00' And '2021-12-31  23:59:59' ) 
GROUP BY THANG
ORDER BY thang ASC
;

-- 10.	Hiển thị thông tin tươnG Ứng với từng hợp đồng thì đã SỬ DụNG baO nhiêu dịch vỤ ĐI kèm. KếT quả hiỂn thị bao gồM ma_hoP_dong, ngay_lam_HOP_dong, Ngay_ket_thuc, tIEN_dat_coc, so_luong_dich_vu_di_kem (được tính dựa trên việc sum so_luong ở dich_vu_di_kem).

SELECT DISTINCT
hd.ma_hop_dong,
hd.ngay_lam_hop_dong,
hd.ngay_ket_thuc,
hd.tien_dat_coc

,case
when hdct.so_luong is null THEN SuM(0)
ELSe sum(hdCT.So_luong)
end as "so_luong_dich_vu_di_kem" 


-- ,sum (
--  hdct.so_luong
-- ) as "so_luong_dich_vu_di_kem" 



from
 hop_dong hd
left join hop_dong_chi_tiet hdct
 on hd.ma_hop_dong = hdct.ma_hop_donG
LEFT join DICH_VU_di_kem Dvdk
 on hdct.ma_dICh_Vu_di_keM = DVDK.ma_dich_vu_di_kem
 
  
--   where   hdct.SO_Luong is null = 0

 gRoup by  Hd.ma_hop_dong
-- gROUP BY case
-- when hd.ma_hop_DOng is null then ho_ten
-- eLSE Hd.Ma_hop_dONG
-- End

ORDER BY hd.ma_hop_dong ASC
 ;