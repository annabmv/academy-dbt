# Adventure Works

Este repositório contém o projeto de dbt, desenvolvido para o Desafio Final de Dados, que é requisito para conclusão do Programa Lightouse by Indicium (2023.10).

## Avaliação

O objetivo desta certificação é avaliar suas competências em um projeto prático conforme a metodologia do Modern Analytics Stack, desenvolvida pela Indicium mas que guarda muitas semelhanças com o Modern Data Stack utilizado por milhares de times de dados modernos. A obtenção desta certificação indica que você:

- Entende o processo de construção de uma plataforma de analytics moderna;

- Entende os objetivos da modelagem dimensional em data warehouses modernos;

- Sabe aplicar a linguagem SQL e a ferramenta dbt para modelar dados em data warehouses modernos;

- Conhece as boas práticas de visualização de dados e sua aplicação em uma ferramenta de Self-Service BI;

- É capaz de desenvolver, validar e testar modelos e abordagens estatísticas mais adequadas para o problema de negócio.

## Descrição dos Dados

A Adventure Works possui um banco de dados transacional que armazena os dados de suas diferentes áreas. Esses dados estão distribuídos em 68 tabelas divididas em 5 schemas: HR (recursos humanos), Sales (vendas), Production (produção) e Purchasing (compras).

## Instruções

Todas as tabelas do banco fonte do SAP da Adventure Works serão carregadas como seeds pelo dbt. Os arquivos .csv com os dados já estão na pasta de seeds.

Para fazer o carregamento de todas as tabelas usem o comando:
- `dbt seed`

Para carregar uma tabela especifíca utilizem o comando
- `dbt seed -s nome_do_csv`

### Problemas comuns

Em caso a linha de comando do dbt fique com o status de estar sempre carregando, ou, o job do comando `dbt seed` fique rodando indefinitivamente mesmo após as 64 tabelas forem carregadas você precisará reiniciar o terminal. Para isso, clique nos três pontos no canto inferior direito ou no lado direito da linha de comando e escolha a opção `Restart IDE`.

## Requisitos de Entrega

Transformação de dados: esta etapa deve incluir documentação e testes de schema e pelo menos um teste de dados, e estar versionada em um repositório de código.

## Recursos:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [dbt community](http://community.getbdt.com/) to learn from other analytics engineers
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
