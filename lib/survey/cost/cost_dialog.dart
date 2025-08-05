import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../basics/api_url.dart';
import '../../basics/app_colors.dart';
import '../../native_service/secure_storage.dart';


class CostDialog extends StatelessWidget {
  const CostDialog({super.key});

  // Future<void> startPayment({
  //   required String token,
  //   required int companyId,
  //   required double amount,
  //   required Function(String paymentIntentId) onSuccess,
  // }) async {
  //   try {
  //     final res = await http.post(
  //       Uri.parse('${ServerConfiguration.domainNameServer}/api/payment/create-payment-intent'),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonEncode({'company_id': companyId}),
  //     );
  //
  //     if (res.statusCode == 200) {
  //       final data = jsonDecode(res.body);
  //       final clientSecret = data['client_secret'];
  //       final paymentIntentId = data['payment_intent_id'];
  //
  //       await Stripe.instance.initPaymentSheet(
  //         paymentSheetParameters: SetupPaymentSheetParameters(
  //           paymentIntentClientSecret: clientSecret,
  //           merchantDisplayName: "Crafty App",
  //           style: ThemeMode.light,
  //         ),
  //       );
  //
  //       await Stripe.instance.presentPaymentSheet();
  //
  //       // إذا ما صار خطأ، معناها الدفع نجح
  //       onSuccess(paymentIntentId);
  //     } else {
  //       Get.snackbar("فشل", "فشل في إنشاء عملية الدفع");
  //     }
  //   } catch (e) {
  //     if (e is StripeException) {
  //       Get.snackbar("تم الإلغاء", e.error.message ?? "أُلغيت العملية");
  //     } else {
  //       Get.snackbar("خطأ", e.toString());
  //     }
  //   }
  // }
  //
  // Future<void> sendOrder({
  //   required String token,
  //   required String paymentIntentId,
  //   required int budget,
  //   required String location,
  //   required List<Map<String, dynamic>> answers,
  // }) async {
  //   final res = await http.post(
  //     Uri.parse('${ServerConfiguration.domainNameServer}/api/Add_Order'),
  //     headers: {
  //       'Authorization': 'Bearer $token',
  //       'Content-Type': 'application/json',
  //     },
  //     body: jsonEncode({
  //       "company_id": 1,
  //       "location": location,
  //       "budget": budget,
  //       "answers": answers,
  //       "payment_intent_id": paymentIntentId,
  //     }),
  //   );
  //
  //   final data = jsonDecode(res.body);
  //   if (data['status'] == true) {
  //     Get.snackbar("نجاح", "تم تقديم الطلب بنجاح ✅");
  //     Get.back();
  //   } else {
  //     Get.snackbar("فشل", data['message']);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final double price = Get.arguments['price'];
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFF3E0), Color(0xFFFFFFFF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: Container(
              width: width * 0.9,
              padding: EdgeInsets.all(width * 0.05),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 20,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.home_work_rounded, size: width * 0.18, color: const Color(0xFFF77520)),
                    const SizedBox(height: 16),
                    Text(
                      "تكلفة مشروعك التقديرية",
                      style: TextStyle(
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "${price.toStringAsFixed(0)} ل.س",
                      style: TextStyle(
                        fontSize: width * 0.07,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "إذا كنت ترغب بالبدء في إعادة مشروع شقتك، اضغط على تأكيد الطلب الآن وسيتم تعيين مشرف خاص لمشروعك ليطلعك على كل المراحل بالتفصيل.",
                      style: TextStyle(
                        fontSize: width * 0.038,
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Get.back(),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppColors.primaryColor),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: height * 0.015),
                              child: Text(
                                "إلغاء",
                                style: TextStyle(
                                  fontSize: width * 0.04,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              final storage = SecureStorage();
                              final token = await storage.read('token');

                              if (token == null) {
                                Get.snackbar("خطأ", "المستخدم غير مسجل الدخول");
                                return;
                              }

                              // startPayment(
                              //   token: token,
                              //   companyId: 1,
                              //   amount: price,
                              //   onSuccess: (paymentIntentId) {
                              //     sendOrder(
                              //       token: token,
                              //       paymentIntentId: paymentIntentId,
                              //       budget: price.toInt(),
                              //       location: "دمشق، المزة",
                              //       answers: [
                              //         // TODO: عدلي هذه القائمة حسب استجابات الاستبيان
                              //         {"question_service_id": 4, "answer": "1"},
                              //         {"question_service_id": 5, "answer": "500"},
                              //         {"question_service_id": 6, "answer": "لا"},
                              //         {"question_service_id": 7, "answer": "2"},
                              //         {"question_service_id": 8, "answer": "15"},
                              //         {"question_service_id": 9, "answer": "نعم"},
                              //       ],
                              //     );
                              //   },
                              // );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: height * 0.015),
                              child: Text(
                                "تأكيد الطلب والدفع",
                                style: TextStyle(
                                  fontSize: width * 0.04,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
