import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Для вибрации (Haptics)
import '../../core/theme.dart';
import '../../core/strings.dart';
import '../../data/models/chronos_event.dart';
import 'dashboard_screen.dart'; // Чтобы вернуться домой после завершения
import '../widgets/lore_dialog.dart';
import '../widgets/sigma_chart.dart';

class SimulationScreen extends StatefulWidget {
  final ChronosEvent event;

  const SimulationScreen({super.key, required this.event});

  @override
  State<SimulationScreen> createState() => _SimulationScreenState();
}

class _SimulationScreenState extends State<SimulationScreen> {
  // Константы симуляции
  static const int _targetSamples = 100; // Размер серии
  static const int _speedMs = 60; // Скорость анимации (чем меньше, тем быстрее)

  final Random _random = Random();
  Timer? _timer;
  
  // Состояние
  List<bool> _results = []; // true = Heads (Gold), false = Tails (Gray)
  int _headsCount = 0;
  bool _isComplete = false;
  List<double> _sigmaHistory = [];

  @override
  void initState() {
    super.initState();
    _startSimulation();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Z-Score в реальном времени
  double get _currentSigma {
    if (_results.isEmpty) return 0.0;
    double expected = _results.length * 0.5;
    double stdDev = sqrt(_results.length * 0.25);
    if (stdDev == 0) return 0.0;
    return (_headsCount - expected) / stdDev;
  }

  void _startSimulation() {
    _timer = Timer.periodic(const Duration(milliseconds: _speedMs), (timer) {
      if (_results.length >= _targetSamples) {
        _finishSimulation();
      } else {
        _generateBit();
      }
    });
  }

  void _generateBit() {
    setState(() {
      bool isHead = _random.nextBool();
      _results.add(isHead);
      if (isHead) _headsCount++;
      
      _sigmaHistory.add(_currentSigma);      
      
      // Вибрация на аномалиях (если сигма скачет)
      if (_currentSigma.abs() > 2.0) {
        HapticFeedback.selectionClick(); 
      }
    });
  }

  void _finishSimulation() {
    _timer?.cancel();
    setState(() {
      _isComplete = true;
    });
    // Финальная тяжелая вибрация при завершении
    HapticFeedback.heavyImpact();
  }

  void _saveAndExit() {
    // TODO: Здесь мы будем сохранять результат в БД (Phase 3)
    // Пока просто обновляем модель и печатаем в консоль
    final resultEvent = ChronosEvent(
      id: widget.event.id,
      query: widget.event.query,
      importance: widget.event.importance,
      type: widget.event.type,
      timestamp: widget.event.timestamp,
      totalSamples: _targetSamples,
      positiveHits: _headsCount,
      sigma: _currentSigma,
    );

    print("SAVED: Sigma=${resultEvent.sigma.toStringAsFixed(2)}");

    // Возвращаемся на дэшборд, сбрасывая все экраны до него
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const DashboardScreen()),
      (Route<dynamic> route) => false,
    );
  }

  Color _getSigmaColor(double sigma) {
    if (sigma.abs() >= 3.0) return AppColors.error;
    if (sigma.abs() >= 2.0) return AppColors.accent;
    return AppColors.primary;
  }

  @override
  Widget build(BuildContext context) {
    double sigma = _currentSigma;
    Color statusColor = _getSigmaColor(sigma);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Header (Context)
              Text(
                _isComplete ? AppStrings.get('sim_complete') : AppStrings.get('sim_running'), 
                style: TextStyle(fontFamily: 'Monospace', color: Colors.grey[600], letterSpacing: 2)
              ),
              const SizedBox(height: 8),
              Text(
                widget.event.query.toUpperCase(),
                style: const TextStyle(
                  fontFamily: 'Monospace', 
                  fontSize: 18, 
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 30),

              // 2. The Entropy Grid (10x10)
              Expanded(
                child: Center(
                  child: LoreWrapper(
                    titleKey: 'lore_grid_title',
                    descKey: 'lore_grid_desc',
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 10,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                        ),
                        itemCount: _targetSamples,
                        itemBuilder: (context, index) {
                          // Если бит еще не сгенерирован - показываем пустую ячейку
                          if (index >= _results.length) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            );
                          }
                          
                          // Если бит есть - красим
                          bool isHead = _results[index];
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              color: isHead ? AppColors.primary : const Color(0xFF2A2A35),
                              borderRadius: BorderRadius.circular(2),
                              boxShadow: isHead 
                                ? [BoxShadow(color: AppColors.primary.withOpacity(0.4), blurRadius: 4)]
                                : [],
                            ),
                          );
                        },
                      ),
                    ), 
                  ),
                ),
              ),

              // 3. Stats & Result
              LoreWrapper( // <--- ОБЕРТКА
                titleKey: 'lore_sigma_title',
                descKey: 'lore_sigma_desc',
                child: Column(
                  children: [
                    Text(
                      sigma.toStringAsFixed(2) + "σ",
                      style: TextStyle(
                        fontSize: 48, 
                        fontWeight: FontWeight.bold, 
                        color: statusColor,
                        shadows: [Shadow(color: statusColor.withOpacity(0.5), blurRadius: 20)]
                      ),
                    ),
                    const Text("CURRENT DEVIATION", style: TextStyle(color: Colors.grey, fontSize: 10, letterSpacing: 2)),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              Expanded(
                flex: 2, // Даем ему побольше места
                child: Container(
                  // Небольшой фон и рамка для эстетики терминала
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    border: Border(
                      top: BorderSide(color: Colors.white.withOpacity(0.1)),
                      bottom: BorderSide(color: Colors.white.withOpacity(0.1)),
                    )
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  width: double.infinity,
                  // Сам график
                  child: SigmaChart(
                    dataPoints: _sigmaHistory,
                    totalPoints: _targetSamples,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 4. Action Button (появляется только в конце)
              SizedBox(
                height: 50,
                child: _isComplete 
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.surface,
                      side: BorderSide(color: statusColor),
                    ),
                    onPressed: _saveAndExit,
                    child: Row(
                      mainAxisSize: MainAxisSize.min, // Чтобы кнопка не растягивалась слишком сильно
                      children: [
                        Text(AppStrings.get('btn_commit'), style: const TextStyle(letterSpacing: 2)),
                        const SizedBox(width: 12),
                        LoreWrapper(
                          titleKey: 'lore_btn_commit_title',
                          descKey: 'lore_btn_commit_desc',
                          child: const Icon(Icons.info_outline, size: 20, color: AppColors.accent),
                        ),
                      ],
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}