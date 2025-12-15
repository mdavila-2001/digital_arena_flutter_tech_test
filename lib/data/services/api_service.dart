import 'package:dio/dio.dart';
import '../models/character_detail_model.dart';
import '../models/character_model.dart';

class PaginatedResponse {
  final List<CharacterModel> characters;
  final int totalPages;
  final int currentPage;
  final bool hasNextPage;

  PaginatedResponse({
    required this.characters,
    required this.totalPages,
    required this.currentPage,
    required this.hasNextPage,
  });
}

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<PaginatedResponse> getCharacters({int page = 1}) async {
    try {
      final response = await _dio.get(
        'https://thesimpsonsapi.com/api/characters',
        queryParameters: {'page': page},
      );

      final data = response.data;
      final List<dynamic> results = data['results'];
      final int totalPages = data['pages'] ?? 1;
      final String? nextUrl = data['next'];

      return PaginatedResponse(
        characters:
            results.map((json) => CharacterModel.fromJson(json)).toList(),
        totalPages: totalPages,
        currentPage: page,
        hasNextPage: nextUrl != null,
      );
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<CharacterDetailModel> getCharacterDetail(int id) async {
    try {
      final response = await _dio.get('https://thesimpsonsapi.com/api/characters/$id');
      
      return CharacterDetailModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Error al cargar detalle del ID $id: $e');
    }
  }
}
