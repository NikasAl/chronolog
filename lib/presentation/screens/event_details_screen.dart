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
  late bool? _isFulfilled;

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
    // Форматирование даты
    final dateStr = "${widget.event.timestamp.day}/${widget.event.timestamp.month} ${widget.event.timestamp.hour}:${widget.event.timestamp.minute.toString().padLeft(2, '0')}";

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.get('details_title'), style: const TextStyle(letterSpacing: 2, fontSize: 14)),
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
              "$dateStr  |  ${AppStrings.get('details_type')}: ${AppStrings.get('type_${widget.event.type.name}')}",
              style: const TextStyle(color: Colors.white38, fontSize: 12),
            ),
            
            const Divider(color: Colors.white10, height: 40),

            // 2. Статистика (с ЛОРОМ)
            Row(
              children: [
                // Сигма
                _buildStatCard(
                  labelKey: 'stat_sigma',
                  value: "${widget.event.sigma.toStringAsFixed(2)}σ",
                  valueColor: color,
                  loreTitleKey: 'lore_stat_sigma_title',
                  loreDescKey: 'lore_stat_sigma_desc',
                ),
                const SizedBox(width: 12),
                // Выборка
                _buildStatCard(
                  labelKey: 'stat_samples',
                  value: "${widget.event.totalSamples}",
                  valueColor: AppColors.primary,
                  loreTitleKey: 'lore_stat_samples_title',
                  loreDescKey: 'lore_stat_samples_desc',
                ),
                const SizedBox(width: 12),
                // Попадания (Hits) - оставляем без лора или дублируем
                _buildStatCard(
                  labelKey: 'stat_hits',
                  value: "${widget.event.positiveHits}",
                  valueColor: AppColors.primary,
                  loreTitleKey: 'lore_grid_title', // Ссылка на общее описание сетки
                  loreDescKey: 'lore_grid_desc',
                ),
              ],
            ),

            const SizedBox(height: 40),

            // 3. Блок "Проверка Реальности"
            // Добавляем (i) с твоей теорией интерпретации
            LoreWrapper(
              titleKey: 'lore_interpretation_title',
              descKey: 'lore_interpretation_desc',
              child: Row(
                children: [
                  Text(
                    AppStrings.get('protocol_title'),
                    style: const TextStyle(color: AppColors.accent, letterSpacing: 2, fontSize: 12),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.help_outline, size: 16, color: AppColors.accent),
                ],
              ),
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
                  Text(
                    AppStrings.get('protocol_question'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _buildFeedbackButton(
                          label: AppStrings.get('btn_divergence'),
                          value: false,
                          activeColor: AppColors.error,
                          icon: Icons.close,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildFeedbackButton(
                          label: AppStrings.get('btn_convergence'),
                          value: true,
                          activeColor: Colors.greenAccent,
                          icon: Icons.check,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            
            // Статус
            if (_isFulfilled != null)
              Center(
                child: Text(
                  _isFulfilled! 
                      ? AppStrings.get('status_fixed')
                      : AppStrings.get('status_diverged'),
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

  // Обновленный виджет карточки со встроенным LoreWrapper
  Widget _buildStatCard({
    required String labelKey, 
    required String value, 
    required Color valueColor,
    required String loreTitleKey,
    required String loreDescKey,
  }) {
    return Expanded(
      child: LoreWrapper( // Оборачиваем всю карточку
        titleKey: loreTitleKey,
        descKey: loreDescKey,
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
              Text(AppStrings.get(labelKey), style: const TextStyle(fontSize: 10, color: Colors.white38)),
            ],
          ),
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
              textAlign: TextAlign.center,
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