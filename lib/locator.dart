// locator.dart
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart'; // Import Isar
import 'package:initiation_task/data/datasources/isar_todo_datasource.dart'; // Import IsarTodoDataSource
import 'package:initiation_task/data/repositories_impl/todo.dart';
// No longer need Hive imports for Todo entity or HiveTodoDataSource if fully migrated
// import 'package:initiation_task/domain/entities/todo.dart';
import 'package:initiation_task/domain/repositories/todo.dart'; // Ensure this has TodoDataSource and TodoRepository

final locator = GetIt.instance;

// Modified to accept Isar instance
Future<void> setupServiceLocators({required Isar isar}) async {
  // Register Isar instance
  locator.registerSingleton<Isar>(isar);

  // Register the Isar data source
  // It now depends on the TodoDataSource interface
  locator.registerLazySingleton<TodoDataSource>(
    () => IsarTodoDataSource(locator<Isar>()),
  );

  // Register the repository, ensuring it depends on the TodoDataSource interface
  locator.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(locator<TodoDataSource>()),
  );

  // AppLifecycleObserver for Isar can be added if needed, e.g., for closing Isar.
  // However, Isar typically manages its lifecycle well.
  // If you had specific logic for Hive.close(), consider if Isar needs similar handling.
  // For now, removing the Hive-specific AppLifecycleObserver.
}

// The Hive-specific AppLifecycleObserver is removed.
// If you need to perform actions on app lifecycle changes for Isar,
// you can create a new observer or integrate it here.
// For example, Isar doesn't strictly require manual closing on app exit like Hive boxes sometimes do for flushing,
// but you might have other cleanup tasks.
