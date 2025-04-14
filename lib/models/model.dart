class Course {
  final String universityCode; // کد دانشگاه
  final String universityName; // اسم دانشگاه
  final String majorCode; // کد رشته
  final String majorName; // اسم رشته
  final String teacherCode; // کد استاد
  final String teacherName; // اسم استاد
  final String courseCode; // کد درس
  final String courseName; // اسم درس
  final String date; // تاریخ
  final String weekday; // روز
  final String time; // ساعت
  final String status; // وضعیت

  Course({
    required this.universityCode,
    required this.universityName,
    required this.majorCode,
    required this.majorName,
    required this.teacherCode,
    required this.teacherName,
    required this.courseCode,
    required this.courseName,
    required this.date,
    required this.weekday,
    required this.time,
    required this.status,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      universityCode: json['universityCode'],
      universityName: json['universityName'],
      majorCode: json['majorCode'],
      majorName: json['majorName'],
      teacherCode: json['teacherCode'],
      teacherName: json['teacherName'],
      courseCode: json['courseCode'],
      courseName: json['courseName'],
      date: json['date'],
      weekday: json['weekday'],
      time: json['time'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'universityCode': universityCode,
      'universityName': universityName,
      'majorCode': majorCode,
      'majorName': majorName,
      'teacherCode': teacherCode,
      'teacherName': teacherName,
      'courseCode': courseCode,
      'courseName': courseName,
      'date': date,
      'weekday': weekday,
      'time': time,
      'status': status,
    };
  }
}
