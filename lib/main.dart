import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const MyApp());
}

final _router = GoRouter(
  initialLocation: '/api-list',
  routes: [
    GoRoute(
      path: '/api-list',
      builder: (context, state) => const Scaffold(body: Center(child: Text("Home: Simpsons API"))),
    ),
    GoRoute(
      path: '/prefs', // Lista de favoritos
      builder: (context, state) => const Scaffold(body: Center(child: Text("Favoritos"))),
      routes: [
        GoRoute(
          path: 'new', // /prefs/new
          builder: (context, state) => const Scaffold(body: Center(child: Text("Nuevo Favorito"))),
        ),
        GoRoute(
          path: ':id', // /prefs/123
          builder: (context, state) => const Scaffold(body: Center(child: Text("Detalle Favorito"))),
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}
