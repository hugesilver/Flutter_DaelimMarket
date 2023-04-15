import 'package:daelim_market/router/app_router.dart';
import 'package:daelim_market/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const DaelimMarket());
}

class DaelimMarket extends StatelessWidget {
  const DaelimMarket({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (context, child) {
        return MaterialApp.router(
          theme: ThemeData(scaffoldBackgroundColor: dmWhite),
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.config,
        );
      },
    );
  }
}