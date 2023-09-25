/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id serial PRIMARY KEY,
    name VARCHAR(50),
    date_of_birth DATE,
    escape_attempts INTEGER,
    neutered BOOLEAN,
    weight_kg DECIMAL(10, 2)
);

vet_clinic=# ALTER TABLE animals
vet_clinic-# ADD COLUMN species VARCHAR;
ALTER TABLE


CREATE TABLE owners (
    id serial PRIMARY KEY,
    full_name VARCHAR(50),
    age INTEGER
);

CREATE TABLE species(
    id serial PRIMARY KEY,
    name VARCHAR(50)
);

/* Make sure that id is set as autoincremented PRIMARY KEY */
SELECT column_name, column_default
FROM information_schema.columns
WHERE table_name = 'animals' 
  AND column_name = 'id'
  AND column_default LIKE 'nextval%';

/* Delete species column */
ALTER TABLE animals
DROP COLUMN species;

/* Add column species_id which is a foreign key referencing species table */
ALTER TABLE animals
ADD COLUMN species_id INTEGER REFERENCES species(id);

/* Add column owner_id which is a foreign key referencing the owners table */
ALTER TABLE animals
ADD COLUMN owner_id INTEGER REFERENCES owners(id);

--Create a table named vets
CREATE TABLE vets (
	id serial PRIMARY KEY,
	name VARCHAR(50),
	age INTEGER,
	date_of_graduation DATE
);

--many-to-many relationship between the tables species and vets:
CREATE TABLE specializations (
	vet_id INTEGER REFERENCES vets(id),
	species_id INTEGER REFERENCES vets(id),
	PRIMARY KEY(vet_id, species_id)
);

--many-to-many relationship between the tables animals and vets
CREATE TABLE visits (
	visit_id serial PRIMARY KEY,
    animal_id INTEGER REFERENCES animals(id),
	vet_id INTEGER REFERENCES vets(id),
	visit_date DATE
);


-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

CREATE TEMPORARY TABLE tt_visits AS SELECT * FROM visits WHERE vet_id = 2;
CREATE INDEX animal_idx ON visits(animal_id asc);
CREATE INDEX vet_idx ON tt_visits (vet_id);
CREATE INDEX email_idx ON owners(email);

