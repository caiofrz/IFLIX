-- TRIGGER que atualiza o valor da locação de um filme, na tabela de locação
DELIMITER $
CREATE TRIGGER atualiza_valor_locacao_filme AFTER INSERT
ON locacao_filme
FOR EACH ROW
BEGIN
    UPDATE locacao AS l, locacao_filme AS lf, filme as f
    SET l.valor = l.valor + f.preco_locacao
    WHERE l.id = lf.locacao_id
    AND lf.filme_id = f.id;
END $
DELIMITER ;

--------------------------------------------------------------------------------------------

-- TRIGGER que atualiza o valor da locação de uma serie, na tabela de locação
DELIMITER $
CREATE TRIGGER atualiza_valor_locacao_serie AFTER INSERT
ON locacao_serie
FOR EACH ROW
BEGIN
    UPDATE locacao AS l, locacao_serie AS ls, serie as s
    SET l.valor = l.valor + s.preco_locacao
    WHERE l.id = ls.locacao_id
    AND ls.serie_id = s.id;
END $
DELIMITER ;
--------------------------------------------------------------------------------------------

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