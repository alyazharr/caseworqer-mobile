# CASEWORQER
## PBP-D01

### Nama Anggota :
- Gibran Rasyadan Jayandaru - 2006464070
- Muhammad Farrel Sava Archini - 2006483025
- Alya Azhar Agharid - 2006462720
- Rizky Ananta - 2006482640
- Nafhan Raissa Syandana - 2006482294
- Christopher Ekaputra Loe - 2006473573
- Dominikus Kern Bunardi -2006464423

---
### Link Download APK
[Caseworqer](https://drive.google.com/drive/folders/19L61XDpijDgKxy0G8xdE_4hUlmlhf1x1?usp=sharing)

---
### Tentang Aplikasi
Pandemi COVID-19 yang melanda seluruh penjuru negeri telah berdampak buruk pada beberapa aspek kehidupan, salah satunya dalam aspek ekonomi dan pekerjaan. Angka banyaknya masyarakat yang kian membutuhkan pekerjaan tidak sebanding dengan lowongan pekerjaan yang tersedia. Ditambah lagi dengan tutupnya perusahaan dikarenakan kestabilan ekonomi perusahaan yang terdampak pandemi ini. Lowongan pekerjaan semakin sedikit dan banyaknya masyarakat yang kesulitan dalam mencari informasi mengenai lowongan kerja menjadi ide awal pembuatan website ini, CaseWorqer.

CaseWorqer hadir menjadi aplikasi terpercaya bagi masyarakat untuk membantu pada pencari pekerjaan agar lebih mudah memperoleh informasi lengkap mengenai lowongan pekerjaan yang tersedia di berbagai daerah. CaseWorqer menjembatani bagi perusahaan-perusahaan yang ingin membuka lowongan pekerjaan dengan para pelamar yang sedang membutuhkan pekerjaan. Tidak hanya itu, para pelamar juga dapat melihat Tips & Trik yang disediakan di website aplikasi ini dan bertanya, berbincang, dan sharing pengalaman sesama pelamar pekerjaan pada forum yang disediakan.

---
### Daftar Modul Aplikasi Mobile & Penjelasan Integrasi Web Service
**1. Home Page(Semua Orang)**  
- About website
- Data kasus covid-19 (https://kawalcorona.com/api/)
- Section Tips dan Trik Protokol kesehatan

**2. Modul untuk User**  
Hal yang akan diimplementasikan :       
- Memasukkan data user in general
- Lowongan pekerjaan yang dilamar
- Data yang akan diambil adalah data-data pribadi user.  
  
Data dari form akan diubah dalam bentuk json sehingga terhubung dengan database django. Data json akan digunakan sebagai perantara antar flutter _(mobile app)_ dengan halaman web.

**3. Modul untuk pelamar kerja**  
Modul ini akan menampilkan lowongan pekerjaan yang tersedia. Lowongan pekerjaan yang tersedia pada halaman web akan diambil datanya berupa _.json_.  
  
Setelah ditampilkan lowongan kerja, para pelamar bisa melamar kerja dalam bentuk form (Semua pelamar yang akan bekerja pada pekerjaan WFO harus menyertakan sertifikat vaksin.). Isian pada form akan dikirim datanya dalam bentuk json ke database django web.

**4. Halaman pembuka lowongan kerja**  
- Membuka lowongan dalam bentuk form 
- Dibedakan antara _WFH/WFO/Mixed_  
  
Para pembuka lowongan kerja dapat membuka lowongan pekerjaan dalam bentuk form. Data dari hasil form membuka lowongan pekerjaan nantinya akan digunakan pada bagian pelamar kerja untuk mencari lowongan dan melamar suatu pekerjaan, kemudian data perusahaan juga akan digunakan pada bagian company review sehingga nantinya dapat di review oleh pelamar.  
  
Hal yang perlu diimplementasikan:  
- Data perusahaan seperti nama pekerjaan, nama perusahaan, lokasi tempat perusahaan tersebut berada, tipe pekerjaan(WFH/WFO/Gabungan) serta tentang pekerjaan tersebut.  
  
Data dari form ini akan diubah menjadi json untuk menghubungkan pada database django.

**5. Halaman untuk profil perusahaan**  
Halaman profil perusahaan berfungsi untuk melihat detail perusahaan yang didaftarkan oleh user, lowongan-lowongan yang dibuka, dan para pelamar dari masing-masing lowongan.  
  
Hal yang perlu diimplementasikan:  
- Form untuk memasukkan data diri umum perusahaan.  
- Tampilan mengenai detail perusahaan, lowongan-lowongan dari perusahaan tersebut, serta siapa yang sudah melamar pada lowongan tersebut.  
  
Data yang diambil adalah data dari model ProfilPerusahaan dan model Pelamar. Transfer data dilakukan dari database django ke aplikasi dan sebaliknya. Transfer data dilakukan melalui konversi data ke bentuk json.

**6. Halaman untuk Company Job Review**  
- Menampilkan review dari job perusahaan tertentu  
- Memberikan review kepada job perusahaan
- Mencari job perusahaan untuk direview  
  
Hal yang perlu diimplementasikan:
- Form rating
- Form komentar
- Tampilan utama kumpulan job perusahaan
- Fitur search job  
  
Data yang diambil adalah:
- Value rating dan komentar
- Data job perusahaan dari lowongan kerja  
  
Data diambil dengan mengubah data form pada website menjadi json untuk digunakan ke dalam mobile apps. Begitu juga sebaliknya, data dari form pada mobile apps akan dikirim dalam bentuk json juga ke django web,

**7.Tips dan trik diterima lamaran**  

Tips and trik merupakan halaman web bagi user untuk membaca artikel-artikel yang berkaitan dengan dunia kerja.  
  
Hal yang perlu diimplementasikan: 
- Berita 
- Form untuk mencari berita atau trending yang diinginkan (search bar)
- Form untuk admin yang dapat mengimplementasikan CRUD  
  
Data yang akan diambil adalah  judul artikel, artikel ,url gambar, dan ringkasan artikel.  
  
Data dari form akan dibuat dalam bentuk json, data json ini akan digunakan sebagai perantara dari website django ke flutter atau flutter ke django. 

**8. Forum**  
Forum merupakan sebuah halaman pagi para pengguna untuk saling berinteraksi dan berbagi pengalaman di dunia kerja. Pengguna bisa memposting forum baru dan memberikan reply atau balasan pada suatu forum.   
  
Hal yang perlu diimplementasikan :
- Form untuk memulai postingan baru (berisi judul dan isi form)
- Form untuk fitur reply tiap postingan
- Toggle button dan alert  
  
Data postingan pengguna dan reply pada tiap objek postingan akan diambil dari website dengan framework django yang telah dibuat sebelumnya dalam bentuk json. Data json sebagai media pengiriman data dari django ke flutter dan sebaliknya.

---
#### Persona : 
**1. Admin**
- Mengelola berita resmi dan informasi trending pada Page Tips dan Trik diterima lamaran

**2. Pelamar**
- Melihat serta menganalisa kasus covid yang terjadi tergantung dari calon dimana pelamar akan bekerja nantinya
- Mempelajari tata cara protokol kesehatan sehingga akan melindungi pelamar yang nantinya akan bekerja
- Melihat lowongan-lowongan pekerjaan yang ada sehingga dapat disesuaikan dengan skill serta kebutuhan pelamar
- Melamar sebuah pekerjaan  
- Mempelajari bagaimana lamaran yang diajukan dapat diterima oleh pemberi lamaran
- Berinteraksi dengan sesama pelamar yang lainnya sehingga dapat bertukar ide, pengalaman, dll

**3. Pemberi Lamaran**
- Membuka lowongan pekerjaan sehingga para pelamar dapat melamar pekerjaan
- Melihat serta menganalisa kasus covid yang terjadi sehingga pemberi lamaran dapat mengetahui tingkat kasus yang terjadi di daerah pelamar-pelamarnya berada
- Sama seperti pelamar dapat mempelajari tata cara protokol kesehatan sehingga keduanya dapat terlindungi dengan baik
- Memisahkan antara lowongan pekerjaan yang akan dilaksanakan _WFH/WFO/Mixed_ sehingga pelamar dapat memilih lowongan yang sesuai