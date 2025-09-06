# Oficina Mecânica - Sistema de Banco de Dados

## 📌 Visão Geral do Projeto

Este projeto consiste na *modelagem, implementação e consultas de um banco de dados relacional* para uma oficina mecânica. Ele foi desenvolvido com o objetivo de gerenciar *clientes, veículos, mecânicos, equipes, serviços, peças e ordens de serviço*, permitindo um controle completo das operações da oficina.

O sistema simula o funcionamento real de uma oficina, incluindo a *persistência de dados, consultas complexas e geração de informações relevantes, como **valores totais de serviços e peças, **histórico de ordens de serviço* e *estatísticas de equipes e mecânicos*.

O código completo do Projeto se encontra no script.sql

---

## 🗂 Estrutura do Banco de Dados

O banco de dados possui as seguintes tabelas principais:

| Tabela                        | Descrição                                                                                  |
|--------------------------------|--------------------------------------------------------------------------------------------|
| *Cliente*                    | Armazena informações dos clientes, como nome, endereço, telefone e e-mail.                |
| *Veiculo*                     | Contém dados dos veículos, vinculados a um cliente.                                        |
| *Mecanico*                    | Cadastro dos mecânicos e suas especialidades.                                              |
| *Equipe*                      | Equipes de trabalho da oficina.                                                           |
| *Equipe_Mecanico*             | Relacionamento N:N entre equipes e mecânicos.                                             |
| *Ordem_Servico*               | Registro das ordens de serviço emitidas, com informações de veículo, equipe e status.     |
| *Servico*                      | Lista de serviços oferecidos pela oficina, incluindo valor da mão de obra.               |
| *OS_Servico*                   | Relação N:N entre ordens de serviço e serviços executados.                                |
| *Peca*                         | Cadastro de peças disponíveis na oficina.                                                |
| *OS_Peca*                      | Relação N:N entre ordens de serviço e peças utilizadas, incluindo quantidade e valor.     |
| *Tabela_Referencia_Mao_Obra*  | Tabela de referência para valores de mão de obra por tipo de serviço.                     |
| *Historico_OS*                 | Histórico de alterações de status das ordens de serviço.                                  |

---

## 🛠 Funcionalidades Implementadas

1. *Gerenciamento de Clientes e Veículos*  
   - Cadastro de clientes e seus veículos.  
   - Controle de informações pessoais e de contato.

2. *Gestão de Mecânicos e Equipes*  
   - Criação de equipes e associação de mecânicos a equipes.  
   - Especialidades dos mecânicos registradas para melhor alocação de tarefas.

3. *Controle de Ordens de Serviço*  
   - Registro de ordens de serviço com data de emissão e conclusão.  
   - Associação de serviços e peças utilizados.  
   - Cálculo de valores totais de cada ordem (mão de obra + peças).

4. *Histórico e Auditoria*  
   - Registro de mudanças de status das ordens de serviço para acompanhamento de processos.

5. *Consultas SQL Avançadas*  
   - Recuperações simples e filtradas com SELECT e WHERE.  
   - Atributos derivados, como o valor total de uma ordem.  
   - Ordenações (ORDER BY) e agrupamentos com filtros (HAVING).  
   - Junções complexas para gerar relatórios completos sobre clientes, veículos, ordens, serviços e peças.

---

## 💻 Como Utilizar

### 1. Configuração do Banco de Dados
1. Instale o MySQL em sua máquina.
2. Abra o MySQL Workbench ou seu terminal MySQL.
3. Copie e cole o script SQL do projeto (arquivo oficina.sql) para criar todas as tabelas e inserir dados de teste.

### 2. Consultas
O banco de dados já inclui *queries de exemplo*, como:  
- Listar clientes e contatos.  
- Consultar ordens de serviço em andamento.  
- Calcular o valor total de cada ordem de serviço.  
- Verificar equipes com mais de um mecânico.  
- Obter uma visão completa de clientes, veículos, serviços e peças em cada ordem.

---

## 🧩 Exemplo de Uso

*Calcular valor total de uma ordem de serviço:*
sql
SELECT o.Numero_OS,
       SUM(COALESCE(os.Valor,0) + COALESCE(op.Valor,0)) AS Valor_Total
FROM Ordem_Servico o
LEFT JOIN OS_Servico os ON o.ID_OS = os.ID_OS
LEFT JOIN OS_Peca op ON o.ID_OS = op.ID_OS
GROUP BY o.Numero_OS;
Listar clientes e veículos:

sql
Copiar código
SELECT c.Nome AS Cliente, v.Placa, v.Marca, v.Modelo
FROM Veiculo v
JOIN Cliente c ON v.ID_Cliente = c.ID_Cliente;

---

📊 Benefícios
Gestão completa de clientes, veículos e ordens de serviço.

Relatórios detalhados sobre serviços e peças utilizados.

Possibilidade de expansão futura para faturamento, agenda de serviços e relatórios estatísticos.

Estrutura clara e organizada, permitindo fácil manutenção e integração com sistemas externos.

---

📝 Tecnologias Utilizadas
MySQL: Banco de dados relacional.

SQL: Linguagem de consultas para criação, manipulação e consulta de dados.

GitHub: Repositório para versionamento e controle do projeto.
