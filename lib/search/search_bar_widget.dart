import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../search/search_controller.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key, required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MySearchController>();

    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(width * 0.08),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, height * 0.004),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Obx(() {
              return TextField(
                textDirection: TextDirection.rtl,
                onChanged: controller.onQueryChanged,
                decoration: InputDecoration(
                  hintText: 'ابحث هنا...',
                  border: InputBorder.none,
                  icon: controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : const Icon(Icons.search),
                ),
              );
            }),
          ),
        ),
        SizedBox(width: width * 0.03),
        Container(
          padding: EdgeInsets.all(width * 0.025),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, height * 0.004),
              ),
            ],
          ),
          child: Icon(Icons.notifications,
              size: width * 0.065, color: const Color(0xfff77520)),
        ),
      ],
    );
  }
}
