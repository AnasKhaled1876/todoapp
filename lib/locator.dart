// locator.dart
import 'package:get_it/get_it.dart';
import 'package:initiation_task/data/repositories_impl/todo.dart';
import 'package:isar/isar.dart'; // Import Isar
import 'package:initiation_task/data/datasources/local/isar_todo_datasource.dart'; // Import IsarTodoDataSource
import 'package:initiation_task/domain/repositories/todo.dart'; // Ensure this has TodoDataSource and TodoRepository

final locator = GetIt.instance;

// Modified to accept Isar instance
Future<void> setupServiceLocators({required Isar isar}) async {
  // Register Isar instance
  locator.registerSingleton<Isar>(isar);


  // Register the Isar data source
  locator.registerLazySingleton<IsarTodoDataSource>(
    () => IsarTodoDataSource(isar),
  );

  //
  locator.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(locator<IsarTodoDataSource>()),
  );
}
