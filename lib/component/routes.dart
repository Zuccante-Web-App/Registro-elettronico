import 'package:registro_elettronico/ui/feature/absences/absences_page.dart';
import 'package:registro_elettronico/ui/feature/agenda/agenda_page.dart';
import 'package:registro_elettronico/ui/feature/grades/grades_page.dart';
import 'package:registro_elettronico/ui/feature/home/home_page.dart';
import 'package:registro_elettronico/ui/feature/lessons/lessons_page.dart';
import 'package:registro_elettronico/ui/feature/login/login_page.dart';
import 'package:registro_elettronico/ui/feature/noticeboard/noticeboard_page.dart';
import 'package:registro_elettronico/ui/feature/splash_screen/splash_screen.dart';

class Routes {
  static const MAIN = '/';
  static const LOGIN = '/login';
  static const HOME = '/home';
  static const LESSONS = '/lessons';
  static const GRADES = '/grades';
  static const AGENDA = '/agenda';
  static const ABSENCES = '/absences';
  static const NOTICEBOARD = '/noticeboard';

  static var routes = {
    MAIN: (ctx) => SplashScreen(),
    LOGIN: (ctx) => LoginPage(),
    HOME: (ctx) => HomePage(),
    LESSONS: (ctx) => LessonsPage(),
    GRADES: (ctx) => GradesPage(),
    AGENDA: (ctx) => AgendaPage(),
    ABSENCES: (ctx) => AbsencesPage(),
    NOTICEBOARD: (ctx) => NoticeboardPage()
  };
}
