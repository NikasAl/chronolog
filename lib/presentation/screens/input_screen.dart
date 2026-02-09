import 'package:flutter/material.dart';
import '../../core/strings.dart';
import '../../core/theme.dart';
import '../../data/models/chronos_event.dart';
import 'simulation_screen.dart';
import '../widgets/lore_dialog.dart';


class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _queryController = TextEditingController();
  double _importance = 5.0;
  int _selectedSamples = 100; // По умолчанию
  final List<int> _sampleOptions = [100, 400, 1000];

  EventType _selectedType = EventType.prediction;

  void _initiateSequence() {
    if (_queryController.text.isEmpty) return;

    final event = ChronosEvent(
      query: _queryController.text,
      importance: _importance.toInt(),
      type: _selectedType,
      totalSamples: _selectedSamples,
      timestamp: DateTime.now(),
    );

    print("Event Created: ${event.query}, Importance: ${event.importance}");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SimulationScreen(event: event),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.get('new_entry_title')),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Ввод текста
            LoreWrapper(
              titleKey: 'lore_input_query_title',
              descKey: 'lore_input_query_desc',
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(AppStrings.get('query_label'), style: TextStyle(color: AppColors.accent)),
                  const SizedBox(width: 8),
                  const Icon(Icons.info_outline, size: 16, color: Colors.white24), // Иконка-подсказка
                ],
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _queryController,
              maxLines: 3,
              style: const TextStyle(fontFamily: 'Monospace', color: Colors.white),
              decoration: InputDecoration(
                hintText: AppStrings.get('query_hint'),
                hintStyle: TextStyle(color: Colors.white24),
              ),
            ),
            
            const SizedBox(height: 40),

            // 2. Важность (Slider)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LoreWrapper(
                  titleKey: 'lore_input_imp_title',
                  descKey: 'lore_input_imp_desc',
                  child: Row(
                    children: [
                      Text(AppStrings.get('importance_label'), style: TextStyle(color: AppColors.accent)),
                      const SizedBox(width: 8),
                      const Icon(Icons.info_outline, size: 16, color: Colors.white24),
                    ],
                  ),
                ),
                Text("${_importance.toInt()}", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary)),
              ],
            ),
            Slider(
              value: _importance,
              min: 1,
              max: 10,
              divisions: 9,
              activeColor: AppColors.primary,
              inactiveColor: AppColors.surface,
              onChanged: (val) => setState(() => _importance = val),
            ),

            const SizedBox(height: 40),

            // 3. Тип события (Chips)
            LoreWrapper(
              titleKey: 'lore_input_type_title',
              descKey: 'lore_input_type_desc',
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("EVENT_TYPE:", style: TextStyle(color: AppColors.accent)),
                  const SizedBox(width: 8),
                  const Icon(Icons.info_outline, size: 16, color: Colors.white24),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: EventType.values.map((type) {
                bool isSelected = _selectedType == type;
                return ChoiceChip(
                  label: Text(AppStrings.get('type_${type.name}')),
                  selected: isSelected,
                  selectedColor: AppColors.accent.withOpacity(0.2),
                  backgroundColor: AppColors.surface,
                  labelStyle: TextStyle(
                    color: isSelected ? AppColors.accent : Colors.white54,
                    fontFamily: 'Monospace',
                  ),
                  onSelected: (selected) {
                    if (selected) setState(() => _selectedType = type);
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 40),

            // 4. Размер выборки (Samples)
            LoreWrapper(
              titleKey: 'lore_samples_title',
              descKey: 'lore_samples_desc',
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(AppStrings.get('input_samples_label'), style: const TextStyle(color: AppColors.accent)),
                  const SizedBox(width: 8),
                  const Icon(Icons.info_outline, size: 16, color: Colors.white24),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Сегментированный переключатель
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.white10),
              ),
              child: Row(
                children: _sampleOptions.map((samples) {
                  bool isSelected = _selectedSamples == samples;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedSamples = samples),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.accent.withOpacity(0.2) : Colors.transparent,
                          borderRadius: BorderRadius.circular(2),
                          border: isSelected ? Border.all(color: AppColors.accent.withOpacity(0.5)) : null,
                        ),
                        child: Text(
                          "$samples",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Monospace',
                            fontWeight: FontWeight.bold,
                            color: isSelected ? AppColors.accent : Colors.white24,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const Spacer(),

            // 5. Кнопка запуска
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.surface,
                  foregroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: const BorderSide(color: AppColors.primary),
                  ),
                ),
                onPressed: _initiateSequence,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppStrings.get('btn_start'), style: const TextStyle(letterSpacing: 2)),
                    const SizedBox(width: 12),
                    // Наш виджет с лором
                    LoreWrapper(
                      titleKey: 'lore_btn_start_title',
                      descKey: 'lore_btn_start_desc',
                      child: const Icon(Icons.info_outline, size: 20, color: AppColors.accent),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}