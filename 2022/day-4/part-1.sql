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

insert into assignments(first_section, last_section) values
(2, 4),
(6, 8);

select * from assignments;

drop schema public cascade;
drop database part_1;

