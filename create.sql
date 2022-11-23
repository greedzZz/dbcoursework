CREATE TABLE systems
(
    name              varchar(255) PRIMARY KEY,
    planets           integer NOT NULL CHECK (planets >= 0),
    habitable_planets integer NOT NULL CHECK (habitable_planets >= 0),
    republican        boolean NOT NULL
);
CREATE TABLE planets
(
    name                varchar(255) PRIMARY KEY,
    habitable           boolean      NOT NULL,
    satellites          integer      NOT NULL CHECK (satellites >= 0),
    diameter            integer      NOT NULL CHECK (diameter >= 0),
    republic_controlled boolean      NOT NULL,
    system_name         varchar(255) NOT NULL REFERENCES systems ON DELETE RESTRICT
);
CREATE TABLE battles
(
    id             integer PRIMARY KEY,
    name           varchar(255) NOT NULL,
    date           date         NOT NULL,
    victory        boolean      NOT NULL,
    space          boolean      NOT NULL,
    soldier_losses integer      NOT NULL CHECK (soldier_losses >= 0),
    vehicle_losses integer      NOT NULL CHECK (vehicle_losses >= 0),
    planet_name    varchar(255) NOT NULL REFERENCES planets ON DELETE RESTRICT
);
CREATE TABLE armies
(
    id          integer PRIMARY KEY,
    name        varchar(255) NOT NULL,
    system_name varchar(255) REFERENCES systems ON DELETE RESTRICT
);
CREATE TABLE regiments
(
    id          integer PRIMARY KEY,
    name        varchar(255) NOT NULL,
    army_id     integer      NOT NULL REFERENCES armies ON DELETE RESTRICT,
    planet_name varchar(255) REFERENCES planets ON DELETE RESTRICT
);
CREATE TABLE squads
(
    id          integer PRIMARY KEY,
    name        varchar(255) NOT NULL,
    special     boolean      NOT NULL,
    regiment_id integer      NOT NULL REFERENCES regiments ON DELETE RESTRICT
);
CREATE TABLE clones
(
    number       integer PRIMARY KEY,
    name         varchar(255),
    birthday     date    NOT NULL,
    batch_number integer NOT NULL CHECK (batch_number >= 0),
    squad_id     integer NOT NULL REFERENCES squads ON DELETE RESTRICT
);
CREATE TABLE commanders
(
    number       integer PRIMARY KEY,
    name         varchar(255) NOT NULL,
    birthday     date         NOT NULL,
    batch_number integer      NOT NULL CHECK (batch_number >= 0),
    squad_id     integer      NOT NULL REFERENCES squads ON DELETE RESTRICT
);
CREATE TABLE colonels
(
    number       integer PRIMARY KEY,
    name         varchar(255) NOT NULL,
    birthday     date         NOT NULL,
    batch_number integer      NOT NULL CHECK (batch_number >= 0),
    regiment_id  integer      NOT NULL REFERENCES regiments ON DELETE RESTRICT
);
CREATE TABLE jedi
(
    id      integer PRIMARY KEY,
    name    varchar(255) NOT NULL,
    race    varchar(255) NOT NULL,
    male    boolean      NOT NULL,
    army_id integer REFERENCES armies ON DELETE RESTRICT
);
CREATE TABLE vehicles
(
    id               integer PRIMARY KEY,
    series           varchar(255) NOT NULL,
    model            varchar(255) NOT NULL,
    regiment_id      integer      NOT NULL REFERENCES regiments ON DELETE RESTRICT,
    commander_number integer      NOT NULL REFERENCES commanders ON DELETE RESTRICT
);
CREATE TABLE battle_participation
(
    regiment_id integer NOT NULL REFERENCES regiments ON DELETE RESTRICT,
    battle_id   integer NOT NULL REFERENCES battles ON DELETE RESTRICT
);