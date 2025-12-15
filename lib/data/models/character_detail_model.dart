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
        ? "https://cdn.thesimpsonsapi.com/500$basePath" 
        : "https://via.placeholder.com/200";
    
    final gender = json['gender'] as String? ?? 'Desconocido';

    String occupation = json['occupation'] as String? ?? 'Sin trabajo';

    String status = json['status'] as String? ?? 'Desconocido';

    if (occupation.toLowerCase() == 'unemployed') {
      occupation = gender == 'Female' ? 'Desempleada' : 'Desempleado';
    }

    if (occupation.toLowerCase() == 'unknown') {
      occupation = 'Desconocido';
    }

    if (occupation.toLowerCase() == 'retired') {
      occupation = gender == 'Female' ? 'Jubilada' : 'Jubilado';
    }

    if (occupation.toLowerCase() == 'housewife') {
      occupation = 'Ama de casa';
    }

    if (status.toLowerCase() == 'alive') {
      status = gender == 'Female' ? 'Viva' : 'Vivo';
    }

    if (status.toLowerCase() == 'deceased') {
      status = gender == 'Female' ? 'Fallecida' : 'Fallecido';
    }

    return CharacterDetailModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? 'Desconocido',
      description: json['description'] as String? ?? 'Sin descripción',
      occupation: occupation,
      age: json['age'] as int? ?? 0,
      imageUrl: fullImage,
      status: status,
      phrases: (json['phrases'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ?? [],
    );
  }
}