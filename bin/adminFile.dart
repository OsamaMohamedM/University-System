import 'dart:io';
import 'person.dart';
import 'Course.dart';
import 'doctor.dart';
import 'studentFile.dart';
import 'student.dart';

List<Admin> admins = [];

class Admin extends Person {
  Admin(int id, String name, int age, String nationalID, String tel,pass)
      : super(id, name, tel, age, nationalID,pass);
}

class AdminUI {
  void showOptions() {
    while (true) {
      print(
          "1-add course\n2-add doctor\n3-add student\n4-reset student password\n5-reset doctor password\n6-assign course to doctor\n7-exit");
      int choose = int.parse(stdin.readLineSync() ?? "-1");
      switch (choose) {
        case 1:
          _addCourse();
          break;
        case 2:
          _addDoctor();
          break;
        case 3:
          _addStudent();
          break;
        case 4:
          _resetPassword<StudentProfile>(Students, "student");
          break;
        case 5:
          _resetPassword<DoctorProfile>(doctors, "doctor");
          break;
        case 6:
          _assignCourseToDoctor();
          break;
        case 7:
          return;
        default:
          continue;
      }
    }
  }

  void _resetPassword<T>(List<T> list, String userType) {
    print("Enter $userType's ID:");
    int ID = int.parse(stdin.readLineSync() ?? "-1");
    while (ID < 0 || ID >= list.length) {
      print("Enter a valid ID:");
      ID = int.parse(stdin.readLineSync() ?? "-1");
    }

    bool found = false;
    for (int i = 0; i < list.length; i++) {
      if (userType == "student" &&
          list[i] is StudentProfile &&
          (list[i] as StudentProfile).StudentData.id == ID) {
        String newPassword = _getNewPassword();
        (list[i] as StudentProfile).StudentData.password = newPassword;
        print("Password reset successfully for student ID: $ID\n");
        found = true;
        break;
      } else if (userType == "doctor" &&
          list[i] is DoctorProfile &&
          (list[i] as DoctorProfile).DoctorData.id == ID) {
        String newPassword = _getNewPassword();
        (list[i] as DoctorProfile).DoctorData.password = newPassword;
        print("Password reset successfully for doctor ID: $ID\n");
        found = true;
        break;
      }
    }

    if (!found) {
      print("$userType with ID: $ID not found.\n");
    }
  }

  String _getNewPassword() {
    print("Enter new password:");
    String newPassword = stdin.readLineSync() ?? "";
    while (newPassword.isEmpty) {
      print("Please input a valid password:");
      newPassword = stdin.readLineSync() ?? "";
    }
    return newPassword;
  }

  void _assignCourseToDoctor() {
    print("Assigning course to doctor...");
    _displayCourses();
    int chooseCourse = int.parse(stdin.readLineSync() ?? "-1");
    while (chooseCourse < 1 || chooseCourse > courses.length) {
      chooseCourse = _handleInvalidChoice(chooseCourse, courses.length);
      if (chooseCourse == -1) return;
    }

    _displayDoctors();
    int chooseDoctor = int.parse(stdin.readLineSync() ?? "-1");
    while (chooseDoctor < 1 || chooseDoctor > doctors.length) {
      chooseDoctor = _handleInvalidChoice(chooseDoctor, doctors.length);
      if (chooseDoctor == -1) return;
    }

    doctors[chooseDoctor - 1].taskManger.addcourse(courses[chooseCourse - 1]);
    print("Course assigned successfully!\n");
  }

  int _handleInvalidChoice(int choice, int maxOption) {
    print("Invalid choice. Do you want to continue?");
    print("1-Continue\n2-Exit");
    int decision = int.parse(stdin.readLineSync() ?? "-1");
    if (decision == 1) {
      print("Enter your choice (1-$maxOption):");
      choice = int.parse(stdin.readLineSync() ?? "-1");
    } else {
      return -1;
    }
    return choice;
  }

  void _displayCourses() {
    for (int i = 0; i < courses.length; i++) {
      print("${i + 1} ${courses[i].CourseData.name}");
    }
  }

  void _displayDoctors() {
    for (int i = 0; i < doctors.length; i++) {
      print("${i + 1} ${doctors[i].DoctorData.name}");
    }
  }

  void _addCourse() {
    print("Enter name of course:");
    String name = stdin.readLineSync() ?? "";
    while (name.isEmpty) {
      print("Please input a valid name:");
      name = stdin.readLineSync() ?? "";
    }

    print("Enter number of hours:");
    int hours = int.parse(stdin.readLineSync() ?? "-1");
    while (hours <= 0) {
      print("Please input a valid number of hours:");
      hours = int.parse(stdin.readLineSync() ?? "-1");
    }

    Course course = Course(name, hours);
    courses.add(CourseProfile(course));
    print("Course added successfully!\n");
  }

  void _addDoctor() {
    Doctor doctor = _createDoctor();
    doctors.add(DoctorProfile(doctor));
    print("Doctor added successfully!\n");
  }

  Doctor _createDoctor() {
    print("Enter doctor's name:");
    String name = stdin.readLineSync() ?? "";
    while (name.isEmpty) {
      print("Please input a valid name:");
      name = stdin.readLineSync() ?? "";
    }

    String password = _getValidInput("password");
    String tel = _getValidInput("telephone number");
    int numOfYear = _getValidIntInput("number of years of experience", 0);
    int age = _getValidIntInput("age", 1);
    double salary = _getValidDoubleInput("salary", 0);

    return Doctor(name, tel, age, password, numOfYear, salary);
  }

  void _addStudent() {
    print("Enter student's name:");
    String name = stdin.readLineSync() ?? "";
    while (name.isEmpty) {
      print("Please input a valid name:");
      name = stdin.readLineSync() ?? "";
    }

    String nationalID = _getValidInput("national ID", 11);
    String tel = _getValidInput("telephone number");
    int numOfYear = _getValidIntInput("number of hours", 0);
    int age = _getValidIntInput("age", 1);
    double gpa = _getValidDoubleInput("GPA", 0, 4.0);

    Student student = Student(name, age, nationalID, tel, numOfYear, gpa,nationalID);
    StudentProfile x = StudentProfile(student);
    Students.add(x);
    print("Student added successfully!\n");
  }

  String _getValidInput(String field, [int length = 0]) {
    print("Enter $field:");
    String input = stdin.readLineSync() ?? "";
    while (input.isEmpty || (length > 0 && input.length != length)) {
      print("Please input a valid $field:");
      input = stdin.readLineSync() ?? "";
    }
    return input;
  }

  int _getValidIntInput(String field, int minValue) {
    print("Enter $field:");
    int input = int.parse(stdin.readLineSync() ?? "-1");
    while (input < minValue) {
      print("Please input a valid $field:");
      input = int.parse(stdin.readLineSync() ?? "-1");
    }
    return input;
  }

  double _getValidDoubleInput(String field, double minValue,
      [double maxValue = double.infinity]) {
    print("Enter $field:");
    double input = double.parse(stdin.readLineSync() ?? "-1");
    while (input < minValue || input > maxValue) {
      print("Please input a valid $field:");
      input = double.parse(stdin.readLineSync() ?? "-1");
    }
    return input;
  }
}
