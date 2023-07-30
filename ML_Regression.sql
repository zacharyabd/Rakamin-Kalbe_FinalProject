-- melihat bentuk data dari tabel data_gabungan

select * from data_gabungan

/* ================================================== */
-- mengubah kolom "DATE dengan tipe data varchar(50) menjadi tipe data Date

-- 1. membuat kolom "Tanggal" baru untuk tipe data Date
ALTER TABLE data_gabungan  ADD COLUMN Tanggal DATE;

-- 2. perbarui nilai kolom baru
UPDATE data_gabungan  SET Tanggal = TO_DATE("DATE" , 'YYYY-MM-DD');

-- 3. hapus kolom "DATE" yang lama
ALTER TABLE data_gabungan  DROP COLUMN "DATE";

/* ================================================== */
/* ================================================== */
/* ================================================== */
-- Membuat data untuk MACHINE LEARNING REGRESSION (TIME SERIES)
-- yaitu groupby by date lalu yang di aggregasi adalah qty di sum

SELECT tanggal, SUM(qty) AS total_qty
FROM data_gabungan dg 
GROUP BY tanggal
ORDER BY tanggal;