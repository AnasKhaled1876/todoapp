import 'package:mocktail/mocktail.dart';
import 'package:initiation_task/data/datasources/todo.dart';
import 'package:initiation_task/domain/entities/todo.dart';

// Create a MockHiveTodoDataSource class using mocktail
class MockHiveTodoDataSource extends Mock implements HiveTodoDataSource {}

// It's good practice to register fallback values for custom types
// if they are used as arguments to mocked methods or as return types
// for methods that might not be explicitly stubbed in all tests.
void registerHiveFallbackValues() {
  registerFallbackValue(Todo(key: 0, title: '', createdAt: DateTime.now()));
}
