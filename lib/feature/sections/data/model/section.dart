class Section {
  int id;
  String name;
  int familyId;
  int instrumentId;

  Section({
    required this.id,
    required this.name,
    required this.familyId,
    required this.instrumentId,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['id'],
      name: json['name'],
      familyId: json['familyId'],
      instrumentId: json['instrumentId'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Section && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
