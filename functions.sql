CREATE OR REPLACE FUNCTION get_squad_clones(squad_number integer)
    RETURNS TABLE
            (
                number       integer,
                batch_number integer
            )
AS
$$
SELECT number, batch_number
FROM clones
WHERE squad_id = squad_number;
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION get_regiment_clones(regiment_number integer)
    RETURNS TABLE
            (
                number       integer,
                batch_number integer
            )
AS
$$
SELECT number, batch_number
FROM clones
         INNER JOIN squads ON clones.squad_id = squads.id
WHERE regiment_id = regiment_number;
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION get_army_clones(army_number integer)
    RETURNS TABLE
            (
                number       integer,
                batch_number integer
            )
AS
$$
SELECT number, batch_number
FROM clones
         INNER JOIN squads ON clones.squad_id = squads.id
         INNER JOIN regiments ON squads.regiment_id = regiments.id
WHERE army_id = army_number;
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION get_regiment_commanders(regiment_number integer)
    RETURNS TABLE
            (
                number       integer,
                name         varchar,
                batch_number integer
            )
AS
$$
SELECT number, commanders.name, batch_number
FROM commanders
         INNER JOIN squads ON commanders.squad_id = squads.id
WHERE regiment_id = regiment_number;
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION get_army_commanders(army_number integer)
    RETURNS TABLE
            (
                number       integer,
                name         varchar,
                batch_number integer
            )
AS
$$
SELECT number, commanders.name, batch_number
FROM commanders
         INNER JOIN squads ON commanders.squad_id = squads.id
         INNER JOIN regiments ON squads.regiment_id = regiments.id
WHERE army_id = army_number;
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION get_army_colonels(army_number integer)
    RETURNS TABLE
            (
                number       integer,
                name         varchar,
                batch_number integer
            )
AS
$$
SELECT number, colonels.name, batch_number
FROM colonels
         INNER JOIN regiments ON colonels.regiment_id = regiments.id
WHERE army_id = army_number;
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION get_regiment_vehicles(regiment_number integer)
    RETURNS TABLE
            (
                series           varchar,
                model            varchar,
                commander_number integer
            )
AS
$$
SELECT series, model, commander_number
FROM vehicles
WHERE regiment_id = regiment_number;
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION get_army_vehicles(army_number integer)
    RETURNS TABLE
            (
                series           varchar,
                model            varchar,
                commander_number integer
            )
AS
$$
SELECT series, model, commander_number
FROM vehicles
         INNER JOIN regiments ON vehicles.regiment_id = regiments.id
WHERE army_id = army_number;
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION get_jedi()
    RETURNS TABLE
            (
                name        varchar,
                race        varchar,
                male        boolean,
                army_number integer
            )
AS
$$
SELECT name, race, male, army_id
FROM jedi;
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION get_planets(system varchar)
    RETURNS TABLE
            (
                name                varchar,
                habitable           boolean,
                satellites          integer,
                diameter            integer,
                republic_controlled boolean
            )
AS
$$
SELECT name, habitable, satellites, diameter, republic_controlled
FROM planets
WHERE system_name = system;
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION get_battles(system varchar)
    RETURNS TABLE
            (
                id             integer,
                name           varchar,
                date           date,
                victory        boolean,
                space          boolean,
                soldier_losses integer,
                vehicle_losses integer,
                planet_name    varchar
            )
AS
$$
SELECT battles.id,
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
    RETURNS TABLE
            (
                name    varchar,
                army_id integer
            )
AS
$$
SELECT name, army_id
FROM battle_participation
         INNER JOIN regiments ON battle_participation.regiment_id = regiments.id
WHERE battle_id = battle;
$$ LANGUAGE sql;