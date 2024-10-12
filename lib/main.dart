import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/src/features/sensor_part/provider/sensor_provider.dart';
import '/src/features/todo_screen/provider/todo_provider.dart';
import 'src/features/entry_screen/presentation/entry_page.dart';
import 'package:provider/provider.dart';
import 'src/utils/app_assets.dart';
import 'src/utils/app_colors.dart';
import 'src/utils/local_storage_manager.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await ScreenUtil.ensureScreenSize();
  await dotenv.load(fileName: AppAssets.envFile);
  await LocalStorageManager.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SensorProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TodoNoteProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(390, 836),
      minTextAdapt: true,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
        ),
        useMaterial3: true,
      ),
      home: const EntryPage(),
    );
  }
}
