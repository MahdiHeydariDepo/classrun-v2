import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/model.dart'; // adjust path if needed

class UniversityPage extends StatefulWidget {
  const UniversityPage({super.key});

  @override
  State<UniversityPage> createState() => _UniversityPageState();
}

class _UniversityPageState extends State<UniversityPage> {
  List<Course> _courses = [];
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  Future<void> _loadCourses() async {
    final String response = await rootBundle.loadString('assets/courses.json');
    final data = json.decode(response) as List;
    final loadedCourses = data.map((json) => Course.fromJson(json)).toList();

    setState(() {
      _courses = loadedCourses;
    });
  }

  List<MapEntry<String, String>> get _filteredUniversities {
    final uniqueUniversities = {
      for (var course in _courses) course.universityCode: course.universityName,
    };

    return uniqueUniversities.entries
        .where(
          (entry) =>
              entry.value.contains(_searchText) ||
              entry.key.contains(_searchText),
        )
        .toList();
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
                        itemCount: _filteredUniversities.length,
                        itemBuilder: (context, index) {
                          final entry = _filteredUniversities[index];
                          return uniItem(entry.key, entry.value);
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
            "دانشگاه ها",
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
          hintText: "دانشگاه مورد نظر را وارد کنید",
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(fontFamily: 'zain')
        ),
        onChanged: (value) {
          setState(() {
            _searchText = value;
          });
        },
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
              "نام دانشگاه",
              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'zain'),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "کد دانشگاه",
              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'zain'),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget uniItem(String code, String name) {
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
                Navigator.pushNamed(
                  context,
                  '/selection',
                  arguments: {'universityCode': code, 'universityName': name},
                );
              },
              child: const Text(
                "انتخاب",
                style: TextStyle(fontWeight: FontWeight.w900 ,fontFamily: 'zain'),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w800,fontFamily: 'zain'),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              code,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w800,fontFamily: 'zain'),
            ),
          ),
        ],
      ),
    );
  }
}
