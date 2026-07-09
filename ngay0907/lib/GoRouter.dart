import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _dataResult;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
        backgroundColor: Colors.deepPurple[100],
      ),
      body: Center(
        child: Column(
          spacing: 24,
          children: [
            ElevatedButton(
              onPressed: () {
                // su dung query parameters
                context.push(
                  Uri(
                    path: '/product/123',
                    queryParameters: {'filter': 'abc'},
                  ).toString(),
                );
              },
              child: Text('Go to Product Detail'),
            ),

            ElevatedButton(
              onPressed: () async {
                _dataResult = await context.push<String>(
                  Uri(path: '/profile').toString(),
                );

                setState(() {
                  _dataResult = _dataResult ?? 'Khong co du lieu tra ve';
                });
              },
              child: Text('Lay du lieu ve'),
            ),

            Text(_dataResult ?? '')
          ],
        ),
      ),
    );
  }
}

class ProductScreen extends StatelessWidget {
  final String productId;
  final String? filter;

  const ProductScreen({super.key, required this.productId, this.filter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail page'),
        backgroundColor: Colors.blue[100],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Product ID: $productId\nFilter: ${filter ?? 'Khong co gia tri loc'}',
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.pop();
              },
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile page'), backgroundColor: Colors.lime),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.pop();
            // context.pop('Du lieu tra ve man home tu man profile');
          },
          child: Text('back to home'),
        ),
      ),
    );
  }
}
