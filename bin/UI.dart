import 'Course.dart';
import 'student.dart';
import 'dart:io';

class TaskManagerUI {
  final StudentProfile student;

  TaskManagerUI(this.student);

  void performTask() {
    List<Course> courses = student.courseManager.courses;
    int courseIndex = _chooseOption(
        "Please choose a course", courses.map((c) => c.name).toList());
    if (courseIndex == -1) return;

    Course selectedCourse = courses[courseIndex];
    List<Task> tasks = student.taskManager.getTasksForCourse(selectedCourse);
    int taskIndex = _chooseOption(
        "Please choose a task",
        tasks.map((t) =>
                "${t.description} ${t.isCompleted ? 'complete' : 'not complete'}")
            .toList());
    if (taskIndex == -1) return;

    student.taskManager.completeTask(selectedCourse, tasks[taskIndex]);
  }

  int _chooseOption(String prompt, List<String> options) {
    print(prompt);
    for (int i = 0; i < options.length; i++) {
      print("$i- ${options[i]}");
    }
    int? choice = int.tryParse(stdin.readLineSync() ?? "-1");
    if (choice == null || choice < 0 || choice >= options.length) {
      print("Invalid choice");
      return -1;
    }
    return choice;
  }
}

class CoursePrerequisiteChecker {
  final StudentProfile _student;

  CoursePrerequisiteChecker(this._student);

  bool hasMetPrerequisites(Course course) {
    return course.pre.every(
        (prerequisite) => _student.courseManager.isRegstered(prerequisite));
  }
}

class CourseDisplay {
  final StudentProfile _student;
  final CoursePrerequisiteChecker _checker;

  CourseDisplay(this._student, this._checker);

  void showAvailableCourses(List<CourseProfile>courses) {
    for (int i = 0; i < courses.length; i++) {
      if (!_student.courseManager.isRegstered(courses[i].CourseData) &&
          _checker.hasMetPrerequisites(courses[i].CourseData)) {
        print("$i ${courses[i].CourseData.name}");
      }
    }

    int? chosenIndex = _getUserInput();
    if (chosenIndex != null &&
        chosenIndex >= 0 &&
        chosenIndex < courses.length) {
      _student.courseManager.registerCourse(courses[chosenIndex].CourseData);
      _student.gradeManager.addcourse(courses[chosenIndex].CourseData);
      courses[chosenIndex].tasks.registerObserver(_student);
    } else {
      print("Invalid selection.");
    }
  }

  int? _getUserInput() {
    int? input = int.tryParse(stdin.readLineSync() ?? "-1");
    return input;
  }
}




class RegisterCourseUI {
  final StudentProfile _student;

  RegisterCourseUI(this._student);

  void showAvailableCourses(List<CourseProfile> courses) {
    final checker = CoursePrerequisiteChecker(_student);
    final display = CourseDisplay(_student, checker);
    display.showAvailableCourses(courses);
  }
}
