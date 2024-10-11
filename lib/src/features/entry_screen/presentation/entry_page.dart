import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/app_colors.dart';
import '../../sensor_part/presentation/sensor_screen.dart';
import '../../todo_screen/presentation/todo_splash_screen.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({super.key});

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _body(context));
  }

  Widget _body(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          btnWidget(
              context: context,
              btnColor: AppColors.primaryColor,
              btnTittle: "A To-Do List",
              btnTextColor: Colors.black,
              btnFunc: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SplashTodoScreen(),
                  ),
                );
              }),
          SizedBox(
            height: 8.h,
          ),
          btnWidget(
              context: context,
              btnColor: AppColors.secondaryPrimaryColor,
              btnTextColor: Colors.white,
              btnTittle: "Sensor Tracking",
              btnFunc: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const SensorDetailScreen()),
                  (Route<dynamic> route) => false,
                );
              }),
        ],
      ),
    );
  }

  Widget btnWidget(
      {required BuildContext context,
      required Color btnColor,
      required Color btnTextColor,
      required String btnTittle,
      required VoidCallback btnFunc}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 76.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          backgroundColor: btnColor,
        ),
        onPressed: btnFunc,
        child: Text(
          btnTittle,
          style: TextStyle(
            color: btnTextColor,
            fontSize: 21.sp,
          ),
        ),
      ),
    );
  }
}
