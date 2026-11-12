import 'package:flutter/material.dart';

// תחנה 6 — מ-Dart ל-Flutter: אפליקציית ציונים
// כל מושג מהתחנות הקודמות מופיע כאן:
//   תחנה 2: const / final / int / String
//   תחנה 3: List
//   תחנה 4: פונקציות (average, isPassing)
//   תחנה 5: מחלקה (Student)

const int passGrade = 56;

// ---- חלק 1: המחלקה Student ----
class Student {
  final String name;
  int grade;

  Student({required this.name, required this.grade});

  bool get isPassing => grade >= passGrade;
}

// ---- חלק 2: פונקציה שמחשבת ממוצע ----
double average(List<Student> students) {
  if (students.isEmpty) return 0;
  var sum = 0;
  for (final s in students) {
    sum += s.grade;
  }
  return sum / students.length;
}

void main() {
  runApp(const GradesApp());
}

class GradesApp extends StatelessWidget {
  const GradesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ציונים',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // כיוון מימין לשמאל — בשביל עברית
      builder: (context, child) =>
          Directionality(textDirection: TextDirection.rtl, child: child!),
      home: const GradesPage(),
    );
  }
}

class GradesPage extends StatefulWidget {
  const GradesPage({super.key});

  @override
  State<GradesPage> createState() => _GradesPageState();
}

class _GradesPageState extends State<GradesPage> {
  // ---- חלק 3: רשימת התלמידים ----
  final List<Student> _students = [
    Student(name: 'נועה', grade: 92),
    Student(name: 'עומר', grade: 48),
    Student(name: 'דנה', grade: 71),
    Student(name: 'יוסף', grade: 54),
  ];

  // ---- חלק 4: כפתור שמעלה ציון ----
  void _raiseGrade(Student student) {
    // setState אומר ל-Flutter לצייר מחדש את המסך
    setState(() {
      student.grade = (student.grade + 5).clamp(0, 100);
    });
  }

  // ---- חלק 5: הוספת תלמיד חדש עם ציון ----
  Future<void> _addStudent() async {
    final nameController = TextEditingController();
    final gradeController = TextEditingController();
    String? error;

    final student = await showDialog<Student>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('הוספת ציון'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'שם'),
              ),
              TextField(
                controller: gradeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'ציון (0–100)',
                  errorText: error,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('ביטול'),
            ),
            FilledButton(
              onPressed: () {
                final name = nameController.text.trim();
                final grade = int.tryParse(gradeController.text.trim());
                if (name.isEmpty || grade == null || grade < 0 || grade > 100) {
                  setDialogState(() => error = 'צריך שם וציון בין 0 ל-100');
                  return;
                }
                Navigator.pop(context, Student(name: name, grade: grade));
              },
              child: const Text('הוספה'),
            ),
          ],
        ),
      ),
    );

    if (student != null) {
      setState(() => _students.add(student));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addStudent,
        icon: const Icon(Icons.person_add),
        label: const Text('הוספת ציון'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ממוצע למעלה
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'ממוצע: ${average(_students).toStringAsFixed(1)}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _students.length,
                itemBuilder: (context, index) {
                  final student = _students[index];
                  return ListTile(
                    // ✓ ירוק למי שעבר, ✗ אדום למי שנכשל
                    leading: Icon(
                      student.isPassing ? Icons.check_circle : Icons.cancel,
                      color: student.isPassing ? Colors.green : Colors.red,
                    ),
                    title: Text(student.name),
                    subtitle: Text('ציון: ${student.grade}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.add),
                      tooltip: 'העלאת ציון',
                      onPressed: () => _raiseGrade(student),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
