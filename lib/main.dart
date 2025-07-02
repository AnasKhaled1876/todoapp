import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:initiation_task/config/themes/light.dart';
import 'package:initiation_task/domain/entities/todo.dart'; // Import Todo for Isar schema
import 'package:initiation_task/locator.dart';
import 'package:isar/isar.dart'; // Import Isar
import 'package:path_provider/path_provider.dart'; // Import path_provider
import 'package:shared_preferences/shared_preferences.dart';
import 'presentation/screens/home.dart';
import 'package:flutter/material.dart';

/// The app's entrypoint.
///
/// Ensures that the binding to the Flutter engine is complete, sets up the
/// service locators using [setupServiceLocators], and runs the app using
/// [ProviderScope] to use RiverPod and [MyApp].
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  // Initialize Isar
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [TodoSchema], // Add TodoSchema
    directory: dir.path,
  );

  // Pass Isar instance to the locator setup
  await setupServiceLocators(isar: isar); // Modified to pass Isar

  List<Locale> supportedLocales = [Locale('en'), Locale('ar')];

  Locale startLocale = Locale(Platform.localeName.split('_').first);

  final language = locator<SharedPreferences>().getString('language');
  if (language != null) {
    startLocale = Locale(language);
  } else {
    if (!supportedLocales.contains(startLocale)) {
      startLocale = Locale('en');
    }
  }

  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: supportedLocales,
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
        startLocale: startLocale,
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: const HomeScreen(),
    );
  }
}
