-- ====================================================================
-- ETAPA 2 - IMPLEMENTAÇÃO FÍSICA: SCRIPT DDL (CRIAÇÃO)
-- SISTEMA: FITCONTROL
-- ALUNO: ARTHUR BARROS DE QUEIROZ
-- ====================================================================

-- 1. Criação da tabela PLANO (Sem dependências)
CREATE TABLE PLANO (
    id_plano INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    valor DECIMAL(6,2) NOT NULL,
    CONSTRAINT PK_PLANO PRIMARY KEY (id_plano)
);

-- 2. Criação da tabela INSTRUTOR (Sem dependências)
CREATE TABLE INSTRUTOR (
    id_instrutor INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    especialidade VARCHAR(50),
    CONSTRAINT PK_INSTRUTOR PRIMARY KEY (id_instrutor)
);

-- 3. Criação da tabela EXERCICIO (Sem dependências)
CREATE TABLE EXERCICIO (
    id_exercicio INT NOT NULL,
    nome_exercicio VARCHAR(100) NOT NULL,
    grupo_muscular VARCHAR(50) NOT NULL,
    CONSTRAINT PK_EXERCICIO PRIMARY KEY (id_exercicio)
);

-- 4. Criação da tabela ALUNO (Depende de PLANO)
CREATE TABLE ALUNO (
    id_aluno INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    data_ultima_mensalidade DATE,
    id_plano INT,
    CONSTRAINT PK_ALUNO PRIMARY KEY (id_aluno),
    CONSTRAINT UN_ALUNO_CPF UNIQUE (cpf),
    CONSTRAINT FK_ALUNO_PLANO FOREIGN KEY (id_plano) 
        REFERENCES PLANO(id_plano) ON DELETE SET NULL
);

-- 5. Criação da tabela TREINO (Depende de ALUNO e INSTRUTOR)
CREATE TABLE TREINO (
    id_treino INT NOT NULL,
    nome_treino VARCHAR(50) NOT NULL,
    data_criacao DATE NOT NULL,
    id_aluno INT NOT NULL,
    id_instrutor INT NOT NULL,
    CONSTRAINT PK_TREINO PRIMARY KEY (id_treino),
    CONSTRAINT FK_TREINO_ALUNO FOREIGN KEY (id_aluno) 
        REFERENCES ALUNO(id_aluno) ON DELETE CASCADE,
    CONSTRAINT FK_TREINO_INSTRUTOR FOREIGN KEY (id_instrutor) 
        REFERENCES INSTRUTOR(id_instrutor) ON DELETE RESTRICT
);

-- 6. Criação da tabela TREINO_EXERCICIO (Tabela intermediária N:M)
CREATE TABLE TREINO_EXERCICIO (
    id_treino INT NOT NULL,
    id_exercicio INT NOT NULL,
    series INT NOT NULL,
    repeticoes INT NOT NULL,
    carga INT NOT NULL,
    CONSTRAINT PK_TREINO_EXERCICIO PRIMARY KEY (id_treino, id_exercicio),
    CONSTRAINT FK_TE_TREINO FOREIGN KEY (id_treino) 
        REFERENCES TREINO(id_treino) ON DELETE CASCADE,
    CONSTRAINT FK_TE_EXERCICIO FOREIGN KEY (id_exercicio) 
        REFERENCES EXERCICIO(id_exercicio) ON DELETE RESTRICT
);
