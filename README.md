# MST тестовое задание 

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

## Архитектура
Сочетание Clean Architecture + MVVM (в presentation)
UI->ViewModel(ChangeNotifier, bloc, riverpod)->Usecase(опционально - бизнес логика)->repo->source 

Сгенерированное
objectbox.g.dart, objectbox-model.json
app/router/app_router.gr.dart

## Дополнение
Кейсы, которые стоит и нужно обновить в реальном проекте:
- Обработка покупок и получение тарифов, статусов подписки. Сейчас это локальная заглушка, которая не выполняет реальную цепочку при покупке (обработка статуса и тд).
- Обработка ошибок. Отдельный глобальный сервис для обработки и сортировки всех возможных ошибок, логирования и оповещения пользователя
- тема приложения (если нужна кастомная)
