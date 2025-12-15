# Simpsons Clean App 🍩

Prueba técnica desarrollada en Flutter que gestiona una lista de personajes de Los Simpsons, permitiendo consultarlos desde una API, buscar en tiempo real y guardar favoritos localmente con persistencia de datos.

## 📋 Características

* **Arquitectura Limpia:** Separación de responsabilidades (Data, Domain, Presentation).
* **Gestión de Estado:** Uso de `flutter_bloc` (Cubit) para estados predecibles.
* **Persistencia Local:** Base de datos NoSQL con `Hive` para guardar favoritos y funcionar offline.
* **Navegación:** Rutas nombradas y Deep Linking con `go_router`.
* **Búsqueda en Tiempo Real:** Filtrado instantáneo de personajes.
* **Inyección de Dependencias:** Desacoplamiento total usando `get_it`.

## 🛠️ Tecnologías

* **Flutter:** 3.x
* **Lenguaje:** Dart
* **Networking:** Dio
* **State Management:** Flutter Bloc (Cubit)
* **Local DB:** Hive
* **Routing:** GoRouter

## Instalación
# Clonar el repositorio:

git clone https://github.com/mdavila-2001/digital_arena_flutter_tech_test.git
cd digital_arena_flutter_tech_test

# Instalar dependencias:

flutter pub get

# Generar adaptadores (Hive/Freezed): Nota: Este proyecto usa generación de código para la base de datos.

dart run build_runner build --delete-conflicting-outputs

# Ejecutar la App:

flutter run

## 📂 Arquitectura y Estructura

El proyecto sigue una estructura Feature-First combinada con Clean Architecture:

lib/
├── core/                  # Configuración global (DI, Router, Themes)
├── data/                  # Capa de Datos (Data Sources, Models, Repositories)
│   ├── services/          # ApiService y LocalStorageService (Hive)
│   └── models/            # Modelos de API y Entidades Locales
├── features/              # Funcionalidades de la App
│   ├── home/              # Pantalla Principal (Lista API + Buscador)
│   ├── favorites/         # Gestión de Favoritos (CRUD Local)
│   └── detail/            # Detalle del Personaje (API Externa)
└── main.dart              # Punto de entrada