class AppStrings {
  static const String lang = 'ru'; // Переключай на 'en' здесь

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'app_title': 'CHRONO_LOG // V.0.1',
      'dashboard_empty': 'NO_DATA',
      'dashboard_waiting': 'WAITING FOR INPUT...',
      'new_entry_title': 'NEW_ENTRY // CONTEXT',
      'query_label': 'QUERY_PROTOCOL:',
      'query_hint': 'Enter your question or intent...',
      'importance_label': 'IMPORTANCE_LEVEL:',
      'type_label': 'EVENT_TYPE:',
      'btn_start': 'INITIALIZE_SEQUENCE >>',
      'type_decision': 'DECISION',
      'type_prediction': 'PREDICTION',
      'type_calibration': 'CALIBRATION',
      // Подсказки
      'coach_add_title': 'New Observation',
      'coach_add_desc': 'Start here to log a new event or decision.',

      // ...
      // В секции 'en' (аналогично)
      'lore_btn_start_title': 'Sequence Initiation',
      'lore_btn_start_desc': 'Starting the quantum entropy generator. The system will begin searching for probabilistic paths matching your intent.',
      'lore_btn_commit_title': 'Wave Collapse',
      'lore_btn_commit_desc': 'Pressing this button collapses the wavefunction. The event is logged and becomes part of your personal history.',

    },
    'ru': {
      'app_title': 'ХРОНО_ЛОГ // В.0.1',
      'dashboard_empty': 'НЕТ_ДАННЫХ',
      'dashboard_waiting': 'ОЖИДАНИЕ ВВОДА...',
      'new_entry_title': 'НОВАЯ_ЗАПИСЬ // КОНТЕКСТ',
      'query_label': 'ПРОТОКОЛ_ЗАПРОСА:',
      'query_hint': 'Введите ваш вопрос или намерение...',
      'importance_label': 'УРОВЕНЬ_ВАЖНОСТИ:',
      'type_label': 'ТИП_СОБЫТИЯ:',
      'btn_start': 'ИНИЦИАЛИЗАЦИЯ >>',
      'type_decision': 'РЕШЕНИЕ',
      'type_prediction': 'ПРЕДСКАЗАНИЕ',
      'type_calibration': 'КАЛИБРОВКА',
      // Подсказки
      'coach_add_title': 'Новое наблюдение',
      'coach_add_desc': 'Нажмите здесь, чтобы зафиксировать событие или задать вопрос Вселенной.',

      // Simulation Screen
      'sim_running': 'СИМУЛЯЦИЯ_АКТИВНА...',
      'sim_complete': 'СИМУЛЯЦИЯ ЗАВЕРШЕНА',
      'sim_grid_label': 'ЭНТРОПИЙНАЯ РЕШЕТКА',
      'sim_sigma_label': 'ТЕКУЩЕЕ ОТКЛОНЕНИЕ',
      'btn_commit': 'ЗАФИКСИРОВАТЬ НАБЛЮДЕНИЕ',
      
      // Lore / Explanations (Заголовки и тексты)
      'lore_grid_title': 'Энтропийная Решетка (10x10)',
      'lore_grid_desc': 'Визуализация 100 квантовых событий. Каждый бит — это бросок монеты. Золотой = Орел (1), Серый = Решка (0). Паттерны кластеризации могут указывать на вмешательство.',
      
      'lore_sigma_title': 'Z-Оценка (Сигма)',
      'lore_sigma_desc': 'Мера невероятности события. \n\n0σ - 2σ: Нормальный шум.\n2σ - 3σ: Аномалия (Вероятность < 5%).\n>3σ: Критический сбой реальности (Вероятность < 0.3%).',
      
      'lore_btn_title': 'Фиксация Волны',
      'lore_btn_desc': 'Нажатие этой кнопки коллапсирует волновую функцию. Событие записывается в журнал и становится частью вашей личной истории.',

      // Lore для Input Screen
      'lore_input_query_title': 'Протокол Намерения',
      'lore_input_query_desc': 'Четко сформулируйте вопрос или действие. Вселенная реагирует на наблюдателя. Чем конкретнее запрос, тем меньше квантового шума будет в ответе.',
      
      'lore_input_imp_title': 'Гравитационный Вес (1-10)',
      'lore_input_imp_desc': 'Субъективная значимость события для вашей временной линии.\n\n1-3: Бытовой шум (Еда, мелкий выбор).\n4-7: Локальные события (Встречи, рабочие задачи).\n8-10: Точки бифуркации (Судьбоносные решения).',
      
      'lore_input_type_title': 'Тип Взаимодействия',
      'lore_input_type_desc': 'РЕШЕНИЕ: Активный поиск ответа "Как поступить?".\nПРЕДСКАЗАНИЕ: Пассивное наблюдение будущего.\nКАЛИБРОВКА: Тест датчиков на нейтральных событиях.',

      // Кнопка запуска
      'lore_btn_start_title': 'Инициализация Последовательности',
      'lore_btn_start_desc': 'Запуск генератора квантовой энтропии. Система начнет поиск вероятностных путей, соответствующих вашему намерению.',

      'lore_btn_commit_title': 'Фиксация Волны',
      'lore_btn_commit_desc': 'Нажатие этой кнопки коллапсирует волновую функцию. Событие записывается в журнал и становится частью вашей личной истории.',
    },
  };

  static String get(String key) {
    return _localizedValues[lang]?[key] ?? key;
  }
}