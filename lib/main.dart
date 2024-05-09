
import 'package:firebase_core/firebase_core.dart';
import 'package:fitness/view/main_tab/main_tab_view.dart';
import 'package:fitness/view/on_boarding/on_boarding_view.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'common/colo_extension.dart';
import 'firebase_options.dart';
final navigatorKey = GlobalKey<NavigatorState>();
Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(child,
          maxWidth: 1200,
          minWidth: 480,

          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(410, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(410, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.resize(800, name: TABLET),
            const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(1000, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(1000, name: DESKTOP),
          ],
          background: Container(color: const Color(0xFFF5F5F5))),
      title: 'Fitness 3 in 1',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: TColor.primaryColor1,
        fontFamily: "Poppins"
      ),
      navigatorKey: navigatorKey,
      home: const OnBoardingView(),
    );
  }
}

