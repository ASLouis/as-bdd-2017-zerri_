use championnat;

-- Supression des contraintes PK et FK de toutes les tables
DECLARE @sql nvarchar(max) = '';
SELECT  @sql += 'ALTER TABLE ' + Table_Name  +'  drop constraint ' + Constraint_Name + ';'
FROM Information_Schema.CONSTRAINT_TABLE_USAGE 
ORDER BY Constraint_Name 
EXEC SP_EXECUTESQL @sql;
GO

-- supression des tables de la BDD
EXEC sp_MSforeachtable @command1 = "DROP TABLE ?"
GO

--TABLE MATCH
CREATE TABLE match (
	id_match integer NOT NULL,
	type_match varchar(50),
	date_match date,
	heure time,
	site_match varchar(50),
	influence integer
);
ALTER TABLE match ADD CONSTRAINT PK_id_match PRIMARY KEY (id_match);

--TABLE JOUEUR
CREATE TABLE joueur (
    id_joueur integer NOT NULL,
	numero_joueur integer,
	nom_joueur varchar(50),
	prenom_joueur varchar(50),
	poste varchar(50),
    id_equipe char(3),
	id_match integer
);
ALTER TABLE joueur ADD CONSTRAINT PK_id_joueur PRIMARY KEY (id_joueur);

--TABLE EQUIPE
CREATE TABLE equipe (
    id_equipe char(3) NOT NULL,
    nom_equipe varchar(50),
    id_pays integer NOT NULL
);
ALTER TABLE equipe ADD CONSTRAINT PK_id_equipe PRIMARY KEY (id_equipe);

--TABLE ENTRAINEUR
CREATE TABLE entraineur (
    id_entraineur integer NOT NULL,
	nom_entraineur varchar(50),
	prenom_entraineur varchar(50),
    id_equipe char(3) NOT NULL
);
ALTER TABLE entraineur ADD CONSTRAINT PK_id_entraineur PRIMARY KEY (id_entraineur);

--TABLE SANCTION
CREATE TABLE sanction (
	id_sanction integer NOT NULL,
	carton varchar(50),
	temps time,
	id_joueur integer
);
ALTER TABLE sanction ADD CONSTRAINT PK_id_sanction PRIMARY KEY (id_sanction);

--TABLE POINTS
CREATE TABLE points (
	id_point integer NOT NULL,
	nombre_point integer,
	temps time,
	id_joueur integer,
	id_equipe char(3) NOT NULL
);
ALTER TABLE points ADD CONSTRAINT PK_id_point PRIMARY KEY (id_point);

--TABLE OFFICIEL
CREATE TABLE officiel (
    id_officiel integer NOT NULL,
	nom_officiel varchar(50),
	prenom_officiel varchar(50),
	role_officiel varchar(50),
    id_match integer
);
ALTER TABLE officiel ADD CONSTRAINT PK_id_officiel PRIMARY KEY (id_officiel);

--TABLE PAYS
CREATE TABLE pays (
    id_pays integer NOT NULL,
    nom_pays varchar(50),
    iso char(3)
);
ALTER TABLE pays ADD CONSTRAINT PK_id_pays PRIMARY KEY (id_pays);

-- ajout des contraintes pour les clés étrangères
ALTER TABLE joueur ADD CONSTRAINT FK_id_joueur
	FOREIGN KEY (id_joueur) REFERENCES joueur (id_joueur) 
;
ALTER TABLE joueur ADD CONSTRAINT FK_id_match
	FOREIGN KEY (id_match) REFERENCES match (id_match) 
;
ALTER TABLE equipe ADD CONSTRAINT FK_id_pays
	FOREIGN KEY (id_pays) REFERENCES pays (id_pays) 
;
ALTER TABLE entraineur ADD CONSTRAINT FK_id_entraineur
	FOREIGN KEY (id_equipe) REFERENCES equipe (id_equipe) 
;
ALTER TABLE sanction ADD CONSTRAINT FK_id_sanction
	FOREIGN KEY (id_joueur) REFERENCES joueur (id_joueur) 
;
ALTER TABLE points ADD CONSTRAINT FK_id_joueur_points
	FOREIGN KEY (id_joueur) REFERENCES joueur (id_joueur) 
;
ALTER TABLE points ADD CONSTRAINT FK_id_equipe_points
	FOREIGN KEY (id_equipe) REFERENCES equipe (id_equipe) 
;
ALTER TABLE officiel ADD CONSTRAINT FK_id_match_officiel
	FOREIGN KEY (id_match) REFERENCES match (id_match) 
;

--Insertions des données
INSERT INTO pays VALUES (1, 'Secundus', 'sec'), (2, 'Galba', 'gal'), (3, 'Tranquillus', 'tra'),(4, 'Nasica', 'nas'), (5, 'Minor', 'min'), (6, 'Lepidus', 'lep'), (7, 'Nepos', 'nep'), (8, 'Rufus', 'ruf'), (9, 'Porcius', 'por'), (10, 'Victor', 'vic'), (11, 'Octavius', 'oct'), (12, 'Vindex', 'vin'), (13, 'Decimus', 'dec'), (14, 'Lentulus', 'len'), (15, 'Cicero', 'cic'), (16, 'Clemens', 'cle'), (17, 'Agricola', 'agr'), (18, 'Magnus', 'mag'), (19, 'Cinna', 'cin'), (20, 'Proculus', 'pro'), (21, 'Bestius', 'bes'), (22, 'Pertinax', 'per'), (23, 'Flaccus', 'fla'), (24, 'Ovidius', 'ovi'), (25, 'Pulcher', 'pul'), (26, 'Catulus', 'cat'), (27, 'Tacitus', 'tac'), (28, 'Naevius', 'nae'), (29, 'Afer', 'afe'), (30, 'Rutilus', 'rut'), (31, 'Caepio', 'cae'), (32, 'Priscus', 'pri'), (33, 'Pollio', 'pol'), (34, 'Asinius', 'asi'), (35, 'Crispus', 'cri'), (36, 'Fuscus', 'fus'), (37, 'Italicus', 'ita'), (38, 'Scaurus', 'sca'), (39, 'Coclès', 'coc'), (40, 'Gracchus', 'gra'), (41, 'Septimus', 'sep'); 
INSERT INTO equipe VALUES ('E01', 'Hellbreakwall', 14), ('E02', 'Hamethunder', 15), ('E03', 'Catelf', 20), ('E04', 'Hammerlocke', 16), ('E05', 'Greengrey', 9), ('E06', 'Ragearrow', 7), ('E07', 'Dawnflare', 11),('E08', 'Hiltmane', 13), ('E09', 'Mountainbright', 5), ('E10', 'Staffeyes', 1), ('E11', 'Glidewater', 18), ('E12', 'Moosemagenta', 12), ('E13', 'Boar', 6), ('E14', 'Eyesshortore', 2), ('E15', 'Fireday', 3), ('E16', 'Bowlocke', 17), ('E17', 'Falconchase', 4), ('E18', 'Shadowlord', 19), ('E19', 'Cloakbreak', 10), ('E20', 'Batlake', 8);
INSERT INTO match VALUES (1, 'Finale', '2014-06-28', '20:00:00', 'Stade A', 1468), (2, 'Demi-Finale', '2014-06-22', '20:00:00','Stade A', 1742), (3, 'Demi-Finale', '2014-06-23', '20:00:00', 'Stade B', 1953), (4, 'Quart de finale', '2014-06-15', '12:00:00', 'Stade A', 1278), (5, 'Quart de finale', '2014-06-15', '20:00:00', 'Stade B', 1358), (6, 'Quart de finale', '2014-06-16', '12:00:00', 'Stade A', 1257), (7, 'Quart de finale', '2014-06-16', '20:00:00', 'Stade B', 1438);
INSERT INTO joueur VALUES (1, 87, 'SELAN', 'Hincellarde', 'Titulaire', 'EO7', 1), (2, 167, 'MAMIL', 'Jemel', 'Titulaire', 'EO7', 1), (3, 107, 'PECUR', 'Liceronde', 'Titulaire', 'EO7', 1), (4, 127, 'MAUMBOT', 'Girasina', 'Titulaire', 'EO7', 1), (5, 27, 'TALOD', 'Saugir', 'Titulaire', 'EO7', 1), (6, 187, 'PISCOT', 'Linan', 'Remplaçant', 'EO7', 1), (7, 7, 'HALOS', 'Drakis', 'Remplaçant', 'EO7', 1), (8, 47, 'BUIS', 'Prolot', 'Remplaçant', 'EO7', 1), (9, 33, 'KONARD', 'Runlvath', 'Titulaire', 'E13', 1), (10, 67, 'TASCUS', 'Sovarde', 'Remplaçants', 'E07', 1), (11, 153, 'PASIR', 'Buon', 'Titulaire', 'E13', 1), (12, 133, 'SHALUTOR', 'Todearde', 'Titulaire', 'E13', 1), (13, 33, 'LEORELER', 'Batal', 'Titulaire', 'E13', 1), (14, 93, 'BAGARD', 'Bratianne', 'Titulaire', 'E13', 1), (15, 53, 'RARSEL', 'Prellissa', 'Remplaçants', 'E13', 1), (16, 53, 'JAMEN', 'Picercysse', 'Remplaçants', 'E13', 1), (17, 73, 'PIBRUR', 'Pigravina', 'Remplaçants', 'E13', 1), (18, 47, 'BUIS', 'Prolot', 'Titulaire', 'E07', 2), (19, 107, 'PECUR', 'Liceronde', 'Titulaire', 'E07', 2), (20, 167, 'MAMIL', 'Jemel', 'Titulaire', 'E07', 2), (21, 127, 'MAUMBOT', 'Girasina', 'Titulaire', 'E07', 2), (22, 87, 'SELAN', 'Hincellarde', 'Titulaire', 'E07', 2), (23, 67, 'TASCUS', 'Sovarde', 'Remplaçant', 'E07', 2), (24, 187, 'PISCOT', 'Linan', 'Remplaçant', 'E07', 2), (25, 27, 'TALOD', 'Saugir', 'Remplaçant', 'E07', 2), (26, 147, 'ZAMETH', 'Lallyse', 'Remplaçant', 'E07', 2), (27, 61, 'MATHAN', 'Misice', 'Titulaire', 'E01', 2), (28, 181, 'LEOSCE', 'Grembien', 'Titulaire', 'E01', 2), (29, 41, 'JINARSAL', 'Valareth', 'Titulaire', 'E01', 2), (30, 161, 'DIDEREL', 'Jedis', 'Titulaire', 'E01', 2), (31, 141, 'TRALINSOT', 'Datianne', 'Titulaire', 'E01', 2), (32, 121, 'LIDERIL', 'Grepamissa', 'Remplaçant', 'E01', 2), (33, 21, 'TRAMAN', 'Reludor', 'Remplaçant', 'E01', 2), (34, 101, 'NARESER', 'Vatielle', 'Remplaçant', 'E01', 2), (35, 81, 'RANMUR', 'Tolionne', 'Remplaçant', 'E01', 2), (36, 193, 'VABRIR', 'Sorcer', 'Titulaire', 'E13', 3), (37, 33, 'KONARD', 'Runlvath', 'Titulaire', 'E13', 3), (38, 173, 'DAUNOT', 'Emar', 'Titulaire', 'E13', 3), (39, 153, 'PASIR', 'Buon', 'Titulaire', 'E13', 3), (40, 93, 'BAGARD', 'Bratianne', 'Titulaire', 'E13', 3), (41, 53, 'RARSEL', 'Prellissa', 'Remplaçant', 'E13', 3), (42, 73, 'PIBRUR', 'Pigravina', 'Remplaçant', 'E13', 3), (43, 113, 'JAMEN', 'Picercysse', 'Remplaçant', 'E13', 3), (44, 13, 'LEORELER', 'Batal', 'Remplaçant', 'E13', 3), (45, 123, 'TRABERT', 'Leosianne', 'Titulaire', 'E03', 3), (46, 163, 'SITHATH', 'Bosath', 'Titulaire', 'E03', 3), (47, 3, 'LUDAN', 'Drusas', 'Titulaire', 'E03', 3), (48, 63, 'LITIL', 'Jelertysse', 'Titulaire', 'E03', 3), (49, 183, 'RANMUS', 'Dapod', 'Titulaire', 'E03', 3), (50, 23, 'IDAAS', 'Ocis', 'Remplaçant', 'E03', 3), (51, 103, 'DRARTIL', 'Ficeta', 'Remplaçant', 'E03', 3), (52, 43, 'HIBRIR', 'Drodur', 'Remplaçant', 'E03', 3), (53, 143, 'SAURIRAN', 'Beorita', 'Remplaçant', 'E03', 3), (54, 127, 'MAUMBOT', 'Girasina', 'Titulaire', 'E07', 4), (55, 47, 'BUIS', 'Prolot', 'Titulaire', 'E07', 4), (56, 67, 'TASCUS', 'Sovarde', 'Titulaire', 'E07', 4), (57, 147, 'ZAMETH', 'Lallyse', 'Titulaire', 'E07', 4), (58, 87, 'SELAN', 'Hincellarde', 'Titulaire', 'E07', 4), (59, 107, 'PECUR', 'Liceronde', 'Remplaçant', 'E07', 4), (60, 167, 'MAMIL', 'Jemel', 'Remplaçant', 'E07', 4), (61, 27, 'TALOD', 'Saugir', 'Remplaçant', 'E07', 4), (62, 187, 'PISCOT', 'Linan', 'Remplaçant', 'E07', 4), (63, 112, 'BEGARG', 'Shasina', 'Titulaire', 'E12', 4), (64, 32, 'HASUS', 'Drazas', 'Titulaire', 'E12', 4), (65, 72, 'RANNIN', 'Saupersille', 'Titulaire', 'E12', 4), (66, 132, 'KOLVON', 'Predercina', 'Titulaire', 'E12', 4), (67, 192, 'BACAN', 'Jedirtas', 'Titulaire', 'E12', 4), (68, 52, 'ZATHIN', 'Rapyse', 'Remplaçant', 'E12', 4), (69, 92, 'LEOZUS', 'Haia', 'Remplaçant', 'E12', 4), (70, 152, 'MAURIN', 'Radil', 'Remplaçant', 'E12', 4), (71, 172, 'UIS', 'Vagil', 'Remplaçant', 'E12', 4), (72, 161, 'DIDEREL', 'Jedis', 'Titulaire', 'E01', 5), (73, 121, 'LIDERIL', 'Grepamissa', 'Titulaire', 'E01', 5), (74, 1, 'TARTUS', 'Sitan', 'Titulaire', 'E01', 5), (75, 41, 'JINARSAL', 'Valareth', 'Titulaire', 'E01', 5), (76, 61, 'MATHAN', 'Misice', 'Titulaire', 'E01', 5), (77, 181, 'LEOSCE', 'Grembien', 'Remplaçant', 'E01', 5), (78, 21, 'TRAMAN', 'Reludor', 'Remplaçant', 'E01', 5), (79, 101, 'NARESER', 'Vatielle', 'Remplaçant', 'E01', 5), (80, 81, 'RANMUR', 'Tolionne', 'Remplaçant', 'E01', 5), (81, 135, 'TONARD', 'Hatadonde', 'Titulaire', 'E15', 5), (82, 175, 'ZANOD', 'Maon', 'Titulaire', 'E15', 5), (83, 55, 'THOGRADAM', 'Catonde', 'Titulaire', 'E15', 5), (84, 95, 'LORETH', 'Jabrille', 'Titulaire', 'E15', 5), (85, 115, 'LORER', 'Oradice', 'Titulaire', 'E15', 5), (86, 35, 'FISAR', 'Droscion', 'Remplaçant', 'E15', 5), (87, 15, 'BUBRON', 'Bothod', 'Remplaçant', 'E15', 5), (88, 155, 'SANUS', 'Mercan', 'Remplaçant', 'E15', 5), (89, 195, 'BROGUR', 'Bumor', 'Remplaçant', 'E15', 5), (90, 93, 'BAGARD', 'Bratianne', 'Titulaire', 'E13', 6), (91, 173, 'DAUNOT', 'Emar', 'Titulaire', 'E13', 6), (92, 53, 'RARSEL', 'Prellissa', 'Titulaire', 'E13', 6), (93, 193, 'VABRIR', 'Sorcer', 'Titulaire', 'E13', 6), (94, 33, 'KONARD', 'Runlvath', 'Titulaire', 'E13', 6), (95, 113, 'JAMEN', 'Picercysse', 'Remplaçant', 'E13', 6), (96, 13, 'LEORELER', 'Batal', 'Remplaçant', 'E13', 6), (97, 133, 'SHALUTOR', 'Todearde', 'Remplaçant', 'E13', 6), (98, 153, 'PASIR', 'Buon', 'Remplaçant', 'E13', 6), (99, 13, 'LEORELER', 'Batal', 'Remplaçant', 'E13', 6), (100, 114, 'DRATETUS', 'Ludalline', 'Titulaire', 'E14', 6), (101, 134, 'SEBAS', 'Grevia', 'Titulaire', 'E14', 6), (102, 54, 'GRECE', 'Daugramialle', 'Titulaire', 'E14', 6), (103, 194, 'MAGOMBIN', 'Shadas', 'Titulaire', 'E14', 6), (104, 174, 'TUAN', 'Bancesan', 'Titulaire', 'E14', 6), (105, 74, 'ITAL', 'Ranianne', 'Remplaçant', 'E14', 6), (106, 14, 'EKAR', 'Thedis', 'Remplaçant', 'E14', 6), (107, 94, 'RUNGRAS', 'Jidine', 'Remplaçant', 'E14', 6), (108, 34, 'JECASER', 'Yrtin', 'Remplaçant', 'E14', 6), (109, 183, 'RANMUS', 'Dapod', 'Titulaire', 'E03', 7), (110, 43, 'HIBRIR', 'Drodur', 'Titulaire', 'E03', 7), (111, 103, 'DRARTIL', 'Ficeta', 'Titulaire', 'E03', 7), (112, 23, 'IDAAS', 'Ocis', 'Titulaire', 'E03', 7), (113, 123, 'TRABERT', 'Leosianne', 'Titulaire', 'E03', 7), (114, 83, 'BEOCAN', 'Hamibella', 'Remplaçant', 'E03', 7), (115, 143, 'SAURIRAN', 'Beorita', 'Remplaçant', 'E03', 7), (116, 163, 'SITHATH', 'Bosath', 'Remplaçant', 'E03', 7), (117, 3, 'LUDAN', 'Drusas', 'Remplaçant', 'E03', 7), (118, 79, 'MAUDETH', 'Varella', 'Titulaire', 'E19', 7), (119, 19, 'TOKARD', 'Ludert', 'Titulaire', 'E19', 7), (120, 139, 'BEODUS', 'Thocarina', 'Titulaire', 'E19', 7), (121, 159, 'MERETH', 'Rundesien', 'Titulaire', 'E19', 7), (122, 179, 'SEDIN', 'Kore', 'Titulaire', 'E19', 7), (123, 39, 'PREMETH', 'Jaral', 'Remplaçant', 'E19', 7), (124, 59, 'RUNSAS', 'Tozie', 'Remplaçant', 'E19', 7), (125, 199, 'LUGATH', 'Tusor', 'Remplaçant', 'E19', 7), (126, 119, 'RIMEL', 'Loparcita', 'Remplaçant', 'E19', 7);
INSERT INTO entraineur VALUES (374, 'FERNANDES', 'Lola', 'E07'), (375, 'BOULANGER', 'Lola', 'E13'), (301, 'GUILLARD', 'Franck', 'E01'), (361, 'RACINE', 'Agathe', 'E03'), (304, 'TRAN', 'Jérôme', 'E07'), (314, 'DELCOURT', 'Jean-François', 'E12'), (305, 'BONNOT', 'Eric', 'E01'), (317, 'LACOUR', 'Henri', 'E15'), (316, 'BILLON', 'Sébastien', 'E14'), (321, 'DELON', 'David', 'E19');
INSERT INTO sanction VALUES (1, 'Carton jaune', '00:09:12',2), (2, 'Carton rouge', '00:16:45',9), (3, 'Carton rouge', '00:23:04',18), (4, 'Carton jaune', '01:07:07',24), (5, 'Carton jaune', '01:07:07',30), (6, 'Carton jaune', '00:10:25',37), (7, 'Carton jaune', '00:18:09',37), (8, 'Carton jaune', '00:18:09',52), (9, 'Carton jaune', '01:40:58',61), (10, 'Carton rouge', '01:15:42',54), (11, 'Carton rouge', '00:05:13',94);
INSERT INTO officiel VALUES (282, 'BAYANAGA', 'Matsuyasu', 'Commissaire du match', 1), (299, 'YORI', 'Ao', 'Arbitre', 1), (228, 'MUNEAKA', 'Mune', 'Arbitre assistant 1', 1), (202, 'YORIYAMA', 'Okakaka', 'Arbitre assistant 2', 1), (210, 'NOBU', 'Shimoue', 'Commissaire du match', 2), (242, 'MOCHISHIMO', 'Kitsuka', 'Arbitre', 2), (269, 'MOCHIAKI', 'Motoie', 'Arbitre assistant 1', 2), (218, 'MASA', 'Yoshi', 'Arbitre assistant 2', 2), (284, 'SAKA', 'Tsugu', 'Commissaire du match', 3), (247, 'MOTO', 'Mitsushi', 'Arbitre', 3), (209, 'FUKAICHI', 'Higatani', 'Arbitre assistant 1', 3), (286, 'SUGITOKI', 'Shimo', 'Commissaire du match', 4), (230, 'SHIIKE', 'Mochiyoko', 'Arbitre', 4), (254, 'MIZU', 'Takemune', 'Arbitre assistant 1', 4), (226, 'YOSHIMAE', 'Matsu', 'Arbitre assistant 2', 4), (233, 'NOTANI', 'Toshiiwa', 'Commissaire du match', 5), (244, 'YOSHIJIMA', 'Hiromatsu', 'Arbitre', 5), (220, 'SHIMOBA', 'Nagaike', 'Arbitre assistant 1', 5), (285, 'HIGAHIDE', 'Yoritoshi', 'Commissaire du match', 6), (258, 'SADANOBU', 'Yorikane', 'Arbitre', 6), (238, 'TOMO', 'Iwakita', 'Arbitre assistant 1', 6), (256, 'SHIMATADA', 'Maetsugu', 'Commissaire du match', 7), (263, 'TOSHIAKI', 'Toki', 'Arbitre', 7), (298, 'UCHITOKI', 'Take', 'Arbitre assistant 1', 7);
INSERT INTO points VALUES (1, 2, '00:05:14', 5, 'E07'), (2, 4, '00:35:12', 7, 'E07'), (3, 1, '00:12:51', 5, 'E13'), (4, 4, '00:25:22', 4, 'E07'), (5, 3, '01:24:29', 29, 'E01'), (6, 2, '00:35:52', 3, 'E07'), (7, 1, '01:40:09', 32, 'E01'), (8, 3, '01:16:04', 36,'E13'), (9, 2, '01:54:08', 40, 'E13'), (10, 5, '00:40:41', 56, 'E07'), (11, 3, '01:32:25', 66, 'E12'), (12, 2, '01:53:24', 63, 'E12'), (13, 3, '01:59:42', 61, 'E07'), (14, 1, '00:36:11', 84, 'E15'), (15, 1, '01:24:14', 83, 'E15'), (16, 1, '01:54:45', 88, 'E15'), (17, 5, '00:20:06', 82, 'E15'), (18, 5, '01:50:39', 84, 'E01'), (19, 1, '01:08:39', 91, 'E13'), (20, 2, '00:42:13', 109, 'E03'), (21, 3, '00:58:21', 112, 'E03'), (22, 1, '01:10:07', 121, 'E19'), (23, 1, '01:56:34', 119, 'E19');
