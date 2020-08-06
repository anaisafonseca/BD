create table anaisa.trabalho(
Nome VARCHAR(12),
dia TIMESTAMP
)
--Criando grupos de usuários
create group estagiario;
create group analista;
create group gerente;

--Removendo todos privilégios de todos os grupos
revoke all on SCHEMA anaisa from estagiario;
revoke all on SCHEMA anaisa from analista;
revoke all on SCHEMA anaisa from gerente;

--Atrubuindo privilégios especificos para cada grupo
grant select on anaisa.trabalho to group estagiario;
grant select, update, insert on anaisa.trabalho to group analista;
grant all on SCHEMA anaisa to group gerente;
