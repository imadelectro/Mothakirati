import 'package:flutter/material.dart';

void main() {
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مذكرتي - ملاحظاتي',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Cairo',
      ),
      home: const NotesScreen(),
    );
  }
}

class NoteItem {
  final String title;
  final String description;
  final String date;
  final String category;
  final Color categoryColor;
  final IconData categoryIcon;

  NoteItem({
    required this.title,
    required this.description,
    required this.date,
    required this.category,
    required this.categoryColor,
    required this.categoryIcon,
  });
}

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final List<NoteItem> notes = [
    NoteItem(
      title: 'لوحة كهربائية',
      description: 'تركيب لوحة كهربائية لـ 3 غرف مع توفيق...',
      date: '2025/10/12',
      category: 'صناعي',
      categoryColor: Colors.orange,
      categoryIcon: Icons.factory,
    ),
    NoteItem(
      title: 'عطل في محرك',
      description: 'توقف المحرك بعد ارتفاع التيار الكهربائي...',
      date: '2025/10/10',
      category: 'محركات',
      categoryColor: Colors.blue,
      categoryIcon: Icons.settings_suggest,
    ),
    NoteItem(
      title: 'ملاحظة عامة',
      description: 'يجب تغيير قاطع الكابل في الغلط...',
      date: '2025/09/18',
      category: 'صيانة',
      categoryColor: Colors.red,
      categoryIcon: Icons.build,
    ),
    NoteItem(
      title: 'فكرا مشروع',
      description: 'تأني إدارة LED للمحلات والشركات...',
      date: '2025/09/15',
      category: 'صفقات',
      categoryColor: Colors.purple,
      categoryIcon: Icons.lightbulb,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0F172A),
          title: const Text('ملاحظاتي', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              // حقل البحث وزر التصفية
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'ابحث في الملاحظات...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_list),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              // شبكة عرض الملاحظات
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // صورة أو أيقونة توضيحية للملاحظة
                          Container(
                            height: 90,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                            ),
                            child: Center(
                              child: Icon(note.categoryIcon, size: 40, color: note.categoryColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(note.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: note.categoryColor.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(note.category, style: TextStyle(fontSize: 10, color: note.categoryColor, fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  note.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                                ),
                                const SizedBox(height: 6),
                                Text(note.date, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                              ],
                            ),
                          ),
                        ],
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
}
