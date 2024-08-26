import 'dart:io';
import 'student.dart';
import 'Course.dart';
import 'UI.dart';

List<StudentProfile> Students = [];

class StudentProfileUI {
  final StudentProfile student;

  StudentProfileUI(this.student);

  void showOptions() {
    while (true) {
      print("Please choose one:");
      print("1. Do Task");
      print("2. Show Courses");
      print("3. Show Grades in Courses");
      print("4. Register Course");
      print("5. Drop Course");
      print("6. Exit");

      stdout.write("Enter your choice (1-6): ");
      String? choice = stdin.readLineSync();

      switch (choice) {
        case '1':
          _doTask();
          break;
        case '2':
          _showCourses();
          break;
        case '3':
          _showGrades();
          break;
        case '4':
          _registerCourse();
          break;
        case '5':
          _dropCourse();
          break;
        case '6':
          print("Exiting...");
          return;
        default:
          print("Invalid choice. Please enter a number between 1 and 6.");
      }
    }
  }

  void _doTask() {
    print("Doing task...");
    TaskManagerUI taskManagerUI = TaskManagerUI(student);
    taskManagerUI.performTask();
  }

  void _showCourses() {
    print("Showing courses...");
    List<Course> courses = student.courseManager.courses;
    for (Course course in courses) {
      print(course.name);
    }
  }

  void _showGrades() {
    print("Showing grades...");
    Map<Course, String> grades = student.gradeManager.grades;
    grades.forEach((course, grade) {
      print("${course.name}   $grade");
    });
  }

  void _registerCourse() {
    print("Registering for a course...");
    RegisterCourseUI registerCourseUI = RegisterCourseUI(student);
    registerCourseUI.showAvailableCourses(courses);
  }

  void _dropCourse() {
    print("Dropping a course...");
    List<Course> availableCourses = student.gradeManager.grades.entries
        .where((entry) => entry.value == "?")
        .map((entry) => entry.key)
        .toList();

    for (int i = 0; i < availableCourses.length; i++) {
      print("$i ${availableCourses[i].name}");
    }

    int choice = int.parse(stdin.readLineSync() ?? "-1");
    if (choice >= 0 && choice < availableCourses.length) {
      Course course = availableCourses[choice];
      student.courseManager.dropCourse(course);
      student.gradeManager.remove(course);
    } else {
      print("Invalid choice.");
    }
  }
}
