-- melihat bentuk data dari tabel data_gabungan

select * from data_gabungan

-- karena kolom tanggal sudah ada berdasarkan quey ssebelumnya, maka tidak ada yang diubah

/* ================================================== */
/* ================================================== */
/* ================================================== */
-- Membuat data untuk MACHINE LEARNING CLUSTERING
-- untuk dapat membuat cluster customer-customer yang mirip
/* Membuat data baru untuk clustering, yaitu groupby by customerID lalu yang di aggregasi adalah :
○ Transaction id count
○ Qty sum
○ Total amount sum */
select  customerid,
		count(transactionid) as tot_transaksi,
		sum(qty) as tot_qty,
		sum(totalamount) as tot_amount
from data_gabungan
group by customerid
order by customerid;