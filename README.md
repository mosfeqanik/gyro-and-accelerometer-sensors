# Todo List App with Sensor Features

This project is a **Todo List application** where users can create and manage multiple todo lists, add tasks to each list, and interact with device sensors. The app is built using Flutter with state management handled by the `provider` package, and data persistence powered by `sqflite`.

## Features

### 1. **Todo Lists & Tasks**
- Users can create and manage multiple todo lists.
- Each todo list can have multiple tasks.
- Data persistence is implemented using `sqflite` and `path` packages.

**Relevant Code:**
- Data Layer: [`database.dart`](lib/src/core/data/database.dart)
- State Management: [`todo_provider.dart`](lib/src/features/todo_screen/provider/todo_provider.dart)

### 2. **Sensor Integration**
- The app includes integration with the device's gyroscope and accelerometer sensors.
- Users can view live sensor data in the app.

**Relevant Code:**
- Sensor Screen: [`sensor_screen.dart`](lib/src/features/sensor_part/presentation/sensor_screen.dart)
- Sensor Provider: [`sensor_provider.dart`](lib/src/features/sensor_part/provider/sensor_provider.dart)

## Packages Used
- **State Management**: [`provider`](https://pub.dev/packages/provider)
- **Local Database**: [`sqflite`](https://pub.dev/packages/sqflite), [`path`](https://pub.dev/packages/path)
- **Sensor Handling**: [`sensors_plus`](https://pub.dev/packages/sensors_plus)


