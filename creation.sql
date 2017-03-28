--CREATION DES TABLES DE LA BASE DE DONNÉES--

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


--TABLE EQUIPE
CREATE TABLE equipe (
    id_equipe char(3) NOT NULL,
    nom_equipe varchar(50),
    id_pays integer NOT NULL
);


--TABLE ENTRAINEUR
CREATE TABLE entraineur (
    id_entraineur integer NOT NULL,
	nom_entraineur varchar(50),
	prenom_entraineur varchar(50),
    id_equipe char(3) NOT NULL
);


--TABLE SANCTION
CREATE TABLE sanction (
	id_sanction integer NOT NULL,
	carton varchar(50),
	temps time,
	id_joueur integer
);


--TABLE POINTS
CREATE TABLE points (
	id_point integer NOT NULL,
	nombre_point integer,
	temps time,
	id_joueur integer,
	id_equipe char(3) NOT NULL
);


--TABLE OFFICIEL
CREATE TABLE officiel (
    id_officiel integer NOT NULL,
	nom_officiel varchar(50),
	prenom_officiel varchar(50),
	role_officiel varchar(50),
    id_match integer
);


--TABLE PAYS
CREATE TABLE pays (
    id_pays integer NOT NULL,
    nom_pays varchar(50),
    iso char(3)
);
