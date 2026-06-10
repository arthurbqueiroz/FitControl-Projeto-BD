-- ====================================================================
-- PARTE 1: AUTOMAÇÃO COM TRIGGER 
-- ====================================================================
 
-- Cenário: Sempre que um aluno tiver a "data_ultima_mensalidade" atualizada,
-- o sistema registra automaticamente essa alteração em uma tabela de auditoria,
-- garantindo rastreabilidade de todos os pagamentos realizados.
 
-- 1.1. Criação da tabela de suporte para auditoria de histórico de renovações
CREATE TABLE LOG_RENOVACAO_ALUNO (
    id_log                SERIAL      NOT NULL,
    id_aluno              INT         NOT NULL,
    data_alteracao        TIMESTAMP   NOT NULL,
    usuario_sistema       VARCHAR(50) NOT NULL,
    antiga_data_pagamento DATE,
    nova_data_pagamento   DATE,
    CONSTRAINT PK_LOG_RENOVACAO PRIMARY KEY (id_log)
);
 
 
-- 1.2. Criação da função que será executada pelo Trigger
CREATE OR REPLACE FUNCTION fn_auditoria_pagamento_aluno()
RETURNS TRIGGER AS $$
BEGIN
    -- Dispara o log somente quando a data de pagamento foi de fato alterada
    IF NOT (OLD.data_ultima_mensalidade IS NOT DISTINCT FROM NEW.data_ultima_mensalidade) THEN
        INSERT INTO LOG_RENOVACAO_ALUNO (
            id_aluno,
            data_alteracao,
            usuario_sistema,
            antiga_data_pagamento,
            nova_data_pagamento
        ) VALUES (
            NEW.id_aluno,
            NOW(),
            CURRENT_USER,
            OLD.data_ultima_mensalidade,
            NEW.data_ultima_mensalidade
        );
    END IF;
 
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
 
 
-- 1.3. Criação do Trigger de Auditoria de Dados
CREATE TRIGGER TRG_AUDITORIA_PAGAMENTO_ALUNO
AFTER UPDATE ON ALUNO
FOR EACH ROW
EXECUTE FUNCTION fn_auditoria_pagamento_aluno();
 
 
-- ====================================================================
-- PARTE 2: CONTROLE DE TRANSAÇÕES (CENÁRIOS REAIS DE NEGÓCIO)
-- ====================================================================
 
-- --------------------------------------------------------------------
-- CENÁRIO A: Transação com Sucesso (COMMIT completo)
-- Contexto: Matrícula em lote de um novo Aluno com atribuição imediata de Treino.
-- Ambas as operações precisam ser atômicas: ou as duas salvam, ou nenhuma salva.
-- --------------------------------------------------------------------
 
BEGIN;
 
    -- 1. Cadastra um novo aluno de forma íntegra
    INSERT INTO ALUNO (id_aluno, nome, cpf, data_ultima_mensalidade, id_plano)
    VALUES (100, 'Arthur Teste Commit', '00011122233', '2026-06-10', 1);
 
    -- 2. Vincula uma ficha de treino inicial a esse aluno no mesmo instante
    INSERT INTO TREINO (id_treino, nome_treino, data_criacao, id_aluno, id_instrutor)
    VALUES (200, 'Treino A - Adaptação', '2026-06-10', 100, 10);
 
-- 3. Ambas as operações ocorreram sem falhas: consolida os dados permanentemente
COMMIT;
 
 
-- --------------------------------------------------------------------
-- CENÁRIO B: Cenário de Erro com Inconsistência (ROLLBACK explícito)
-- Contexto: Tentativa de inserção que viola integridade referencial.
-- O ROLLBACK desfaz todo o bloco, garantindo que nenhum dado parcial seja salvo.
-- --------------------------------------------------------------------
 
BEGIN;
 
    -- 1. Inserção aparentemente válida
    INSERT INTO ALUNO (id_aluno, nome, cpf, data_ultima_mensalidade, id_plano)
    VALUES (101, 'Aluno Erro Rollback', '00099988877', '2026-06-10', 1);
 
    -- 2. ERRO PROPOSITAL: instrutor de id 999 não existe na tabela INSTRUTOR.
    --    Isso viola a FK_TREINO_INSTRUTOR e coloca a transação em estado de erro.
    INSERT INTO TREINO (id_treino, nome_treino, data_criacao, id_aluno, id_instrutor)
    VALUES (201, 'Treino Invalido', '2026-06-10', 101, 999);
 
-- 3. ROLLBACK desfaz TODO o bloco, inclusive o Aluno 101 inserido no passo 1.
ROLLBACK;
 
 
-- --------------------------------------------------------------------
-- CENÁRIO C: Simulação Operacional de Rollback de Segurança Manual
-- Contexto: Exclusão acidental em massa de registros críticos sem cláusula WHERE.
-- O ROLLBACK recupera todos os dados do estado anterior ao DELETE.
-- --------------------------------------------------------------------
 
BEGIN;
 
    -- Simulação de erro operacional grave: DELETE sem WHERE apaga todos os planos
    DELETE FROM PLANO;
 
    -- Auditoria identifica o erro antes do COMMIT: transação revertida com segurança
    ROLLBACK;
 
 
-- ====================================================================
-- PARTE 3: CONSULTAS DE VALIDAÇÃO DOS CENÁRIOS
-- ====================================================================
 
-- Consulta 1: Prova que o Aluno 100 (Cenário A - COMMIT) foi salvo corretamente
SELECT * FROM ALUNO WHERE id_aluno = 100;
 
-- Consulta 2: Prova que o Aluno 101 (Cenário B - ROLLBACK) NÃO existe no banco
SELECT * FROM ALUNO WHERE id_aluno = 101;
 
-- Consulta 3: Prova que a tabela PLANO permaneceu intacta após o Rollback do Cenário C
SELECT * FROM PLANO;
 
-- Consulta 4: Visualiza o log de auditoria gerado pelo Trigger
-- UPDATE ALUNO SET data_ultima_mensalidade = '2026-07-10' WHERE id_aluno = 100;
SELECT * FROM LOG_RENOVACAO_ALUNO;
