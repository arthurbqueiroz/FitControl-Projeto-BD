-- ====================================================================
-- ETAPA 2 - IMPLEMENTAÇÃO FÍSICA: SCRIPT DML (INSERÇÃO EXPANDIDA)
-- SISTEMA: FITCONTROL
-- EXIGÊNCIA: MÍNIMO 20 REGISTROS POR TABELA + DADOS INCORRETOS/VAZIOS
-- ====================================================================

-- --------------------------------------------------------------------
-- 1. TABELA: PLANO (3 Planos Oficiais + 17 Simulações/Inconsistências)
-- --------------------------------------------------------------------
INSERT INTO PLANO (id_plano, nome, valor) VALUES 
(1, 'Mensal Padrão', 119.90),
(2, 'Trimestral Bronze', 299.70),
(3, 'Anual Ouro', 999.00),
(4, 'Plano Semanal', 39.90),
(5, 'Plano Corporativo A', 89.90),
(6, 'Plano Corporativo B', 79.90),
(7, 'Plano Universitário', 69.90),
(8, 'Plano Senior', 59.90),
(9, 'Plano Black Promocional', 149.90),
(10, 'Plano Casal', 199.90),
(11, 'Plano Familiar (3 pessoas)', 279.90),
(12, 'Plano Off-Peak (Horário de Pouco Movimento)', 49.90),
(13, 'Plano Pilates Incluso', 189.90),
(14, 'Plano Lutas Incluso', 159.90),
(15, 'Plano Dança Incluso', 139.90),
(16, 'Plano Fim de Semana', 29.90),
(17, 'Plano Verão Antecipado', 450.00),
(18, 'Plano Fidelidade 2 Anos', 1500.00),
(19, 'Plano Gympass Basic', 0.00),
(20, 'Plano TotalPass Standard', 0.00),
-- DADOS INCORRETOS/VAZIOS SOLICITADOS PELO PROFESSOR PARA TESTES NA ETAPA 3:
(21, 'Plano Errado Valor Negativo', -50.00), -- Inconsistência: Valor negativo
(22, 'Plano Sem Nome ou Sem Custo Real', 0.01);

-- --------------------------------------------------------------------
-- 2. TABELA: INSTRUTOR (20 Instrutores Válidos + Inconsistências)
-- --------------------------------------------------------------------
INSERT INTO INSTRUTOR (id_instrutor, nome, specialty) VALUES 
(10, 'Rodrigo Silva', 'Musculação Hipertrofia'),
(20, 'Mariana Costa', 'Treinamento Funcional e Pilates'),
(30, 'Carlos Eduardo', 'Cárdio e Alta Performance'),
(40, 'Ana Beatriz Abreu', 'Crossfit e Core'),
(50, 'Fernando Souza', 'Danças e Ritmos'),
(60, 'Juliana Paes', 'Yoga e Alongamento'),
(70, 'Ricardo Oliveira', 'Boxe e Artes Marciais'),
(80, 'Patricia Pillar', 'Spinning / Ciclismo Indoor'),
(90, 'Marcelo Novaes', 'Avaliação Física'),
(100, 'Camila Pitanga', 'Musculação para Idosos'),
(110, 'Thiago Lacerda', 'Ergometria'),
(120, 'Giovanna Antonelli', 'Zumba Fitness'),
(130, 'Bruno Gagliasso', 'Calistenia'),
(140, 'Grazi Massafera', 'Nutrição Esportiva e Treino'),
(150, 'Reynaldo Gianecchini', 'Natação e Hidroginástica'),
(160, 'Taís Araújo', 'Mat Pilates'),
(170, 'Lázaro Ramos', 'Preparação Física para Atletas'),
(180, 'Paolla Oliveira', 'Ritmos e Funcional'),
(190, 'Mateus Solano', 'Ginástica Localizada'),
(200, 'Deborah Secco', 'Musculação Feminina Avançada'),
-- DADOS INCORRETOS/VAZIOS SOLICITADOS PELO PROFESSOR PARA TESTES NA ETAPA 3:
(210, 'Instrutor Sem Especialidade Definida', NULL); -- Inconsistência: Especialidade nula

-- --------------------------------------------------------------------
-- 3. TABELA: EXERCICIO (20 Exercícios Válidos + Inconsistências)
-- --------------------------------------------------------------------
INSERT INTO EXERCICIO (id_exercicio, nome_exercicio, grupo_muscular) VALUES 
(100, 'Supino Reto com Barra', 'Peito'),
(101, 'Agachamento Livre', 'Pernas'),
(102, 'Puxada Aberta no Pulley', 'Costas'),
(103, 'Desenvolvimento com Halteres', 'Ombros'),
(104, 'Rosca Direta', 'Braços'),
(105, 'Leg Press 45 Graus', 'Pernas'),
(106, 'Extensão de Pernas (Cadeira Extensora)', 'Pernas'),
(107, 'Flexão de Pernas (Mesa Flexora)', 'Pernas'),
(108, 'Crucifixo Reto com Halteres', 'Peito'),
(109, 'Remada Baixa Sentada', 'Costas'),
(110, 'Elevação Lateral', 'Ombros'),
(111, 'Tríceps Corda no Pulley', 'Braços'),
(112, 'Abdominal Infra', 'Abdômen'),
(113, 'Prancha Isométrica', 'Abdômen'),
(114, 'Levantamento Terra', 'Costas/Pernas'),
(115, 'Afundo com Halteres', 'Pernas'),
(116, 'Supino Inclinado com Halteres', 'Peito'),
(117, 'Remada Unilateral (Serrote)', 'Costas'),
(118, 'Rosca Concentrada', 'Braços'),
(119, 'Tríceps Testa com Barra W', 'Braços'),
-- DADOS INCORRETOS/VAZIOS SOLICITADOS PELO PROFESSOR PARA TESTES NA ETAPA 3:
(120, 'Exercício Fantasma Sem Grupo Muscular', 'Desconhecido'); -- Dado incorreto/vago

-- --------------------------------------------------------------------
-- 4. TABELA: ALUNO (20 Alunos Válidos + Inconsistências)
-- --------------------------------------------------------------------
INSERT INTO ALUNO (id_aluno, nome, cpf, data_ultima_mensalidade, id_plano) VALUES 
(1, 'Arthur Barros', '12345678901', '2026-05-10', 3),
(2, 'Beatriz Souza', '98765432100', '2026-05-15', 1),
(3, 'Carlos Henrique', '45678912344', '2026-04-20', 2),
(4, 'Daniela Mendes', '78912345655', '2026-05-01', 1),
(5, 'Eduardo Costa', '11122233344', '2026-05-25', 1),
(6, 'Fernanda Lima', '55566677788', '2026-03-10', 3),
(7, 'Gabriel Jesus', '99988877766', '2026-05-12', 2),
(8, 'Helena Roitman', '22233344455', '2026-05-14', 1),
(9, 'Igor Rodrigues', '44455566677', '2026-02-28', 1),
(10, 'Jessica Alba', '77788899900', '2026-05-18', 3),
(11, 'Klay Thompson', '88899900011', '2026-05-20', 2),
(12, 'Larissa Manoela', '33344455566', '2026-05-05', 1),
(13, 'Murilo Benício', '12312312312', '2026-01-15', 1),
(14, 'Natália Guimarães', '45645645645', '2026-05-22', 3),
(15, 'Otávio Augusto', '78978978978', '2026-05-24', 2),
(16, 'Paula Fernandes', '98798798798', '2026-04-01', 1),
(17, 'Quentin Tarantino', '65465465465', '2026-05-19', 3),
(18, 'Rafaela Silva', '32132132132', '2026-05-11', 1),
(19, 'Samuel Rosa', '15915915915', '2026-05-02', 2),
(20, 'Tatiana Weston', '75375375375', '2026-05-09', 1),
-- DADOS INCORRETOS/VAZIOS SOLICITADOS PELO PROFESSOR PARA TESTES NA ETAPA 3:
(21, 'Aluno Sem Plano Inadimplente', '85285285285', NULL, NULL), -- Inconsistência: Sem data de mensalidade e sem plano vinculado
(22, 'Aluno com Data de Mensalidade Futura Incorreta', '96396396396', '2030-12-31', 1);

-- --------------------------------------------------------------------
-- 5. TABELA: TREINO (20 Treinos Válidos + Inconsistências)
-- --------------------------------------------------------------------
INSERT INTO TREINO (id_treino, nome_treino, data_criacao, id_aluno, id_instrutor) VALUES 
(501, 'Treino A - Superior', '2026-05-11', 1, 10),
(502, 'Treino B - Inferior', '2026-05-11', 1, 10),
(503, 'Funcional Iniciante', '2026-05-16', 2, 20),
(504, 'Foco em Superiores', '2026-05-02', 4, 30),
(505, 'Hipertrofia Pernas', '2026-05-25', 5, 10),
(506, 'Treino C - Ombros', '2026-03-12', 6, 40),
(507, 'Cárdio Intenso', '2026-05-13', 7, 30),
(508, 'Yoga Matinal', '2026-05-15', 8, 60),
(509, 'Funcional Avançado', '2026-03-01', 9, 20),
(510, 'Força Máxima', '2026-05-19', 10, 130),
(511, 'Core e Abdômen', '2026-05-21', 11, 40),
(512, 'Alongamento Postural', '2026-05-06', 12, 60),
(513, 'Adaptação Máquinas', '2026-01-16', 13, 100),
(514, 'Definição Abdominal', '2026-05-23', 14, 200),
(515, 'Resistência Muscular', '2026-05-25', 15, 190),
(516, 'Circuito Queima Grasa', '2026-04-02', 16, 80),
(517, 'Preparação Postural', '2026-05-20', 17, 160),
(518, 'Artes Marciais - Técnico', '2026-05-12', 18, 70),
(519, 'Treino A - Costas e Bíceps', '2026-05-03', 19, 10),
(520, 'Treino B - Coxas e Panturrilhas', '2026-05-10', 20, 10),
-- DADOS INCORRETOS/VAZIOS SOLICITADOS PELO PROFESSOR PARA TESTES NA ETAPA 3:
(521, 'Treino Antigo Inconsistente', '1900-01-01', 3, 20); -- Inconsistência: Data de criação inválida para o cenário real

-- --------------------------------------------------------------------
-- 6. TABELA: TREINO_EXERCICIO (20 Vínculos Válidos + Inconsistências)
-- --------------------------------------------------------------------
INSERT INTO TREINO_EXERCICIO (id_treino, id_exercicio, series, repeticoes, carga) VALUES 
(501, 100, 4, 10, 50),
(501, 102, 4, 12, 45),
(501, 103, 3, 10, 14),
(502, 101, 4, 8, 80),
(502, 105, 4, 10, 120),
(503, 101, 3, 15, 20),
(503, 104, 3, 12, 10),
(504, 116, 4, 10, 18),
(504, 117, 4, 10, 22),
(505, 101, 4, 10, 60),
(505, 106, 3, 12, 40),
(506, 103, 4, 10, 12),
(506, 110, 3, 15, 8),
(507, 113, 3, 1, 0), -- 1 minuto de prancha (carga 0)
(508, 113, 4, 1, 0),
(509, 101, 4, 15, 30),
(510, 114, 5, 5, 140),
(511, 112, 4, 20, 0),
(512, 113, 3, 1, 0),
(513, 106, 3, 15, 25),
-- DADOS INCORRETOS/VAZIOS SOLICITADOS PELO PROFESSOR PARA TESTES NA ETAPA 3:
(514, 112, 0, 0, 0); -- Inconsistência: Séries e repetições zeradas para um exercício ativo
