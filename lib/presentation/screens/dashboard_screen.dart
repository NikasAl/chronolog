import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../../core/theme.dart';
import '../../core/strings.dart';
import '../../data/database/isar_service.dart'; // Импорт сервиса
import '../../data/models/chronos_event.dart'; // Импорт модели
import 'input_screen.dart';
import 'event_details_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Ключ для элемента, который хотим подсветить
  final GlobalKey _fabKey = GlobalKey();
  final IsarService _service = IsarService(); // Инициализируем сервис

  @override
  void initState() {
    super.initState();
    // Туториал можно временно отключить или оставить, как удобнее
    Future.delayed(const Duration(seconds: 1), _showTutorial);
  }

  void _showTutorial() {
    TutorialCoachMark(
      targets: [
        TargetFocus(
          identify: "Target 1",
          keyTarget: _fabKey,
          alignSkip: Alignment.topRight,
          contents: [
            TargetContent(
              align: ContentAlign.top,
              builder: (context, controller) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.get('coach_add_title'),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        AppStrings.get('coach_add_desc'),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
          shape: ShapeLightFocus.Circle,
          radius: 10,
        ),
      ],
      colorShadow: AppColors.background, // Затемнение фона
      textSkip: "SKIP >>",
      paddingFocus: 10,
      opacityShadow: 0.8,
    ).show(context: context);
  }

  // Хелпер для получения цвета карточки по сигме
  Color _getSigmaColor(double sigma) {
    if (sigma.abs() >= 3.0) return AppColors.error;
    if (sigma.abs() >= 2.0) return AppColors.accent;
    return AppColors.primary; // Gold
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.get('app_title')),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder<List<ChronosEvent>>(
        stream: _service.listenToEvents(), // Слушаем базу в реальном времени
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          }

          final events = snapshot.data ?? [];

          // Если событий нет - показываем заглушку
          if (events.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: AppColors.primary.withOpacity(0.2), width: 2),
                    ),
                    child: Center(
                      child: Text(AppStrings.get('dashboard_empty'),
                          style: const TextStyle(color: Colors.white24)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(AppStrings.get('dashboard_waiting'),
                      style: const TextStyle(letterSpacing: 3, color: Colors.white54)),
                ],
              ),
            );
          }

          // Если события есть - показываем список
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              final sigmaColor = _getSigmaColor(event.sigma);

              return Card(
                color: AppColors.surface,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: sigmaColor.withOpacity(0.3))),
                child: ListTile(
                  onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventDetailsScreen(event: event),
                          ),
                        );
                      },                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  // Иконка слева (Сигма)
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: sigmaColor.withOpacity(0.5)),
                    ),
                    child: Center(
                      child: Text(
                        event.sigma.toStringAsFixed(1),
                        style: TextStyle(
                          color: sigmaColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Monospace'
                        ),
                      ),
                    ),
                  ),
                  // Заголовок (Вопрос)
                  title: Text(
                    event.query,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Monospace'
                    ),
                  ),
                  // Подзаголовок (Тип + Дата)
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Row(
                      children: [
                        Icon(Icons.access_time, size: 12, color: Colors.white38),
                        const SizedBox(width: 4),
                        Text(
                          // Простой формат даты, можно улучшить intl пакетом позже
                          "${event.timestamp.hour}:${event.timestamp.minute.toString().padLeft(2, '0')}", 
                          style: const TextStyle(color: Colors.white38, fontSize: 12),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Text(
                            event.type.name.toUpperCase(),
                            style: const TextStyle(
                              color: AppColors.primary, 
                              fontSize: 10,
                              fontFamily: 'Monospace'
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Иконка справа (Статус)
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Иконка сигмы (старая логика)
                      Icon(
                          event.sigma.abs() > 2.0 ? Icons.warning_amber_rounded : Icons.check_circle_outline,
                          color: sigmaColor,
                          size: 20,
                      ),
                      // Точка статуса Feedback (Новое)
                      if (event.isFulfilled != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Icon(
                            event.isFulfilled! ? Icons.check : Icons.close,
                            size: 12,
                            color: event.isFulfilled! ? Colors.greenAccent : AppColors.error,
                          ),
                        )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        key: _fabKey,
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const InputScreen()),
          );
        },
      ),
    );
  }
}