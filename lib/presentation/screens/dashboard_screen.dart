import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../../core/theme.dart';
import '../../core/strings.dart';
import 'input_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Ключ для элемента, который хотим подсветить
  final GlobalKey _fabKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // Показываем подсказку через 1 секунду после запуска (только один раз надо бы, но пока всегда)
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.get('app_title')),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
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
      ),
      floatingActionButton: FloatingActionButton(
        key: _fabKey, // Привязываем ключ сюда
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