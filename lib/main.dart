import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:initiation_task/config/themes/light.dart';
import 'package:initiation_task/locator.dart';
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

  await setupServiceLocators();

  List<Locale> supportedLocales = [Locale('en'), Locale('ar')];

  Locale startLocale = Locale(Platform.localeName.split('_').first);

  if (!supportedLocales.contains(startLocale)) {
    startLocale = Locale('en');
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
