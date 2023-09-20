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

--What animals belong to Melody Pond?
SELECT a.name AS animal_name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';

--List of all animals that are pokemon (their type is Pokemon).
SELECT a.name AS animal_name
FROM animals a
JOIN species s ON a.species_id = s.id
WHERE s.name = 'Pokemon';

--List all owners and their animals, remember to include those that don't own any animal.
SELECT o.full_name AS owner_name, a.name AS animal_name
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id;

--How many animals are there per species?
SELECT s.name AS species_name, COUNT(*) AS animal_count
FROM animals a
JOIN species s ON a.species_id = s.id
GROUP BY s.name;


--List all Digimon owned by Jennifer Orwell.
SELECT a.name AS digimon_name
FROM animals a
JOIN owners o ON a.owner_id = o.id
JOIN species s ON s.species_id = s.id

--List all animals owned by Dean Winchester that haven't tried to escape.
SELECT a.name AS animal_name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

--Who owns the most animals?
SELECT o.full_name AS owner_name, COUNT(*) AS animal_count
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name
ORDER BY animal_count DESC
LIMIT 1;