import 'package:bpexch/Service/logo_service.dart';
import 'package:bpexch/auth/loginscreen.dart';
import 'package:bpexch/model/company_info_service.dart';
import 'package:bpexch/provider/animation_provider.dart';
import 'package:bpexch/provider/pagestate_provider.dart';
import 'package:bpexch/provider/payment_method_provider.dart';
import 'package:bpexch/provider/webview_provider.dart';
import 'package:bpexch/utils/saveToken.dart';
import 'package:bpexch/view/BottomNavBar/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final token = await getToken();
  final user = await getUser();

  // ignore: avoid_print
  print('*************Stored Token: $token*************');
  if (user != null) {
    // ignore: avoid_print
    print('*************User Data: ${user.name}*************');
  } else {
    // ignore: avoid_print
    print('*************No user data found*************');
  }

  final companyInfoService = CompanyInfoService();
  final companyInfo = await companyInfoService.fetchCompanyInfo();

  if (companyInfo != null) {
    // ignore: avoid_print
    print('*************Fetched Company Info: $companyInfo*************');
  } else {
    // ignore: avoid_print
    print('*************Failed to fetch company info*************');
  }

  final logoService = LogoService();
  await logoService.fetchAndSaveCompanyLogo();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? companyLogoBase64 = prefs.getString('company_logo');
  if (companyLogoBase64 != null) {
    // ignore: avoid_print
    print(
        '*************Logo fetched successfully. Base64 String: $companyLogoBase64*************');
  } else {
    // ignore: avoid_print
    print('*************No logo found in SharedPreferences*************');
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
            ? BottomNavBarScreen(user: user)
            : LoginScreen(companyInfo: companyInfo),
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
