import 'package:flutter/material.dart';
import '../edit_product_screen.dart';
import '../my_products_screen.dart';

class AddPage extends StatelessWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: SizedBox(
            width: 110,
            height: 55,
            child: Image.asset(
              'assets/images/logob.png',
              fit: BoxFit.fill,
            )),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const EditProductScreen()));
              },
              child: Container(
                height: 100,
                width: 150,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    gradient:
                        LinearGradient(colors: [Colors.blue, Colors.purple])),
                child: const Center(
                    child: Text('Add New',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22))),
              ),
            ),
            const SizedBox(height: 25),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MyProductsScreen()));
              },
              child: Container(
                height: 100,
                width: 150,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    gradient:
                        LinearGradient(colors: [Colors.red, Colors.purple])),
                child: const Center(
                    child: Text('Manage All',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
