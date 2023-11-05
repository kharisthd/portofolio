-- Simple Queries--
--1-- Advanced Filtering bertujuan untuk digunakan untuk filter dengan nilai tidak sama 
--- perintah nya 
--- = sama dengan , != <> tidak sama dengan , > lebih dari, >= lebih dari atau sama dengan

-- case 1 : kasih notifikasi via email untuk customer yang sudah tidak aktif dan kasih hadiah kalau mereka 
--- bisa konfirmasi nomor telepon
select * from public.rakamin_customer
where konfirmasi_telepon != 1;

--- case 2 : Ambil semua nama dan email dari RakaFood customers yang nomor hp nya belum dikonfirmasi
select nama,
	email
	from public.rakamin_customer
where konfirmasi_telepon != 1;

--- case 3 : Bro, kita harus kasih tau customers yang umurnya di atas 30 nih karena ada promo 
--- botol minuman jika beli makanan X, lumayan kan buat anak-anak mereka.
--- Oh, berarti kita butuh list nama, email dan nomor hp mereka ya buat ngirimin
--- promo gitu misalnya ?
select nama,
	email,
	telepon
	from public.rakamin_customer
where umur > 30;


--2-- Advanced Filtering bertujuan untuk filter lebih dari satu kondisi 
--- perintah nya 
--- and untuk kedua kondisi harus terpenuhi ,
--- or untuk salah satu kondisi harus terpenuhi

-- case 1: Bro, ada kah customer kita yang penipu dan pengguna aktif ini ?
select * from public.rakamin_customer
where penipu = 1 and pengguna_aktif = 1; 

-- case 2 Bro, adakah customer kita yang lahirnya di bulan juni atau juli ini ? 
-- Mungkin bisa kita kasih surprise ulang tahun jika mereka order pas tanggal ulang tahunnya
select * from public.rakamin_customer
where bulan_lahir = 'Juni' or bulan_lahir = 'Juli'

-- case 3 : Bro, tolong cari ada ga sih customer yang registrasinya 2013 ke atas 
-- terus lahirnya di bulan Juni atau Juli? Soalnya mau ada campaign di bulan-bulan itu 
-- khusus buat pengguna baru!
select * from public.rakamin_customer
where tanggal_registrasi >= '2013-01-01' and (bulan_lahir = 'Juni' or bulan_lahir = 'Juli')
;

--3-- Advanced Filtering bertujuan untuk filter lebih dari satu kondisi 
--- perintah nya 
--- not ketika kendisi tidak terpenuhi

-- case 1 : Bro, ambilin data customer yang bulan lahirnya bukan Desember dong!
select * from public.rakamin_customer
where not bulan_lahir = 'Desember';

-- case 2 : Kita pengen exclude customer yang umurnya 20an nih untuk campaign selanjutnya!
select * from public.rakamin_customer
where not (umur >= 20 and umur <30)
order by umur;

--4-- Advanced Filtering filter suatu kolom dengan lebih dari satu nilai. 
--- perintah nya 
--- SELECT kolom_1, kolom_2, . . . kolom_10
--- FROM <nama tabel>
--- WHERE kolom_1 IN (‘x’,’y’)

--- case 1 : Bro, adakah customer kita yang lahirnya di bulan juni, juli atau agustus ini ?
--- Mungkin bisa kita kasih surprise ulang
--- tahun jika mereka order pas tanggal ulang tahunnya
select * from public.rakamin_customer
where bulan_lahir in ('Juni','Juli','Agustus')

--4-- Advanced Filtering Digunakan ketika ingin melakukan filter suatu kolom dengan
---   hanya menggunakan sebagian/beberapa karakter sebagai referensi. 
--- perintah nya 
SELECT kolom_1, kolom_2, . . . kolom_10
FROM <nama tabel>
WHERE kolom_1 LIKE ‘%x%’
--- ● Filter LIKE hanya dapat menggunakan tipe data varchar saja
--- ● karakter % merepresentasikan ‘karakter apa saja’

--- case 1 : Bro, ada masalah hacker nih di google mail, bisa pastikan ga customer kita yang
--- pakai gmail.com masih aman?
select * from public.rakamin_customer
where email like '%gmail.com'

--- case 2 : Bro, provider x mau ngasih promo ke customers kita nih, bakal ngasih diskon 40%
--- kalau beli dengan point.
--- Hmm menarik-menarik, berarti customer yang nomor hp nya diawali
--- 62852 itu potensial customer untuk promo ini ya?
select * from public.rakamin_customer
where telepon like '62852%';

--5-- Advanced Filtering Digunakan ketika ingin melakukan filter suatu kolom dengan batas bawah
--- dan batas atas tertentu. Umumnya untuk tipe data angka atau tanggal.
--- perintah nya 
SELECT kolom_1, kolom_2, . . . kolom_10
FROM <nama tabel>
WHERE kolom_1 BETWEEN x AND y

--- case 1 Bro, ada ga customers kita yang umurnya mulai 20 tahun hingga 25 tahun ?
select * from public.rakamin_customer
where umur between 20 and 25
order by umur asc

--6-- Case When Membuat suatu kolom baru jika kolom lain memenuhi kondisi tertentu.
--- perintah nya 
select *,
case when kolom_1 = ‘A’ then ‘benar’
 when kolom_1 = ‘B’ then ‘benar’
 when kolom_1 = ‘C’ then ‘salah’
 when kolom_1 = ‘D’ then ‘salah’
 end as kolom_baru
FROM (tabel)

--- case 1 
Bro, gw udah punya nih customers yang pakai
Telkomsel , cuma umur nya masih bervariasi.
Bisa dibuat 3 grup umur aja ga sih ?
Misalnya nih
● umur 1 - 20 : anak
● umur 21 - 70 : bapak
● umur 71 ke atas : kakek

select 
	nama,
	umur,
case when umur <= 20 then 'anak'
when umur <= 70 then 'bapak'
else 'kakek'
end as status
from rakamin_customer
order by umur asc

--- case 2
Bro, ini ada data nomor telepon, bisa ga kita
definisikan itu dari provider apa?
sesederhana ini aja definisinya
Hmm mungkin jadi gini ya bro ?
● diawali 62852 : telkomsel
● diawali 62878 : XL
● diawali 62896 : 3
● sisanya anggap aja “lainnya” 

select 	
	nama,
	telepon,
case
	when telepon like '62852%' then 'telkomsel'
	when telepon like '62878%' then 'XL'
	when telepon like '62896%' then '3'
	else 'lainnya'
	end as provider
from rakamin_customer
order by provider asc

--7A-- Aggregation Digunakan untuk melakukan akumulasi data atau merangkum data.
--- perintah nya 
SELECT count(1)
FROM <tabel>

--- case 1
Bro, coba tebak…
ada berapa customers kita
sekarang ?

select*from public.rakamin_customer

select count (1)
from rakamin_customer

--7B-- Aggregation Menghitung total baris data tidak kosong pada kolom tertentu
--- perintah nya 
SELECT count(<nama kolom>)
FROM <tabel>

--- case 1
ada berapa total data tidak kosong pada kolom bulan_lahir dari customers
kita ?
select count (bulan_lahir)
from rakamin_customer

--- 7C -- alias digunakan untuk merapihkan keterangan nama kolom
--- perintah nya 
SELECT 
	count nama as total_pelanggan
	count bulan_lahir as total_bulan
FROM <tabel>

--- case 1 
ada berapa total customer dan total baris tidak kosong pada kolom
bulan_lahir dari customers kita ?
(rapi kan nama kolom pada hasilnya)
select  
	count (nama) as total_pelanggan,
	count (bulan_lahir) as total_bulan_lahir
from rakamin_customer;

--- 7D -- COUNT(DISTINCT kolom) Menghitung total unik (tidak ada duplikat) data tidak kosong pada sebuah
kolom tertentu
--- perintah nya 
SELECT count(distinct <kolom>)
FROM <tabel>

--- case 1
ada berapa total unik data tidak kosong pada kolom bulan_lahir
dari customers kita ?
select count (distinct bulan_lahir) as bulan_unik
from rakamin_customer

--- case 2
juga bisa digunakan untuk melihat apakah ada data yang duplikat
pada kolom tertentu
select count (bulan_lahir) as total_bulan_lahir,
count (distinct bulan_lahir) as total_unik_bulan_lahir
from rakamin_customer

--- 7D -- Aggregation 4 Other
min digunakan untuk mendapatkan nilai minimum dari suatu kolom tertentu
SELECT min(kolom)
FROM <tabel>

--- case 1
Bro, customer kita yang paling muda, berapa
umurnya?.. kantor kita ingin terapkan batas
minimal umur nih buat dapatkan promo
spesial.
nanti umur terkecil itu kita jadikan batasnya
select min (umur) as umur_terkecil
from rakamin_customer

max digunakan untuk mendapatkan nilai maksimum dari suatu kolom tertentu
SELECT max(kolom)
FROM <tabel>
-- case 1
Bro, customer kita paling tua umurnya berapa?
SELECT max(umur) as umur_tertua
FROM rakamin_customer

avg digunakan untuk mendapatkan nilai rata-rata dari suatu kolom tertentu
SELECT avg(kolom)
FROM <tabel>
Bro, coba tebak…
berapa umur rata-rata customer kita ?
--- case 1
select avg (umur) as rata_rata_umur_pelanggan
from rakamin_customer

sum digunakan untuk mendapatkan nilai penjumlahan dari suatu kolom tertentu
SELECT sum(kolom)
FROM <tabel>
--- case 1
Bro, revenue kita dari order selama ini
udah berapa banyak ya ?
select*from public.rakamin_order
select sum (harga) as total_revenue
from rakamin_order

--8A-- Aggregation - GROUP BY digunakan untuk mendapatkan akumulasi pada kolom tertentu.
--- perintah nya 
SELECT kolom_1,
 count(1) as total
FROM <tabel>
GROUP BY kolom_1

--- case 1
Bro, sekarang bulan juli nih..
ada berapa customers yang ulang tahun di
bulan juli ya?
select*from public.rakamin_customer
select bulan_lahir,
	count (1) as total_ultah_bulan
from rakamin_customer
group by bulan_lahir

--- case 2 
berapa total customers yang aktif dan tidak aktif ?
select pengguna_aktif,
	count (1) as total_pengguna
from rakamin_customer
group by pengguna_aktif

--- case 3 
berapa total customers memiliki nomor telepon Telkomsel dan XL ?
select
case
	when telepon like '62852%' then 'telkomsel'
	when telepon like '62878%' then 'XL'
	else 'lainnya'
	end as provider,
	count (1) as total_provider
from rakamin_customer
group by provider;

--- case 4
berapa total customers memiliki nomor telepon Telkomsel dan XL, yang lahir di
bulan maret ?
select
case
	when telepon like '62852%' then 'telkomsel'
	when telepon like '62878%' then 'XL'
	else 'lainnya'
	end as provider,
	bulan_lahir,
	count (1) as total_provider
from rakamin_customer
where bulan_lahir = 'Maret'
group by (1,2)

--8B-- Aggregation - HAVING digunakan untuk melakukan filter terhadap hasil akumulasi yang telah
dilakukan aggregate.
--- perintahnya
select kolom_1,
 count(1) as total
FROM <tabel>
GROUP BY kolom_1
HAVING count(1) > x

--- case 1
Bagaimana persebaran total customer pada masing-masing provider yang
jumlah customernya lebih dari 20?
select
case
	when telepon like '62852%' then 'telkomsel'
	when telepon like '62878%' then 'XL'
	else 'lainnya'
	end as provider,
	count (1) as total_provider
from rakamin_customer
group by (1)
having count (1) > 20;

----------- END Simple Queries------	

----------- SQL COMPLEX ------------

--1-- alias (as) bertujuan untuk memberikan nama sementara
--- perintah nya 
--- select kolom as .... from table as .....
-- case bagaimana persebaran pelanggan aktif dan non aktif berdasarkan kelompok 
umur (0-12 anak anak) 13-18 remaja, 19-50 dewasa
--query
select*from public.rakamin_customer_copy
select 
case 
when umur between 0 and 12 then 'anak anak'
when umur between 13 and 18 then 'remaja'
when umur between 19 and 50 then 'dewasa'
end as kelompok_umur,
sum (case when pengguna_aktif=1 then 1 else 0 end) as total_pengguna_aktif,
sum (case when pengguna_aktif = 0 then 1 else 1 end) as total_pengguna_tidak_aktif
from rakamin_customer_copy
group by 1;
---query alternatif
select
case
when umur <=12 then 'anak anak'
when umur <=18 then 'remaja'
else 'dewasa'
end as kelompok_umur,
sum (case when pengguna_aktif= 1 then 1 else 0 end)
as total_pengguna_aktif,
sum (case when pengguna_aktif = 0 then 1 else 1 end)
as total_pengguna_tidak_aktif
from rakamin_customer_copy
group by 1; ---- harus pake group by dikarenakan fungsi agregasi
--------

--2A-- subquery from
-- penjelasan : kita bisa membuat query di dalam query yang tujuannya mengambil data untuk proses selanjutnya
-- dan bisa juga untuk membuat tabel virtual
--- perintah nya 
--- select (kolom 1),(kolom 2) from (select (kolom),(kolom) from tabel a) as ....
-- perintah : ambil data pengguna aktif nama email dari tabel sub dengan isi (nama, email, telpon dan umur)
select nama, email
from
(
	select nama, email, telepon, umur
	from rakamin_customer_copy
	where pengguna_aktif =1
)
as tabel_sub
-- bagaimana persebaran total customer pada masing masing provider yang jumlah customernya lebih dari 20
select *
from
(
	select
		case when telepon like '62852%' then 'Telkomsel'
		when telepon like '62878%' then 'XL'
		when telepon like '62896%' then '3'
		else 'lainnya'
		end as provider,
	count (nama) as total_pelanggan
	from rakamin_customer_copy
	group by (1) --- mending bikin query dalemnya dulu , cek, kalo udah bener, baru bikin query utama
) as rc 
where rc.total_pelanggan > 20;

-- bagaimana persebaran total customer pada masing masing provider yang jumlah customernya lebih dari 20
query utama
query sub
select distinct left (telepon,5) from rakamin_customer_copy; 
select * from
(
select 
	case
		when telepon like '62852%' then 'Telkomsel'
		when telepon like '62878%' then 'XL'
		when telepon like '62896%' then '3'
		else 'lainnya'
		end as provider,
	count (1) as total_pelanggan
	from rakamin_customer_copy
	group by (1)
) as sc
where total_pelanggan > 20;

--2B-- subquery where
-- penjelasan : berguna untuk filtering subquery yang digunakan untuk query utama
--- perintah nya 
--- select (kolom 1),(kolom 2) from table (where kolom 1) in (select (kolom_1) from table a) -- tanpa alias
-- perintah 1 : ambil data customer yang pernah melakukan order di kfc
select *
from rakamin_customer_copy
where id_pelanggan in
	(
	select id_pelanggan
	from public.rakamin_merchant
	where id_merchant=5
	)
-- perintah 2 : ambil data customer yang pernah melakukan order burger king no 2
select *
from rakamin_customer_copy
where id_pelanggan in
(
	select id_pelanggan 
	from rakamin_order 
	where id_merchant = 2
)

--3A-- joint introduction
-- penjelasan : merupakan inti sql jadi untuk menggabungkan 2 kolom dengan tabel yang berbeda
--- perintah nya 
--- select (kolom 1),(kolom 2) from table a <tipe Join> table b on table_a <kolom>= table_b <kolom>
--- tipe join
--- 1.inner join = mencocokan dan menampilkan data yang sama antara 2 tabel
--- 2.left join = menampilkan semua data di tabel kiri dan data cocok di tabel kanan
--- 3.right join = menampilkan semua data di tabel kanan dan data cocok di tabel kiri
--- 4.full outer join = menampilkan semua data baik ada yang cocok atau tidak di semua tabel

--3B-- joint use case

-- case join 1: kita akan kirim souvenir ke alamat customer agar lebih royal dengan provider awalan 62852
1. cek apa yang bisa kita join
--select*from rakamin_customer no telpon ada disini 
SELECT * FROM public."Rakamin_Customer_Addres"
1. cari no telpon customer
select telepon from rakamin_customer_copy
2. cari alamat customer
SELECT * FROM public."Rakamin_Customer_Addres"
3. coba kita gabungkan dengan id pelanggan
select rc.id_pelanggan,
	rc.nama,
	rc.telepon,
	rca.alamat,
	rca.kota,
	rca.provinsi
from rakamin_customer_copy as rc
	right join 
	"Rakamin_Customer_Addres" as rca
	on
	rc.id_pelanggan = rca.id_pelanggan
where  telepon like '62852%';

-- case join 2: kita akan kirim souvenir ke alamat customer agar lebih royal untuk orang yang pernah order
select 
	distinct rc.id_pelanggan,
	rc.nama,
	rc.telepon,
	ro.tanggal_pembelian,
	rca.alamat,
	rca.kota,
	rca.provinsi
from rakamin_customer_copy as rc
	right join 
	"rakamin_order" as ro
	on
	rc.id_pelanggan = ro.id_pelanggan
left join "Rakamin_Customer_Addres" as rca
	on
	rca.id_pelanggan = ro.id_pelanggan
where  telepon like '62852%'
order by rc.id_pelanggan;

--3C--left join dan inner join
-- case join 2: kita akan kirim souvenir ke alamat customer agar lebih royal untuk orang yang pernah order
select 
	rca.id_pelanggan,
	rca.alamat,
	rca.kota,
	rca.provinsi,
	ro.tanggal_pembelian
from public."Rakamin_Customer_Addres" as rca
join
rakamin_order as ro
on rca.id_pelanggan = ro.id_pelanggan

--- 4 Subquery dan Join---

--- case 1
Ambil data customer yang
pernah melakukan transaksi
yang total harganya lebih
dari 50000.
select * from
(
	select 
	id_pelanggan,
	sum (harga) as total_harga
	from rakamin_order
	group by 1
	having sum (harga) > 50000
) as ro
left join rakamin_customer as rc on rc.id_pelanggan = ro.id_pelanggan;

--- 5 Union---
--- Untuk menggabungkan dua atau lebih hasil query dari sebuah tabel, dapat digunakan UNION.
--- perintahnya 
select [kolom_1], [kolom_2]
from <table_a>
[UNION]
select [kolom_1], [kolom_2]
from <table_b>
Syarat:
- Semua kolom yang digunakan antara
tabel a dan tabel b harus sama
- Tipe data dari kolomnya juga harus
sama
- Urutan dari kolom pun juga harus sama
--- Jenis UNION
UNION = Mengembalikan data secara distinct
UNION ALL = Mengembalikan data secara duplikat (jika ada)

--- case 1
Ambil data customer yang memiliki umur lebih dari 20. Ambil juga data customer
yang lahir pada bulan Mei. (gunakan UNION & UNION ALL)
--- Union 
select 
	nama,
	email,
	bulan_lahir
from rakamin_customer as rc
where umur > 20
union
select 
	nama,
	email,
	bulan_lahir
from rakamin_customer as rc
where bulan_lahir = 'Mei'

--- Union all
select 
	nama,
	email,
	bulan_lahir
from rakamin_customer as rc
where umur > 20
union all
select 
	nama,
	email,
	bulan_lahir
from rakamin_customer as rc
where bulan_lahir = 'Mei'

--- 6 Common Table Expressions (CTE) ---
--- Kita dapat juga membentuk sebuah temporary table dengan perintah SQL ini
--- perintahnya 
WITH [nama_temporary_table] AS (
 [put your query here...]
)
SELECT *
FROM [nama_temporary_table]

--- case 1 
Dengan menggunakan contoh
sebelumnya (Ambil data customer
yang pernah melakukan transaksi
yang total harganya lebih dari
50000

with orders as
(
select 
	id_pelanggan,
	sum (harga) as total_harga
	from rakamin_order
	group by 1
	having sum (harga) > 50000
)		
select * 
from orders as o
left join rakamin_customer as rc on rc.id_pelanggan = o.id_pelanggan
