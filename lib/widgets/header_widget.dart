import 'package:flutter/material.dart';
import 'package:rebuild_flat/widgets/top_curve_clipper.dart';

import '../basics/app_colors.dart';


class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key, required this.height, required this.width});

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TopCurveClipper(),
      child: Container(
        height: height * 0.22,
        width: double.infinity,
        color: AppColors.primaryColor,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(
          right: width * 0.05,
          left: width * 0.05,
          bottom: height * 0.03,
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'مرحبا',
                      style: TextStyle(
                        fontSize: width * 0.06,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkOrange,
                      ),
                    ),
                    SizedBox(height: height * 0.005),
                    Text(
                      'أعد إعمار شقتك الان',
                      style: TextStyle(
                        fontSize: width * 0.055,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: width * 0.03),
              ClipRRect(
                borderRadius: BorderRadius.circular(width * 0.03),
                child: Image.asset(
                  'assets/engineer.png',
                  height: width * 0.15,
                  width: width * 0.15,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: width * 0.02),
              // زر الإعدادات داخل Builder
              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.settings, color: Colors.white),
                  iconSize: width * 0.07,
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


