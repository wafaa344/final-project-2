// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:get/get.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:project2/basics/api_url.dart';
//
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
//           merchantDisplayName: "Your Company",
//           style: ThemeMode.light,
//         ),
//       );
//
//       await Stripe.instance.presentPaymentSheet();
//
//
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
//   } else {
//     Get.snackbar("فشل", data['message']);
//   }
// }
//
