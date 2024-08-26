import 'Course.dart';
import 'student.dart';

interface class Observer {
  void update(Course coures, Task task) {}
}

interface class Subject {
  void registerObserver(StudentProfile observer) {}
  void removeObserver(StudentProfile observer) {}
  void notifyObservers(Task task) {}
}
