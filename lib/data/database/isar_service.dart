import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/chronos_event.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationSupportDirectory();
      return await Isar.open(
        [ChronosEventSchema], // Схема из сгенерированного файла
        directory: dir.path,
        inspector: true, // Позволяет дебажить БД (если нужно)
      );
    }
    return Future.value(Isar.getInstance());
  }

  // 1. Сохранить событие
  Future<void> saveEvent(ChronosEvent event) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.chronosEvents.put(event);
    });
  }

  // 2. Получить поток всех событий (для обновления UI в реальном времени)
  Stream<List<ChronosEvent>> listenToEvents() async* {
    final isar = await db;
    yield* isar.chronosEvents.where().sortByTimestampDesc().watch(fireImmediately: true);
  }
  
  // 3. Получить все события один раз
  Future<List<ChronosEvent>> getAllEvents() async {
    final isar = await db;
    return await isar.chronosEvents.where().sortByTimestampDesc().findAll();
  }

  // 4. Очистить базу (для тестов)
  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }

  // 5. Обновить статус (Feedback)
  Future<void> updateFeedback(Id id, bool isFulfilled) async {
    final isar = await db;
    await isar.writeTxn(() async {
      final event = await isar.chronosEvents.get(id);
      if (event != null) {
        event.isFulfilled = isFulfilled;
        await isar.chronosEvents.put(event);
      }
    });
  }

  // 6. Удалить событие (на случай ошибки)
  Future<void> deleteEvent(Id id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.chronosEvents.delete(id);
    });
  }

}