-- YemekYolda: food-delivery app sample dataset (Sep - Nov 2025)
-- Run in SQLite (e.g. sqliteonline.com) before the queries.
-- Tables are prefixed with y_ .

DROP TABLE IF EXISTS y_siparisler;
DROP TABLE IF EXISTS y_kullanicilar;
DROP TABLE IF EXISTS y_restoranlar;

CREATE TABLE y_kullanicilar (
  kullanici_id INTEGER PRIMARY KEY,
  ad           TEXT,
  sehir        TEXT,
  kayit_tarihi DATE
);

CREATE TABLE y_restoranlar (
  restoran_id  INTEGER PRIMARY KEY,
  restoran_adi TEXT,
  mutfak       TEXT
);

-- durum (status): 'Teslim' (delivered) or 'İptal' (cancelled)
-- kupon (coupon): code used, NULL if none
CREATE TABLE y_siparisler (
  siparis_id     INTEGER PRIMARY KEY,
  kullanici_id   INTEGER,
  restoran_id    INTEGER,
  siparis_tarihi DATE,
  tutar          REAL,
  durum          TEXT,
  kupon          TEXT
);

INSERT INTO y_kullanicilar VALUES
(1,  'Ali',    'İstanbul', '2025-06-02'),
(2,  'Buse',   'İstanbul', '2025-06-15'),
(3,  'Cem',    'Ankara',   '2025-07-01'),
(4,  'Damla',  'İzmir',    '2025-07-20'),
(5,  'Efe',    'İstanbul', '2025-08-05'),
(6,  'Fatma',  'Ankara',   '2025-08-18'),
(7,  'Gökhan', 'İzmir',    '2025-09-03'),
(8,  'Hande',  'İstanbul', '2025-09-10'),
(9,  'İlker',  'Ankara',   '2025-09-25'),
(10, 'Jale',   'İstanbul', '2025-10-04'),
(11, 'Kaan',   'İzmir',    '2025-10-15'),
(12, 'Lale',   'İstanbul', '2025-10-28'),
(13, 'Murat',  'Ankara',   '2025-11-06'),
(14, 'Nil',    'İstanbul', '2025-11-12'),
(15, 'Okan',   'İzmir',    '2025-11-20');

INSERT INTO y_restoranlar VALUES
(1, 'Burger Durağı',   'Fast Food'),
(2, 'Napoli Pizza',    'Pizza'),
(3, 'Anadolu Sofrası', 'Ev Yemeği'),
(4, 'Sushi Ada',       'Uzak Doğu'),
(5, 'Dürümcü Usta',    'Fast Food'),
(6, 'Yeşil Tabak',     'Salata');

INSERT INTO y_siparisler VALUES
(1001, 1, 5, '2025-09-06', 135.00, 'Teslim', NULL),
(1002, 3, 4, '2025-09-06', 540.00, 'Teslim', NULL),
(1003, 2, 5, '2025-09-13', 210.00, 'İptal', NULL),
(1004, 1, 5, '2025-09-14', 190.00, 'Teslim', NULL),
(1005, 1, 2, '2025-09-16', 380.00, 'Teslim', NULL),
(1006, 7, 1, '2025-09-16', 215.00, 'Teslim', NULL),
(1007, 3, 2, '2025-09-22', 255.00, 'Teslim', 'HOSGELDIN'),
(1008, 3, 6, '2025-09-22', 170.00, 'Teslim', NULL),
(1009, 8, 6, '2025-09-23', 200.00, 'Teslim', 'HOSGELDIN'),
(1010, 2, 6, '2025-09-24', 255.00, 'Teslim', 'INDIRIM20'),
(1011, 5, 3, '2025-09-24', 220.00, 'İptal', 'HOSGELDIN'),
(1012, 1, 1, '2025-09-28', 200.00, 'Teslim', NULL),
(1013, 5, 2, '2025-09-30', 240.00, 'Teslim', NULL),
(1014, 8, 5, '2025-09-30', 120.00, 'Teslim', 'INDIRIM20'),
(1015, 1, 1, '2025-10-01', 285.00, 'İptal', 'INDIRIM20'),
(1016, 3, 3, '2025-10-05', 165.00, 'İptal', NULL),
(1017, 10, 3, '2025-10-05', 270.00, 'Teslim', 'INDIRIM20'),
(1018, 4, 2, '2025-10-06', 330.00, 'Teslim', NULL),
(1019, 2, 5, '2025-10-07', 125.00, 'İptal', 'HOSGELDIN'),
(1020, 4, 2, '2025-10-07', 405.00, 'Teslim', 'HOSGELDIN'),
(1021, 2, 5, '2025-10-09', 180.00, 'Teslim', 'HOSGELDIN'),
(1022, 2, 4, '2025-10-11', 610.00, 'Teslim', NULL),
(1023, 1, 2, '2025-10-12', 320.00, 'Teslim', NULL),
(1024, 11, 4, '2025-10-15', 555.00, 'Teslim', NULL),
(1025, 10, 5, '2025-10-16', 180.00, 'Teslim', NULL),
(1026, 3, 2, '2025-10-20', 225.00, 'Teslim', NULL),
(1027, 11, 2, '2025-10-20', 245.00, 'Teslim', NULL),
(1028, 6, 3, '2025-10-21', 250.00, 'Teslim', 'HOSGELDIN'),
(1029, 8, 2, '2025-10-26', 395.00, 'Teslim', NULL),
(1030, 10, 4, '2025-10-26', 555.00, 'Teslim', NULL),
(1031, 8, 2, '2025-10-28', 380.00, 'Teslim', NULL),
(1032, 7, 2, '2025-10-29', 245.00, 'Teslim', NULL),
(1033, 9, 4, '2025-11-02', 510.00, 'Teslim', NULL),
(1034, 4, 1, '2025-11-03', 220.00, 'Teslim', 'INDIRIM20'),
(1035, 12, 3, '2025-11-04', 200.00, 'Teslim', NULL),
(1036, 11, 2, '2025-11-05', 340.00, 'Teslim', 'INDIRIM20'),
(1037, 1, 1, '2025-11-08', 270.00, 'Teslim', 'INDIRIM20'),
(1038, 5, 3, '2025-11-08', 230.00, 'Teslim', 'INDIRIM20'),
(1039, 8, 4, '2025-11-08', 625.00, 'Teslim', NULL),
(1040, 1, 1, '2025-11-09', 255.00, 'Teslim', NULL),
(1041, 9, 4, '2025-11-09', 635.00, 'Teslim', NULL),
(1042, 13, 1, '2025-11-10', 215.00, 'Teslim', 'HOSGELDIN'),
(1043, 10, 2, '2025-11-12', 280.00, 'Teslim', NULL),
(1044, 14, 6, '2025-11-12', 240.00, 'İptal', NULL),
(1045, 1, 5, '2025-11-13', 170.00, 'İptal', NULL),
(1046, 3, 3, '2025-11-16', 265.00, 'İptal', NULL),
(1047, 2, 2, '2025-11-19', 345.00, 'Teslim', 'HOSGELDIN'),
(1048, 6, 4, '2025-11-19', 610.00, 'Teslim', 'INDIRIM20'),
(1049, 7, 1, '2025-11-20', 195.00, 'Teslim', 'INDIRIM20'),
(1050, 13, 4, '2025-11-20', 420.00, 'Teslim', NULL),
(1051, 3, 6, '2025-11-22', 245.00, 'Teslim', NULL),
(1052, 7, 4, '2025-11-23', 410.00, 'Teslim', NULL),
(1053, 14, 2, '2025-11-23', 360.00, 'Teslim', NULL),
(1054, 5, 2, '2025-11-24', 220.00, 'Teslim', 'INDIRIM20'),
(1055, 12, 2, '2025-11-24', 240.00, 'Teslim', 'HOSGELDIN'),
(1056, 8, 3, '2025-11-26', 270.00, 'Teslim', 'HOSGELDIN'),
(1057, 13, 2, '2025-11-26', 375.00, 'Teslim', 'HOSGELDIN'),
(1058, 15, 4, '2025-11-26', 485.00, 'İptal', NULL),
(1059, 5, 4, '2025-11-30', 560.00, 'Teslim', 'HOSGELDIN');
