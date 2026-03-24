/*  {
        "id": 2,
        "createdAt": "2024-04-18T12:58:36.761Z",
        "name": "Books"
    },*/
class DataCategoryModelFields {
  static const String id = "id";
  static const String cratedAt = "createdAt";
  static const String name = "name";
}

class DataCategoryModel {
  final int id;
  final DateTime cratedAt;
  final String name;
  DataCategoryModel({required this.id, required this.cratedAt, required this.name});
  DataCategoryModel copyWith({
    int? id,
    DateTime? cratedAt,
    String? name,
  }) {
    return DataCategoryModel(id: id ?? this.id, cratedAt: cratedAt ?? this.cratedAt, name: name ?? this.name);
  }

  factory DataCategoryModel.fromJson(Map<String, dynamic> json) {
    return DataCategoryModel(
        id: json[DataCategoryModelFields.id] as int? ?? 0,
        cratedAt: DateTime.parse(json[DataCategoryModelFields.cratedAt]) as DateTime? ?? DateTime.now(),
        name: json[DataCategoryModelFields.name] as String );
  }
  Map<String, dynamic> toJson() =>
      {DataCategoryModelFields.id: id, DataCategoryModelFields.cratedAt: cratedAt, DataCategoryModelFields.name: name};
  @override
  String toString() {
    return """
    ${DataCategoryModelFields.id}:$id,
    ${DataCategoryModelFields.cratedAt}:$cratedAt,
    ${DataCategoryModelFields.name}:$name
    """;
  }
}
