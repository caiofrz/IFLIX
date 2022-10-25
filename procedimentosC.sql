-- View que armazena as principais infos sobre os usuários escondendo o cpf e data de nascimento
CREATE VIEW vw_infos_clientes AS 
SELECT (id, nome, email, telefone)
FROM cliente;

SELECT * FROM vw_infos_clientes;


-- View que armazena as locacoes de junho/2022
CREATE VIEW vw_locacoes_junho AS
SELECT (id, data_inicio, data_fim, valor, cliente_id)
FROM locacao
WHERE data_inicio >= "2022-06-01" AND data_fim <= "2022-06-30";

SELECT * FROM vw_locacoes_junho;


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