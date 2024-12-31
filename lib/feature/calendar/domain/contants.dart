enum EventType {
  rehearsal,
  concert;

  String get name {
    switch (this) {
      case EventType.rehearsal:
        return 'Ensayo';
      case EventType.concert:
        return 'Concierto';
    }
  }
}
