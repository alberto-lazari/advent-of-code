set client_min_messages to warning;

create database part_1;
create schema public;

-- range of sections to clean, in the form (first-last)
create table assignments (
    id serial primary key,
    first_section integer not null,
    last_section integer not null
);

-- pair of elf assignments
create table assignment_pairs (
    id serial primary key,
    first_elf_id integer unique not null references assignments(id),
    second_elf_id integer unique not null references assignments(id)
);

-- damned command to parse the file...
\set command sed' '-e' '"s/\(.*\)-\(.*\),\(.*\)-\(.*\)/\1,\2\n\3,\4/"' '<' ':pwd/:input

copy assignments (first_section, last_section) from program :'command' with csv;

select * from assignments;

select * from assignment_pairs;

drop schema public cascade;
drop database part_1;

