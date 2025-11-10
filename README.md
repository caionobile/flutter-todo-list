# Lista de tarefas (To do list) ✅

Aplicação Flutter de lista de tarefas seguindo os princípios de Clean Architecture, Clean Code e SOLID, com testes unitários das principais funcionalidades.

## 📱 Sobre o projeto

### Funcionalidades

- Criação de tarefas
- Exclusão (ao pressionar e segurar a tarefa na listagem)
- Filtragem de tarefas baseada no estado

### Tecnologias utilizadas (packages)

- [**shared_preferences**](https://pub.dev/packages/shared_preferences): cache local
- [**equatable**](https://pub.dev/packages/equatable): comparação de objetos
- [**provider**](https://pub.dev/packages/provider): gerenciamento de estado
- [**mockito**](https://pub.dev/packages/mockito) e [**build_runner**](https://pub.dev/packages/build_runner): testes

## 🚀 Como executar o projeto

- Versão do Flutter: 3.35.x
- Versão do Dart: 3.9.x

```
// Limpa o cache e arquivos temporários (se necessário)
flutter clean

// Instala os packages
flutter pub get

// Executa
flutter run
```

## 🔎 Como rodar os testes

```
// Executa TODOS os testes
flutter test

// Executa testes com cobertura
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html

// Executa testes específicos (por pasta ou arquivo)
flutter test test/features/todo/domain/ 
flutter test test/features/todo/presentation/widgets/todo_list_test.dart
```
