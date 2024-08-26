import 'dart:io';
import 'doctor.dart';
import 'Course.dart';

class DoctorProfileUI {
  final DoctorProfile doctor;

  DoctorProfileUI(this.doctor);

  void showOptions() {
    while (true) {
      print("Please choose one:");
      print("1. add Task");
      print("2. Show Courses");
      print("3. Exit");

      stdout.write("Enter your choice (1-3): ");
      String? choice = stdin.readLineSync();

      switch (choice) {
        case '1':
          _addTask();
          break;
        case '2':
          _showCourses();
          break;
        case '3':
          print("Exiting...");
          return;
        default:
          print("Invalid choice. Please enter a number between 1 and 3.");
      }
    }
  }

  void _addTask() {
    print("Adding task...");
    List<CourseProfile> Courses = doctor.taskManger.lst;

    for (int i = 0; i < Courses.length; i++) {
      print("$i ${Courses[i].CourseData.name}");
    }

    stdout.write("Choose a course (0-${Courses.length - 1}): ");
    int choose = int.parse(stdin.readLineSync()!);

    stdout.write("Enter task description: ");
    String description = stdin.readLineSync()!;

    Task task = Task(description);
    doctor.taskManger.addTask(courses[choose].CourseData, task);

    print("Task added successfully.");
  }

  void _showCourses() {
    print("Showing courses...");

    List<CourseProfile> courses = doctor.taskManger.lst;
    for (CourseProfile courseProfile in courses) {
      print(courseProfile.CourseData.name);
    }
  }
}
