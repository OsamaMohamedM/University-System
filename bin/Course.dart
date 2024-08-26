import 'observerDessgin.dart';
import 'student.dart';

List<CourseProfile> courses = [];

class Course {
  final int _id;
  String _name;
  final int _hours;
  static int _num = 1;
  List<Course> _Prerequisites = [];
  Course(this._name, this._hours) : _id = _num++;

  String get name => _name;
  int get id => _id;
  int get hours => _hours;
  List<Course> get pre => _Prerequisites;
  void setPrerequisites(Course course) {
    _Prerequisites.add(course);
  }
}

class CourseTasks implements Subject {
  final Course _course;
  CourseTasks(this._course);
  List<StudentProfile> observers = [];
  Course get course => _course;

  @override
  void registerObserver(StudentProfile observer) {
    observers.add(observer);
  }

  @override
  void removeObserver(StudentProfile observer) {
    observers.remove(observer);
  }

  @override
  void notifyObservers(Task task) {
    for (var ob in observers) {
      ob.taskManager.update(_course, task);
    }
  }
}

class Task {
  final int id;
  final String description;
  bool isCompleted;
  static int num = 1;
  Task(this.description)
      : isCompleted = false,
        id = num + 1;

  void complete() {
    isCompleted = true;
  }
}

class CourseProfile {
  final Course CourseData;
  final CourseTasks tasks;
  CourseProfile(this.CourseData) : tasks = CourseTasks(CourseData);
}
