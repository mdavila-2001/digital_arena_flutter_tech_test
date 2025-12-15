import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../data/models/character_model.dart';
import '../../../injection_container.dart';
import '../cubit/favorites_cubit.dart';
import '../cubit/favorites_state.dart';

class AddFavoriteScreen extends StatefulWidget {
  final CharacterModel? character;

  const AddFavoriteScreen({super.key, this.character});

  @override
  State<AddFavoriteScreen> createState() => _AddFavoriteScreenState();
}

class _AddFavoriteScreenState extends State<AddFavoriteScreen> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.character == null) {
      return Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () => context.go('/api-list'),
            child: const Text("Selecciona un personaje primero"),
          ),
        ),
      );
    }

    final char = widget.character!;

    return BlocProvider(
      create: (context) => sl<FavoritesCubit>(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Nuevo Favorito")),
        body: BlocConsumer<FavoritesCubit, FavoritesState>(
          listener: (context, state) {
            if (state is FavoritesLoaded) {
              context.go('/prefs'); 
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("¡Guardado con éxito!")),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Hero(
                      tag: char.id,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(char.image),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(char.name, style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: "Nombre Personalizado",
                        hintText: "Ej: El mejor personaje",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.edit),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor escribe un nombre';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => context.pop(),
                            child: const Text("Cancelar"),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: FilledButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<FavoritesCubit>().addFavorite(
                                      char,
                                      _nameController.text,
                                    );
                              }
                            },
                            child: const Text("Guardar"),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}