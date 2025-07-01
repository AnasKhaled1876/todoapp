import 'package:flutter_test/flutter_test.dart';
import 'package:initiation_task/data/repositories_impl/todo.dart';
import 'package:initiation_task/domain/entities/todo.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_todo_datasource.dart'; // Use the new MockTodoDataSource

void main() {
  setUpAll(() {
    // Register fallback value for the new Todo entity
    registerFallbackValue(Todo(title: 'fallback', isDone: false)..id = 0);
  });

  late MockTodoDataSource mockTodoDataSource; // Use the new mock
  late TodoRepositoryImpl todoRepositoryImpl;

  setUp(() {
    mockTodoDataSource = MockTodoDataSource();
    todoRepositoryImpl = TodoRepositoryImpl(
      mockTodoDataSource,
    ); // Inject the new mock
  });

  group('TodoRepositoryImpl', () {
    // Updated Todo entity, id will be auto-incremented or set if needed for specific tests
    final tTodo = Todo(title: 'Test Todo', isDone: false)..id = 1;
    final tTodoList = [tTodo];

    test('addTodo should call addTodo on the data source', () async {
      when(() => mockTodoDataSource.addTodo(any())).thenAnswer((_) async {});
      await todoRepositoryImpl.addTodo(tTodo);
      verify(() => mockTodoDataSource.addTodo(tTodo)).called(1);
    });

    test('deleteTodo should call deleteTodo on the data source', () async {
      when(() => mockTodoDataSource.deleteTodo(any())).thenAnswer((_) async {});
      await todoRepositoryImpl.deleteTodo(tTodo.id); // Use id
      verify(() => mockTodoDataSource.deleteTodo(tTodo.id)).called(1); // Use id
    });

    test(
      'getTodos should call getTodos on the data source and return a list of todos',
      () async {
        when(
          () => mockTodoDataSource.getTodos(),
        ).thenAnswer((_) async => tTodoList);
        final result = await todoRepositoryImpl.getTodos();
        expect(result, tTodoList);
        verify(() => mockTodoDataSource.getTodos()).called(1);
      },
    );

    test(
      'toggleTodo should get todo, toggle isDone, and update on the data source',
      () async {
        // Arrange
        final originalTodo = Todo(title: 'Test', isDone: false)..id = 1;

        // Mock getTodoById to return the original todo
        when(
          () => mockTodoDataSource.getTodoById(originalTodo.id),
        ).thenAnswer((_) async => originalTodo);
        // Mock updateTodo to complete successfully
        when(
          () => mockTodoDataSource.updateTodo(
            any(
              that: predicate<Todo>(
                (todo) =>
                    todo.id == originalTodo.id &&
                    todo.isDone == !originalTodo.isDone,
              ),
            ),
          ),
        ).thenAnswer((_) async {});

        // Act
        await todoRepositoryImpl.toggleTodo(originalTodo.id);

        // Assert
        verify(() => mockTodoDataSource.getTodoById(originalTodo.id)).called(1);
        // Verify that updateTodo was called with the toggled state.
        // We use a predicate to check the properties of the Todo passed to updateTodo.
        verify(
          () => mockTodoDataSource.updateTodo(
            any(
              that: predicate<Todo>((todo) {
                return todo.id == originalTodo.id &&
                    todo.isDone == !originalTodo.isDone;
              }),
            ),
          ),
        ).called(1);
      },
    );

    test('updateTodo should call updateTodo on the data source', () async {
      // Arrange
      // The repository's updateTodo now takes only a Todo object
      when(() => mockTodoDataSource.updateTodo(any())).thenAnswer((_) async {});

      // Act
      await todoRepositoryImpl.updateTodo(tTodo); // Pass the Todo object

      // Assert
      verify(() => mockTodoDataSource.updateTodo(tTodo)).called(1);
    });
  });
}
