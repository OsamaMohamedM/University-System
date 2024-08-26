import 'person.dart';
import 'Course.dart';

List<DoctorProfile> doctors=[];

class Doctor extends Person {
  double _salry = 0;
  static int _num = 1;
  int _numOfYears = 0;

  Doctor(String name, String tel, int age, String pass, this._numOfYears,
      this._salry)
      : super(_num++, name, tel, age,"EGYPT",pass) {}

  void updateSalry(double money) {
    _salry = money;
  }

  double get salry => _salry;

  int get numofYears => _numOfYears;
}

class DoctorTask {
  List<CourseProfile> _lst = [];

  void addcourse(CourseProfile course) {
    lst.add(course);
  }

  List<CourseProfile> get lst => _lst;

  void addTask(Course course, Task task) {
    for (var element in courses) {
      if (element.CourseData.id == course.id) {
        element.tasks.notifyObservers(task);
        return;
      }
    }
  }
}

class DoctorProfile {
  final Doctor DoctorData;
  final DoctorTask taskManger;
  DoctorProfile(this.DoctorData) : taskManger = DoctorTask();
}
