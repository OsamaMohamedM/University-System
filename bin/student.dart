import 'Course.dart';
import 'person.dart';
import 'observerDessgin.dart';


class Student extends Person {
  static int _num = 1;
  final int level = 1;
  double _gpa = 0;
  int numberOfHours = 0;

  Student(String name, int age,String nationalID, String tel,this.numberOfHours,this._gpa,String pass)
      : super(_num++,name,tel,age,nationalID,pass);

  double get gpa => _gpa;

  void updateGpa(double gpa) {
    _gpa = gpa;
  }
}

class StudentCourseManager {
  List<Course> _courses;
  StudentCourseManager() : _courses = [];

  void registerCourse(Course course) {
    if (!_courses.contains(course)) {
      _courses.add(course);
    }
  }

  void dropCourse(Course course) {
    _courses.remove(course);
  }

  List<Course> get courses => List.unmodifiable(_courses);

  bool isRegstered(Course course) {
    return _courses.any((c) => c.id == course.id);
  }
}

class StudentGradeManager {
  final Student _student;
  final Map<Course, String> _grades;

  StudentGradeManager(this._student) : _grades = {};

  static const Map<String, double> _gradeMapping = {
    "A+": 4.0,
    "A": 3.7,
    "B+": 3.3,
    "B": 3.0,
    "C+": 2.7,
    "C": 2.4,
    "D+": 2.2,
    "D": 2.0,
    "F": 0.0,
  };

  void calculateGpa() {
    double sum = 0;
    double totalHours = 0;
    _grades.forEach((course, grade) {
      double gradeValue = _getGradeValue(grade);
      sum += gradeValue * course.hours;
      totalHours += course.hours;
    });
    if (totalHours > 0) {
      _student.updateGpa(sum / totalHours);
    }
  }

  double _getGradeValue(String grade) {
    return _gradeMapping[grade] ?? 0.0;
  }

  String determineLetterGrade(double grade) {
    if (grade >= 90) return "A+";
    if (grade >= 85) return "A";
    if (grade >= 80) return "B+";
    if (grade >= 75) return "B";
    if (grade >= 70) return "C+";
    if (grade >= 65) return "C";
    if (grade >= 60) return "D+";
    if (grade >= 50) return "D";
    return "F";
  }

  void assignGrade(Course course, double grade) {
    _grades[course] = determineLetterGrade(grade);
  }

  void remove(Course course) {
    _grades.remove(course);
  }

  void addcourse(Course course) {
    _grades[course] = "?";
  }

  Map<Course, String> get grades => Map.unmodifiable(_grades);
}

class StudentTaskManager implements Observer {
  final Map<Course, List<Task>> _courseTasks;
  StudentTaskManager() : _courseTasks = {};
  @override
  void update(Course course, Task task) {
      _courseTasks.putIfAbsent(course, () => []);
      _courseTasks[course]!.add(task);

  }

  List<Task> getTasksForCourse(Course course) {
    return _courseTasks[course] ?? [];
  }

  Map<Course, List<Task>> getAllTasks() {
    return Map.unmodifiable(_courseTasks);
  }

  void completeTask(Course course, Task task) {
    if (_courseTasks.containsKey(course) &&
        _courseTasks[course]!.contains(task)) {
      task.complete();
    } else {
      print(
          "Task not found in this course or student is not registered for this course.");
    }
  }

  List<Task> getCompletedTasksForCourse(Course course) {
    return _courseTasks[course]?.where((task) => task.isCompleted).toList() ??
        [];
  }

  List<Task> getIncompleteTasksForCourse(Course course) {
    return _courseTasks[course]?.where((task) => !task.isCompleted).toList() ??
        [];
  }
}

class StudentProfile {
  final Student StudentData;
  final StudentCourseManager courseManager;
  final StudentGradeManager gradeManager;
  final StudentTaskManager taskManager;

  StudentProfile(this.StudentData)
      : courseManager = StudentCourseManager(),
        gradeManager = StudentGradeManager(StudentData),
        taskManager = StudentTaskManager();
}
