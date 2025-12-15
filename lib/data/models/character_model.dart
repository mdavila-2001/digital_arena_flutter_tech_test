class CharacterModel {
  final int id;
  final String name;
  final String image;
  final String occupation;
  final int age;
  final String gender;
  final String status;
  final List<String> phrases;

  CharacterModel({
    required this.id,
    required this.name,
    required this.image,
    required this.occupation,
    required this.age,
    required this.gender,
    required this.status,
    required this.phrases,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    const cdnUrl = 'https://cdn.thesimpsonsapi.com/200';

    final gender = json['gender'] as String? ?? 'Desconocido';

    String occupation = json['occupation'] as String? ?? 'Sin trabajo';
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

    return CharacterModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? 'Desconocido',
      image:
          json['portrait_path'] != null
              ? '$cdnUrl${json['portrait_path']}'
              : '',
      occupation: occupation,
      age: json['age'] as int? ?? 0,
      gender: gender,
      status: json['status'] as String? ?? 'Desconocido',
      phrases:
          (json['phrases'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'portrait_path': image,
      'occupation': occupation,
      'age': age,
      'gender': gender,
      'status': status,
      'phrases': phrases,
    };
  }
}
