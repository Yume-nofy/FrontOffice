-- Supprimer la base si elle existe déjà
DROP DATABASE IF EXISTS nom_de_ta_base;

-- Créer la base de données
CREATE DATABASE nom_de_ta_base
    WITH 
    OWNER = postgres        -- ou un autre utilisateur
    ENCODING = 'UTF8'
    LC_COLLATE = 'fr_FR.UTF-8'
    LC_CTYPE = 'fr_FR.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
