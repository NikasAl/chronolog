import 'package:flutter/material.dart';
// import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../../core/theme.dart';
import '../../core/strings.dart';
import '../../data/database/isar_service.dart';
import '../../data/models/chronos_event.dart';
import 'input_screen.dart';
import 'event_details_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey _fabKey = GlobalKey();
  final IsarService _service = IsarService();
  
  // Состояние фильтра
  bool _showTodayOnly = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), _showTutorial);
  }

  void _showTutorial() {
    // ... (код туториала без изменений) ...
    // Можно временно закомментировать, если мешает при отладке
  }

  Color _getSigmaColor(double sigma) {
    if (sigma.abs() >= 3.0) return AppColors.error;
    if (sigma.abs() >= 2.0) return AppColors.accent;
    return AppColors.primary;
  }

  // Хелпер для сравнения дат (игнорируем время)
  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  // Генерация красивого заголовка даты
  String _getDateHeader(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final checkDate = DateTime(date.year, date.month, date.day);

    if (checkDate == today) {
      return AppStrings.get('date_today');
    } else if (checkDate == yesterday) {
      return AppStrings.get('date_yesterday');
    } else {
      // Формат DD.MM.YYYY
      return "${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}";
    }
  }

  // Основной метод построения сгруппированного списка
  List<Widget> _buildGroupedListItems(List<ChronosEvent> events) {
    final List<Widget> items = [];
    
    if (events.isEmpty) return items;

    // 1. Фильтрация
    final filteredEvents = _showTodayOnly 
        ? events.where((e) => _isSameDay(e.timestamp, DateTime.now())).toList()
        : events;

    if (filteredEvents.isEmpty) return items;

    // 2. Группировка
    String? lastHeader;

    for (var event in filteredEvents) {
      final header = _getDateHeader(event.timestamp);
      
      // Если дата изменилась по сравнению с предыдущим элементом -> добавляем заголовок
      if (lastHeader != header) {
        items.add(_buildDateHeader(header));
        lastHeader = header;
      }
      
      // Добавляем саму карточку
      items.add(_buildEventCard(event));
    }

    return items;
  }

  Widget _buildDateHeader(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(
              color: AppColors.accent,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              fontSize: 12,
              fontFamily: 'Monospace',
            ),
          ),
          const SizedBox(width: 8),
          const Expanded(child: Divider(color: Colors.white10)),
        ],
      ),
    );
  }

  Widget _buildEventCard(ChronosEvent event) {
    final sigmaColor = _getSigmaColor(event.sigma);
    return Card(
      color: AppColors.surface,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6), // Чуть меньше отступы
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
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                  fontFamily: 'Monospace'),
            ),
          ),
        ),
        title: Text(
          event.query,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Monospace'),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Row(
            children: [
              const Icon(Icons.access_time, size: 12, color: Colors.white38),
              const SizedBox(width: 4),
              Text(
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
                      fontFamily: 'Monospace'),
                ),
              ),
            ],
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              event.sigma.abs() > 2.0
                  ? Icons.warning_amber_rounded
                  : Icons.check_circle_outline,
              color: sigmaColor,
              size: 20,
            ),
            if (event.isFulfilled != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Icon(
                  event.isFulfilled! ? Icons.check : Icons.close,
                  size: 12,
                  color: event.isFulfilled!
                      ? Colors.greenAccent
                      : AppColors.error,
                ),
              )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.get('app_title')),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        // Добавляем переключатель в AppBar
        actions: [
          Row(
            children: [
               Text(
                AppStrings.get('date_today'), 
                style: TextStyle(
                  fontSize: 10, 
                  color: _showTodayOnly ? AppColors.accent : Colors.white24,
                  fontWeight: FontWeight.bold
                )
              ),
              Switch(
                value: _showTodayOnly,
                activeColor: AppColors.accent,
                inactiveThumbColor: Colors.grey,
                onChanged: (val) {
                  setState(() {
                    _showTodayOnly = val;
                  });
                },
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: StreamBuilder<List<ChronosEvent>>(
        stream: _service.listenToEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: AppColors.primary));
          }

          final events = snapshot.data ?? [];
          
          // Строим список элементов (Заголовки + Карточки)
          final listItems = _buildGroupedListItems(events);

          if (listItems.isEmpty) {
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
                  Text(
                    _showTodayOnly 
                      ? "NO EVENTS TODAY" // Можно вынести в строки
                      : AppStrings.get('dashboard_waiting'),
                    style: const TextStyle(
                        letterSpacing: 3, color: Colors.white54),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 80), // Отступ под FAB
            itemCount: listItems.length,
            itemBuilder: (context, index) {
              return listItems[index];
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