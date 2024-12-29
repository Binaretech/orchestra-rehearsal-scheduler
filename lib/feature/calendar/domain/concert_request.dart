class CreateConcertRequest {
  final String title;
  final List<String> repertoire;
  final String location;
  final bool isDefinitive;
  final String date;
  final List<String> rehearsalDays;
  final List<Distribution> distribution;

  CreateConcertRequest({
    required this.title,
    required this.repertoire,
    required this.location,
    required this.isDefinitive,
    required this.date,
    required this.rehearsalDays,
    required this.distribution,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'repertoire': repertoire,
      'location': location,
      'isDefinitive': isDefinitive,
      'date': date,
      'rehearsalDays': rehearsalDays,
      'distribution': distribution.map((d) => d.toJson()).toList(),
    };
  }
}

class Distribution {
  final int section;
  final List<MusicStand> musicStands;

  Distribution({
    required this.section,
    required this.musicStands,
  });

  Map<String, dynamic> toJson() {
    return {
      'section': section,
      'musicStands': musicStands.map((ms) => ms.toJson()).toList(),
    };
  }
}

class MusicStand {
  final int stand;
  final List<int> musicians;

  MusicStand({
    required this.stand,
    required this.musicians,
  });

  Map<String, dynamic> toJson() {
    return {
      'stand': stand,
      'musicians': musicians,
    };
  }
}
