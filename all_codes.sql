-- MENGECEK APAKAH ADA NULL VALUES DI TIAP TABEL

-- TABEL CUSTOMER
select * from customer
where 	customerid is null or  
		age  is null or  
		gender is null or 
		"Marital Status" is null or 
		income is null;

/* DI TABEL CUSTOMER ADA 3 DATA YANG KOSONG PADA KOLOM MARITAL STATUS
 * MAKA DARI ITU AKAN DI ISI DENGAN DATA MODUS (MARIED)
 */
update customer 
set "Marital Status" = 'Married' 
where "Marital Status" is null;

-- DATA MISSING VALUES SUDAH TERISI
select * from customer;

-- TABEL PRODUCT
select * from product
where 	productid is null or  
		"Product Name" is null or  
		price is null;	
	
-- TABEL STORE
select * from store
where 	storeid is null or  
		storename is null or  
		groupstore is null or 
		"Type" is null or
		latitude is null or
		longitude is null;
	
-- TABEL TRANSACTION
select * from transaction
where 	transactionid is null or
		customerid is null or
		"Date" is null or
		productid is null or
		price is null or
		qty is null or
		totalamount is null or
		storeid is null

/*========================================================================*/
-- CHALLENGE query 1 : Berapa rata-rata umur customer jika dilihat dari marital statusnya ?
select round(avg(age),2) as rata_umur, "Marital Status"  from customer
group by "Marital Status" 
order by avg(age) desc;

-- CHALLENGE query 2 : Berapa rata-rata umur customer jika dilihat dari gender nya ?
select gender, round(avg(age),2) as rata_umur from customer 
group by gender 
order by avg(age) desc;

-- CHALLENGE query 3 : Tentukan nama store dengan total quantity terbanyak!
select storename, sum(qty) as quantity from store
left join transaction
on transaction.storeid = store.storeid 
group by storename 
order by sum(qty) desc;

-- CHALLENGE query 4 : Tentukan nama produk terlaris dengan total amount terbanyak!
/* 
 * tabel transaction dan tabel product memiliki primary key storeid berupa varchar
 * maka dari itu, primary key pada kedua tabel harus diubah ke integer 
 * agar dapat di- join
 */ 

-- mengubah kolom storeid di tabel transaction
select * from transaction;

update transaction
set productid = case productid 
				when 'P1' then 1
				when 'P2' then 2
				when 'P3' then 3
				when 'P4' then 4
				when 'P5' then 5
				when 'P6' then 6
				when 'P7' then 7
				when 'P8' then 8
				when 'P9' then 9
				when 'P10' then 10
				end;
				
select * from transaction;

ALTER TABLE transaction 
ALTER COLUMN productid set data TYPE int 
USING productid::INTEGER;

-- mengubah kolom storeid di tabel product
select * from product;

update product 
set productid = case productid 
				when 'P1' then 1
				when 'P2' then 2
				when 'P3' then 3
				when 'P4' then 4
				when 'P5' then 5
				when 'P6' then 6
				when 'P7' then 7
				when 'P8' then 8
				when 'P9' then 9
				when 'P10' then 10
				end;

ALTER TABLE product
ALTER COLUMN productid set data TYPE int 
USING productid::INTEGER;
			
select * from product;

-- hasil challange 4: Tentukan nama produk terlaris dengan total amount terbanyak!
select "Product Name",sum(totalamount) as total_amount from product
left join transaction
on product.productid = transaction.productid 
group by "Product Name" 
order by sum(totalamount) desc;

/*========================================================================*/
-- cek tiap tabel
select * from customer;
select * from product;
select * from store;
select * from transaction;

/*========================================================================*/
-- update tabel customer kolom income menjadi float
update customer 
set income = replace(income::text, ',', '.');

-- lalu mengubah kolom income menjadi decimal/float
ALTER TABLE customer 
ALTER COLUMN income set data TYPE numeric  
USING income::numeric;

/*========================================================================*/
-- mengubah tipe data pada kolom "Date" menjadi tipe data Date pada tabel Transaction
-- 1.menambahkan kolom baru untuk tanggal
ALTER TABLE transaction
ADD "DATE" DATE;

-- 2.Mengupdate tabel transaction dan memindahkan kolom varchar "Date" yang lama ke kolom "DATE" yang baru
UPDATE transaction
SET "DATE" = TO_DATE("Date", 'DD/MM/YYYY');

-- 3.Menghapus kolom "Date" yang lama
ALTER TABLE transaction
DROP COLUMN "Date";
/*========================================================================*/
-- Menggabungkan semua dataset menjadi 1 data utama

SELECT 
    t.transactionid,
    c.customerid,
    c.age,
    c.gender,
    c."Marital Status",
    c.income,
    p."Product Name",
    s.storename,
    s.groupstore,
    s."Type",
    s.latitude,
    s.longitude,
    t.price,
    t.qty,
    t.totalamount,
    t."DATE"
FROM 
    "transaction" t
JOIN
    customer c ON t.customerid = c.customerid
JOIN
    product p ON t.productid = p.productid
JOIN
    store s ON t.storeid = s.storeid;
