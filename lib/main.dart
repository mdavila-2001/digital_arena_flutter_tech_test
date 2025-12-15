import 'package:digital_arena_flutter_tech_test/features/home/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

final _router = GoRouter(
  initialLocation: '/api-list',
  routes: [
    GoRoute(
      path: '/api-list',
      builder: (context, state) => const HomeScreen(), 
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Listado de los Simpsons',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.yellow),
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}