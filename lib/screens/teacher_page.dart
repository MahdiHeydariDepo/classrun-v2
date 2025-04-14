import 'package:flutter/material.dart';
import '../models/model.dart';

class TeacherPage extends StatefulWidget {
  final List<Course> courses;
  const TeacherPage({super.key, required this.courses});

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  List<String> _teachers = [];

  @override
  void initState() {
    super.initState();
    _extractTeachers();
  }

  void _extractTeachers() {
    final uniqueTeachers = {
      for (var course in widget.courses) course.teacherCode: course.teacherName
    };

    setState(() {
      _teachers = uniqueTeachers.entries
          .map((entry) => "${entry.key}:${entry.value}")
          .toList();
    });
  }

  void _filterTeachers(String query) {
    final filtered = widget.courses
        .where((course) =>
            course.teacherName.contains(query) ||
            course.teacherCode.contains(query))
        .map((course) => "${course.teacherCode}:${course.teacherName}")
        .toSet()
        .toList();

    setState(() {
      _teachers = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      body: Column(
        children: [
          _buildHeader(context),
          _buildSearchField(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildTableHeader(),
                    const Divider(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _teachers.length,
                        itemBuilder: (context, index) {
                          final split = _teachers[index].split(':');
                          return teacherItem(split[0], split[1]);
                        },
                      ),
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

 Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF9C7DCA),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      padding: const EdgeInsets.only(top: 50, bottom: 20, right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              const Spacer(),

            ],
          ),
          const SizedBox(height: 20),
          const Text(
            "اساتید",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'zain'
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: TextField(
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText: "نام استاد مورد نظر را وارد کنید",
          hintStyle: TextStyle(fontFamily: 'zain'),
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
        onChanged: _filterTeachers,
      ),
    );
  }

  Widget _buildTableHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Expanded(
            flex: 2,
            child: Text(
              "انتخاب",
              style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'zain'),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              "نام استاد",
              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'zain'),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "کد استاد",
              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'zain'),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget teacherItem(String code, String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9C7DCA),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                final filteredCourses = widget.courses
                    .where((course) => course.teacherCode == code)
                    .toList();

                Navigator.pushNamed(
                  context,
                  '/courselist',
                  arguments: filteredCourses,
                );
              },
              child: const Text(
                "انتخاب",
                style: TextStyle(fontWeight: FontWeight.w900, fontFamily: 'zain'),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w800, fontFamily: 'zain'),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              code,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w800, fontFamily: 'zain'),
            ),
          ),
        ],
      ),
    );
  }
}
