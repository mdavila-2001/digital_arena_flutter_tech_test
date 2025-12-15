import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../injection_container.dart';
import '../cubit/favorites_cubit.dart';
import '../cubit/favorites_state.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FavoritesCubit>()..loadFavorites(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Mis Favoritos"),
          actions: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () => context.go('/api-list'),
            ),
          ],
        ),
        body: BlocBuilder<FavoritesCubit, FavoritesState>(
          builder: (context, state) {
            if (state is FavoritesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FavoritesLoaded) {
              if (state.favorites.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.favorite_border, size: 60, color: Colors.grey),
                      const SizedBox(height: 10),
                      const Text("No tienes favoritos aún"),
                      TextButton(
                        onPressed: () => context.go('/api-list'),
                        child: const Text("Ir a agregar uno"),
                      )
                    ],
                  ),
                );
              }

              return ListView.separated(
                itemCount: state.favorites.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final fav = state.favorites[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(fav.image),
                    ),
                    title: Text(fav.customName),
                    subtitle: Text("Original: ${fav.originalName}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("¿Eliminar?"),
                            content: const Text("Se borrará de tu lista local."),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: const Text("Cancelar"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(ctx);
                                  context.read<FavoritesCubit>().deleteFavorite(fav.apiId);
                                },
                                child: const Text("Eliminar", style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    onTap: () {
                      // Aquí iríamos al detalle (/prefs/:id)
                    },
                  );
                },
              );
            } else if (state is FavoritesError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}