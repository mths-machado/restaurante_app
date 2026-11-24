# Restaurante App

Aplicativo feito em Flutter para cadastro de pratos de um restaurante, desenvolvido para a prova P3 da disciplina de Tecnologia de Construção de Software I na PUC Goiás.

## O que o app faz

- **Listagem**: mostra os pratos cadastrados em cards (o app já inicia com um exemplo na lista e exibe uma mensagem quando ela está vazia).
- **Cadastro**: pelo botão `+`, abre o formulário para adicionar um novo prato com os campos *Prato*, *Categoria* e *Ingrediente principal*.
- **Edição**: ao tocar em um prato da lista, abre a mesma tela de formulário já preenchida e atualiza o item na mesma posição.
- **Exclusão**: cada item tem um botão de lixeira que pede confirmação antes de remover o prato da lista.
- **Validação**: impede salvar se algum campo estiver vazio ou só com espaços, e remove espaços extras no início e no fim do texto ao salvar.

## Como rodar

1. Instale o [Flutter](https://docs.flutter.dev/get-started/install) na sua máquina.
2. Clone este repositório e entre na pasta do projeto:
   ```bash
   git clone <url-do-repositorio>
   cd restaurante_app
   ```
3. Baixe as dependências:
   ```bash
   flutter pub get
   ```
4. Execute no Chrome:
   ```bash
   flutter run -d chrome
   ```

## Estrutura do projeto

- `lib/main.dart`: ponto de entrada do app e tela inicial (`HomePage`) com a lista de pratos, abertura do cadastro/edição e diálogo de exclusão.
- `lib/prato.dart`: classe `Prato` com os campos `prato`, `categoria` e `ingrediente`.
- `lib/form_page.dart`: tela de formulário (`FormPage`) usada tanto para cadastrar quanto para editar um prato, com validação dos campos.

## Decisões

- **Lista em memória**: os pratos ficam guardados em uma lista dentro do estado da tela inicial, sem banco de dados, então os dados somem ao fechar o app.
- **Estado com `StatefulWidget` e `setState`**: como o app é pequeno, o gerenciamento de estado foi feito direto com `setState`, sem bibliotecas extras.
- **Navegação com `Navigator`**: a troca entre a lista e o formulário usa `Navigator.push` e `Navigator.pop` retornando o objeto `Prato`.

## Autor

Matheus Machado.
