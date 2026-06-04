-- RELATÓRIO 1: Visão Geral dos Alunos e Seus Respectivos Planos
-- Justificativa: Uso de INNER JOIN para auditoria administrativa de contratos ativos.
-- Atende a: RF07 (Consultar Alunos por Situação)
SELECT 
    A.id_aluno,
    A.nome AS nome_aluno,
    A.cpf,
    P.nome AS nome_plano,
    P.valor AS valor_mensalidade
FROM ALUNO A
INNER JOIN PLANO P ON A.id_plano = P.id_plano
ORDER BY A.nome;


-- RELATÓRIO 2: Fichas de Treino Detalhadas por Aluno e Instrutor Responsável
-- Justificativa: Uso de múltiplos INNER JOINs para reconstruir a estrutura de prescrição.
-- Atende a: RF06 (Prescrever Ficha de Treino)
SELECT 
    T.id_treino,
    A.nome AS nome_aluno,
    I.nome AS nome_instrutor,
    T.nome_treino,
    E.nome_exercicio,
    TE.series,
    TE.repeticoes,
    TE.carga
FROM TREINO T
INNER JOIN ALUNO A ON T.id_aluno = A.id_aluno
INNER JOIN INSTRUTOR I ON T.id_instrutor = I.id_instrutor
INNER JOIN TREINO_EXERCICIO TE ON T.id_treino = TE.id_treino
INNER JOIN EXERCICIO E ON TE.id_exercicio = E.id_exercicio
ORDER BY A.nome, T.nome_treino;


-- RELATÓRIO 3: Análise Financeira por Tipo de Plano (Faturamento Estimado)
-- Justificativa: Uso de Funções Agregadas (COUNT, SUM) e GROUP BY para métricas gerenciais.
SELECT 
    P.nome AS nome_plano,
    COUNT(A.id_aluno) AS total_alunos_matriculados,
    SUM(P.valor) AS faturamento_estimado_mensal
FROM PLANO P
INNER JOIN ALUNO A ON P.id_plano = A.id_plano
GROUP BY P.nome, P.valor
ORDER BY total_alunos_matriculados DESC;


-- RELATÓRIO 4: Instrutores Sobrecarregados (Mais de 2 Treinos Prescritos)
-- Justificativa: Uso de GROUP BY associado ao filtro de grupo HAVING e Função Agregada.
SELECT 
    I.id_instrutor,
    I.nome AS nome_instrutor,
    I.especialidade,
    COUNT(T.id_treino) AS total_treinos_prescritos
FROM INSTRUTOR I
INNER JOIN TREINO T ON I.id_instrutor = T.id_instrutor
GROUP BY I.id_instrutor, I.nome, I.especialidade
HAVING COUNT(T.id_treino) > 2
ORDER BY total_treinos_prescritos DESC;


-- RELATÓRIO 5: Alunos que Treinam Acima da Média de Carga Geral da Academia
-- Justificativa: Uso de Subquery no bloco WHERE associado a múltiplos JOINs e AVG.
SELECT DISTINCT
    A.nome AS nome_aluno,
    T.nome_treino,
    E.nome_exercicio,
    TE.carga
FROM ALUNO A
INNER JOIN TREINO T ON A.id_aluno = T.id_aluno
INNER JOIN TREINO_EXERCICIO TE ON T.id_treino = TE.id_treino
INNER JOIN EXERCICIO E ON TE.id_exercicio = E.id_exercicio
WHERE TE.carga > (SELECT AVG(carga) FROM TREINO_EXERCICIO)
ORDER BY TE.carga DESC;


-- CONSULTA 6: Identificação de Alunos Inadimplentes ou Sem Vínculo de Plano (Dados em Branco)
-- Justificativa: Uso de LEFT JOIN e filtragem IS NULL para capturar registros soltos no sistema.
SELECT 
    A.id_aluno,
    A.nome AS nome_aluno,
    A.cpf,
    A.data_ultima_mensalidade,
    A.id_plano
FROM ALUNO A
LEFT JOIN PLANO P ON A.id_plano = P.id_plano
WHERE A.id_plano IS NULL OR A.data_ultima_mensalidade IS NULL;


-- CONSULTA 7: Mapeamento de Planos Inconsistentes com Valores Negativos ou Zerados
-- Justificativa: Busca de erros de inserção lógica de regras de negócio.
SELECT 
    id_plano,
    nome AS nome_plano,
    valor
FROM PLANO
WHERE valor <= 0;


-- CONSULTA 8: Mapeamento de Instrutores Cadastrados Sem Especialidade
-- Justificativa: Filtro de campos obrigatórios não preenchidos na base de dados técnica.
SELECT 
    id_instrutor,
    nome AS nome_instrutor,
    especialidade
FROM INSTRUTOR
WHERE especialidade IS NULL;


-- CONSULTA 9: Identificação de Exercícios no Banco sem Uso Efetivo em Fichas
-- Justificativa: Uso de RIGHT JOIN para identificar lacunas no catálogo de exercícios.
SELECT 
    E.id_exercicio,
    E.nome_exercicio,
    E.grupo_muscular
FROM TREINO_EXERCICIO TE
RIGHT JOIN EXERCICIO E ON TE.id_exercicio = E.id_exercicio
WHERE TE.id_exercicio IS NULL;


-- CONSULTA 10: Auditoria de Treinos com Ficha Técnica Zerada (Séries ou Carga nulas/zeradas)
-- Justificativa: Validação de inconsistência operacional no módulo de prescrição.
SELECT 
    T.id_treino,
    T.nome_treino,
    E.nome_exercicio,
    TE.series,
    TE.repeticoes,
    TE.carga
FROM TREINO T
INNER JOIN TREINO_EXERCICIO TE ON T.id_treino = TE.id_treino
INNER JOIN EXERCICIO E ON TE.id_exercicio = E.id_exercicio
WHERE TE.series = 0 OR TE.repeticoes = 0;
