import 'package:isar/isar.dart';

// Эта строка пока будет подчеркнута красным, пока мы не запустим генератор. Это нормально.
part 'chronos_event.g.dart';

@collection
class ChronosEvent {
  Id id = Isar.autoIncrement; // Внутренний ID базы данных

  late String query;          // Вопрос наблюдателя
  late int importance;        // 1-10
  late int totalSamples;      // 100/400/1000
  late DateTime timestamp;

  @Enumerated(EnumType.name)  // Сохраняем как строку ('decision', etc)
  late EventType type;

  // Результаты
  late int positiveHits;
  late double sigma;
  
  // Feedback
  bool? isFulfilled; 

  // Конструктор для удобства
  ChronosEvent({
    required this.query,
    required this.importance,
    required this.totalSamples,
    required this.type,
    required this.timestamp,
    this.positiveHits = 0,
    this.sigma = 0.0,
    this.isFulfilled,
  });
}

enum EventType { decision, prediction, calibration }