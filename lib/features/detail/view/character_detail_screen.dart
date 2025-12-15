import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../injection_container.dart';
import '../cubit/detail_cubit.dart';
import '../cubit/detail_state.dart';

class CharacterDetailScreen extends StatelessWidget {
  final int characterId;

  const CharacterDetailScreen({super.key, required this.characterId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DetailCubit>()..loadDetail(characterId),
      child: Scaffold(
        appBar: AppBar(title: const Text("Detalle del Personaje")),
        body: const CharacterDetailView(),
      ),
    );
  }
}

class CharacterDetailView extends StatelessWidget {
  const CharacterDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailCubit, DetailState>(
      builder: (context, state) {
        if (state is DetailLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DetailLoaded) {
          final char = state.character;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Hero(
                    tag: char.id,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(char.imageUrl),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    char.name,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                
                Wrap(
                  spacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    _InfoChip(label: "${char.age} años", icon: Icons.cake),
                    _InfoChip(label: char.status, icon: Icons.health_and_safety),
                    _InfoChip(label: char.occupation, icon: Icons.work),
                  ],
                ),
                const Divider(height: 30),

                Text("Biografía", style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text(
                  char.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 20),

                if (char.phrases.isNotEmpty) ...[
                  Text("Frases Célebres", style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  ...char.phrases.map((phrase) => Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              const Icon(Icons.format_quote, color: Colors.grey),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  phrase,
                                  style: const TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                ]
              ],
            ),
          );
        } else if (state is DetailError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox();
      },
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final IconData icon;
  const _InfoChip({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 16),
      label: Text(label),
    );
  }
}