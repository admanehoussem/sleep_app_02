class SleepData {
  final String id;
  final DateTime bedtime;
  final DateTime wakeTime;
  final int sleepQuality; // 1-5 scale
  final List<String> notes;
  final Duration totalSleep;
  final Duration deepSleep;
  final Duration lightSleep;
  final Duration remSleep;

  SleepData({
    required this.id,
    required this.bedtime,
    required this.wakeTime,
    this.sleepQuality = 3,
    this.notes = const [],
    required this.totalSleep,
    required this.deepSleep,
    required this.lightSleep,
    required this.remSleep,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bedtime': bedtime.toIso8601String(),
      'wakeTime': wakeTime.toIso8601String(),
      'sleepQuality': sleepQuality,
      'notes': notes,
      'totalSleep': totalSleep.inMinutes,
      'deepSleep': deepSleep.inMinutes,
      'lightSleep': lightSleep.inMinutes,
      'remSleep': remSleep.inMinutes,
    };
  }
}