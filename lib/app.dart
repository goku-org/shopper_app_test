import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';
import 'package:shopper_app/providers/auth_provider.dart';
import 'package:shopper_app/resources/app_strings.dart';
import 'package:shopper_app/resources/app_theme.dart';
import 'package:shopper_app/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>.value(value: AuthProvider()),
      ],
      child: MaterialApp.router(
        routerDelegate: RoutemasterDelegate(routesBuilder: (context) => routes),
        routeInformationParser: const RoutemasterParser(),
        builder: BotToastInit(),
        title: AppStrings.appName,
        theme: AppTheme(context).lightTheme,
        themeMode: ThemeMode.light,
      ),
    );
  }
}
