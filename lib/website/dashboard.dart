import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
     final String userName;
  const DashboardPage({Key? key, required this.userName}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem-vindo(a), $userName'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Overview',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMetricCard(
                  context,
                  title: 'Total',
                  value: '\$20,000',
                  icon: Icons.shopping_bag,
                  color: Colors.green,
                ),
                _buildMetricCard(
                  context,
                  title: 'Compras',
                  value: '1,000',
                  icon: Icons.shopping_cart,
                  color: Colors.blue,
                ),
                _buildMetricCard(
                  context,
                  title: 'Customers',
                  value: '500',
                  icon: Icons.people,
                  color: Colors.orange,
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              'Recent Sales',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: const Icon(Icons.shopping_bag),
                    title: Text('Order #${index + 1}'),
                    subtitle: const Text('Customer Name'),
                    trailing: Text('\$${(index + 1) * 200}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildMetricCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3 - 30,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 30,
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
