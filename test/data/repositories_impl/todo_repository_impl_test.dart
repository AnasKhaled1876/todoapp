import 'package:flutter_test/flutter_test.dart';
import 'package:initiation_task/data/repositories_impl/todo.dart';
import 'package:initiation_task/domain/entities/todo.dart';
import 'package:mocktail/mocktail.dart';

// Import the mock and potentially its fallback registration if not already global
import '../../mocks/mock_hive_todo_data_source.dart';

void main() {
  // Register fallback values once for all tests in this file
  setUpAll(() {
    // Assuming Todo is a complex type used in method arguments for HiveTodoDataSource
    registerFallbackValue(Todo(key: 0, title: '', createdAt: DateTime.now()));
  });

  late MockHiveTodoDataSource mockHiveTodoDataSource;
  late TodoRepositoryImpl todoRepositoryImpl;

  setUp(() {
    mockHiveTodoDataSource = MockHiveTodoDataSource();
    todoRepositoryImpl = TodoRepositoryImpl(mockHiveTodoDataSource);
  });

  group('TodoRepositoryImpl', () {
    final tTodo = Todo(key: 1, title: 'Test Todo', createdAt: DateTime.now());
    final tTodoList = [tTodo];

    test('addTodo should call addTodo on the data source', () async {
      // Arrange
      // Use `any()` for the Todo argument if specific instance doesn't matter for the stub.
      when(() => mockHiveTodoDataSource.addTodo(any())).thenAnswer((_) async {});

      // Act
      await todoRepositoryImpl.addTodo(tTodo);

      // Assert
      verify(() => mockHiveTodoDataSource.addTodo(tTodo)).called(1);
    });

    test('deleteTodo should call deleteTodo on the data source', () async {
      // Arrange
      when(() => mockHiveTodoDataSource.deleteTodo(any())).thenAnswer((_) async {});

      // Act
      await todoRepositoryImpl.deleteTodo(tTodo.key);

      // Assert
      verify(() => mockHiveTodoDataSource.deleteTodo(tTodo.key)).called(1);
    });

    test('getTodos should call getTodos on the data source and return a list of todos', () async {
      // Arrange
      when(() => mockHiveTodoDataSource.getTodos()).thenAnswer((_) async => tTodoList);

      // Act
      final result = await todoRepositoryImpl.getTodos();

      // Assert
      expect(result, tTodoList);
      verify(() => mockHiveTodoDataSource.getTodos()).called(1);
    });

    test('toggleTodo should call toggleTodo on the data source', () async {
      // Arrange
      when(() => mockHiveTodoDataSource.toggleTodo(any())).thenAnswer((_) async {});

      // Act
      await todoRepositoryImpl.toggleTodo(tTodo.key);

      // Assert
      verify(() => mockHiveTodoDataSource.toggleTodo(tTodo.key)).called(1);
    });

    test('updateTodo should call updateTodo on the data source', () async {
      // Arrange
      // Use `any()` for key and Todo if specific instances don't matter for the stub.
      when(() => mockHiveTodoDataSource.updateTodo(any(), any())).thenAnswer((_) async {});

      // Act
      await todoRepositoryImpl.updateTodo(tTodo.key, tTodo);

      // Assert
      verify(() => mockHiveTodoDataSource.updateTodo(tTodo.key, tTodo)).called(1);
    });
  });
}
