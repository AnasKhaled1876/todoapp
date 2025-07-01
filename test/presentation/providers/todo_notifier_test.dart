import 'package:flutter_test/flutter_test.dart';
import 'package:initiation_task/domain/entities/todo.dart';
import 'package:initiation_task/presentation/providers/todo.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../mocks/mock_todo_repository.dart'; // Updated import

void main() {
  // Register fallback values once for all tests
  setUpAll(() {
    registerFallbackValue(Todo(key: 0, title: '', createdAt: DateTime.now(), isDone: false));
  });

  late MockTodoRepository mockTodoRepository;
  late ProviderContainer container;
  // TodoNotifier is implicitly created by the provider, we get it from the container

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    container = ProviderContainer(
      overrides: [
        todosProvider.overrideWith((ref) => TodoNotifier(mockTodoRepository)),
      ],
    );
    // Initialise a default behavior for getTodos as it's called in constructor
    when(() => mockTodoRepository.getTodos()).thenAnswer((_) async => []);
  });

  tearDown(() {
    container.dispose();
  });

  group('TodoNotifier', () {
    final tTodo1 = Todo(key: 1, title: 'Test Todo 1', createdAt: DateTime.now());
    final tTodo2 = Todo(key: 2, title: 'Test Todo 2', createdAt: DateTime.now());

    test('initial state is empty if repository returns empty list', () async {
      // Arrange
      // getTodos is called in constructor, mock is already set up in global setUp
      // Act
      final notifier = container.read(todosProvider.notifier);
      await Future.delayed(Duration.zero); // allow microtasks to complete

      // Assert
      expect(notifier.debugState, isEmpty);
      verify(() => mockTodoRepository.getTodos()).called(1);
    });

    test('loadTodos loads todos from repository and updates state', () async {
      // Arrange
      when(() => mockTodoRepository.getTodos()).thenAnswer((_) async => [tTodo1, tTodo2]);
      final notifier = container.read(todosProvider.notifier); // Re-read or ensure notifier is fresh

      // Act
      notifier.loadTodos(); // Explicitly call loadTodos
      await Future.delayed(Duration.zero); // allow microtasks to complete

      // Assert
      expect(notifier.debugState, [tTodo1, tTodo2]);
      // getTodos is called once in constructor, and once explicitly
      verify(() => mockTodoRepository.getTodos()).called(2);
    });

    test('addTodo adds a todo to state and calls repository', () async {
      // Arrange
      final notifier = container.read(todosProvider.notifier);
      when(() => mockTodoRepository.addTodo(any())).thenAnswer((_) async => {});

      // Act
      notifier.addTodo(tTodo1);

      // Assert
      expect(notifier.debugState, [tTodo1]);
      verify(() => mockTodoRepository.addTodo(tTodo1)).called(1);
    });

    test('removeTodo removes a todo from state and calls repository', () async {
      // Arrange
      final notifier = container.read(todosProvider.notifier);
      notifier.state = [tTodo1, tTodo2]; // Set initial state
      when(() => mockTodoRepository.deleteTodo(any())).thenAnswer((_) async => {});

      // Act
      notifier.removeTodo(tTodo1);

      // Assert
      expect(notifier.debugState, [tTodo2]);
      verify(() => mockTodoRepository.deleteTodo(tTodo1.key)).called(1);
    });

    test('toggleTodo toggles todo isDone status and calls repository', () async {
      // Arrange
      final notifier = container.read(todosProvider.notifier);
      final tTodo = Todo(key: 1, title: 'Test', createdAt: DateTime.now(), isDone: false);
      notifier.state = [tTodo];
      when(() => mockTodoRepository.toggleTodo(any())).thenAnswer((_) async => {});

      final toggledTodo = tTodo.copyWith(isDone: true);

      // Act
      notifier.toggleTodo(key: tTodo.key, todo: toggledTodo);

      // Assert
      expect(notifier.debugState.first.isDone, true);
      verify(() => mockTodoRepository.toggleTodo(tTodo.key)).called(1);
    });

    test('updateTodo updates todo title and calls repository', () async {
      // Arrange
      final notifier = container.read(todosProvider.notifier);
      final tInitialTodo = Todo(key: 1, title: 'Initial', createdAt: DateTime.now());
      notifier.state = [tInitialTodo];

      final tUpdatedTodo = tInitialTodo.copyWith(title: 'Updated');
      // Ensure the mock is prepared for the specific updated object or use `any()` if details don't matter for the mock.
      when(() => mockTodoRepository.updateTodo(tInitialTodo.key, tUpdatedTodo)).thenAnswer((_) async => {});


      // Act
      notifier.updateTodo(key: tInitialTodo.key, todo: tUpdatedTodo);

      // Assert
      expect(notifier.debugState.first.title, 'Updated');
      verify(() => mockTodoRepository.updateTodo(tInitialTodo.key, tUpdatedTodo)).called(1);
    });

    test('loadTodos is called on initialization if state is empty (verified by initial setup)', () async {
      // This test is essentially covered by the `initial state is empty` test
      // and the global setUp's when(() => mockTodoRepository.getTodos()).thenAnswer
      // We verify that getTodos() was called during initialization.
      verify(() => mockTodoRepository.getTodos()).called(1);
    });
  });
}
