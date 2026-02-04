-- ==================================================================
--  SCRIPT DE CREATION ET SUPPRESSION D'UNE BASE DE DONNÉES POSTGRESQL
-- ==================================================================

-- 1️⃣ Connexion à la base système par défaut (postgres)
\c postgres;

-- 2️⃣ Suppression de la base existante (si elle existe)
DROP DATABASE IF EXISTS ma_base_test;

-- 3️⃣ Création de la nouvelle base
CREATE DATABASE ma_base_test
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'fr_FR.UTF-8'
    LC_CTYPE = 'fr_FR.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

-- 4️⃣ Afficher la liste des bases pour vérifier
\l


