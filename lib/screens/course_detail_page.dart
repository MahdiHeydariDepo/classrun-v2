import 'package:flutter/material.dart';
import '../models/model.dart'; // Adjust path as needed

class CourseDetailPage extends StatelessWidget {
  final Course course;

  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 50,
              right: 20,
              left: 20,
              bottom: 20,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF9C7DCA),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(height: 10),
                Text(
                  "جزئیات درس",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'zain',
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: Colors.black54),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('assets/images/Vector.png'),
                        const Text(
                          "جزئیات درس",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: 'zain',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Divider(),
                    const SizedBox(height: 12),
                    _revdetailText("نام درس", course.courseName),
                    _detailText("کد درس", course.courseCode),
                    _revdetailText("نام استاد", course.teacherName),
                    _detailText("کد استاد", course.teacherCode),
                    _revdetailText("نام دانشگاه", course.universityName),
                    _detailText("کد دانشگاه", course.universityCode),
                    _revdetailText("نام رشته", course.majorName),
                    _detailText("کد رشته", course.majorCode),

                    _detailText("تاریخ", course.date),
                    _revdetailText("روز", course.weekday),
                    _detailText("ساعت", course.time),
                    _revdetailText("وضعیت", course.status),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailText(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        "$value :$title",
        textAlign: TextAlign.right,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          fontFamily: 'zain',
        ),
      ),
    );
  }

  Widget _revdetailText(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        "$title :$value ",
        textAlign: TextAlign.right,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          fontFamily: 'zain',
        ),
      ),
    );
  }
}
