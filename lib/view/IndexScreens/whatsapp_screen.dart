import 'package:bpexch/utils/Reusable/blurred_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher_string.dart';

class WhatsappLink extends StatefulWidget {
  const WhatsappLink({super.key});

  @override
  State<WhatsappLink> createState() => _WhatsappLinkState();
}

class _WhatsappLinkState extends State<WhatsappLink>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(begin: 1.5, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> openWhatsApp(BuildContext context, String phoneNumber) async {
    final whatsappUrl = "https://wa.me/$phoneNumber";

    if (await canLaunchUrlString(whatsappUrl)) {
      await launchUrlString(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not open WhatsApp")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        const BlurredBackground(
          imagePath: 'assets/images/appimage.jpg',
          blurSigmaX: 15,
          blurSigmaY: 15,
          opacity: 0.2,
        ),
        Positioned(
          top: 100.h,
          left: 0.w,
          right: 0.w,
          child: Center(
            child: Text(
              'Tap here to contact',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
          top: 200.h,
          left: 0.w,
          right: 0.w,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.scale(
                scale: _bounceAnimation.value,
                child: child,
              );
            },
            child: GestureDetector(
              onTap: () => openWhatsApp(context, "+92 300 8497241"),
              child: Container(
                width: 100.w,
                height: 100.h,
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
        )
      ],
    ));
  }
}
