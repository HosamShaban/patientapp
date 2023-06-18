import 'package:flutter/material.dart';
import 'package:patientapp/auth/Register_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final myController = PageController();
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 80),
            child: PageView(
              controller: myController,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 100),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Image.asset('assets/images/photo1.jpg'),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: const Text(
                          'التشخيص أصبح أسهل',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: const Text(
                          'يمكنك التطبيق من التشخيص بسهولة وباقل التكاليف ويمكنك اختيار الطبيب الذي تريده',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 100),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Image.asset('assets/images/photo4.jpeg'),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: const Text(
                          'متابعة نسبة السكر',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: const Text(
                          ' التطبيق يتيح لك إدخال القراءات اليومية لمستوى السكر في الدم وتتبعها على مدار الوقت',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 100),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Image.asset('assets/images/photo3.jpeg'),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: const Text(
                          'عزيزي المريض',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: const Text(
                          'مرض السكري هو أكثر الأمراض المزمنة التي تحتاج منك رعاية حثيثة ودورية لتجنب المضاعفات وهذا ماسنساعدك عليه',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 550),
            child: Center(
              child: SmoothPageIndicator(
                controller: myController,
                count: 3,
                effect: const SlideEffect(
                    spacing: 8,
                    radius: 4,
                    dotWidth: 24,
                    dotColor: Color(0xfffd9d9d9),
                    dotHeight: 7,
                    activeDotColor: Color(0xff407BFF)),
                onDotClicked: (index) => myController.animateToPage(index,
                    duration: const Duration(microseconds: 500),
                    curve: Curves.easeInOut),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 60, left: 300),
            child: TextButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterScreen())),
                child: const Text(
                  'تخطي',
                  style: TextStyle(
                      color: Color(0xff888888),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )),
          )
        ],
      ),
      bottomSheet: Container(
        color: Colors.white,
        child: InkWell(
          onTap: () => myController.nextPage(
              duration: const Duration(microseconds: 300),
              curve: Curves.easeInOut),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xff407BFF),
            ),
            margin: const EdgeInsets.all(20),
            height: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen())),
                    child: const Text(
                      'التالي',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
