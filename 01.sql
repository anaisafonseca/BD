--Crianda tabela do cliente
CREATE TABLE tb_cliente (
    id_cliente  INTEGER,
    titulo      CHAR(4),
    nome        VARCHAR(32) CONSTRAINT nn_nome      NOT NULL,
    sobrenome   VARCHAR(32) CONSTRAINT nn_sobrenome NOT NULL,
    endereco    VARCHAR(62) CONSTRAINT nn_endereco  NOT NULL,
    numero      VARCHAR(5)  CONSTRAINT nn_numero    NOT NULL,
    complemento VARCHAR(62),
    cep         VARCHAR(10),
    cidade      VARCHAR(62) CONSTRAINT nn_cidade     NOT NULL,
    estado      CHAR(2)     CONSTRAINT nn_estado     NOT NULL,
    fone_fixo   VARCHAR(15) CONSTRAINT nn_fone_fixo  NOT NULL,
    fone_movel  VARCHAR(15) CONSTRAINT nn_fone_movel NOT NULL,
    fg_ativo    INTEGER,
    CONSTRAINT pk_id_cliente PRIMARY KEY(id_cliente)
);
DROP TABLE tb_pedido
--Criando tabela do pedido
CREATE TABLE tb_pedido (
    id_pedido  INTEGER,
    id_cliente INTEGER CONSTRAINT nn_id_cliente NOT NULL,
    dt_compra  TIMESTAMP,
    dt_entrega TIMESTAMP,
    valor      NUMERIC(7,2),
    fg_ativo   INTEGER,
    CONSTRAINT pk_id_pedido PRIMARY KEY(id_pedido),
  CONSTRAINT uq_id_cliente UNIQUE(id_cliente),
    CONSTRAINT fk_ped_id_pedido FOREIGN KEY(id_cliente)
      REFERENCES tb_cliente(id_cliente)
);
--Criando tabela do item
CREATE TABLE tb_item (
 id_item   INTEGER CONSTRAINT nn_id_item NOT NULL,
 ds_item   VARCHAR(64) CONSTRAINT nn_ds_item NOT NULL,
 preco_custo  NUMERIC(7,2) CONSTRAINT nn_preco_custo NOT NULL,
 preco_venda  NUMERIC(7,2) CONSTRAINT nn_preco_venda NOT NULL,
 fg_ativo  INTEGER,
 CONSTRAINT pk_id_item PRIMARY KEY(id_item),
 CONSTRAINT pt_preco_custo CHECK(preco_custo>0),
 CONSTRAINT bg_preco_venda CHECK(preco_venda>preco_custo)
);
--Criando tabela de item pedido
CREATE TABLE tb_item_pedido (
 id_item   INTEGER,
 id_pedido  INTEGER,
 quantidade  INTEGER,
 CONSTRAINT pk_item_pedido PRIMARY KEY(id_item,id_pedido)
 CONSTRAINT fk_item FOREIGN KEY(id_item)
  REFERENCES tb_item(id_item),
 CONSTRAINT fk_pedido FOREIGN KEY(id_pedido)
  REFERENCES tb_pedido(id_pedido)
);
DROP TABLE tb_codigo_barras
--Criando tabela codigo de barra do item
CREATE TABLE tb_codigo_barras (
 codigo_barras  INTEGER CONSTRAINT nn_codigo_barras NOT NULL,
 id_item    INTEGER CONSTRAINT nn_id_item NOT NULL,
 CONSTRAINT fk_id_item FOREIGN KEY(id_item)
  REFERENCES tb_item(id_item),
 CONSTRAINT uq_id_item UNIQUE(id_item)
);
--Criando tabela do estoque
CREATE TABLE tb_estoque (
 id_item   INTEGER CONSTRAINT nn_id_item NOT NULL,
 quantidade  INTEGER CONSTRAINT nn_quantidade NOT NULL,
 FOREIGN KEY(id_item)
  REFERENCES tb_item(id_item)
);
--Selecionando tabela item
SELECT * FROM public.tb_item
--Inserindo valores na tabela item
INSERT INTO tb_item
VALUES(1,'Sorvete',1.99,4.99)
INSERT INTO tb_item
VALUES(2,'Morango',3.99,6.99)
--Selecionando tabela codigo de barras
SELECT * FROM public.tb_codigo_barras
--Inserindo codigo de barras do item
INSERT INTO tb_codigo_barras
VALUES(15423687,1)
INSERT INTO tb_codigo_barras
VALUES(15468589,2)
--Selecionando tabela estoque
SELECT * FROM public.tb_estoque
--Inserindo valores de estoque
INSERT INTO tb_estoque
VALUES(1,257)
INSERT INTO tb_estoque
VALUES(2,138)
--Selecionando tabela de clientes
SELECT * FROM public.tb_cliente
--Inserindo clientes
INSERT INTO tb_cliente
VALUES(1,'Sra','Bernadette','Galdino','Rua das Hortências','666','Casa','38400-003','Americana','SP','193521-4785','1999145-8752',1)
INSERT INTO tb_cliente
VALUES(2,'Sr','Geronimo','Parker','Avenida dos Tucanos','4985','Apartamento 31','38407-022','Rio de Janeiro','RJ','213158-9595','2199147-3636',1)
INSERT INTO tb_cliente
VALUES(3,'Sr','Claudete','Silva','Avanida das Dores','202','Casa',38405-008,'Pirenópolis','GO','623234-7665','6299598-2361',1)
--Selecionando tabela de pedido
SELECT * FROM public.tb_pedido
--Inserindo valores de pedido
INSERT INTO tb_pedido
VALUES(1,1,'24-07-2019','18-09-2019',70,1)
INSERT INTO tb_pedido
VALUES(2,2,'27-12-2019','12/02/2020',172.60,1)
INSERT INTO tb_pedido
VALUES(3,3,'19-03-2017 17:53:47','25/05/2017 15:42:10',452.53,1)
--Selecionando a tabela item/pedido
SELECT * FROM public.tb_item_pedido
--Inserindo na tabela item pedido
INSERT INTO tb_item_pedido
VALUES(1,1,10)
INSERT INTO tb_item_pedido
VALUES(2,3,600)