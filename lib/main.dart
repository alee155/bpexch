import 'package:bpexch/auth/loginscreen.dart';
import 'package:bpexch/provider/animation_provider.dart';
import 'package:bpexch/provider/pagestate_provider.dart';
import 'package:bpexch/provider/payment_method_provider.dart';
import 'package:bpexch/provider/webview_provider.dart';
import 'package:bpexch/utils/saveToken.dart';
import 'package:bpexch/view/BottomNavBar/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Retrieve token and user data
  final token = await getToken();
  final user = await getUser(); // Fetch the UserModel from SharedPreferences

  print('*************Stored Token: $token*************');

  // Print User data if available
  if (user != null) {
    print('*************User Data: ${user.name}*************');
  } else {
    print('*************No user data found*************');
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AnimationProvider()),
        ChangeNotifierProvider(create: (_) => PaymentMethodProvider()),
        ChangeNotifierProvider(create: (_) => PageStateProvider()),
        ChangeNotifierProvider(create: (_) => WebViewProvider()),
      ],
      child: MyApp(
        initialRoute: token != null && user != null
            ? BottomNavBarScreen(
                user:
                    user) // Navigate to BottomNavBarScreen if user is logged in
            : const LoginScreen(), // Else, show LoginScreen
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget initialRoute;

  const MyApp({super.key, required this.initialRoute});

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
          home: initialRoute,
        );
      },
    );
  }
}
