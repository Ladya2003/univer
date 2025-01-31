const String tableHobbyEntity = 'hobby_entity';

class HobbyEntityFields {
  static final List<String> values = [
    id, name, type, description
  ];

  static const String id = '_id';
  static const String name = 'name';
  static const String type = 'type';
  static const String description = 'description';
}

class HobbyEntity {
  final int? id;
  final String name;
  final String type; // "Draw" или "Read"
  final String description;

  HobbyEntity({
    this.id,
    required this.name,
    required this.type,
    required this.description,
  });

  HobbyEntity copy({int? id, String? name, String? type, String? description}) =>
      HobbyEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        description: description ?? this.description,
      );

  Map<String, dynamic> toJson() => {
    HobbyEntityFields.id: id,
    HobbyEntityFields.name: name,
    HobbyEntityFields.type: type,
    HobbyEntityFields.description: description,
  };

  static HobbyEntity fromJson(Map<String, Object?> json) => HobbyEntity(
    id: json[HobbyEntityFields.id] as int?,
    name: json[HobbyEntityFields.name] as String,
    type: json[HobbyEntityFields.type] as String,
    description: json[HobbyEntityFields.description] as String,
  );

  static List<Map<String, dynamic>> listToJson(List<HobbyEntity> entityList) {
    return entityList.map((entity) => entity.toJson()).toList();
  }

  static List<HobbyEntity> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => HobbyEntity.fromJson(json)).toList();
  }
}

class Read extends HobbyEntity {
  Read({int? id, required String name, required String description})
      : super(id: id, name: name, type: 'Read', description: description);
}

class Draw extends HobbyEntity {
  Draw({int? id, required String name, required String description})
      : super(id: id, name: name, type: 'Draw', description: description);
}
