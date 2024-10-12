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

## ScreenShots of application
<br /> 
<img align="left" alt="verify_page" width="100%"  src="https://github.com/mosfeqanik/todo-with-gyro-and-accelerometer-sensors/blob/main/assesment_screenshot/app_banner_5.jpg" />
![App Demo](https://github.com/mosfeqanik/todo-with-gyro-and-accelerometer-sensors/blob/main/assesment_screenshot/full%20app%20screenplay.gif)

## Getting Started

To run the project locally, follow these steps:

1. Clone the repository:
    ```bash
    git clone https://github.com/your-username/todo-sensor-app.git
    ```

2. Install the dependencies:
    ```bash
    flutter pub get
    ```

3. Run the app:
    ```bash
    flutter run
    ```

## Folder Structure

```plaintext
lib/
│
├── src/
│   ├── core/
│   │   └── data/
│   │       └── database.dart          # SQLite database setup and operations
│   ├── features/
│   │   ├── todo_screen/
│   │   │   └── provider/
│   │   │       └── todo_provider.dart  # State management for todo feature
│   │   ├── sensor_part/
│   │   │   ├── presentation/
│   │   │   │   └── sensor_screen.dart  # UI for sensor data display
│   │   │   └── provider/
│   │   │       └── sensor_provider.dart # Sensor data provider
