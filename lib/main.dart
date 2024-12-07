import 'package:bpexch/auth/loginscreen.dart';
import 'package:bpexch/provider/animation_provider.dart';
import 'package:bpexch/provider/pagestate_provider.dart';
import 'package:bpexch/provider/payment_method_provider.dart';
import 'package:bpexch/provider/webview_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AnimationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PaymentMethodProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PageStateProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => WebViewProvider(),
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
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),
          home: const LoginScreen(),
        );
      },
    );
  }
}
