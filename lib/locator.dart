// locator.dart
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:initiation_task/data/datasources/todo.dart';
import 'package:initiation_task/data/repositories_impl/todo.dart';
import 'package:initiation_task/domain/entities/todo.dart';
import 'package:initiation_task/domain/repositories/todo.dart';

final locator = GetIt.instance;

Future<void> setupServiceLocators() async {
  // Initialize Hive
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(TodoAdapter());
  }

  // Register the Hive box as a singleton
  final todoBox = await Hive.openBox<Todo>('todos');
  locator.registerSingleton<Box<Todo>>(todoBox);

  // Register the data source
  locator.registerLazySingleton<HiveTodoDataSource>(
    () => HiveTodoDataSource(locator<Box<Todo>>()),
  );

  // Register the repository
  locator.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(locator<HiveTodoDataSource>()),
  );

  // Add this if you need to close the box when the app is closing
  // (e.g., in main's dispose)
  // getIt.registerSingleton(AppLifecycleObserver());
}

// Optional: Close Hive boxes when app is closing
// class AppLifecycleObserver with WidgetsBindingObserver {
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.detached) {
//       Hive.close();
//     }
//   }
// }
