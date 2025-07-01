import 'package:mocktail/mocktail.dart';
import 'package:initiation_task/domain/repositories/todo.dart';
import 'package:initiation_task/domain/entities/todo.dart';

// Create a MockTodoRepository class using mocktail
class MockTodoRepository extends Mock implements TodoRepository {}

// Helper to register fallback values for Todo entities if needed by mocktail
// for methods returning Future<Todo> or involving complex types.
// This is generally needed if you have methods that are not void or simple primitives.
void registerFallbackValues() {
  registerFallbackValue(Todo(title: ''));
}
