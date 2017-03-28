--AJOUT DES CONTRAINTES POUR LES CLÉS PRIMAIRES--

ALTER TABLE match ADD CONSTRAINT PK_id_match PRIMARY KEY (id_match);
ALTER TABLE joueur ADD CONSTRAINT PK_id_joueur PRIMARY KEY (id_joueur);
ALTER TABLE equipe ADD CONSTRAINT PK_id_equipe PRIMARY KEY (id_equipe);
ALTER TABLE entraineur ADD CONSTRAINT PK_id_entraineur PRIMARY KEY (id_entraineur);
ALTER TABLE sanction ADD CONSTRAINT PK_id_sanction PRIMARY KEY (id_sanction);
ALTER TABLE points ADD CONSTRAINT PK_id_point PRIMARY KEY (id_point);
ALTER TABLE officiel ADD CONSTRAINT PK_id_officiel PRIMARY KEY (id_officiel);
ALTER TABLE pays ADD CONSTRAINT PK_id_pays PRIMARY KEY (id_pays);

--AJOUT DES CONTRAINTES POUR LES CLÉS ÉTRANGÈRES--

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
