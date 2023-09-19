/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals  WHERE NAME LIKE '%mon';

SELECT NAME FROM animals WHERE DATE_OF_BIRTH BETWEEN '2016-01-01' AND '2019-12-31';

SELECT NAME FROM animals WHERE NEUTERED = true AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered = true;

SELECT * FROM animals WHERE name <> 'Gabumon';

SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;


/* Inside a transaction update the animals table setting the species column to unspecified.*/
BEGIN;
BEGIN
vet_clinic=*# UPDATE animals
vet_clinic-*# SET species = 'unspecified';
UPDATE 11
vet_clinic=*# SELECT * FROM animals

vet_clinic=*# ROLLBACK;
ROLLBACK
vet_clinic=# SELECT * FROM animals;

/* Inside a transaction update the animals table setting to 'digimon' or 'pokemon' */
vet_clinic=# BEGIN;
BEGIN
vet_clinic=*# UPDATE animals SET species = 'digimon' WHERE name LIKE '%MON';
UPDATE 0
vet_clinic=*#  UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE 6
vet_clinic=*# UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
UPDATE 5
vet_clinic=*# SELECT * FROM animals;

vet_clinic=*# COMMIT;
COMMIT
vet_clinic=# SELECT * FROM animals;

/* Delete table and then make rollback */
vet_clinic=# BEGIN;
BEGIN
vet_clinic=*# DELETE FROM animals;
DELETE 11
vet_clinic=*# SELECT * FROM animals;

vet_clinic=*# ROLLBACK;
ROLLBACK
vet_clinic=# SELECT * FROM animals;


vet_clinic=# BEGIN;
BEGIN
vet_clinic=*# DELETE FROM animals
vet_clinic-*# WHERE date_of_birth > '2022-01-01';
DELETE 1
vet_clinic=*# SAVEPOINT my_savepoint;
SAVEPOINT
vet_clinic=*# UPDATE animals
vet_clinic-*# SET weight_kg = weight_kg * -1;
UPDATE 10
vet_clinic=*# ROLLBACK TO my_savepoint
vet_clinic-*# ;
ROLLBACK
vet_clinic=*# UPDATE animals
vet_clinic-*# SET weight_kg = weight_kg * -1
vet_clinic-*# WHERE weight_kg < 0;
UPDATE 4
vet_clinic=*# COMMIT;
COMMIT


/* How many animals are there? */
SELECT COUNT(*) FROM animals;

/* How many animals have never tried to escape? */
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

/* What is the average weight of animals? */
SELECT AVG(weight_kg) FROM animals;

/* Who escapes the most, neutered or not neutered animals? */
SELECT neutered, MAX(escape_attempts) as max_escape_attempts
FROM animals
GROUP BY neutered;

/* What is the minimum and maximum weight of each type of animal? */
SELECT species, MIN(weight_kg) as min_weight, MAX(weight_kg) as max_weight
FROM animals
GROUP BY species;

/* What is the average number of escape attempts per animal type of those born between 1990  and 2000? */
SELECT species, AVG(escape_attempts) as avg_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;