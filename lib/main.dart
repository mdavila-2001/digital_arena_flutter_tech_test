import 'package:digital_arena_flutter_tech_test/features/favorites/view/add_favorite_screen.dart';
import 'package:digital_arena_flutter_tech_test/features/home/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'data/models/character_model.dart';
import 'features/detail/view/character_detail_screen.dart';
import 'features/favorites/view/favorites_screen.dart';
import 'injection_container.dart' as di;

class FavoriteDetailScreen extends StatelessWidget {
  final String id;
  const FavoriteDetailScreen({super.key, required this.id});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text("Detalle ID: $id")),
        body: const Center(child: Text("Datos del personaje guardado")),
      );
}

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
      routes: const [],
    ),
    GoRoute(
      path: '/prefs',
      name: 'favorites',
      builder: (context, state) => const FavoritesScreen(),
      routes: [
        GoRoute(
          path: 'new', 
          name: 'add_favorite',
          builder: (context, state) {
            final char = state.extra as CharacterModel?;
            return AddFavoriteScreen(character: char);
          },
        ),
        GoRoute(
          path: ':id', 
          name: 'favorite_detail',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return FavoriteDetailScreen(id: id);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/api-detail/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return CharacterDetailScreen(characterId: id);
      },
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