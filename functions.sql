CREATE OR REPLACE FUNCTION get_squad_clones(squad_number integer)
    RETURNS SETOF clones
AS
$$
SELECT *
FROM clones
WHERE squad_id = squad_number;
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION get_regiment_clones(regiment_number integer)
    RETURNS SETOF clones
AS
$$
SELECT number, clones.name, birthday, batch_number, squad_id
FROM clones
         INNER JOIN squads ON clones.squad_id = squads.id
WHERE regiment_id = regiment_number;
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION get_army_clones(army_number integer)
    RETURNS SETOF clones
AS
$$
SELECT number, clones.name, birthday, batch_number, squad_id
FROM clones
         INNER JOIN squads ON clones.squad_id = squads.id
         INNER JOIN regiments ON squads.regiment_id = regiments.id
WHERE army_id = army_number;
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION get_regiment_commanders(regiment_number integer)
    RETURNS SETOF commanders
AS
$$
SELECT number, commanders.name, birthday, batch_number, squad_id
FROM commanders
         INNER JOIN squads ON commanders.squad_id = squads.id
WHERE regiment_id = regiment_number;
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION get_army_commanders(army_number integer)
    RETURNS SETOF commanders
AS
$$
SELECT number, commanders.name, birthday, batch_number, squad_id
FROM commanders
         INNER JOIN squads ON commanders.squad_id = squads.id
         INNER JOIN regiments ON squads.regiment_id = regiments.id
WHERE army_id = army_number;
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION get_army_colonels(army_number integer)
    RETURNS SETOF colonels
AS
$$
SELECT number, colonels.name, birthday, batch_number, regiment_id
FROM colonels
         INNER JOIN regiments ON colonels.regiment_id = regiments.id
WHERE army_id = army_number;
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION get_regiment_vehicles(regiment_number integer)
    RETURNS SETOF vehicles
AS
$$
SELECT *
FROM vehicles
WHERE regiment_id = regiment_number;
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION get_army_vehicles(army_number integer)
    RETURNS SETOF vehicles
AS
$$
SELECT vehicles.id, series, model, regiment_id, commander_number
FROM vehicles
         INNER JOIN regiments ON vehicles.regiment_id = regiments.id
WHERE army_id = army_number;
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION get_jedi()
    RETURNS SETOF jedi
AS
$$
SELECT *
FROM jedi;
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION get_planets(system varchar)
    RETURNS SETOF planets
AS
$$
SELECT *
FROM planets
WHERE system_name = system;
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION get_battles(system varchar)
    RETURNS SETOF battles
AS
$$
SELECT id,
       battles.name,
       date,
       victory,
       space,
       soldier_losses,
       vehicle_losses,
       planet_name
FROM battles
         INNER JOIN planets ON battles.planet_name = planets.name
WHERE system_name = system;
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION get_battle_regiments(battle integer)
    RETURNS SETOF regiments
AS
$$
SELECT id, name, army_id, planet_name
FROM battle_participation
         INNER JOIN regiments ON battle_participation.regiment_id = regiments.id
WHERE battle_id = battle;
$$ LANGUAGE sql;