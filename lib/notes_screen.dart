import 'package:flutter/material.dart';

void main() {
  runApp(const TasksApp());
}

class TasksApp extends StatelessWidget {
  const TasksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مذكرتي - مهامي اليومية',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Cairo',
      ),
      home: const TasksScreen(),
    );
  }
}

class TaskItem {
  final String title;
  final String category;
  final String time;
  bool isCompleted;

  TaskItem({
    required this.title,
    required this.category,
    required this.time,
    this.isCompleted = false,
  });
}

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  int selectedTab = 0; // 0: اليوم, 1: الأسبوع, 2: الكل

  final List<TaskItem> tasks = [
    TaskItem(title: 'تركيب لوحة كهربائية منزلية', category: 'منزلي', time: '09:00', isCompleted: true),
    TaskItem(title: 'فحص محرك 380V', category: 'صناعي', time: '14:00', isCompleted: false),
    TaskItem(title: 'شراء كونتاكتور', category: 'مواد', time: '17:00', isCompleted: false),
    TaskItem(title: 'مقاومة مع الزبون', category: 'طاريء', time: '19:00', isCompleted: false),
    TaskItem(title: 'إعداد الفاتورة', category: 'محاسبة', time: '21:00', isCompleted: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0F172A),
          title: const Text('مهامي اليومية', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // أزرار التبديل (اليوم / الأسبوع / الكل)
              Row(
                children: [
                  Expanded(child: _buildTabButton('اليوم', 0)),
                  const SizedBox(width: 8),
                  Expanded(child: _buildTabButton('الأسبوع', 1)),
                  const SizedBox(width: 8),
                  Expanded(child: _buildTabButton('الكل', 2)),
                ],
              ),
              const SizedBox(height: 16),
              const Text('الجمعة 2025/10/06', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 8),
              
              // قائمة المهام
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        leading: Checkbox(
                          value: task.isCompleted,
                          activeColor: Colors.green,
                          onChanged: (bool? value) {
                            setState(() {
                              task.isCompleted = value ?? false;
                            });
                          },
                        ),
                        title: Text(
                          task.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                            color: task.isCompleted ? Colors.grey : Colors.black,
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(task.category, style: const TextStyle(fontSize: 10, color: Colors.blue)),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.access_time, size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(task.time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF0284C7),
          onPressed: () {},
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    bool isSelected = selectedTab == index;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? const Color(0xFF0284C7) : Colors.grey[200],
        foregroundColor: isSelected ? Colors.white : Colors.black87,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () => setState(() => selectedTab = index),
      child: Text(title),
    );
  }
}
