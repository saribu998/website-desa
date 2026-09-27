CREATE DATABASE IF NOT EXISTS website_desa CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE website_desa;

CREATE TABLE users (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20) DEFAULT NULL,
    role ENUM('admin', 'operator', 'warga') NOT NULL DEFAULT 'warga',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE penduduk (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NULL,
    nik VARCHAR(20) NOT NULL UNIQUE,
    kk VARCHAR(20) NOT NULL,
    nama_lengkap VARCHAR(150) NOT NULL,
    tempat_lahir VARCHAR(100) NOT NULL,
    tanggal_lahir DATE NOT NULL,
    jenis_kelamin ENUM('Laki-laki', 'Perempuan') NOT NULL,
    alamat TEXT NOT NULL,
    rt VARCHAR(10) NOT NULL,
    rw VARCHAR(10) NOT NULL,
    desa VARCHAR(100) NOT NULL,
    kecamatan VARCHAR(100) NOT NULL,
    kabupaten VARCHAR(100) NOT NULL,
    provinsi VARCHAR(100) NOT NULL,
    agama VARCHAR(50) NOT NULL,
    status_perkawinan VARCHAR(50) NOT NULL,
    pekerjaan VARCHAR(100) NOT NULL,
    pendidikan VARCHAR(50) NOT NULL,
    foto VARCHAR(255) DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_penduduk_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE keluarga (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nomor_kk VARCHAR(30) NOT NULL UNIQUE,
    kepala_keluarga VARCHAR(150) NOT NULL,
    alamat TEXT NOT NULL,
    rt VARCHAR(10) NOT NULL,
    rw VARCHAR(10) NOT NULL,
    desa VARCHAR(100) NOT NULL,
    kecamatan VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE surat_template (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nama_template VARCHAR(100) NOT NULL,
    kategori VARCHAR(100) NOT NULL,
    isi_template TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE pengajuan_surat (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    penduduk_id BIGINT UNSIGNED NOT NULL,
    jenis_surat VARCHAR(100) NOT NULL,
    nomor_pengajuan VARCHAR(50) NOT NULL UNIQUE,
    tanggal_pengajuan TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('pending', 'review', 'approved', 'rejected', 'completed') NOT NULL DEFAULT 'pending',
    catatan_admin TEXT DEFAULT NULL,
    file_pendukung VARCHAR(255) DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_pengajuan_penduduk FOREIGN KEY (penduduk_id) REFERENCES penduduk(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE berita (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    judul VARCHAR(200) NOT NULL,
    isi TEXT NOT NULL,
    gambar VARCHAR(255) DEFAULT NULL,
    penulis VARCHAR(100) NOT NULL,
    tanggal DATE NOT NULL,
    status ENUM('draft', 'published') NOT NULL DEFAULT 'published',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE galeri (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    judul VARCHAR(200) NOT NULL,
    deskripsi TEXT DEFAULT NULL,
    gambar VARCHAR(255) NOT NULL,
    tanggal DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE agenda (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    judul VARCHAR(200) NOT NULL,
    deskripsi TEXT NOT NULL,
    tanggal_mulai DATE NOT NULL,
    tanggal_selesai DATE NOT NULL,
    lokasi VARCHAR(200) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE pengaduan (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    penduduk_id BIGINT UNSIGNED NOT NULL,
    judul VARCHAR(200) NOT NULL,
    isi TEXT NOT NULL,
    status ENUM('baru', 'diproses', 'selesai') NOT NULL DEFAULT 'baru',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_pengaduan_penduduk FOREIGN KEY (penduduk_id) REFERENCES penduduk(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE profil_desa (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nama_desa VARCHAR(150) NOT NULL,
    tagline VARCHAR(200) DEFAULT NULL,
    sejarah TEXT NOT NULL,
    visi TEXT NOT NULL,
    misi TEXT NOT NULL,
    alamat TEXT NOT NULL,
    telepon VARCHAR(30) DEFAULT NULL,
    email VARCHAR(150) DEFAULT NULL,
    logo VARCHAR(255) DEFAULT NULL,
    maps_link TEXT DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE layanan_desa (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nama_layanan VARCHAR(150) NOT NULL,
    deskripsi TEXT NOT NULL,
    syarat TEXT NOT NULL,
    durasi_proses VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE notifikasi (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    judul VARCHAR(200) NOT NULL,
    isi TEXT NOT NULL,
    dibaca BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_notifikasi_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

INSERT INTO profil_desa (
    nama_desa, tagline, sejarah, visi, misi, alamat, telepon, email, maps_link
) VALUES (
    'Desa Cempaka',
    'Maju, Sejahtera, dan Berdaya Saing',
    'Desa Cempaka merupakan desa yang berdiri sejak masa kolonial, dengan semangat gotong royong dan budaya lokal yang kuat. Seiring waktu, desa ini terus berkembang dengan memadukan potensi alam, kearifan lokal, dan inovasi pelayanan publik berbasis teknologi.',
    'Mewujudkan masyarakat desa yang mandiri, sejahtera, dan berdaya saing berbasis potensi lokal.',
    '1. Meningkatkan pelayanan publik yang cepat, transparan, dan akuntabel.\n2. Mengembangkan potensi ekonomi masyarakat desa.\n3. Menjaga kelestarian lingkungan dan budaya lokal.\n4. Mendorong partisipasi aktif masyarakat dalam pembangunan.',
    'Jl. Raya Desa Cempaka No. 12, Kecamatan Sukamaju, Kabupaten Bandung',
    '0812-3456-7890',
    'admin@desacempaka.id',
    'https://maps.google.com/?q=Desa+Cempaka'
);

INSERT INTO surat_template (nama_template, kategori, isi_template) VALUES
('Surat Keterangan Domisili', 'Kependudukan', 'Dengan ini menerangkan bahwa yang bersangkutan benar-benar bertempat tinggal di Desa Cempaka ...'),
('Surat Keterangan Usaha', 'Kependudukan', 'Yang bertanda tangan di bawah ini ...'),
('Surat Pengantar KTP', 'Kependudukan', 'Memperhatikan bahwa yang bersangkutan adalah penduduk Desa Cempaka ...');

INSERT INTO layanan_desa (nama_layanan, deskripsi, syarat, durasi_proses) VALUES
('Layanan KTP', 'Pelayanan pembuatan dan pengajuan KTP baru serta perubahan data.', 'Fotokopi KK, fotokopi KTP lama, formulir pengajuan.', '3 hari kerja'),
('Layanan KK', 'Pelayanan pembuatan atau perubahan Kartu Keluarga.', 'Formulir, fotokopi KTP keluarga, akta kelahiran.', '2 hari kerja'),
('Layanan Domisili', 'Pembuatan surat domisili dan persyaratan lainnya.', 'KTP, KK, surat pengantar RT/RW.', '1 hari kerja');
