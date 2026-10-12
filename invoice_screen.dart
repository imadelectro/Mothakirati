import 'package:flutter/material.dart';

void main() {
  runApp(const MouzakiratiApp());
}

class MouzakiratiApp extends StatelessWidget {
  const MouzakiratiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مذكرتي - فاتورة جديدة',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Cairo',
      ),
      home: const NewInvoiceScreen(),
    );
  }
}

class ItemRow {
  String title;
  int quantity;
  double price;

  ItemRow({required this.title, required this.quantity, required this.price});

  double get total => quantity * price;
}

class NewInvoiceScreen extends StatefulWidget {
  const NewInvoiceScreen({super.key});

  @override
  State<NewInvoiceScreen> createState() => _NewInvoiceScreenState();
}

class _NewInvoiceScreenState extends State<NewInvoiceScreen> {
  bool isHomeType = true;
  final TextEditingController nameController = TextEditingController(text: 'أحمد بن عيسى');
  final TextEditingController phoneController = TextEditingController(text: '07 12 34 56 78');
  final TextEditingController notesController = TextEditingController(text: 'تركيب لوحة كهربائية منزلية');
  final TextEditingController paidController = TextEditingController(text: '10000');

  List<ItemRow> items = [
    ItemRow(title: 'كابل 3x2.5', quantity: 50, price: 190),
    ItemRow(title: 'قاطع 20A', quantity: 3, price: 850),
    ItemRow(title: 'مقبس', quantity: 10, price: 300),
    ItemRow(title: 'أجرة العمل', quantity: 1, price: 5000),
  ];

  double get subTotal => items.fold(0, (sum, item) => sum + item.total);
  double get paid => double.tryParse(paidController.text) ?? 0;
  double get remaining => subTotal - paid;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0F172A),
          title: const Text('فاتورة جديدة', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {},
          ),
          actions: [
            IconButton(icon: const Icon(Icons.check, color: Colors.white), onPressed: () {}),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // اختيار نوع الفاتورة (منزلي / صناعي)
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isHomeType ? const Color(0xFF0284C7) : Colors.grey[200],
                        foregroundColor: isHomeType ? Colors.white : Colors.black87,
                      ),
                      onPressed: () => setState(() => isHomeType = true),
                      icon: const Icon(Icons.home),
                      label: const Text('منزلي'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: !isHomeType ? const Color(0xFF0284C7) : Colors.grey[200],
                        foregroundColor: !isHomeType ? Colors.white : Colors.black87,
                      ),
                      onPressed: () => setState(() => isHomeType = false),
                      icon: const Icon(Icons.factory),
                      label: const Text('صناعي'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // بيانات الزبون
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'اسم الزبون', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'رقم الهاتف', prefixIcon: Icon(Icons.phone), border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: notesController,
                decoration: const InputDecoration(labelText: 'ملاحظات', prefixIcon: Icon(Icons.note), border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),

              // جدول المواد
              Container(
                color: Colors.grey[100],
                padding: const EdgeInsets.all(8),
                child: const Row(
                  children: [
                    Expanded(flex: 3, child: Text('البيان', style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(flex: 2, child: Text('الكمية', style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(flex: 2, child: Text('سعر الوحدة', style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(flex: 2, child: Text('المجموع', style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                ),
              ),
              const Divider(height: 1),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Text(item.title)),
                        Expanded(flex: 2, child: Text('${item.quantity}')),
                        Expanded(flex: 2, child: Text('${item.price.toStringAsFixed(0)} دج')),
                        Expanded(flex: 2, child: Text('${item.total.toStringAsFixed(0)} دج', style: const TextStyle(fontWeight: FontWeight.bold))),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),

              // زر إضافة مادة
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0284C7)),
                  onPressed: () {
                    setState(() {
                      items.add(ItemRow(title: 'مادة جديدة', quantity: 1, price: 1000));
                    });
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text('إضافة مادة', style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 20),

              // الحسابات والتفاصيل المالية
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('المجموع العام:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Text('${subTotal.toStringAsFixed(0)} دج', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('المدفوع:', style: TextStyle(fontSize: 16)),
                          SizedBox(
                            width: 100,
                            height: 40,
                            child: TextField(
                              controller: paidController,
                              keyboardType: TextInputType.number,
                              onChanged: (v) => setState(() {}),
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.zero),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('المتبقي:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
                          Text('${remaining.toStringAsFixed(0)} دج', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // أزرار العمليات (حفظ، مشاركة PDF، طباعة)
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF16A34A)),
                      onPressed: () {},
                      icon: const Icon(Icons.save, color: Colors.white),
                      label: const Text('حفظ', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0284C7)),
                      onPressed: () {},
                      icon: const Icon(Icons.share, color: Colors.white),
                      label: const Text('مشاركة PDF', style: TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF475569)),
                      onPressed: () {},
                      icon: const Icon(Icons.print, color: Colors.white),
                      label: const Text('طباعة', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
