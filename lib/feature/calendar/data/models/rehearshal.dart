class Rehearsal {
  final int id;
  final DateTime date;
  final String location;
  final bool isGeneral;
  final int concertId;
  final dynamic concert;
  final dynamic users;
  final DateTime createdAt;
  final DateTime updatedAt;

  Rehearsal({
    required this.id,
    required this.date,
    required this.location,
    required this.isGeneral,
    required this.concertId,
    required this.concert,
    required this.users,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Rehearsal.fromJson(Map<String, dynamic> json) {
    return Rehearsal(
      id: json['id'],
      date: DateTime.parse(json['date']),
      location: json['location'],
      isGeneral: json['isGeneral'],
      concertId: json['concertId'],
      concert: json['concert'],
      users: json['users'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
