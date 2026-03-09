# 🎮 Brawl Stars Mobile 2D

Полнофункциональная 2D мобильная игра на **Flutter** с использованием **Flame engine**. Игра оптимизирована для Android и iOS.

## 📋 Требования

- Flutter 3.41.4 или выше
- Dart 3.11.1 или выше
- Android SDK (для Android сборки)
- Xcode (для iOS сборки)

## 🚀 Быстрый старт

### 1. Клонируйте репозиторий
```bash
git clone https://github.com/bbaka1486-cmd/brawl-stars-mobile.git
cd brawl-stars-mobile
```

### 2. Установите зависимости
```bash
flutter pub get
```

### 3. Запустите на эмуляторе
```bash
# Android
flutter run -d emulator-5554

# iOS
flutter run -d iPhone
```

### 4. Соберите APK для Android
```bash
flutter build apk --release
```

APK будет создан в: `build/app/outputs/flutter-apk/app-release.apk`

## 🎯 Игровая механика

### Управление
- **Касание + перетаскивание** — движение персонажа (зеленый круг)
- **Касание** — стрельба в направлении касания

### Враги
- **Оранжевые враги** — движутся к вам и наносят урон при контакте
- Враги спавнятся случайно на арене

### Система здоровья и очков
- **Здоровье**: 100 HP, уменьшается на 5 при контакте с врагом
- **Очки**: +100 за каждого убитого врага
- **Game Over**: когда здоровье достигает 0

## 🏗️ Структура проекта

```
brawl_stars_mobile/
├── lib/
│   ├── main.dart                    # Главный файл приложения
│   ├── game/
│   │   └── brawl_stars_game.dart    # Основной класс игры (Flame Game)
│   └── components/
│       ├── player.dart              # Компонент игрока
│       ├── enemy.dart               # Компонент врага
│       └── bullet.dart              # Компонент пули
├── android/                         # Конфигурация Android
├── ios/                             # Конфигурация iOS
├── .github/
│   └── workflows/
│       └── build-apk.yml            # GitHub Actions для автоматической сборки
├── codemagic.yaml                   # Конфигурация Codemagic
├── pubspec.yaml                     # Зависимости проекта
└── README.md                        # Этот файл
```

## 📦 Зависимости

- **flame**: ^1.36.0 — 2D game engine для Flutter
- **flutter**: ^3.41.4

## 🔨 Сборка

### Локальная сборка

#### Android
```bash
# Debug
flutter build apk --debug

# Release
flutter build apk --release
```

#### iOS
```bash
# Debug
flutter build ios --debug

# Release
flutter build ios --release
```

### Облачная сборка с Codemagic

1. Перейдите на https://codemagic.io
2. Подключите ваш GitHub репозиторий
3. Выберите `codemagic.yaml` конфигурацию
4. Нажмите "Build"
5. Скачайте готовый APK

### Автоматическая сборка с GitHub Actions

Проект настроен на автоматическую сборку при каждом push в master/main/develop:

1. Перейдите в "Actions" на GitHub
2. Выберите "Build APK"
3. APK будет доступен в artifacts

## 🐛 Решение проблем

### "No Android SDK found"
```bash
# Установите Android SDK
flutter doctor --android-licenses

# Или установите ANDROID_HOME
export ANDROID_HOME=$HOME/Android/Sdk
```

### "Java version not compatible"
Обновите Java до версии 11 или выше:
```bash
java -version
```

### "Gradle build failed"
Очистите кэш:
```bash
flutter clean
flutter pub get
flutter build apk --release
```

### "CocoaPods error" (iOS)
```bash
cd ios
pod repo update
pod install
cd ..
```

## 📱 Установка APK на устройство

```bash
# Через adb
adb install build/app/outputs/flutter-apk/app-release.apk

# Или просто скопируйте APK на устройство и откройте его
```

## 🎨 Кастомизация

### Изменение цветов
Отредактируйте цвета в компонентах:
- `lib/components/player.dart` — цвет игрока
- `lib/components/enemy.dart` — цвет врагов
- `lib/components/bullet.dart` — цвет пуль

### Изменение сложности
В `lib/game/brawl_stars_game.dart`:
```dart
void spawnEnemies(int count) {
  // Измените count для большего количества врагов
}
```

### Изменение скорости
В компонентах:
```dart
double speed = 200; // Измените значение
```

## 📚 Документация

- [Flutter Documentation](https://flutter.dev/docs)
- [Flame Engine Docs](https://flame-engine.org)
- [Dart Language](https://dart.dev)

## 🤝 Вклад

Приветствуются pull requests! Для больших изменений сначала откройте issue.

## 📄 Лицензия

MIT License - смотрите LICENSE файл для деталей

## 👨‍💻 Автор

Создано с ❤️ на Flutter и Flame

## 🔗 Ссылки

- GitHub: https://github.com/bbaka1486-cmd/brawl-stars-mobile
- Codemagic: https://codemagic.io
- Flutter: https://flutter.dev
- Flame: https://flame-engine.org

---

**Наслаждайтесь игрой!** 🎮
