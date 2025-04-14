import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../models/model.dart';
import 'course_detail_page.dart';

class CourseListPage extends StatefulWidget {
  final List<Course> courses;

  const CourseListPage({super.key, required this.courses});

  @override
  State<CourseListPage> createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  late List<Course> _filteredCourses;
  String _searchQuery = "";
  String? _selectedWeekday;
  String? _selectedTime;
  String? _selectedDate;
  bool _onlyCancelled = false;

  final List<String> _weekdays = [
    "شنبه",
    "یکشنبه",
    "دوشنبه",
    "سه‌شنبه",
    "چهارشنبه",
    "پنجشنبه",
    "جمعه",
  ];

  final List<String> _times = List.generate(
    48,
    (index) =>
        '${(index ~/ 2).toString().padLeft(2, '0')}:${(index % 2 == 0) ? '00' : '30'}',
  );

  @override
  void initState() {
    super.initState();
    _filteredCourses = widget.courses;
  }

  void _applyFilters() {
    setState(() {
      _filteredCourses =
          widget.courses.where((course) {
            final matchesQuery =
                course.courseName.contains(_searchQuery) ||
                course.teacherName.contains(_searchQuery) ||
                course.majorName.contains(_searchQuery);

            final matchesWeekday =
                _selectedWeekday == null || course.weekday == _selectedWeekday;
            final matchesTime =
                _selectedTime == null || course.time == _selectedTime;
            final matchesDate =
                _selectedDate == null || course.date == _selectedDate;
            final matchesCancelled =
                !_onlyCancelled || course.status == "لغو شده";

            return matchesQuery &&
                matchesWeekday &&
                matchesTime &&
                matchesDate &&
                matchesCancelled;
          }).toList();
    });
  }

  void _pickDate() async {
    final picked = await showPersianDatePicker(
      context: context,
      initialDate: Jalali.now(),
      firstDate: Jalali(1300, 1),
      lastDate: Jalali(1450, 12),
      locale: const Locale("fa", "IR"),
      textDirection: TextDirection.rtl,
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = "${picked.year}/${picked.month}/${picked.day}";
        _applyFilters();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      body: Column(
        children: [
          _buildHeader(context),
          _buildSearchField(),
          _buildFilterSection(),
          const SizedBox(height: 10),
          Expanded(
            child:
                _filteredCourses.isEmpty
                    ? const Center(child: Text("هیچ درسی یافت نشد"))
                    : ListView.builder(
                      itemCount: _filteredCourses.length,
                      itemBuilder: (context, index) {
                        return _buildCourseCard(
                          context,
                          _filteredCourses[index],
                        );
                      },
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
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
      ),
      padding: const EdgeInsets.only(top: 50, bottom: 20, right: 20, left: 20),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const Spacer(),
          const Text(
            "دروس",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'zain'
            ),
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
        onChanged: (value) {
          _searchQuery = value;
          _applyFilters();
        },
        decoration: InputDecoration(
          hintText: "جستجو بر اساس نام درس، استاد یا رشته...",
          hintStyle: TextStyle(fontFamily: 'zain'),
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildFilterSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedWeekday,
                  isExpanded: true,
                  decoration: const InputDecoration(labelText: "روز هفته",labelStyle: TextStyle(fontFamily: 'zain')),
                  items:
                      _weekdays
                          .map(
                            (day) =>
                                DropdownMenuItem(value: day, child: Text(day, style: TextStyle(fontFamily: 'zain'),)),
                          )
                          .toList(),
                  onChanged: (value) {
                    _selectedWeekday = value;
                    _applyFilters();
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedTime,
                  isExpanded: true,
                  decoration: const InputDecoration(labelText: "ساعت", labelStyle: TextStyle(fontFamily: 'zain')),
                  items:
                      _times
                          .map(
                            (time) => DropdownMenuItem(
                              value: time,
                              child: Text(time),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    _selectedTime = value;
                    _applyFilters();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _pickDate,
                  icon: const Icon(Icons.date_range),
                  label: Text(_selectedDate ?? "انتخاب تاریخ", style: TextStyle(fontFamily: 'zain'),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: const Text("فقط کلاس‌های لغو شده", style: TextStyle(fontFamily: 'zain'),),
                selected: _onlyCancelled,
                onSelected: (selected) {
                  setState(() {
                    _onlyCancelled = selected;
                    _applyFilters();
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(BuildContext context, Course course) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CourseDetailPage(course: course)),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textDirection: TextDirection.rtl,
                  children: [
                    Text("درس: ${course.courseName} (${course.courseCode})", style: TextStyle(fontFamily: 'zain'),),
                  ],
                ),
                const SizedBox(height: 6),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textDirection: TextDirection.rtl,
                  children: [
                    Text(
                      "دانشگاه: ${course.universityName} (${course.universityCode})", style: TextStyle(fontFamily: 'zain')
                    ),
                    Text("رشته: ${course.majorName}", style: TextStyle(fontFamily: 'zain')),
                  ],
                ),
                const SizedBox(height: 6),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textDirection: TextDirection.rtl,
                  children: [
                    Text("استاد: ${course.teacherName}", style: TextStyle(fontFamily: 'zain')),
                    Text("ساعت: ${course.time}", style: TextStyle(fontFamily: 'zain')),
                  ],
                ),
                const SizedBox(height: 6),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textDirection: TextDirection.rtl,
                  children: [
                    Text("روز: ${course.weekday}", style: TextStyle(fontFamily: 'zain')),
                    Text("تاریخ: ${course.date}", style: TextStyle(fontFamily: 'zain')),
                    Text("وضعیت: ${course.status}", style: TextStyle(fontFamily: 'zain')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
