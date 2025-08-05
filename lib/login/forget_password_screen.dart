import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../basics/app_colors.dart';
import 'forget_password_service.dart';

enum ForgetStep { email, code, reset }

class ForgetPasswordDialog extends StatefulWidget {
  const ForgetPasswordDialog({super.key});

  @override
  State<ForgetPasswordDialog> createState() => _ForgetPasswordDialogState();
}

class _ForgetPasswordDialogState extends State<ForgetPasswordDialog> {
  final emailController = TextEditingController();
  final codeController = TextEditingController();
  final passwordController = TextEditingController();

  ForgetStep currentStep = ForgetStep.email;
  String? savedCode;

  void handleNext() async {
    if (currentStep == ForgetStep.email) {
      final email = emailController.text.trim();
      if (email.isEmpty) {
        Get.snackbar("خطأ", "يرجى إدخال البريد الإلكتروني");
        return;
      }

      final message = await ForgetPasswordService.sendResetCode(email);
      Get.snackbar("النتيجة", message ?? "حدث خطأ غير معروف");

      if (message != null && message.contains("تم إرسال")) {
        setState(() => currentStep = ForgetStep.code);
      }
    }

    else if (currentStep == ForgetStep.code) {
      final code = codeController.text.trim();
      if (code.length != 6) {
        Get.snackbar("خطأ", "أدخل رمز مكون من 6 أرقام");
        return;
      }

      final message = await CheckCodeService.verifyCode(code);
      Get.snackbar("النتيجة", message ?? "حدث خطأ");

      if (message == "الرمز صحيح.") {
        savedCode = code; // حفظ الكود لاستخدامه لاحقًا
        setState(() => currentStep = ForgetStep.reset);
      }
    }

    else if (currentStep == ForgetStep.reset) {
      final password = passwordController.text.trim();
      if (password.length < 6) {
        Get.snackbar("خطأ", "كلمة السر يجب أن تكون على الأقل 6 حروف");
        return;
      }

      final message = await ResetPasswordService.resetPassword(savedCode!, password);
      Get.snackbar("النتيجة", message ?? "حدث خطأ");

      if (message == "تم إعادة تعيين كلمة المرور بنجاح") {
        Navigator.of(context).pop(); // إغلاق مربع الحوار
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        currentStep == ForgetStep.email
            ? "استعادة كلمة السر"
            : currentStep == ForgetStep.code
            ? "تحقق من الرمز"
            : "إعادة تعيين كلمة السر",
        style: const TextStyle(color: AppColors.primaryColor),

      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (currentStep == ForgetStep.email) ...[
            const Align(
              alignment: Alignment.centerRight,
              child: Text("أدخل بريدك الإلكتروني"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: "example@gmail.com",
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
              ),
            ),
          ],
          if (currentStep == ForgetStep.code) ...[
            const Align(
              alignment: Alignment.centerRight,
              child: Text("أدخل الرمز المرسل إلى بريدك"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: codeController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: const InputDecoration(
                hintText: "******",
                counterText: "",
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
              ),
            ),
          ],
          if (currentStep == ForgetStep.reset) ...[
            const Align(
              alignment: Alignment.centerRight,
              child: Text("أدخل كلمة السر الجديدة"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "••••••",
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
              ),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: handleNext,
          child: Text(
            currentStep == ForgetStep.reset ? "إنهاء" : "التالي",
            style: const TextStyle(color: AppColors.primaryColor),
          ),
        ),
      ],
    );
  }
}
