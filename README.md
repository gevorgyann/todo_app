# Todo App

A comprehensive Flutter todo application built with BLoC architecture pattern, featuring task management with status tracking, due dates, and local storage persistence.

## Features

- ✅ **Complete Task Management**: Create, read, update, and delete todos
- 🔄 **Status Tracking**: Organize tasks by status (To Do, In Progress, In Review, Completed)
- 📅 **Due Date Management**: Set and track task due dates with overdue indicators
- 💾 **Local Storage**: Persistent data storage using SharedPreferences
- 🎨 **Modern UI**: Clean, Material Design 3 interface with custom theming
- 🏗️ **BLoC Architecture**: Scalable state management with flutter_bloc
- 🔒 **Type Safety**: Immutable data models using Freezed
- 📱 **Responsive Design**: Works seamlessly across different screen sizes

## Architecture

This app follows the **BLoC (Business Logic Component)** pattern for state management:

```
lib/
├── blocs/           # Business logic and state management
│   ├── events/      # BLoC events
│   ├── states/      # BLoC states
│   └── todo_bloc.dart
├── models/          # Data models (Freezed)
├── screens/         # UI screens
├── widgets/         # Reusable UI components
├── services/        # Data layer (repository pattern)
├── utils/           # Utilities and constants
└── main.dart
```

## Tech Stack

- **Flutter**: UI framework
- **flutter_bloc**: State management
- **freezed**: Immutable data classes
- **shared_preferences**: Local data persistence
- **equatable**: Value equality comparisons
- **flutter_slidable**: Swipe actions
- **intl**: Internationalization and date formatting

## Getting Started

### Prerequisites

- Flutter SDK (>= 3.9.2)
- Dart SDK
- Android Studio / VS Code
- iOS Simulator / Android Emulator

### Installation

1. Clone the repository:
```bash
git clone <your-repo-url>
cd todo_app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Generate code (for Freezed models):
```bash
flutter packages pub run build_runner build
```

4. Run the app:
```bash
flutter run
```

## Usage

### Creating a Todo
1. Tap the floating action button (➕)
2. Fill in the title and description
3. Optionally set a due date
4. Tap "Add" to create the todo

### Managing Todos
- **Complete**: Tap the checkbox or swipe right
- **Edit**: Tap on the todo item
- **Delete**: Swipe left on the todo item
- **Change Status**: Long press and select new status

### Status Categories
- **К выполнению (To Do)**: New tasks waiting to be started
- **В работе (In Progress)**: Tasks currently being worked on
- **На проверке (In Review)**: Tasks pending review
- **Выполнено (Completed)**: Finished tasks

## Data Model

```dart
class Todo {
  final String id;
  final String title;
  final String description;
  final TodoStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? dueDate;
}
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Future Enhancements

- [ ] Categories and tags
- [ ] Task priorities
- [ ] Reminder notifications
- [ ] Team collaboration
- [ ] Dark mode support
- [ ] Export/Import functionality
