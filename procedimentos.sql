----------- VIEW -------------

-- A VIEW vai conter os filmes que foram alugados entre 2021 até a data atual 
create view vw_filme_alugado_data as
select f.nome as filme, l.data_inicio as data_locação from locacao l 
inner join locacao_filme lf on l.id = lf.locacao_id
inner join filme f on lf.filme_id = f.id
where l.data_inicio between ('2021-01-01') and (curdate())
order by f.nome;

SELECT * FROM vw_filme_alugado_data;

---------------------------------------------------------------

-- View que armazena as principais infos sobre os usuários escondendo o cpf e data de nascimento
CREATE VIEW vw_infos_clientes AS 
SELECT (id, nome, email, telefone)
FROM cliente;

SELECT * FROM vw_infos_clientes;
---------------------------------------------------------------

-- A VIEW contém o nome dos clientes o nome do filme alugado e o valor unitário de cada filme.
create view vw_filmes_alugados_clientes as
select c.nome as cliente, f.nome as filme, f.preco_locacao as preco_un
from cliente c inner join locacao l on c.id = l.cliente_id
inner join locacao_filme lf on l.id = lf.locacao_id 
inner join filme f on lf.filme_id = f.id
order by c.nome;

SELECT * FROM vw_filmes_alugados_clientes;
---------------------------------------------------------------

-- A VIEW contém o nome dos clientes o nome do serie alugada e o valor unitário de cada serie.
create view vw_series_alugadas_clientes as
select c.nome as cliente, f.nome as serie, f.preco_locacao as preço_un
from cliente c inner join locacao l on c.id = l.cliente_id
inner join locacao_filme lf on l.id = lf.locacao_id 
inner join serie f on lf.filme_id = f.id
order by c.nome;

SELECT * FROM vw_series_alugadas_clientes;




--------------- TRIGGER -------------------------

-- -----------------------------------------------------------------------------------------------
delimiter $
create trigger tgg_historico_filme 
before delete on filme
for each row
begin
	insert into historicoF_S
    set acao = 'Delete',
    id_filme = old.id,
	nome = old.nome,
    ano = old.ano,
    classificacao = old.classificacao,
    preco_locacao = old.preco_locacao,
    produtora = old.produtora_id,
    genero = old.genero_id,
    data_modificacao = now();
end $
delimiter ;

-- -------------------------------------------------------------------------------------------------
delimiter $
create trigger tgg_historico_serie
before delete on serie
for each row
begin
	insert into historicoF_S
    set acao = 'Delete',
    id_serie = old.id,
	nome = old.nome,
    ano = old.ano,
    classificacao = old.classificacao,
    preco_locacao = old.preco_locacao,
    num_tem = old.num_temp,
    produtora = old.produtora_id,
    genero = old.genero_id,
    data_modificacao = now();
end $
delimiter ;

-- -------------------------------------------------------------------------------------------------
delimiter $
create trigger tgg_historico_serieUp
before update on serie
for each row
begin
	insert into historicoF_S
    set acao = 'Update',
    id_serie = old.id,
	nome = old.nome,
    ano = old.ano,
    classificacao = old.classificacao,
    preco_locacao = old.preco_locacao,
    num_tem = old.num_temp,
    produtora = old.produtora_id,
    genero = old.genero_id,
    data_modificacao = now();
end $
delimiter ;

-- -------------------------------------------------------------------------------------------------
delimiter $
create trigger tgg_historico_filmeUp
before update on filme
for each row
begin
	insert into historicoF_S
    set acao = 'Update',
    id_filme = old.id,
	nome = old.nome,
    ano = old.ano,
    classificacao = old.classificacao,
    preco_locacao = old.preco_locacao,
    produtora = old.produtora_id,
    genero = old.genero_id,
    data_modificacao = now();
end $
delimiter ;

------------------------------------------------------------------------------------------------------


---------------------- STORED PROCEDURES --------------------

-- Procedure que exibe o histórico de locação de um cliente esécífico
DELIMITER $
CREATE PROCEDURE sp_historico_cliente(in nome_cliente VARCHAR(45))
BEGIN
	select c.nome as cliente, count(l.id) as qt_locaçâo, l.valor as valor_total 
	from cliente c left join locacao l on c.id = l.cliente_id
    where c.nome = nome_cliente
	group by c.nome;
    
END $
DELIMITER ;

CALL sp_historico_cliente("Ruan Ian Moura");

---------------------------------------------------------------

-- Procedure para cadastrar locações 
-- Opção(1. Filme, 2.Serie), id da locação, id do cliente, id do filme, id da serie

delimiter $
create procedure sp_inserir_locacao(in opcao int, in id_locacao int, in id_cliente int, in id_filme int, in id_serie int)
begin
	declare vl_filme decimal(5,2);
    declare vl_serie decimal(5,2);
    declare vl decimal(5,2);
	insert into locacao values(id_locacao, curdate(), adddate(curdate(), 30), 00.00, id_cliente);
    select preco_locacao into vl_filme from filme where id = id_filme;
    select preco_locacao into vl_serie from serie where id = id_serie;
    select valor into vl from locacao where cliente_id = id_cliente group by cliente_id;
    
    if(opcao = 1) then -- FILME
		insert into locacao_filme values(id_locacao, id_filme);
        update locacao l set l.valor = vl + vl_filme where cliente_id = id_cliente;
	end if ;
	if(opcao = 2) then -- SÉRIE
		insert into locacao_serie values(id_locacao, id_serie);
        update locacao l set l.valor = vl + vl_serie where cliente_id = id_cliente;
	end if; 
end $
delimiter ;

CALL sp_inserir_locacao();
-- -----------------------------------------------------------------------------------------------------

-- Procedure que retorna filmes e series com valor de aluguel >= ao passado como parametro 
DELIMITER $
CREATE PROCEDURE retorna_fs_com_preco_maiorigual(IN preco DECIMAL(15,2))
BEGIN 
    SELECT nome AS Filme, preco_locacao AS preco
    FROM filme
    WHERE preco_locacao >= preco;
    
    SELECT nome AS Serie , preco_locacao AS preco
    FROM serie
    WHERE preco_locacao >= preco;
END $
DELIMITER ;

CALL retorna_fs_com_preco_maiorigual();
--------------------------------------------------------------------------------------------

-- Procedure que retorna filmes e series com valor de aluguel <= ao passado como parametro 
DELIMITER $
CREATE PROCEDURE retorna_fs_com_preco_menorigual(IN preco DECIMAL(15,2))
BEGIN 
    SELECT nome AS Filme, preco_locacao AS preco
    FROM filme
    WHERE preco_locacao <= preco;
    
    SELECT nome AS Serie , preco_locacao AS preco
    FROM serie
    WHERE preco_locacao <= preco;
END $
DELIMITER ;
-----------------------------------------------------------------------------------------------


---------------------- FUNÇÕES --------------------

-- Função que verifica a frequencia de locação de um usuáro
DELIMITER $
CREATE FUNCTION verificar_frequencia_locacao(id INT) RETURNS VARCHAR(255)
BEGIN
    DECLARE qtd_locacao INT;

    SELECT COUNT(c.cliente_id) INTO qtd_locacao FROM cliente c 
    INNER JOIN locacao l ON c.cliente_id = l.cliente_id;

    IF qtd_locacao <= 15 THEN
        RETURN (SELECT CONCAT("Esse usuário não é recorrente!"));
    ELSE
        RETURN (SELECT CONCAT("Esse usuário faz alugueis periodicamente!"));
    END IF;
END $
DELIMITER ;
---------------------------------------------------------------

