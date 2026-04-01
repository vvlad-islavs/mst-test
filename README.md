<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-04-01 at 16 46 05" src="https://github.com/user-attachments/assets/0ed88f3e-c554-446c-bb4c-a8f5c8cb6b2e" /># MST тестовое задание 

## Запуск

Установить dart, Flutter и подключить к проекту
Команды для запуска: 
flutter pub get
flutter run 

## Структура
Верхний уровень lib/
  app/: роутер
  app/router/app_router.dart, app/router/router.dart 
    core/: общий слой приложения (data/domain/di + утилиты/презентационные общие вещи)
    core/core.dart — общий barrel (data, domain, di)
    features/: фичи по экранам
    features/welcome/, features/general/, features/payload/
      дальше presentation/... с screens/, view_models/, widgets/ (где нужно)
      
Сгенерированное
objectbox.g.dart, objectbox-model.json
app/router/app_router.gr.dar

## Архитектура
Сочетание Clean Architecture + MVVM (в presentation)
UI->ViewModel(ChangeNotifier, bloc, riverpod)->Usecase(опционально - бизнес логика)->repo->source 

## Дополнение
Кейсы, которые стоит и нужно обновить в реальном проекте:
- Обработка покупок и получение тарифов, статусов подписки. Сейчас это локальная заглушка, которая не выполняет реальную цепочку при покупке (обработка статуса и тд).
- Обработка ошибок. Отдельный глобальный сервис для обработки и сортировки всех возможных ошибок, логирования и оповещения пользователя
- тема приложения (если нужна кастомная)

<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-04-01 at 16 46 05" src="https://github.com/user-attachments/assets/365da17f-6d18-4599-87a1-5b5515258de8" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-04-01 at 16 46 23" src="https://github.com/user-attachments/assets/2c06b317-76f5-4b0f-88d0-36c6ba26799d" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-04-01 at 16 46 26" src="https://github.com/user-attachments/assets/67f179ed-26b2-41f5-8b69-d40d263883d8" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-04-01 at 16 51 28" src="https://github.com/user-attachments/assets/727e2a21-c191-4690-9654-9253be3c75f2" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-04-01 at 16 51 31" src="https://github.com/user-attachments/assets/1ce35d1f-f440-4d5b-b03b-ce6dc55be29b" />








