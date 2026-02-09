import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../core/strings.dart';

/// Виджет, который оборачивает элемент и показывает справку при клике
class LoreWrapper extends StatelessWidget {
  final Widget child;
  final String titleKey;
  final String descKey;

  const LoreWrapper({
    super.key,
    required this.child,
    required this.titleKey,
    required this.descKey,
  });

  void _showInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => _LoreDialog(
        title: AppStrings.get(titleKey),
        desc: AppStrings.get(descKey),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showInfo(context),
      behavior: HitTestBehavior.opaque, // Чтобы кликалось даже по прозрачным местам
      child: child,
    );
  }
}

/// Само диалоговое окно
class _LoreDialog extends StatelessWidget {
  final String title;
  final String desc;

  const _LoreDialog({required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent, // Прозрачный фон для кастомизации
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface.withOpacity(0.95), // Почти непрозрачный
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.accent, width: 1), // Неоновая рамка
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: 2,
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Заголовок
            Row(
              children: [
                const Icon(Icons.info_outline, color: AppColors.accent),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title.toUpperCase(),
                    style: const TextStyle(
                      color: AppColors.accent,
                      fontFamily: 'Monospace',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.white24, height: 30),
            // Текст
            Text(
              desc,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Monospace',
                height: 1.5,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            // Кнопка закрытия
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("CLOSE_TERMINAL >>", 
                  style: TextStyle(color: Colors.white54, letterSpacing: 2)),
              ),
            )
          ],
        ),
      ),
    );
  }
}