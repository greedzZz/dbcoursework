CREATE INDEX clones_squad_id_idx ON clones (squad_id);
CREATE INDEX squads_regiment_id_idx ON squads (regiment_id);
CREATE INDEX regiments_army_id_idx ON regiments (army_id);
CREATE INDEX commanders_squad_id_idx ON commanders (squad_id);
CREATE INDEX vehicles_regiment_id_idx ON vehicles (regiment_id);
CREATE INDEX planets_system_name_idx ON planets USING hash(system_name);