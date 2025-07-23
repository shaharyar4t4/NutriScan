import 'package:flutter/material.dart';
import 'package:nutriscan/feacture/recent_product/db/scan_history_helper.dart';

class ScanHistoryScreen extends StatelessWidget {
  final dbHelper = ScanHistoryHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan History'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () async {
              await dbHelper.clearAllScans();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('All history cleared')),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: dbHelper.getScans(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final scans = snapshot.data!;

          if (scans.isEmpty) {
            return Center(child: Text('No scan history yet.'));
          }

          return ListView.builder(
            itemCount: scans.length,
            itemBuilder: (context, index) {
              final scan = scans[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text(scan['productName']),
                  subtitle: Text(
                    'Brand: ${scan['brand']}\nCalories: ${scan['calories'].toStringAsFixed(1)} kcal\nScanned: ${scan['dateTime']}',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
