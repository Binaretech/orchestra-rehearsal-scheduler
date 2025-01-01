import 'package:orchestra_rehearsal_scheduler/feature/calendar/domain/contants.dart';

class CalendarDateResponse {
  final List<Event> data;

  CalendarDateResponse({required this.data});

  factory CalendarDateResponse.fromJson(Map<String, dynamic> json) {
    List<Event> data =
        List<Event>.from(json['data'].map((item) => Event.fromJson(item)));
    return CalendarDateResponse(data: data);
  }

  Map<String, dynamic> toJson() {
    return {'data': List<dynamic>.from(data.map((item) => item.toJson()))};
  }
}

class CalendarResponse {
  final Map<String, List<Event>> data;

  CalendarResponse({required this.data});

  factory CalendarResponse.fromJson(Map<String, dynamic> json) {
    Map<String, List<Event>> data = {};
    json['data'].forEach((key, value) {
      data[key] = List<Event>.from(value.map((item) => Event.fromJson(item)));
    });
    return CalendarResponse(data: data);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    this.data.forEach((key, value) {
      data[key] = List<dynamic>.from(value.map((item) => item.toJson()));
    });
    return {'data': data};
  }
}

class Event {
  final int id;
  final EventType type;
  final DateTime date;
  final String title;

  Event(
      {required this.id,
      required this.type,
      required this.date,
      required this.title});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      type: EventType.values.firstWhere((e) {
        return e.toString().toLowerCase() ==
            "eventtype.${json['type'].toLowerCase()}";
      }, orElse: () => EventType.rehearsal),
      date: DateTime.parse(json['date']),
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'date': date.toIso8601String(),
      'title': title,
    };
  }

  String get description => '${type.name}: $title';
}
