import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../provider/payment_method_provider.dart';

class PaymentMethodWidget extends StatelessWidget {
  final String image;
  final String label;
  final String value;
  final double imageHeight;
  final Function(String) onPaymentMethodSelected;

  const PaymentMethodWidget({
    super.key,
    required this.image,
    required this.label,
    required this.value,
    required this.imageHeight,
    required this.onPaymentMethodSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected =
        context.watch<PaymentMethodProvider>().selectedPaymentMethod == value;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: GestureDetector(
        onTap: () {
          context.read<PaymentMethodProvider>().selectPaymentMethod(value);
          onPaymentMethodSelected(value);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: isSelected ? Colors.green : Colors.transparent,
                  width: 4,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio<String>(
                    value: value,
                    groupValue: context
                        .watch<PaymentMethodProvider>()
                        .selectedPaymentMethod,
                    onChanged: (newValue) {
                      if (newValue != null) {
                        context
                            .read<PaymentMethodProvider>()
                            .selectPaymentMethod(newValue);
                        onPaymentMethodSelected(newValue);
                      }
                    },
                    activeColor: Colors.green,
                  ),
                  if (image == 'assets/images/banklogo.png')
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Image.asset(image, height: imageHeight),
                    ),
                  if (image == 'assets/images/jazzcashlogo.png')
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Image.asset(image, height: imageHeight),
                    ),
                  if (image == 'assets/images/easypaisalogo.png')
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Image.asset(image, height: imageHeight),
                    ),
                  SizedBox(width: 20.w),
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Text(
                      label,
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
