// ignore_for_file: avoid_print
// תחנה 2 — משתנים, טיפוסים ו-null
// הרצה: dart run bin/station2_variables.dart

void main() {
  // var — הטיפוס נקבע לפי הערך הראשון ולא משתנה אחר כך
  var city = 'Haifa'; // String
  city = 'Tel Aviv'; // מותר: עדיין String

  // final — אפשר להציב רק פעם אחת (הערך נקבע בזמן ריצה)
  final now = DateTime.now();

  // const — קבוע שידוע כבר בזמן קומפילציה
  const passGrade = 56;

  // טיפוסים מפורשים
  int age = 17;
  double height = 1.72;
  String name = 'Dana';
  bool isStudent = true;

  // null safety: הסימן ? אומר "המשתנה יכול להיות null"
  String? nickname; // כרגע null
  // ?? — "אם זה null, קח את הערך שמימין"
  print('Nickname: ${nickname ?? 'none'}');

  nickname = 'Dani';
  print('Nickname: $nickname'); // Dart יודע שעכשיו זה כבר לא null

  print('$name, $age, $height m, student: $isStudent, $city');
  print('Pass grade: $passGrade, now: ${now.hour}:${now.minute}');

  // ---- 4 שגיאות קומפילציה נפוצות (בטלו את ההערה כדי לראות אותן) ----
  // 1. int x = 'hello';          // String לא נכנס ל-int
  // 2. passGrade = 60;           // אי אפשר לשנות const
  // 3. String s = nickname2;     // משתנה שלא הוגדר
  // 4. String t = null;          // String בלי ? לא יכול להיות null
}
