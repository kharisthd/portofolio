SELECT * FROM public.retail
order by "City";
select "Customer_Name"
from public.retail;

-- rata rata penjualan
select * from public.retail
avg "Total_Cost"

-- berapa jumlah customer
select count (1) as total_pelanggan
from public.retail

-- persentase pengguna store
1. sortir pengguna store 
2. cek jumlah totalnya

select "Store_Type",
	count (1) as jumlah_pelanggan_pada_store,
	round (
		((count (1) / sum (count (1)) over ())*100),2) 
		as presentase_pengguna_pada_store
	from public.retail
	group by (1)
	order by jumlah_pelanggan_pada_store desc;

-- rata rata biaya yang dikeluarkan
select round (avg("Total_Cost"),2) as rata_rata_penjualan
from public.retail

-- persentase penggunaan diskon 
select "Discount_Applied",
	count (1) as keterangan_diskon,
	round (
	((count (1) / sum (count (1)) over ())*100),2
		)
		as persentase_diskon_applied
	from public.retail
	group by (1)

-- persentase jenis pembayaran
select "Payment_Method",
	count (1) as jenis_pembayaran,
	round (
	((count (1) / sum (count (1)) over ())*100),2
		)
		as persentase_jenis_pembayaran
	from public.retail
	group by (1)
	
--  cek data
 SELECT * FROM public.retail
 
-- pembelian season
select "Season",
	count (1) as jenis_season,
	round (
	((count (1) / sum (count (1)) over ())*100),2
		)
		as persentase_season
	from public.retail
	group by (1)


-- berapa banyak jenis promosi yang digunakan
select "Promotion",
	count (1) as jenis_promosi,
	round (
	((count (1) / sum (count (1)) over ())*100),2
		)
		as persentase_promosi
	from public.retail
	group by (1)
	order by jenis_promosi desc
	
-- coba cek tanggal dari terbaru sampai terlama
select "Date" 
	from public.retail
	order by "Date" Desc

-- produk apa yang paling banyak dibeli
select "Product"
	from public.retail
	order by "Product" Desc
	
