import 'package:flutter/material.dart';
import 'package:meme_factory/config/routes/router_manager.dart';
import 'package:meme_factory/config/theme/theme.dart';
import 'package:meme_factory/core/constants/strings.dart';
import 'package:meme_factory/core/injection/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: RouterManager.config,
      debugShowCheckedModeBanner: false,
      title: AppStrings.title,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
    );
  }
}
