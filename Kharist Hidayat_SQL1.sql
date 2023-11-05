Soal 1
Select distinct kota
from rakamin_customer_addres

Soal 2
select*from rakamin_order
order by tanggal_pembelian desc
limit 10;

Soal 3
SELECT * FROM rakamin_customer
WHERE penipu = 1.


Soal 4
select*from rakamin_order
	where metode_bayar = 'shopeepay'
	order by harga desc;

Soal 5
create table rakamin_customer_address_tangerang as
select*from rakamin_customer_address
where kota = 'Tangerang';

soal 6
UPDATE rakamin_customer_address_tangerang
SET provinsi = 'Banten'
WHERE kota = 'Tangerang';

UPDATE rakamin_customer_address_tangerang
SET alamat = 'Karawaci'
WHERE id_pelanggan = 10;

soal 7
INSERT INTO rakamin_customer_address_tangerang 
(id_alamat, id_pelanggan, alamat, kota, provinsi)
VALUES (101, 70, 'Ciledug', 'Tangerang', 'Banten');

Soal 8
DELETE FROM rakamin_customer_address_tangerang
WHERE id_alamat = 54;




