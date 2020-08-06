--quantidade de cidades no Brasil
create or replace function cidadesBrasil()
returns integer as
$$
	declare
		cidades integer;
	begin
		select count(localidade) into cidades from localidades;
		return cidades;
	end
$$
Language plpgsql;

select cidadesBrasil()

-- quantidade de cidades em MG
create or replace function numeroMG()
returns integer as
$$
	declare
		cidades integer;
	begin
		select count(localidade) into cidades from localidades where estado='MG' ;
		return cidades;
	end
$$
Language plpgsql;

select numeroMG()

-- cidades de MG
create or replace function cidadesMG() returns table(localidades varchar) as
$$	
	begin
		return query
		select localidade from localidades where estado='MG' ;		
	end
$$
Language plpgsql;

select cidadesMG()

-- ruas de Uberlândia
create or replace function ruasUberlandia() returns setof logradouros as
$$
	begin
		return query
		select * from logradouros where localidade = (select codigo from localidades where localidade ='Uberlândia') and tipo ='Rua';
	end
$$
Language plpgsql;

select ruasUberlandia()

drop function alterar
--inserir, alterar e remover registros da tabela de localidades
create or replace function alterar(op char, cidades varchar(50), estados char(2), codigos integer) 
returns varchar as
$$
	begin
		if(op='i') Then
			insert into localidades values(((select max(codigo) from localidades)+1),cidades,estados);
			return 'inserido';
		elsif(op='u') Then
			update localidades SET localidade=cidades, estado=estados where codigo = codigos;
			return 'alterado';
		elsif(op='d') Then
			delete from localidades where localidade=cidades;
			return 'deletado';
		end if;
	end
$$
Language plpgsql;

select alterar('i','aaa','MG',0)
select alterar('u','bbb','MG',(select max(codigo) from localidades))
select alterar('d','bbb','MG',0)	

--trigger responsável pela auditoria das informações da tabela de localidades
create table localidades_auditoria
(
 operacao char not null,
 usuario varchar not null,
 dt_hr timestamp not null,
 codigo integer not null,
 localidade varchar(50),
 estado char(2)
)

create or replace function auditoria()
returns trigger as
$$
	begin
		if(tg_op = 'DELETE') Then
			insert into localidades_auditoria
			select 'D', user, now(), OLD.*;
			return OLD;
		elsif (tg_op = 'UPDATE') then
			insert into localidades_auditoria
			select 'U', user, now(), new.*;
			return new;
		elsif (tg_op = 'INSERT') then
			insert into localidades_auditoria
			select 'I', user, now(), new.*;
			return new;
		end if;
		return null;
	end
$$
language plpgsql;

create trigger tgauditoria
after insert or update or delete on localidades
for each row execute procedure auditoria();

select * from localidades_auditoria
