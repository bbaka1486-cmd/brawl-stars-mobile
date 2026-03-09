# Инструкция по сборке APK для Brawl Stars Mobile

## Требования
- Flutter SDK (установлен)
- Android SDK
- Java Development Kit (JDK 17 или выше)
- Android Studio (опционально)

## Способ 1: Локальная сборка на Windows/Mac/Linux

### 1. Установите Flutter
```bash
# Скачайте Flutter с https://flutter.dev/docs/get-started/install
# Добавьте Flutter в PATH
export PATH="$PATH:/path/to/flutter/bin"
```

### 2. Установите Android SDK
```bash
# На Windows/Mac используйте Android Studio
# На Linux:
sudo apt-get install android-sdk
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
```

### 3. Примите лицензии Android
```bash
flutter doctor --android-licenses
```

### 4. Соберите APK
```bash
cd brawl_stars_mobile
flutter build apk --release
```

APK будет создан в: `build/app/outputs/flutter-apk/app-release.apk`

## Способ 2: Облачная сборка (Codemagic)

1. Перейдите на https://codemagic.io
2. Подключите ваш GitHub репозиторий
3. Выберите Flutter как платформу
4. Нажмите "Build" для Android
5. Скачайте готовый APK

## Способ 3: GitHub Actions

Используйте GitHub Actions для автоматической сборки APK при каждом push.

## Структура проекта

```
brawl_stars_mobile/
├── lib/
│   ├── main.dart              # Главный файл приложения
│   ├── game/
│   │   └── brawl_stars_game.dart  # Основной класс игры
│   └── components/
│       ├── player.dart        # Компонент игрока
│       ├── enemy.dart         # Компонент врага
│       └── bullet.dart        # Компонент пули
├── android/                   # Конфигурация Android
├── pubspec.yaml              # Зависимости проекта
└── README.md                 # Информация о проекте
```

## Игровая механика

- **Управление**: Касание и перетаскивание для движения
- **Стрельба**: Касание экрана для выстрела
- **Враги**: Оранжевые враги движутся к игроку
- **Здоровье**: Снижается при контакте с врагами
- **Очки**: +100 за каждого убитого врага

## Возможные ошибки и решения

### "No Android SDK found"
Установите Android SDK и установите переменную окружения ANDROID_HOME

### "Java version not compatible"
Обновите Java до версии 17 или выше

### "Gradle build failed"
Очистите кэш:
```bash
flutter clean
flutter pub get
flutter build apk --release
```

## Контакты и поддержка

Для вопросов посетите:
- Flutter документация: https://flutter.dev/docs
- Flame engine: https://flame-engine.org
- GitHub Issues: https://github.com/flutter/flutter/issues
