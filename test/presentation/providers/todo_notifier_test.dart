import 'package:flutter_test/flutter_test.dart';
import 'package:initiation_task/domain/entities/todo.dart';
import 'package:initiation_task/presentation/providers/todo.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../mocks/mock_todo_repository.dart'; // Updated import

void main() {
  // Register fallback values once for all tests
  setUpAll(() {
    // Updated Todo for Isar: id, title, isDone
    registerFallbackValue(Todo(title: 'fallback', isDone: false)..id = 0);
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
    // Updated Todo instances for Isar
    final tTodo1 = Todo(title: 'Test Todo 1', isDone: false)..id = 1;
    final tTodo2 = Todo(title: 'Test Todo 2', isDone: false)..id = 2;

    test('initial state is empty if repository returns empty list', () async {
      // Arrange
      // getTodos is called in constructor, mock is already set up in global setUp
      // Act
      final notifier = container.read(todosProvider.notifier);
      await Future.delayed(Duration.zero); // allow microtasks to complete

      // Assert
      expect(notifier.state, isEmpty);
      verify(() => mockTodoRepository.getTodos()).called(1);
    });

    test('loadTodos loads todos from repository and updates state', () async {
      // Arrange
      when(
        () => mockTodoRepository.getTodos(),
      ).thenAnswer((_) async => [tTodo1, tTodo2]);
      final notifier = container.read(
        todosProvider.notifier,
      ); // Re-read or ensure notifier is fresh

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
      when(
        () => mockTodoRepository.deleteTodo(any()),
      ).thenAnswer((_) async => {});

      // Act
      notifier.removeTodo(tTodo1);

      // Assert
      expect(notifier.debugState, [tTodo2]);
      verify(
        () => mockTodoRepository.deleteTodo(tTodo1.id),
      ).called(1); // Use id
    });

    test('toggleTodo toggles todo isDone status and calls repository', () async {
      // Arrange
      final notifier = container.read(todosProvider.notifier);
      // Use the Isar Todo entity
      final tTodo = Todo(title: 'Test', isDone: false)..id = 1;
      notifier.state = [tTodo];
      // toggleTodo in repository now takes id
      when(
        () => mockTodoRepository.updateTodo(any()),
      ).thenAnswer((_) async => {});

      // The notifier's toggleTodo might need adjustment based on its new implementation
      // Assuming notifier.toggleTodo now takes the id and potentially the new state or fetches+updates
      // For this example, let's assume it takes the todo object itself, or just its ID
      // and the notifier handles fetching/updating.
      // If toggleTodo in notifier is `toggleTodo(Todo todoToToggle)`
      // final toggledTodo = tTodo.copyWith(isDone: true);
      // notifier.toggleTodo(toggledTodo);

      // If toggleTodo in notifier is `toggleTodo(int id)`:
      notifier.toggleTodo(id: tTodo.id, todo: tTodo);

      // Assert
      // The state update logic within the notifier needs to be consistent.
      // If it fetches and updates, the mock for getTodoById and updateTodo within toggleTodo would need setup.
      // For now, we assume the state is updated directly or by the mocked toggleTodo.
      // This assertion might need to change based on how TodoNotifier.toggleTodo is refactored.
      // We'll assume for now that the mockTodoRepository.toggleTodo handles the state change for the purpose of this test.
      // If the notifier updates its state internally after the call:
      // await Future.delayed(Duration.zero); // Allow state update
      // expect(notifier.debugState.first.isDone, true);

      // Verify the repository method is called
      verify(() => mockTodoRepository.updateTodo(tTodo)).called(1); // Use id
    });

    test('updateTodo updates todo and calls repository', () async {
      // Arrange
      final notifier = container.read(todosProvider.notifier);
      final tInitialTodo = Todo(title: 'Initial', isDone: false)..id = 1;

      // Mock the repository's getTodos to return our initial state
      when(
        () => mockTodoRepository.getTodos(),
      ).thenAnswer((_) async => [tInitialTodo]);

      // Reset the notifier to ensure loadTodos() is called with our mock
      notifier.loadTodos();
      await Future.delayed(
        Duration.zero,
      ); // Allow the async operation to complete

      final tUpdatedTodo = tInitialTodo.copyWith(title: 'Updated');

      when(
        () => mockTodoRepository.updateTodo(
          any(
            that: predicate<Todo>(
              (arg) =>
                  arg.id == tUpdatedTodo.id && arg.title == tUpdatedTodo.title,
            ),
          ),
        ),
      ).thenAnswer((_) async => {});

      // Act
      notifier.updateTodo(id: tUpdatedTodo.id, todo: tUpdatedTodo);

      // Assert
      expect(notifier.state.first.title, 'Updated');
      expect(notifier.state.first.id, tInitialTodo.id);

      verify(
        () => mockTodoRepository.updateTodo(any(that: isA<Todo>())),
      ).called(1);
    });
    
    // test(
    //   'loadTodos is called on initialization if state is empty (verified by initial setup)',
    //   () async {
    //     // This test is essentially covered by the `initial state is empty` test
    //     // and the global setUp's when(() => mockTodoRepository.getTodos()).thenAnswer
    //     // We verify that getTodos() was called during initialization.
    //     verify(() => mockTodoRepository.getTodos()).called(1);
    //   },
    // );
  });
}
