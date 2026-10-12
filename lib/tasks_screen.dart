import 'package:flutter/material.dart';

void main() {
  runApp(const MouzakiratiApp());
}

class MouzakiratiApp extends StatelessWidget {
  const MouzakiratiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مذكرتي لأعمال الكهرباء',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Cairo',
      ),
      home: const HomeScreen(),
    );
  }
}

// ================= الشاشة الرئيسية =================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0F172A),
          title: const Text('مذكرتي - أعمال الكهرباء', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF0284C7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.electric_bolt, color: Colors.amber, size: 40),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('مرحباً بك!', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                        Text('كل أعمالك في مكان واحد', style: TextStyle(color: Colors.white70, fontSize: 14)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: [
                    _buildMenuCard(context, 'فواتيري', Icons.receipt_long, Colors.blue, const InvoicesScreen()),
                    _buildMenuCard(context, 'ديوني', Icons.account_balance_wallet, Colors.green, const DebtsScreen()),
                    _buildMenuCard(context, 'مهامي اليومية', Icons.task_alt, Colors.orange, const TasksScreen()),
                    _buildMenuCard(context, 'ملاحظاتي', Icons.note_alt, Colors.purple, const NotesScreen()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, String title, IconData icon, Color color, Widget targetScreen) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => targetScreen));
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.2),
              radius: 28,
              child: Icon(icon, color: color, size: 30),
            ),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

// ================= شاشة الفواتير =================
class InvoicesScreen extends StatelessWidget {
  const InvoicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(backgroundColor: const Color(0xFF0F172A), title: const Text('قائمة الفواتير', style: TextStyle(color: Colors.white))),
        body: ListView(
          padding: const EdgeInsets.all(12),
          children: const [
            ListTile(
              title: Text('أحمد بن عيسى', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('مبلغ: 19,550 دج - 2025/10/06'),
              trailing: Text('مدفوعة جزئياً', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
            ),
            Divider(),
            ListTile(
              title: Text('مؤسسة النور الصناعية', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('مبلغ: 45,000 دج - 2025/10/03'),
              trailing: Text('غير مدفوعة', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= شاشة الديون =================
class DebtsScreen extends StatelessWidget {
  const DebtsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(backgroundColor: const Color(0xFF0F172A), title: const Text('ديوني', style: TextStyle(color: Colors.white))),
        body: ListView(
          padding: const EdgeInsets.all(12),
          children: const [
            ListTile(
              leading: Icon(Icons.person, color: Colors.blue),
              title: Text('سعيد بوعلام', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('التاريخ: 2025/09/10'),
              trailing: Text('16,000 دج', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.business, color: Colors.red),
              title: Text('شركة الكهرباء', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('التاريخ: 2025/09/05'),
              trailing: Text('21,000 دج', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= شاشة المهام =================
class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(backgroundColor: const Color(0xFF0F172A), title: const Text('مهامي اليومية', style: TextStyle(color: Colors.white))),
        body: ListView(
          padding: const EdgeInsets.all(12),
          children: const [
            CheckboxListTile(
              value: true,
              onChanged: null,
              title: Text('تركيب لوحة كهربائية منزلية'),
              subtitle: Text('09:00 - منزلي'),
            ),
            CheckboxListTile(
              value: false,
              onChanged: null,
              title: Text('فحص محرك 380V'),
              subtitle: Text('14:00 - صناعي'),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= شاشة الملاحظات =================
class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(backgroundColor: const Color(0xFF0F172A), title: const Text('ملاحظاتي', style: TextStyle(color: Colors.white))),
        body: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(12),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(Icons.factory, size: 40, color: Colors.orange),
                    SizedBox(height: 8),
                    Text('لوحة كهربائية', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('تركيب لوحة 3 غرف...', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
