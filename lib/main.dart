import 'package:classrun/models/model.dart';
import 'package:classrun/screens/selection_page.dart';
import 'package:classrun/screens/teacher_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'screens/landing_page.dart';
import 'screens/university_page.dart';
import 'screens/major_page.dart';
import 'screens/courselist_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       locale: const Locale("en", "US"),
      supportedLocales: const [
        Locale("fa", "IR"),
        Locale("en", "US"),
      ],
      localizationsDelegates: const [
        // Add Localization
        PersianMaterialLocalizations.delegate,
        PersianCupertinoLocalizations.delegate,
        // DariMaterialLocalizations.delegate, Dari
        // DariCupertinoLocalizations.delegate,
        // PashtoMaterialLocalizations.delegate, Pashto
        // PashtoCupertinoLocalizations.delegate,
        // SoraniMaterialLocalizations.delegate, Kurdish
        // SoraniCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      title: 'ClassRun',
      theme: ThemeData(fontFamily: 'Vazirmatn'),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const LandingPage());
          case '/selection':
            final args = settings.arguments as Map<String, dynamic>?;
            return MaterialPageRoute(
              builder: (_) => SelectionPage(arguments: args),
            );
          case '/teachers':
            final args = settings.arguments as List<Course>;
            return MaterialPageRoute(
              builder: (_) => TeacherPage(courses: args),
            );
          case '/universities':
            return MaterialPageRoute(builder: (_) => const UniversityPage());
          case '/majors':
            final args = settings.arguments as List<Course>;
            return MaterialPageRoute(builder: (_) => MajorPage(courses: args));
          case '/courselist':
            final args = settings.arguments as List<Course>;
            return MaterialPageRoute(
              builder: (_) => CourseListPage(courses: args),
            );
          default:
            return MaterialPageRoute(
              builder:
                  (_) => Scaffold(body: Center(child: Text('Page not found'))),
            );
        }
      },
    );
  }
}
