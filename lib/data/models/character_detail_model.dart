class CharacterDetailModel {
  final int id;
  final String name;
  final String description;
  final String occupation;
  final int age;
  final String imageUrl;
  final List<String> phrases;
  final String status;

  CharacterDetailModel({
    required this.id,
    required this.name,
    required this.description,
    required this.occupation,
    required this.age,
    required this.imageUrl,
    required this.phrases,
    required this.status,
  });

  factory CharacterDetailModel.fromJson(Map<String, dynamic> json) {
    final basePath = json['portrait_path'] as String? ?? '';
    final fullImage = basePath.isNotEmpty 
        ? "https://thesimpsonsapi.com/500/$basePath" 
        : "https://via.placeholder.com/200";

    return CharacterDetailModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? 'Desconocido',
      description: json['description'] as String? ?? 'Sin descripción',
      occupation: json['occupation'] as String? ?? 'Desempleado',
      age: json['age'] as int? ?? 0,
      imageUrl: fullImage, 
      status: json['status'] as String? ?? 'Unknown',
      phrases: (json['phrases'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ?? [],
    );
  }
}