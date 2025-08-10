import 'package:flutter/material.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/widgets/custom_appbar.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});
  static const String routeName = '/about-us';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: Constants.aboutUs,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.info_outline, color: Colors.blue),
        //     onPressed: () {
        //       // إضافة أي إجراء إضافي
        //     },
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // شعار الشركة
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.business,
                  size: 60,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 24),

              // عنوان الصفحة
              Text(
                Constants.aboutUs,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 16),

              // محتوى الصفحة
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.shadow,
                      blurRadius: 10,
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: SelectableText(
                  Constants.aboutUsText,
                  textAlign: TextAlign.justify, // محاذاة للنص
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.6, // تباعد بين الأسطر
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // معلومات التواصل
              Text(
                'تواصل معنا',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.email,
                        color: Theme.of(context).colorScheme.secondary),
                    onPressed: () {
                      // إجراء إرسال بريد
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.phone,
                        color: Theme.of(context).colorScheme.secondary),
                    onPressed: () {
                      // إجراء اتصال
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.language,
                        color: Theme.of(context).colorScheme.secondary),
                    onPressed: () {
                      // فتح موقع الويب
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
