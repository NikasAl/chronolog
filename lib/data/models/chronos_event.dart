// import 'package:uuid/uuid.dart'; // Потребуется добавить в pubspec.yaml, но пока можно без него

enum EventType { decision, prediction, calibration }

class ChronosEvent {
  final String id;
  final DateTime timestamp;
  final String query;       // Вопрос Вселенной
  final int importance;     // 1-10
  final EventType type;
  
  // Результаты (заполняются после симуляции)
  final int totalSamples;
  final int positiveHits;
  final double sigma;

  ChronosEvent({
    required this.query,
    required this.importance,
    required this.type,
    String? id,
    DateTime? timestamp,
    this.totalSamples = 0,
    this.positiveHits = 0,
    this.sigma = 0.0,
  }) : 
    id = id ?? DateTime.now().millisecondsSinceEpoch.toString(), // Временно, пока нет UUID
    timestamp = timestamp ?? DateTime.now();
}