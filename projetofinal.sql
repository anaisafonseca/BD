--Criando a tabela de clientes
CREATE TABLE loja.tb_clientes(
	id_cliente		INTEGER  	CONSTRAINT nn_id_cliente NOT NULL,
	nome			VARCHAR(50) CONSTRAINT nn_nome 		 NOT NULL,
	cpf				VARCHAR(11)	CONSTRAINT nn_cpf  		 NOT NULL,
	endereco		VARCHAR(60),
	bairro			VARCHAR(30),
	cep				VARCHAR(9),
	cidade			VARCHAR(50) CONSTRAINT nn_cidade	 NOT NULL,
	UF				CHAR(2),
	telefone		VARCHAR(11) CONSTRAINT nn_telefone	 NOT NULL,
CONSTRAINT pk_id_cliente PRIMARY KEY(id_cliente)
);
--Comandos da tabela de clientes
DROP TABLE loja.tb_clientes
SELECT * FROM loja.tb_clientes

--Criando a tabela de vinis
CREATE TABLE loja.tb_vinis(
	id_vinil	INTEGER		   CONSTRAINT nn_id_vinil NOT NULL,
	vinil		VARCHAR(60)    CONSTRAINT nn_vinil    NOT NULL,
	artista 	VARCHAR(50),
	lancamento 	DATE,
	categoria	VARCHAR(25)    CONSTRAINT nn_genero   NOT NULL,
	valor		DECIMAL(10,2),
	estado		VARCHAR(5)	   CONSTRAINT nn_estado   NOT NULL,
	tp_uso		VARCHAR(20),
CONSTRAINT pk_id_vinil PRIMARY KEY(id_vinil)
);
--Comandos da tabela de vinis
DROP TABLE loja.tb_vinis
SELECT * FROM loja.tb_vinis


--Criando tabela de	pedidos 
CREATE	TABLE	loja.tb_pedidos( 
	id_pedido	INTEGER  CONSTRAINT	nn_id_pedido  NOT NULL, 
	id_cliente	INTEGER  CONSTRAINT	nn_id_cliente NOT NULL, 
	valor		DECIMAL(10,2),
CONSTRAINT	pk_id_pedido PRIMARY KEY(id_pedido),
CONSTRAINT	fk_ped_id_pedido FOREIGN KEY(id_cliente) 
	REFERENCES	loja.tb_clientes(id_cliente) 
);
--Comandos da tabela de pedidos
DROP TABLE loja.tb_pedidos
SELECT * FROM loja.tb_pedidos


--Criando a tabela de vinis por pedido
CREATE TABLE loja.tb_vpedido(
	id_pedido	INTEGER,
	id_vinil    INTEGER,
	qtd			INTEGER CONSTRAINT nn_qtd NOT NULL,
CONSTRAINT pk_vpedido PRIMARY KEY(id_vinil,id_pedido),
CONSTRAINT fk_vinil FOREIGN KEY(id_vinil)
	REFERENCES loja.tb_vinis(id_vinil),
CONSTRAINT fk_pedido FOREIGN KEY(id_pedido)
	REFERENCES loja.tb_pedidos(id_pedido)
);
--Comandos da tabela de pedidos
DROP TABLE loja.tb_vpedido
SELECT * FROM loja.tb_vpedido


--Criando a tabela de vendas
CREATE TABLE loja.tb_vendas(
	id_venda	INTEGER			CONSTRAINT nn_id_venda 	 NOT NULL,
	vendedor	VARCHAR(20)		CONSTRAINT nn_vendedor   NOT NULL,
	id_pedido       INTEGER,
	datavenda	DATE			CONSTRAINT nn_datacompra NOT NULL,
	pagamento 	VARCHAR(10)		CONSTRAINT nn_pagamento  NOT NULL,
	CONSTRAINT fk_id_pedido FOREIGN KEY(id_pedido)
		REFERENCES loja.tb_pedidos(id_pedido)
);
--Comandos da tabela de vendas
DROP TABLE loja.tb_vendas
SELECT * FROM loja.tb_vendas


--Inserindo dados nas tabelas
INSERT INTO loja.tb_clientes
VALUES (1, 'Paulo Forti', '85814657820', 'Rua Arthur Bernardes, 150, apt 1001', 'Martins', '38400368', 'Uberlândia', 'MG', '34984165092')
INSERT INTO loja.tb_clientes
VALUES (2, 'Helena Maria', '88200659720', 'Av. dos Vinhedos, 900, casa 45', 'Morada da Colina', '38411159', 'Uberlândia', 'MG', '34984146399')
INSERT INTO loja.tb_clientes
VALUES (3, 'Flavia Almeida', '04472188678', 'Rua Teixeira Santana, 161, apt 122', 'Fundinho', '38400196', 'Uberlândia', 'MG', '34984162627')
INSERT INTO loja.tb_clientes
VALUES (4, 'Daniel Mendes', '04366881667', 'Rua Teixeira Santana, 161, apt 122', 'Fundinho', '38400196', 'Uberlândia', 'MG', '34991178477')
INSERT INTO loja.tb_clientes
VALUES (5, 'Anariele Nascimento', '63983476620', 'Av. Marciano de Ávila, 659', 'Bom Jesus', '38400752', 'Uberlândia', 'MG', '34991955744')

INSERT INTO loja.tb_vinis
VALUES (1, 'AM', 'Arctic Monkeys', '09-09-2013', 'Indie Rock', 154.90, 'Novo')
INSERT INTO loja.tb_vinis
VALUES (2, 'Humbug', 'Arctic Monkeys', '20-08-2009', 'Indie Rock', 121.90, 'Usado', '3 anos')
INSERT INTO loja.tb_vinis
VALUES (3, 'Lady Lady', 'Masego', '07-09-2018', 'R&B', 136.90, 'Novo')
INSERT INTO loja.tb_vinis
VALUES (4, 'Starboy', 'The Weeknd', '25-11-2016', 'R&B', 143.90, 'Usado', '10 meses')
INSERT INTO loja.tb_vinis
VALUES (5, 'racine carrée', 'Stromae', '01-01-2013', 'Hip Hop', 104.90, 'Novo')
INSERT INTO loja.tb_vinis
VALUES (6, 'Vinicius de Moraes', 'Vinicius de Moraes', '01-01-1967', 'MPB', 169.90, 'Novo')

INSERT INTO loja.tb_pedidos
VALUES (1, 1, 306.80) --3,6
INSERT INTO loja.tb_pedidos
VALUES (2, 4, 298.80) --1,4
INSERT INTO loja.tb_pedidos
VALUES (3, 2, 209.80) --2x5
INSERT INTO loja.tb_pedidos
VALUES (4, 4, 258.80) --2,3

INSERT INTO loja.tb_vpedido
VALUES (1, 3, 1) --pedido 1, 3,6
INSERT INTO loja.tb_vpedido
VALUES (1, 6, 1) --pedido 1, 3,6
INSERT INTO loja.tb_vpedido
VALUES (2, 1, 1) --pedido 2, 1,4
INSERT INTO loja.tb_vpedido
VALUES (2, 4, 1) --pedido 2, 1,4
INSERT INTO loja.tb_vpedido
VALUES (3, 5, 2) --pedido 3, 2x5

INSERT INTO loja.tb_vendas
VALUES (1, 'Robert', 1, '05-12-2019', 'Débito')
INSERT INTO loja.tb_vendas
VALUES (2, 'Laura', 2, '05-12-2019', 'Dinheiro')
INSERT INTO loja.tb_vendas
VALUES (3, 'Jorge', 3, '06-12-2019', 'Dinheiro')


--Número de clientes cadastrados
create or replace function loja.nclientes()
returns integer as
$$
	declare      
		nclientes integer;    
	begin      
		select count(id_cliente) into nclientes from loja.tb_clientes;    
	return nclientes;    
	end 
$$ 
Language plpgsql;
drop function loja.nclientes()
select loja.nclientes()


--Número de vinis cadastrados
create or replace function loja.nvinis()
returns integer as
$$
	declare      
		nvinis integer;    
	begin      
		select count(id_vinil) into nvinis from loja.tb_vinis;    
	return nvinis;    
	end 
$$ 
Language plpgsql;
drop function loja.nvinis()
select loja.nvinis()


--Número de pedidos realizados
create or replace function loja.npedidos()
returns integer as
$$
	declare      
		npedidos integer;    
	begin      
		select count(id_pedido) into npedidos from loja.tb_pedidos;    
	return npedidos;    
	end 
$$ 
Language plpgsql;
drop function loja.npedidos()
select loja.npedidos()


--Número de vendas realizadas
create or replace function loja.nvendas()
returns integer as
$$
	declare      
		nvendas integer;    
	begin      
		select count(id_venda) into nvendas from loja.tb_vendas;    
	return nvendas;    
	end 
$$ 
Language plpgsql;
drop function loja.nvendas()
select loja.nvendas()


--Número de pedidos por cliente
CREATE OR REPLACE FUNCTION pedidoscliente(idcliente integer)
RETURNS integer as
$$
	declare
		pcliente integer;
	begin
    	SELECT count(id_pedido)
		into pcliente
    	FROM loja.tb_pedidos
    	WHERE id_cliente = idcliente;
	return pcliente;
	end
$$
Language plpgsql;
DROP FUNCTION pedidoscliente(idcliente integer)
SELECT pedidoscliente(1);
SELECT pedidoscliente(4);

SELECT 
    id_cliente, 
    COUNT(id_cliente)
FROM
    loja.tb_pedidos
GROUP BY id_cliente
ORDER BY id_cliente;


--Número de vinis por artista
CREATE OR REPLACE FUNCTION loja.vinisartista(nmartista varchar)
RETURNS varchar as
$$
	declare
		vartista varchar;
	begin
    	SELECT count(id_vinil)
		into vartista
    	FROM loja.tb_vinis
    	WHERE artista = nmartista;
	return vartista;
	end
$$
Language plpgsql;
DROP FUNCTION loja.vinisartista(nmartista varchar)
SELECT loja.vinisartista('Arctic Monkeys');
SELECT loja.vinisartista('Stromae');

SELECT 
    artista, 
    COUNT(artista)
FROM
    loja.tb_vinis
GROUP BY artista
ORDER BY artista;


--Informações de um cliente a partir de seu código (id_cliente)
CREATE OR REPLACE FUNCTION loja.infocliente(integer)
RETURNS varchar AS																				
$$
	DECLARE
    	infosc loja.tb_clientes%ROWTYPE;
    BEGIN
    	SELECT * INTO infosc FROM loja.tb_clientes WHERE id_cliente = $1;
        RETURN infosc;
    END
$$
LANGUAGE plpgsql;
drop function loja.infocliente(integer)
select loja.infocliente(1);
select loja.infocliente(4);


--Informações de um vinil a partir de seu código (id_vinil)
CREATE OR REPLACE FUNCTION loja.infovinil(integer)
RETURNS varchar AS																				
$$
	DECLARE
    	infosv loja.tb_vinis%ROWTYPE;
    BEGIN
    	SELECT * INTO infosv FROM loja.tb_vinis WHERE id_vinil = $1;
        RETURN infosv;
    END
$$
LANGUAGE plpgsql;
drop function loja.infovinil(integer)
select loja.infovinil(2);
select loja.infovinil(6);


--Informações de um pedido a partir de seu código (id_pedido)
CREATE OR REPLACE FUNCTION loja.infopedido(integer)
RETURNS varchar AS																				
$$
	DECLARE
    	infosp loja.tb_pedidos%ROWTYPE;
    BEGIN
    	SELECT * INTO infosp FROM loja.tb_pedidos WHERE id_pedido = $1;
        RETURN infosp;
    END
$$
LANGUAGE plpgsql; 
drop function loja.infopedido(integer)
select loja.infopedido(1);
select loja.infopedido(2);


--Informações de quantidade de vinil por pedido a partir de seu código   
CREATE OR REPLACE FUNCTION loja.infovpedido(integer)
RETURNS Setof record AS																				
'select * from loja.tb_vpedido v where v.id_pedido=$1'	
LANGUAGE sql; 
drop function loja.infovpedido(integer)
select loja.infovpedido(1);
select loja.infovpedido(3);


--Informações de uma venda a partir de seu código (id_venda)
CREATE OR REPLACE FUNCTION loja.infovenda(integer)
RETURNS varchar AS																				
$$
	DECLARE
    	infosv loja.tb_vendas%ROWTYPE;
    BEGIN
    	SELECT * INTO infosv FROM loja.tb_vendas WHERE id_venda = $1;
        RETURN infosv;
    END
$$
LANGUAGE plpgsql; 
drop function loja.infovenda(integer)
select loja.infovenda(2);
select loja.infovenda(3);


--Forma de pagamento de cada valor por pedido
select p.id_pedido, p.valor, it.pagamento
from loja.tb_pedidos p 
inner join loja.tb_vendas it on p.id_pedido = it.id_pedido


--Alteração na tabela de clientes
create or replace function loja.alterarc(
	op 				CHAR, 
	id_clientes		INTEGER,
	nomes			VARCHAR(50),
	cpfs			VARCHAR(11),
	enderecos		VARCHAR(60),
	bairros			VARCHAR(30),
	ceps			VARCHAR(9),
	cidades			VARCHAR(50),
	UFs				CHAR(2),
	telefones		VARCHAR(11))  
returns varchar as  
$$      
	begin
		if(op='i') Then
		insert into loja.tb_clientes values(((select max(id_cliente) from loja.tb_clientes)+1),id_clientes,nomes,
									  		cpfs, enderecos, bairros, ceps, cidades, UFs, telefones);
		return 'inserido';
		elsif(op='u') Then
		update loja.tb_clientes SET id_cliente=id_clientes, nome=nomes, cpf=cpfs, endereco=enderecos,
		bairro=bairros, cep=ceps, cidade=cidades, UF=UFs, telefone=telefones where id_cliente=id_clientes;
		return 'alterado';
		elsif(op='d') Then
		delete from loja.tb_clientes where id_cliente=id_clientes;
		return 'deletado';
		end if;
	end
$$
Language plpgsql;  


--Alteração na tabela de vinis
create or replace function loja.alterarv(
	op			CHAR,
	id_vinils	INTEGER,
	vinils		VARCHAR(60),
	artistas 	VARCHAR(50),
	lancamentos	DATE,
	categorias	VARCHAR(25),
	valors		DECIMAL(10,2),
	estados		VARCHAR(5),
	tp_usos		VARCHAR(20))
returns varchar as  
$$      
	begin
		if(op='i') Then
		insert into loja.tb_vinis values(((select max(id_vinil) from loja.tb_vinis)+1),vinils, artistas,
										 lancamentos, categorias, valors, estados, tp_usos);
		return 'inserido';
		elsif(op='u') Then
		update loja.tb_vinis SET id_vinil=id_vinils, vinil=vinils, artista=artistas, lancamento=lancamentos,
		categoria=categorias, valor=valors, estado=estados, tp_uso=tp_usos where id_vinil=id_vinils;
		return 'alterado';
		elsif(op='d') Then
		delete from loja.tb_vinis where id_vinil=id_vinils;
		return 'deletado';
		end if;
	end
$$
Language plpgsql;

	
--Alteração na tabela de pedidos
create or replace function loja.alterarp(
	op			CHAR,
	id_pedidos	INTEGER, 
	id_clientes	INTEGER, 
	valors		DECIMAL(10,2))
returns varchar as  
$$      
	begin
		if(op='i') Then
		insert into loja.tb_pedidos values(((select max(id_pedido) from loja.tb_pedidos)+1),id_clientes, valors);
		return 'inserido';
		elsif(op='u') Then
		update loja.tb_pedidos SET id_pedido=id_pedidos, id_cliente=id_clientes, valor=valors where id_pedido=id_pedidos;
		return 'alterado';
		elsif(op='d') Then
		delete from loja.tb_pedidos where id_pedido=id_pedidos;
		return 'deletado';
		end if;
	end
$$
Language plpgsql;

select loja.alterarp('i',0, 2, 52.50)
select loja.alterarp('i',0, 5, 25.60)
select loja.alterarp('u',6, 4, 152.25)
	
--Trigger da tabela de pedidos
create table loja.pedidos_auditoria(
	operacao 	varchar 		not null,      
	usuario 	varchar 	not null,      
	dt_hr 		timestamp 	not null,      
	codigo	 	integer 	not null,      
	id_cliente	varchar(50),      
	valor 		decimal(10,2)  
);
drop table loja.pedidos_auditoria
select * from loja.pedidos_auditoria
select * from loja.tb_pedidos
	
create or replace function pedidos_auditoria() 
returns trigger as  
$$
	begin
		if(tg_op = 'DELETE') Then
			insert into loja.pedidos_auditoria
			select 'D', user, now(), OLD.*;
		return OLD;        
		elsif (tg_op = 'UPDATE') Then            
			insert into loja.pedidos_auditoria            
			select 'U', user, now(), new.*;           
		return new;         
		elsif (tg_op = 'INSERT') Then            
			insert into loja.pedidos_auditoria
			select 'I', user, now(), new.*;            
		return new;         
		end if;   
		return null;      
	end  
$$  
Language plpgsql;    

create trigger tgauditoria
after insert or update or delete on loja.tb_pedidos  
for each row execute procedure pedidos_auditoria();    
 	
	
--Alteração na tabela de vendas
create or replace function alterarvd(
	id_vendas	INTEGER,
	vendedors	VARCHAR(20),
	id_pedidos  INTEGER,
	datavendas	DATE,
	pagamentos 	VARCHAR(10)
returns varchar as  
$$      
	begin
		if(op='i') Then
		insert into loja.tb_vendas values(((select max(id_venda) from loja.tb_vendas)+1), vendedors, id_pedidos, 
										  datavendas, pagamentos);
		return 'inserido';
		elsif(op='u') Then
		update loja.tb_vendas SET id_venda=id_vendas, vendedor=vendedors, id_pedido=id_pedidos, datavenda=datavendas,
		pagamento=pagamentos where id_pedido=id_pedidos;
		return 'alterado';
		elsif(op='d') Then
		delete from loja.tb_vendas where id_venda=id_vendas;
		return 'deletado';
		end if;
	end
$$
Language plpgsql;

