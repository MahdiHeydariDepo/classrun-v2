import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD0C6DD),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Spacer(),
          Image.asset(
            'assets/images/callender_girl.png', // Place your image in `assets/` and define in pubspec.yaml
           
          ),
          const SizedBox(height: 20),
          const Text(
            "ClassRun",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "برنامه‌ ریزی آموزشی",
            style: TextStyle(color: Color.fromARGB(255, 87, 50, 144), fontSize: 20, fontFamily: 'zain'),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Text(
              "با کلاس‌ران می‌توانید بدون نیاز به ورود، برنامه‌های کلاسی دانشگاه خود را مشاهده کنید، تغییرات لحظه‌ای کلاس‌ها را دنبال کنید و از زمان‌بندی دقیق جلسات مطلع شوید.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, height: 1.5, fontFamily: 'zain'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context,   '/universities');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF9C7DCA),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text("مشاهده برنامه‌ کلاسی",
            style: TextStyle(fontFamily: 'zain', fontWeight: FontWeight.w900),),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
