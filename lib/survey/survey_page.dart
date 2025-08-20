import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../basics/app_colors.dart';
import 'cost/cost_controller.dart';
import 'cost/cost_model.dart';
import 'survey_controller.dart';
import 'survey_model.dart';

class SurveyPage extends StatelessWidget {
  const SurveyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SurveyController>();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final args = Get.arguments as Map<String, dynamic>;

    final int companyId = args['companyId'] as int;

    // 👇 التصحيح هون
    final List<int> serviceIds = (args['serviceIds'] as List).map((e) => e as int).toList();


    return Scaffold(
      appBar: AppBar(
        title: const Text('الاستبيان'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          padding: EdgeInsets.all(width * 0.04),
          itemCount: controller.services.length,
          itemBuilder: (context, index) {
            final service = controller.services[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(width * 0.04),
              ),
              elevation: 4,
              margin: EdgeInsets.only(bottom: height * 0.03),
              child: ExpansionTile(
                title: Text(
                  service.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.045,
                  ),
                ),
                children: service.questions.map((q) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.03,
                      vertical: height * 0.015,
                    ),
                    child: _buildQuestion(q, width, height),
                  );
                }).toList(),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(width * 0.04),
        child: ElevatedButton(
          onPressed: () {
            final costController = Get.find<CostController>();
            final surveyController = Get.find<SurveyController>();

            bool allAnswered = true;

            for (var service in surveyController.services) {
              for (var q in service.questions) {
                final value = surveyController.answers[q.id];


                if (q.hasOptions) {
                  if (value == null || value is! int) {
                    allAnswered = false;
                    break;
                  }
                } else {
                  if (value == null || value.toString().trim().isEmpty) {
                    allAnswered = false;
                    break;
                  }
                }
              }
              if (!allAnswered) break;
            }

            if (!allAnswered) {
              Get.snackbar(
                "تنبيه",
                "يرجى الإجابة على جميع الأسئلة قبل الإرسال",
                backgroundColor: Colors.orange.shade100,
                colorText: Colors.black87,
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(seconds: 3),
              );
              return;
            }


            final services = surveyController.services.map((service) {
              final answers = service.questions.map((q) {
                final value = surveyController.answers[q.id];
                return AnswerModel(questionId: q.id, answer: value.toString());
              }).toList();

              return ServiceAnswers(serviceId: service.id, answers: answers);
            }).toList();

            final request = CostRequest(services: services);

            costController.calculateCostOnly(request).then((price) {
              Get.toNamed('/cost', arguments: {
                'price': price,
                'companyId': companyId, // تمرير ID الشركة
                'onConfirm': () {
                  Get.snackbar("تم", "تم تأكيد الطلب بنجاح");
                },
              });
            });
          },


          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            padding: EdgeInsets.symmetric(vertical: height * 0.02),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(width * 0.035),
            ),
          ),
          child: Text(
            'إرسال',
            style: TextStyle(
              fontSize: width * 0.045,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion(QuestionModel question, double width, double height) {
    return GetBuilder<SurveyController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.question,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: width * 0.04,
              ),
            ),
            SizedBox(height: height * 0.015),
            if (question.hasOptions)
              Column(
                children: question.options.map((option) {
                  final currentAnswer = controller.answers[question.id];
                  final isSelected = currentAnswer == option.id;

                  return GestureDetector(
                    onTap: () {
                      controller.answers[question.id] = option.id;
                      controller.update();
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: EdgeInsets.symmetric(vertical: height * 0.008),
                      padding: EdgeInsets.all(width * 0.035),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFFFEDE3) : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(width * 0.03),
                        border: Border.all(
                          color: isSelected ? AppColors.primaryColor : Colors.grey.shade300,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${option.name} - ${option.unit} - ${option.price} د.ع',
                              style: TextStyle(
                                fontSize: width * 0.038,
                                fontWeight: FontWeight.w500,
                                color: isSelected ? AppColors.primaryColor : Colors.black87,
                              ),
                            ),
                          ),
                          if (isSelected)
                            Icon(Icons.check_circle, color: AppColors.primaryColor, size: width * 0.06),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              )
            else
              TextField(
                onChanged: (value) {
                  controller.answers[question.id] = value;
                },
                decoration: InputDecoration(
                  hintText: 'اكتب إجابتك هنا',
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: width * 0.035,
                    vertical: height * 0.015,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width * 0.035),
                    borderSide: const BorderSide(color:AppColors.primaryColor),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
