import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme.dart';
import '../../core/strings.dart';
import '../../data/models/chronos_event.dart';
import 'dashboard_screen.dart';
import '../widgets/lore_dialog.dart';
import '../widgets/sigma_chart.dart';
import '../../data/database/isar_service.dart';

class SimulationScreen extends StatefulWidget {
  final ChronosEvent event;

  const SimulationScreen({super.key, required this.event});

  @override
  State<SimulationScreen> createState() => _SimulationScreenState();
}

class _SimulationScreenState extends State<SimulationScreen> {
  // Скорость анимации
  int get _speedMs {
    if (widget.event.totalSamples >= 1000) return 5; 
    if (widget.event.totalSamples >= 400) return 20;
    return 50; 
  }

  final Random _random = Random();
  Timer? _timer;
  
  List<bool> _results = [];
  int _headsCount = 0;
  bool _isComplete = false;
  List<double> _sigmaHistory = [];

  int get _targetSamples => widget.event.totalSamples;

  @override
  void initState() {
    super.initState();
    _sigmaHistory = [];
    _startSimulation();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  double get _currentSigma {
    if (_results.isEmpty) return 0.0;
    double expected = _results.length * 0.5;
    double stdDev = sqrt(_results.length * 0.25);
    if (stdDev == 0) return 0.0;
    return (_headsCount - expected) / stdDev;
  }

  void _startSimulation() {
    _timer = Timer.periodic(Duration(milliseconds: _speedMs), (timer) {
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
      
      if (_currentSigma.abs() > 2.0) {
        HapticFeedback.selectionClick(); 
      }
    });
  }

  void _finishSimulation() {
    _timer?.cancel();
    
    // АВТО-СОХРАНЕНИЕ
    _autoSaveResult();

    setState(() {
      _isComplete = true;
    });
    HapticFeedback.heavyImpact();
  }

  void _autoSaveResult() async {
    // Создаем экземпляр модели с результатами
    final resultEvent = ChronosEvent(
      query: widget.event.query,
      importance: widget.event.importance,
      totalSamples: _targetSamples,
      type: widget.event.type,
      timestamp: DateTime.now(), // Фиксируем время завершения
      positiveHits: _headsCount,
      sigma: _currentSigma,
      isFulfilled: null, // Пока неизвестно
    );

    // Сохраняем в базу
    final isarService = IsarService();
    await isarService.saveEvent(resultEvent);
    
    print("DB SAVED: Sigma=${resultEvent.sigma.toStringAsFixed(2)}");
  }

  void _exit() {
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

  // Получение текстов для вердикта
  Map<String, String> _getResultStrings(double sigma) {
    double abs = sigma.abs();
    if (abs >= 3.0) {
      return {
        'title': AppStrings.get('result_crit_title'),
        'desc': AppStrings.get('result_crit_desc'),
      };
    } else if (abs >= 2.0) {
      return {
        'title': AppStrings.get('result_warn_title'),
        'desc': AppStrings.get('result_warn_desc'),
      };
    } else {
      return {
        'title': AppStrings.get('result_norm_title'),
        'desc': AppStrings.get('result_norm_desc'),
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    double sigma = _currentSigma;
    Color statusColor = _getSigmaColor(sigma);
    final resultTexts = _getResultStrings(sigma);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
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

              const SizedBox(height: 20),

              // Grid
              Expanded(
                flex: 3, 
                child: Center(
                  child: LoreWrapper(
                    titleKey: 'lore_grid_title',
                    descKey: 'lore_grid_desc',
                    child: LayoutBuilder( 
                      builder: (context, constraints) {
                        int crossAxisCount = sqrt(_targetSamples).ceil();
                        return AspectRatio(
                          aspectRatio: 1.0, 
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              mainAxisSpacing: 2, 
                              crossAxisSpacing: 2,
                            ),
                            itemCount: _targetSamples, 
                            itemBuilder: (context, index) {
                              if (index >= _results.length) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.02),
                                    borderRadius: BorderRadius.circular(1),
                                  ),
                                );
                              }
                              bool isHead = _results[index];
                              return Container(
                                decoration: BoxDecoration(
                                  color: isHead ? AppColors.primary : const Color(0xFF2A2A35),
                                  borderRadius: BorderRadius.circular(1),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ), 
                  ),
                ),
              ),

              // Sigma
              LoreWrapper( 
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
                    Text(AppStrings.get('sim_sigma_label'), style: const TextStyle(color: Colors.grey, fontSize: 10, letterSpacing: 2)),
                  ],
                ),
              ),
              
              const SizedBox(height: 10),
              
              // Chart
              Expanded(
                flex: 2, 
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    border: Border(
                      top: BorderSide(color: Colors.white.withOpacity(0.1)),
                      bottom: BorderSide(color: Colors.white.withOpacity(0.1)),
                    )
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  width: double.infinity,
                  child: SigmaChart(
                    dataPoints: _sigmaHistory,
                    totalPoints: _targetSamples,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // RESULT PANEL (Вместо кнопки)
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 500),
                crossFadeState: _isComplete ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                
                // 1. Состояние загрузки (пустое место или индикатор)
                firstChild: const SizedBox(
                  height: 100,
                  child: Center(
                     child: Text("CALCULATING...", style: TextStyle(letterSpacing: 3, fontSize: 10, color: Colors.white24)),
                  ),
                ),
                
                // 2. Состояние результата (Вердикт + Кнопка выхода)
                secondChild: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    border: Border.all(color: statusColor.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [BoxShadow(color: statusColor.withOpacity(0.1), blurRadius: 10)]
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        resultTexts['title']!,
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          fontFamily: 'Monospace'
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        resultTexts['desc']!,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: statusColor.withOpacity(0.2),
                            foregroundColor: statusColor,
                          ),
                          onPressed: _exit,
                          child: Text(AppStrings.get('btn_acknowledge')),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}