import 'dart:io';
import 'studentFile.dart';
import 'student.dart';
import 'doctor.dart';
import 'person.dart';
import 'doctorFile.dart';
import 'Course.dart';
import 'adminFile.dart';

int chk<T>(int ID, String password, List<T> lst) {

  for (int i = 0; i < lst.length; i++) {
    if (lst[i] is StudentProfile &&
        (lst[i] as StudentProfile).StudentData.id == ID &&
        (lst[i] as StudentProfile).StudentData.password == password) {
      return i;
    } else if (lst[i] is DoctorProfile &&
        (lst[i] as DoctorProfile).DoctorData.id == ID &&
        (lst[i] as DoctorProfile).DoctorData.password == password) {
      return i;
    } else if (lst[i] is Admin &&
        (lst[i] as Admin).id == ID &&
        (lst[i] as Admin).password == password) {
      return i;
    }
  }
  return -1;
}

int login<T>(List<T> lst) {
  print("ENTER your ID");

  int ID = -1;
  ID = int.parse(stdin.readLineSync()!);

  print("ENTER your password");
  String password = "";
  password = stdin.readLineSync() ?? "NO";

  int x = chk(ID, password, lst);
  if (x == -1) {
    print("Invalid ID or Password");
  }
  return x;
}

void main() {
  Admin person = Admin(1, "OSAMA", 18, "123", "923","123");
  admins.add(person);
  stdout.write("Hello\n");
  while (true) {
    print("please choose number\n");
    print("Login as ");
    print("1- student\n2- doctor\n3- admin\n4-exit");
    int choose;
    choose = int.parse(stdin.readLineSync()!);

    if (choose == 1) {
      int x = login(Students);
      if (x != -1) {
        StudentProfileUI obj = StudentProfileUI(Students[x]);
        obj.showOptions();
      }
    } else if (choose == 2) {
      int x = login(doctors);
      if (x != -1) {
        DoctorProfileUI obj = DoctorProfileUI(doctors[x]);
        obj.showOptions();
      }
    } else if (choose == 3) {
      int x = login(admins);
      if (x != -1) {
        AdminUI obj = AdminUI();
        obj.showOptions();
      }
    } else if (choose == 4) {
      break;
    }
  }
}
