# TraktAPI

## Pods

- **Kingfisher** (imagem com cache)
- **KIF** (testes de interface)
- **Nimble** (matcher para testes)

## Classes

### ViewController

Controller principal, que contem a lista de filmes.

### DetailViewController

Controle com os detalhes do filme.

### MovieManager

Classe que gerencia todo o processo de requests dos filmes e guarda esses objetos.

### NetworkRequest

Classe que faz as requisições de dados.

### Json

Classe que facilita a conversão dos dados em Json.

### Classes Extensions

Classes que contem as *extensions* para facilitar as chamadas e evitar muito boilerplate no código.

### MovieManagerTests

Classe com os testes unitários do Manager de filmes.

### NetworkRequestMock

Mock do *NetworkRequest* para fazer os testes.

### ViewControllerTests

Classe com os testes de Interface do app.
