import 'package:flutter/material.dart';
import '../../core/theme.dart';

class SigmaChart extends StatelessWidget {
  final List<double> dataPoints; // История сигм
  final int totalPoints;         // Целевое количество (например, 100)

  const SigmaChart({
    super.key,
    required this.dataPoints,
    required this.totalPoints,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, double.infinity),
      painter: _SigmaChartPainter(
        data: dataPoints,
        maxX: totalPoints,
      ),
    );
  }
}

class _SigmaChartPainter extends CustomPainter {
  final List<double> data;
  final int maxX;
  // Максимальная амплитуда графика по Y (от -4 до +4 сигма)
  final double maxYRange = 4.0; 

  _SigmaChartPainter({required this.data, required this.maxX});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final centerY = size.height / 2;
    // Масштаб: сколько пикселей в одной сигме
    final scaleY = centerY / maxYRange;
    // Шаг по оси X
    final stepX = size.width / (maxX - 1);

    // 1. Рисуем центральную линию (0-sigma)
    paint.color = Colors.white.withOpacity(0.1);
    canvas.drawLine(
      Offset(0, centerY),
      Offset(size.width, centerY),
      paint
    );

    // 2. Рисуем пороговые линии (опционально, для красоты)
    paint.color = AppColors.accent.withOpacity(0.1); // 2 sigma
    canvas.drawLine(Offset(0, centerY - 2 * scaleY), Offset(size.width, centerY - 2 * scaleY), paint);
    canvas.drawLine(Offset(0, centerY + 2 * scaleY), Offset(size.width, centerY + 2 * scaleY), paint);
    
    paint.color = AppColors.error.withOpacity(0.1); // 3 sigma
    canvas.drawLine(Offset(0, centerY - 3 * scaleY), Offset(size.width, centerY - 3 * scaleY), paint);
    canvas.drawLine(Offset(0, centerY + 3 * scaleY), Offset(size.width, centerY + 3 * scaleY), paint);


    if (data.isEmpty) return;

    // 3. Рисуем основной график
    Path path = Path();
    // Начинаем с первой точки
    path.moveTo(0, centerY - (data[0] * scaleY));

    for (int i = 1; i < data.length; i++) {
      double x = i * stepX;
      double y = centerY - (data[i] * scaleY);
      path.lineTo(x, y);
    }

    // Определяем цвет линии по последней точке
    double lastValue = data.last.abs();
    if (lastValue > 3.0) {
      paint.color = AppColors.error;
      paint.strokeWidth = 3.0; // Делаем толще при аномалии
      // paint.shadowColor = AppColors.error;
      // paint.elevation = 10; // (Это не работает в Paint, но для понимания идеи)
    } else if (lastValue > 2.0) {
      paint.color = AppColors.accent;
       paint.strokeWidth = 2.5;
    } else {
      paint.color = AppColors.primary;
      paint.strokeWidth = 2.0;
    }
    
    // Добавляем свечение (простой способ)
    canvas.drawPath(path, paint..maskFilter = const MaskFilter.blur(BlurStyle.solid, 4));
    // Рисуем саму линию поверх свечения
    canvas.drawPath(path, paint..maskFilter = null);
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true; // Перерисовываем всегда при новых данных
}