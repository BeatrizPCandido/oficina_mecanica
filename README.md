# oficina_mecanica

# 🔧 OficinaDB

## 📌 Descrição
Projeto de banco de dados relacional para uma oficina mecânica, com modelagem lógica, criação de esquema SQL e consultas complexas.

## 🧠 Entidades e Regras
| Entidade       | Descrição                         | Regras de Negócio                          |
|----------------|-----------------------------------|--------------------------------------------|
| Cliente        | Proprietário de veículos          | Pode ter vários veículos                   |
| Veículo        | Carro/moto do cliente             | Pertence a um único cliente                |
| Funcionário    | Mecânico ou atendente             | Pode realizar vários serviços              |
| Serviço        | Tipo de serviço                   | Tem preço fixo                             |
| Ordem de Serviço| Registro de serviço realizado    | Relaciona cliente, veículo, funcionário    |
| Peça           | Item usado em serviços            | Pode ser usada em várias ordens            |
| Pagamento      | Forma de pagamento                | Pode ser Pix, cartão, dinheiro             |

## 🗂️ Estrutura
- `script-criacao.sql`
- `script-insercao.sql`
- `consultas.sql`
- `README.md`

## 🧪 Consultas
- Total de serviços por funcionário
- Clientes que gastaram mais de R$ 300
- Peças mais utilizadas

---

Se quiser, posso montar os arquivos `.sql` e o `README.md` completo para você colar no GitHub. Me diz como prefere seguir e vamos deixar esse projeto impecável! 💼✨
