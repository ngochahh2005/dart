class GradeSchool {
  final Map<int, List<String>> _db = {};

  GradeSchool();

  List<bool> add(List<(String, int)> students) {
    List<bool> res = [];

    for (var s in students) {
      String name = s.$1;
      int grade = s.$2;

      if (_isStudentEnrolledName(name)) {
        res.add(false);
      } else {
        _db.putIfAbsent(grade, () => []);
        _db[grade]!.add(name);
        res.add(true);
      }
    }

    return res;
  }

  bool _isStudentEnrolledName(String name) {
    for (var list in _db.values) {
      if (list.contains(name)) return true;
    }
    return false;
  }

  List<String> grade(int gradeNumber) {
    if (!_db.containsKey(gradeNumber)) return [];

    List<String> students = List.from(_db[gradeNumber]!);
    students.sort();
    return students;
  }

  List<String> roster() {
    var sortedGrades = _db.keys.toList()..sort();

    List<String> res = [];
    for (var x in sortedGrades) {
      res.addAll(grade(x));
    }

    return res;
  }
} 

// https://exercism.org/tracks/dart/exercises/grade-school/edit