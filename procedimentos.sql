----------- VIEW -------------

-- A VIEW vai conter os filmes que foram alugados entre 2021 até a data atual 
create view vw_filme_alugado_data as
select f.nome as filme, l.data_inicio as data_locação from locacao l 
inner join locacao_filme lf on l.id = lf.locacao_id
inner join filme f on lf.filme_id = f.id
where l.data_inicio between ('2021-01-01') and (curdate())
order by l.data_inicio;

SELECT * FROM vw_filme_alugado_data;

---------------------------------------------------------------

-- View que armazena as principais infos sobre os usuários escondendo o cpf e data de nascimento
CREATE VIEW vw_infos_clientes AS 
SELECT id, nome, email, telefone
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


-- --------------------------------------------------------------------------

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


---------------------- STORED PROCEDURES --------------------

-- Procedure que exibe o histórico de locação de um cliente esécífico
DELIMITER $
CREATE PROCEDURE sp_historico_cliente(in nome_cliente VARCHAR(45))
BEGIN
	select c.nome as cliente, count(lf.locacao_id) as qt_locaçâo, l.valor as valor_total 
	from cliente c inner join locacao l on c.id = l.cliente_id inner join locacao_filme lf 
	on lf.locacao_id = l.id
	where c.nome = nome_cliente;
    
END $
DELIMITER ;

CALL sp_historico_cliente("Ruan Ian Moura");

CALL sp_historico_cliente("Ruan Ian Moura");

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

CALL retorna_fs_com_preco_maiorigual(10.00);
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
CREATE FUNCTION verificar_frequencia_locacao(id INT) RETURNS VARCHAR(80) DETERMINISTIC
BEGIN
    DECLARE qtd_locacao INT;

    SELECT COUNT(l.cliente_id) INTO qtd_locacao FROM locacao l WHERE id = l.cliente_id;

    IF qtd_locacao < 10 THEN
        RETURN (SELECT CONCAT("Esse usuário não é recorrente!"));
    ELSE
        RETURN (SELECT CONCAT("Esse usuário faz alugueis periodicamente!"));
    END IF;
END $
DELIMITER ;
---------------------------------------------------------------

-- Função que verifica se o cliente está cadastrado no banco. 
DELIMITER $
CREATE FUNCTION verifica_se_esta_cadastrado(nomeCliente VARCHAR(45)) RETURNS VARCHAR(45) DETERMINISTIC
BEGIN 
    DECLARE estaCadastrado VARCHAR(45);

    SELECT nome INTO estaCadastrado
    FROM cliente
    WHERE nome = nomeCliente;

    IF estaCadastrado IS NULL THEN
        RETURN (SELECT CONCAT("Esse usuário não está cadastrado!"));
    ELSE
        RETURN (SELECT CONCAT("Esse usuário ", estaCadastrado, " está cadastrado!"));
    END IF;

END $
DELIMITER ;


