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

do $$
declare
    i int := 1;
begin
    while i <= (select count(*) from assignments) loop
        insert into assignment_pairs (first_elf_id, second_elf_id) values
        (i, i + 1);

        i := i + 2;
    end loop;
end $$;

-- main query
select count(*)
from assignments a1, assignments a2, assignment_pairs p
where a1.id = p.first_elf_id and a2.id = p.second_elf_id and
    ((a1.first_section <= a2.first_section and a1.last_section >= a2.first_section) or
    (a2.first_section <= a1.first_section and a2.last_section >= a1.first_section));

drop schema public cascade;
drop database part_1;

