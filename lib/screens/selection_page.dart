import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/model.dart';

class SelectionPage extends StatefulWidget {
  final Map<String, dynamic>? arguments;

  const SelectionPage({super.key, this.arguments});

  @override
  State<SelectionPage> createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  String? _universityCode;
  String? _universityName;
  List<Course> _allCourses = [];
  List<Course> _filteredCourses = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    final args = widget.arguments;
    if (args != null &&
        args['universityCode'] is String &&
        args['universityName'] is String) {
      _universityCode = args['universityCode'];
      _universityName = args['universityName'];
      _loadCourses();
    } else {
      // No valid arguments — redirect to university selection
      Future.microtask(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('لطفاً ابتدا یک دانشگاه را انتخاب کنید'),
          ),
        );
        Navigator.pushReplacementNamed(context, '/universities');
      });
    }
  }

  Future<void> _loadCourses() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/courses.json',
      );
      final data = json.decode(response) as List;
      final courses = data.map((json) => Course.fromJson(json)).toList();

      setState(() {
        _allCourses = courses;
        _filteredCourses =
            courses
                .where((course) => course.universityCode == _universityCode)
                .toList();
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading courses: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9C7DCA),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 50, right: 16, left: 16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Spacer(),
                if (_universityName != null)
                  Text(
                    _universityName!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'zain'
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child:
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _filteredCourses.isEmpty
                    ? const Center(
                      child: Text('هیچ داده‌ای برای این دانشگاه موجود نیست'),
                    )
                    : ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        selectionCard(
                          context,
                          imagePath: 'assets/images/majors.png',
                          title: 'رشته ها',
                          subtitle:
                              'لیست رشته‌های موجود در دانشگاه را مشاهده نمایید',
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/majors',
                              arguments: _filteredCourses, // This is correct
                            );
                          },
                        ),
                        selectionCard(
                          context,
                          imagePath: 'assets/images/teachers.png',
                          title: 'اساتید',
                          subtitle:
                              'لیست اساتید موجود در دانشگاه را مشاهده نمایید',
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/teachers',
                              arguments: _filteredCourses,
                            );
                          },
                        ),
                        selectionCard(
                          context,
                          imagePath: 'assets/images/courses.png',
                          title: 'دروس',
                          subtitle:
                              'لیست دروس موجود در دانشگاه را مشاهده نمایید',
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/courselist',
                              arguments: _filteredCourses,
                            );
                          },
                        ),
                      ],
                    ),
          ),
        ],
      ),
    );
  }

  Widget selectionCard(
    BuildContext context, {
    required String imagePath,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imagePath,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'zain'
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(color: Colors.black54,fontFamily: 'zain'),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
