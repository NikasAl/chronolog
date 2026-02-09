import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../core/strings.dart';
import '../../data/models/chronos_event.dart';
import '../../data/database/isar_service.dart';
import '../widgets/lore_dialog.dart';

class EventDetailsScreen extends StatefulWidget {
  final ChronosEvent event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  final IsarService _service = IsarService();
  late bool? _isFulfilled; // Локальное состояние выбора

  @override
  void initState() {
    super.initState();
    _isFulfilled = widget.event.isFulfilled;
  }

  void _updateStatus(bool status) async {
    setState(() {
      _isFulfilled = status;
    });
    await _service.updateFeedback(widget.event.id, status);
    // Можно добавить снекбар или вибрацию
  }

  void _deleteEvent() async {
    await _service.deleteEvent(widget.event.id);
    if (mounted) Navigator.pop(context);
  }

  Color _getSigmaColor(double sigma) {
    if (sigma.abs() >= 3.0) return AppColors.error;
    if (sigma.abs() >= 2.0) return AppColors.accent;
    return AppColors.primary;
  }

  @override
  Widget build(BuildContext context) {
    final color = _getSigmaColor(widget.event.sigma);
    final dateStr = "${widget.event.timestamp.day}/${widget.event.timestamp.month} ${widget.event.timestamp.hour}:${widget.event.timestamp.minute.toString().padLeft(2, '0')}";

    return Scaffold(
      appBar: AppBar(
        title: const Text("LOG_ENTRY // DETAILS", style: TextStyle(letterSpacing: 2, fontSize: 14)),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.white24),
            onPressed: _deleteEvent,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Заголовок (Вопрос)
            Text(
              widget.event.query.toUpperCase(),
              style: const TextStyle(
                fontFamily: 'Monospace',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "$dateStr  |  TYPE: ${widget.event.type.name.toUpperCase()}",
              style: const TextStyle(color: Colors.white38, fontSize: 12),
            ),
            
            const Divider(color: Colors.white10, height: 40),

            // 2. Статистика (Плашки)
            Row(
              children: [
                _buildStatCard("SIGMA", "${widget.event.sigma.toStringAsFixed(2)}σ", color),
                const SizedBox(width: 12),
                _buildStatCard("SAMPLES", "${widget.event.totalSamples}", AppColors.primary),
                const SizedBox(width: 12),
                _buildStatCard("HITS", "${widget.event.positiveHits}", AppColors.primary),
              ],
            ),

            const SizedBox(height: 40),

            // 3. Блок "Проверка Реальности"
            const Text(
              "REALITY_CHECK_PROTOCOL:",
              style: TextStyle(color: AppColors.accent, letterSpacing: 2, fontSize: 12),
            ),
            const SizedBox(height: 20),
            
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                children: [
                  const Text(
                    "Сбылось ли событие или подтвердилось ли решение?",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _buildFeedbackButton(
                          label: "НЕТ / DIVERGENCE",
                          value: false,
                          activeColor: AppColors.error,
                          icon: Icons.close,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildFeedbackButton(
                          label: "ДА / CONVERGENCE",
                          value: true,
                          activeColor: Colors.greenAccent, // Можно вынести в theme
                          icon: Icons.check,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            
            // Пояснение
            if (_isFulfilled != null)
              Center(
                child: Text(
                  _isFulfilled! 
                      ? ">> СОБЫТИЕ ЗАФИКСИРОВАНО В ИСТОРИИ <<" 
                      : ">> ОТКЛОНЕНИЕ ОТ ВЕРОЯТНОСТИ ЗАФИКСИРОВАНО <<",
                  style: TextStyle(
                    color: _isFulfilled! ? Colors.greenAccent : AppColors.error,
                    fontFamily: 'Monospace',
                    fontSize: 10,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color valueColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          children: [
            Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: valueColor)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 10, color: Colors.white38)),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackButton({
    required String label,
    required bool value,
    required Color activeColor,
    required IconData icon,
  }) {
    bool isSelected = _isFulfilled == value;
    
    return GestureDetector(
      onTap: () => _updateStatus(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? activeColor.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isSelected ? activeColor : Colors.white10,
            width: isSelected ? 2 : 1
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? activeColor : Colors.white24),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: isSelected ? activeColor : Colors.white24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}