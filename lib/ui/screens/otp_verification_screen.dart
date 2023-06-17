import 'package:e_commerce/ui/screens/bottom_nav_bar_screen.dart';
import 'package:e_commerce/ui/screens/home_screen.dart';
import 'package:e_commerce/ui/state_managers/user_auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../utils/app_colors.dart';
import '../utils/styles.dart';
import '../widgets/common_elevated_button.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;
  const OtpVerificationScreen({Key? key, required this.email})
      : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpETController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<UserAuthController>(builder: (userAuthController) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', height: 80, width: 80),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Enter OTP Code",
                style: titleTextStyle,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                "A 4 digit OTP code has been sent",
                style: subTitleTextStyle,
              ),
              const SizedBox(height: 24),
              PinCodeTextField(
                length: 4,
                obscureText: false,
                animationType: AnimationType.fade,
                keyboardType: TextInputType.number,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                controller: _otpETController,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                  selectedFillColor: Colors.white,
                  selectedColor: Colors.green,
                  activeColor: primaryColor,
                  inactiveColor: Colors.red,
                  inactiveFillColor: Colors.white,
                ),
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                onCompleted: (v) {},
                onChanged: (value) {},
                appContext: context,
              ),
              const SizedBox(height: 16),
              userAuthController.otpVerificationInProgress
                  ? const CircularProgressIndicator()
                  : CommonElevatedButton(
                      title: "Next",
                      onTap: () async {
                        final bool response =
                            await userAuthController.otpVerification(
                                widget.email, _otpETController.text);
                        if (response) {
                          Get.offAll(const BottomNavBarScreen());
                        } else {
                          Get.showSnackbar(

                            const GetSnackBar(
                              title: 'Otp verification failed',
                              message: 'Check your valid Otp and try now!',
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      },
                    ),
              const SizedBox(height: 16),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 12, color: softGreyColor),
                  text: "This code will be expire in ",
                  children: [
                    TextSpan(
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                        text: "120s"),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Resend Code",
                  style: TextStyle(color: Colors.grey.withOpacity(0.6)),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
