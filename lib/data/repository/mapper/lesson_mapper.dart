import 'package:registro_elettronico/data/db/moor_database.dart' as db;
import 'package:registro_elettronico/domain/entity/lessons_response.dart'
    as entity;

/// "evtId": 7096829,
///           "evtDate": "2019-12-09",
///           "evtCode": "LSS0",
///           "evtHPos": 1,
///           "evtDuration": 1,
///           "classDesc": "4IA INFORMATICA",
///           "authorName": "TRENTO PAOLO",
///           "subjectId": 5,
///           "subjectCode": "SOST",
///           "subjectDesc": "SOSTEGNO",
///           "lessonType": "Compresenza",
///           "lessonArg": ""

class LessonMapper {
  const LessonMapper();
  db.Lesson mapLessonEntityToLessoneInsertable(e) {
    print(e.runtimeType);
    return db.Lesson(
        eventId: e.evtId,
        date: DateTime.parse(e.evtDate),
        code: e.evtCode,
        position: e.evtHPos,
        duration: e.evtDuration,
        classe: e.classDesc,
        author: e.authorName,
        subjectId: e.subjectId,
        subjectCode: e.subjectCode,
        subjectDescription: e.subjectDesc,
        lessonType: e.lessonType,
        lessonArg: e.lessonArg);
  }
}
