import 'package:bpexch/Service/getStoredWhatsappNo.dart';
import 'package:bpexch/Service/launchWhatsApp.dart';
import 'package:bpexch/model/user_model.dart';
import 'package:bpexch/provider/pagestate_provider.dart';
import 'package:bpexch/utils/Reusable/blurred_background.dart';
import 'package:bpexch/utils/Reusable/glassycontainer.dart';
import 'package:bpexch/view/Drawer/drawer.dart';
import 'package:bpexch/view/HistoryScreen/history_screen.dart';
import 'package:bpexch/view/ImageCarousel.dart';
import 'package:bpexch/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  final UserModel user;
  String? companyInfo;
  AccountScreen({super.key, required this.user, this.companyInfo});
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;
  final TimeService _timeService = TimeService();
  String? storedWhatsappNo;

  @override
  void initState() {
    _fetchCompanyInfo();
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    print("id: ${widget.user.id}");
    _bounceAnimation = Tween<double>(begin: 1.5, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticInOut),
    );
    _timeService.fetchTime().then((_) async {
      String? whatsappNo = await _timeService.getStoredWhatsappNo();
      setState(() {
        storedWhatsappNo = whatsappNo;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _launchWhatsApp() async {
    await launchWhatsApp(storedWhatsappNo);
  }

  Future<bool> _onWillPop() async {
    SystemNavigator.pop();
    return false;
  }

  Future<void> _fetchCompanyInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedCompanyInfo = prefs.getString('companyInfo');
    print('***Fetched Company Info: $storedCompanyInfo');
    setState(() {
      widget.companyInfo = storedCompanyInfo;
    });
  }

  Future<Uint8List?> fetchImageData() async {
    final url = Uri.parse('https://bpexchdeals.com/api/getAlert');
    try {
      final response = await http.post(url);
      if (response.statusCode == 200) {
        return response.bodyBytes; // Binary data
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }

  Future<void> fetchAlertData() async {
    final url = Uri.parse('https://bpexchdeals.com/api/getAlert');
    try {
      final response = await http.post(url);
      print('***********:Response Headers: ${response.headers}');
      print('***********:Response Body: ${response.body}');
    } catch (e) {
      print('Exception: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PageStateProvider(),
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 9, 40, 65),
            elevation: 0,
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(
              widget.companyInfo ?? '',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          drawer: CustomDrawer(user: widget.user),
          body: Stack(
            children: [
              const BlurredBackground(
                imagePath: 'assets/images/appimage.jpg',
                blurSigmaX: 15,
                blurSigmaY: 15,
                opacity: 0.2,
              ),
              Positioned(
                top: 20.h,
                left: 10.w,
                right: 10.w,
                child: Column(
                  children: [
                    GlassContainer(
                      info: [
                        {
                          "label": "Name",
                          "value": widget.user.name ?? 'N/A',
                        },
                        {
                          "label": "bpexch id",
                          "value": widget.user.bpUsername ?? 'N/A',
                        },
                        {
                          "label": "bpexch Password",
                          "value": widget.user.bpPassword ?? 'N/A',
                        },
                      ],
                    ),
                    SizedBox(height: 20.h),
                    const ImageCarousel(),
                    SizedBox(height: 10.h),
                    CustomElevatedButton(
                      text: 'View History',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HistoryScreen(user: widget.user),
                          ),
                        );
                      },
                      height: 60.h,
                      width: MediaQuery.of(context).size.width,
                      color: const Color.fromARGB(255, 9, 40, 65),
                      borderRadius: 20.r,
                    ),
                    SizedBox(height: 10.h),
                    Align(
                      alignment: Alignment.topRight,
                      child: AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _bounceAnimation.value,
                            child: child,
                          );
                        },
                        child: GestureDetector(
                          onTap: _launchWhatsApp,
                          child: Container(
                            width: 50.w,
                            height: 50.h,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/whatsapp.png',
                                ),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
