-- ModaSepet: e-commerce sample dataset (Sep - Dec 2025)
-- Run in SQLite (e.g. sqliteonline.com) before the queries.
-- Drops and recreates the tables.

DROP TABLE IF EXISTS siparisler;
DROP TABLE IF EXISTS musteriler;
DROP TABLE IF EXISTS oturumlar;

CREATE TABLE musteriler (
  musteri_id   INTEGER PRIMARY KEY,
  ad           TEXT,
  sehir        TEXT,
  kayit_tarihi DATE
);

CREATE TABLE siparisler (
  siparis_id     INTEGER PRIMARY KEY,
  musteri_id     INTEGER,
  siparis_tarihi DATE,
  kategori       TEXT,
  tutar          REAL
);

INSERT INTO musteriler VALUES
(1,  'Ayşe',   'İstanbul',  '2025-01-12'),
(2,  'Mehmet', 'Ankara',    '2025-02-03'),
(3,  'Zeynep', 'İzmir',     '2025-02-20'),
(4,  'Can',    'İstanbul',  '2025-03-15'),
(5,  'Elif',   'Bursa',     '2025-04-01'),
(6,  'Burak',  'Ankara',    '2025-05-10'),
(7,  'Selin',  'İstanbul',  '2025-06-22'),
(8,  'Emre',   'Antalya',   '2025-07-08'),
(9,  'Deniz',  'İzmir',     '2025-08-30'),
(10, 'Ahmet',  'İstanbul',  '2025-09-14'),
(11, 'Kerem',  'Eskişehir', '2025-10-28'),
(12, 'Ece',    'İstanbul',  '2025-11-10'),
(13, 'Mert',   'Ankara',    '2025-12-01'),
(14, 'Naz',    'İzmir',     '2025-12-15');

INSERT INTO siparisler VALUES
-- Eylül
(101, 1,  '2025-09-01', 'Giyim',      450.00),
(102, 2,  '2025-09-02', 'Ayakkabı',   1200.00),
(103, 1,  '2025-09-05', 'Aksesuar',   180.00),
(104, 3,  '2025-09-07', 'Giyim',      620.00),
(105, 4,  '2025-09-10', 'Elektronik', 3500.00),
(106, 5,  '2025-09-12', 'Giyim',      300.00),
(107, 2,  '2025-09-15', 'Giyim',      850.00),
(108, 6,  '2025-09-18', 'Ayakkabı',   950.00),
(109, 7,  '2025-09-20', 'Kozmetik',   240.00),
(110, 1,  '2025-09-25', 'Ayakkabı',   1100.00),
-- Ekim
(111, 8,  '2025-10-01', 'Elektronik', 4200.00),
(112, 3,  '2025-10-03', 'Kozmetik',   410.00),
(113, 9,  '2025-10-05', 'Giyim',      520.00),
(114, 4,  '2025-10-08', 'Aksesuar',   160.00),
(115, 10, '2025-10-10', 'Giyim',      780.00),
(116, 7,  '2025-10-12', 'Giyim',      690.00),
(117, 2,  '2025-10-15', 'Elektronik', 2800.00),
(118, 5,  '2025-10-18', 'Kozmetik',   150.00),
(119, 1,  '2025-10-20', 'Giyim',      530.00),
(120, 6,  '2025-10-22', 'Aksesuar',   220.00),
-- Kasım
(121, 1,  '2025-11-03', 'Giyim',      620.00),
(122, 2,  '2025-11-05', 'Ayakkabı',   1350.00),
(123, 4,  '2025-11-09', 'Aksesuar',   210.00),
(124, 7,  '2025-11-14', 'Kozmetik',   330.00),
(125, 8,  '2025-11-17', 'Elektronik', 2600.00),
(126, 10, '2025-11-20', 'Giyim',      480.00),
(127, 11, '2025-11-22', 'Giyim',      540.00),
(128, 12, '2025-11-26', 'Kozmetik',   260.00),
-- Aralık
(129, 1,  '2025-12-02', 'Giyim',      710.00),
(130, 2,  '2025-12-06', 'Elektronik', 3100.00),
(131, 10, '2025-12-10', 'Ayakkabı',   890.00),
(132, 11, '2025-12-13', 'Giyim',      470.00),
(133, 13, '2025-12-18', 'Giyim',      560.00),
(134, 14, '2025-12-21', 'Aksesuar',   190.00);

-- Website sessions for funnel analysis
-- 1 = step completed, 0 = not completed
CREATE TABLE oturumlar (
  oturum_id     INTEGER PRIMARY KEY,
  cihaz         TEXT,
  urun_gordu    INTEGER,
  sepete_ekledi INTEGER,
  odeme_yapti   INTEGER
);

INSERT INTO oturumlar VALUES
(1,  'Mobil',    1, 1, 1),
(2,  'Mobil',    1, 1, 0),
(3,  'Mobil',    1, 1, 0),
(4,  'Mobil',    1, 1, 0),
(5,  'Mobil',    1, 1, 0),
(6,  'Mobil',    1, 0, 0),
(7,  'Mobil',    1, 0, 0),
(8,  'Mobil',    1, 0, 0),
(9,  'Mobil',    0, 0, 0),
(10, 'Mobil',    0, 0, 0),
(11, 'Masaüstü', 1, 1, 1),
(12, 'Masaüstü', 1, 1, 1),
(13, 'Masaüstü', 1, 1, 1),
(14, 'Masaüstü', 1, 1, 0),
(15, 'Masaüstü', 1, 0, 0),
(16, 'Masaüstü', 1, 0, 0),
(17, 'Masaüstü', 1, 0, 0),
(18, 'Masaüstü', 0, 0, 0),
(19, 'Masaüstü', 0, 0, 0),
(20, 'Masaüstü', 0, 0, 0);
