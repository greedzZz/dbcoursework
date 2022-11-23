CREATE OR REPLACE FUNCTION check_regiment() RETURNS TRIGGER AS
$$
BEGIN
    IF new.planet_name IS NOT NULL AND new.planet_name NOT IN (SELECT planets.name
                                                               FROM planets
                                                                        INNER JOIN armies ON planets.system_name = armies.system_name
                                                               WHERE armies.id = new.army_id) THEN
        RAISE EXCEPTION 'A regiment can only be assigned to a planet that is in the system to which its army is assigned.';
    END IF;
    RETURN new;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_upsert_regiments
    BEFORE INSERT OR UPDATE
    ON regiments
    FOR EACH ROW
EXECUTE PROCEDURE check_regiment();

CREATE OR REPLACE FUNCTION check_vehicle() RETURNS TRIGGER AS
$$
BEGIN
    IF new.regiment_id != (SELECT squads.regiment_id
                           FROM commanders
                                    INNER JOIN squads on commanders.squad_id = squads.id
                           WHERE commanders.number = new.commander_number) THEN
        RAISE EXCEPTION 'The commander must be assigned to the squad that is part of the regiment to which the vehicle is assigned.';
    END IF;
    RETURN new;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_upsert_vehicle
    BEFORE INSERT OR UPDATE
    ON vehicles
    FOR EACH ROW
EXECUTE PROCEDURE check_vehicle();