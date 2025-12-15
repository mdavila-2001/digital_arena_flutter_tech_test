import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        body: const HomeView(),
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeLoaded) {
          return ListView.builder(
            itemCount: state.characters.length,
            itemBuilder: (context, index) {
              final char = state.characters[index];
              return ListTile(
                leading: Image.network(
                  char.image,
                  width: 50,
                  errorBuilder: (_, __, ___) => const Icon(Icons.person),
                ),
                title: Text(char.name),
                subtitle: Text(char.occupation),
                onTap: () {
                  print("Click en ${char.name}");
                },
              );
            },
          );
        } else if (state is HomeError) {
          return Center(child: Text(state.message));
        }
        return const Center(child: Text("Bienvenido"));
      },
    );
  }
}
