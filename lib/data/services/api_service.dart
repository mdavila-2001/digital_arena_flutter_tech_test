import 'package:dio/dio.dart';
import '../models/character_model.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<List<CharacterModel>> getCharacters() async {
    try {
      final response = await _dio.get(
        'https://thesimpsonsapi.com/api/characters',
      );

      final List<dynamic> data = response.data['results'];
      return data.map((json) => CharacterModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}
