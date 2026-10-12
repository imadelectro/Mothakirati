import 'package:flutter/material.dart';

void main() {
  runApp(const DebtsApp());
}

class DebtsApp extends StatelessWidget {
  const DebtsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مذكرتي - إدارة الديون',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Cairo',
      ),
      home: const DebtsScreen(),
    );
  }
}

class DebtItem {
  final String name;
  final String amount;
  final String date;
  final bool isCustomer; // true = لك عند الزبون, false = عليك للموردين

  DebtItem({required this.name, required this.amount, required this.date, required this.isCustomer});
}

class DebtsScreen extends StatefulWidget {
  const DebtsScreen({super.key});

  @override
  State<DebtsScreen> createState() => _DebtsScreenState();
}

class _DebtsScreenState extends State<DebtsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<DebtItem> debts = [
    DebtItem(name: 'سعيد بوعلام', amount: '16,000 دج', date: '2025/09/10', isCustomer: true),
    DebtItem(name: 'شركة الكهرباء', amount: '21,000 دج', date: '2025/09/05', isCustomer: true),
    DebtItem(name: 'أحمد زروقي', amount: '8,500 دج', date: '2025/09/10', isCustomer: true),
    DebtItem(name: 'مؤسسة التجهيز الصناعي', amount: '23,000 دج', date: '2025/09/12', isCustomer: false),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0F172A),
          title: const Text('ديوني', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          centerTitle: true,
          bottom: TabBar(
            controller: _tabController,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.amber,
            tabs: const [
              Tab(text: 'لك عند الزبون'),
              Tab(text: 'عليك للموردين'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildDebtList(true),
            _buildDebtList(false),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF0284C7),
          onPressed: () {},
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildDebtList(bool isCustomerTab) {
    final filteredList = debts.where((d) => d.isCustomer == isCustomerTab).toList();

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          // حقل البحث
          TextField(
            decoration: InputDecoration(
              hintText: isCustomerTab ? 'ابحث باسم الزبون...' : 'ابحث باسم المورد...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final debt = filteredList[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isCustomerTab ? Colors.blue[50] : Colors.red[50],
                      child: Icon(
                        isCustomerTab ? Icons.person : Icons.business,
                        color: isCustomerTab ? Colors.blue : Colors.red,
                      ),
                    ),
                    title: Text(debt.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('الريخ: ${debt.date}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(debt.amount, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 14)),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.red[100],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text('متبقي', style: TextStyle(fontSize: 10, color: Colors.red)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
