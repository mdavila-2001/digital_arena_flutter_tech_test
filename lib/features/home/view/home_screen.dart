import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../injection_container.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeCubit>()..getCharacters(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Los Simpsons"), centerTitle: true),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context.go('/prefs'),
          label: const Text("Ver Favoritos"),
          icon: const Icon(Icons.collections_bookmark),
        ),
        body: const HomeView(),
      ),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isNearBottom) {
      context.read<HomeCubit>().loadMore();
    }
  }

  bool get _isNearBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll - 200);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeLoaded) {
          final displayCharacters = state.filteredCharacters;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  onChanged: (value) => context.read<HomeCubit>().search(value),
                  decoration: InputDecoration(
                    hintText: 'Buscar personaje...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon:
                        state.searchQuery.isNotEmpty
                            ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed:
                                  () => context.read<HomeCubit>().clearSearch(),
                            )
                            : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                ),
              ),
              Expanded(
                child:
                    displayCharacters.isEmpty
                        ? Center(
                          child: Text(
                            'No se encontraron resultados para "${state.searchQuery}"',
                            textAlign: TextAlign.center,
                          ),
                        )
                        : ListView.builder(
                          controller: _scrollController,
                          itemCount:
                              state.searchQuery.isNotEmpty
                                  ? displayCharacters.length
                                  : (state.hasReachedMax
                                      ? displayCharacters.length
                                      : displayCharacters.length + 1),
                          itemBuilder: (context, index) {
                            if (index >= displayCharacters.length) {
                              return const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            final char = displayCharacters[index];
                            final isFavorite = state.favoriteIds.contains(
                              char.id,
                            );
                            return ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  char.image,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (_, __, ___) => Container(
                                        width: 50,
                                        height: 50,
                                        color: Colors.grey[300],
                                        child: const Icon(Icons.person),
                                      ),
                                ),
                              ),
                              title: Text(char.name),
                              subtitle: Text(char.occupation),
                              trailing: IconButton(
                                icon: Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.red,
                                ),
                                onPressed:
                                    isFavorite
                                        ? null
                                        : () async {
                                          await context.push(
                                            '/prefs/new',
                                            extra: char,
                                          );
                                          if (context.mounted) {
                                            context
                                                .read<HomeCubit>()
                                                .refreshFavorites();
                                          }
                                        },
                              ),
                              onTap: () {
                                context.push('/api-detail/${char.id}');
                              },
                            );
                          },
                        ),
              ),
            ],
          );
        } else if (state is HomeError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.message),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.read<HomeCubit>().getCharacters(),
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          );
        }
        return const Center(child: Text("Bienvenido"));
      },
    );
  }
}
