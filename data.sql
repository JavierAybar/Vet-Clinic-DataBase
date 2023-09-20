/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES
    ('Agumon', '2020-02-03', 10.23, true, 0),
    ('Gabumon', '2018-11-15', 8, true, 2),
    ('Pikachu', '2021-01-07', 15.04, false, 1),
    ('Devimon', '2017-05-12', 11, true, 5);

INSERT INTO animals VALUES
    (5, 'Charmander', '2020-02-08', 0, false, -11),
    (6, 'Plantmon', '2021-11-15', 2, true, -5.7),
    (7, 'Squirtle', '1993-04-02', 3, false, -12.13),
    (8, 'Angemon', '2005-06-12', 1, true, -45),
    (9, 'Boarmon', '2005-06-07', 7, true, 20.4),
    (10, 'Blossom', '1998-10-13', 3, true, 17),
    (11, 'Ditto', '2022-05-14', 4, true, 22);


INSERT INTO owners (full_name, age)
VALUES
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);

/* Insert the following data into the species table: Pokemon, Digimon */
INSERT INTO species (name)
VALUES 
  ('Pokemon'),
  ('Digimon');

/* Modify your inserted animals so it includes the species_id value */
/* If the name ends in "mon" it will be Digimon */
UPDATE animals
SET species_id = (SELECT id FROM species WHERE name = 'Digimon')
WHERE name LIKE '%mon';

/* All other animals are Pokemon */
UPDATE animals
SET species_id = (SELECT id FROM species WHERE name = 'Pokemon')
WHERE name NOT LIKE '%mon';


/* Modify your inserted animals to include owner information (owner_id) */

-- Update the owner_id for Agumon
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';

-- Update the owner_id for Gabumon and Pikachu
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHERE name IN ('Gabumon', 'Pikachu');

-- Update the owner_id for Devimon and Plantmon
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
WHERE name IN ('Devimon', 'Plantmon');

-- Update the owner_id for Charmander, Squirtle, and Blossom
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

-- Update the owner_id for Angemon and Boarmon
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name IN ('Angemon', 'Boarmon');
