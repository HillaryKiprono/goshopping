import 'package:flutter/material.dart';

class CategoryItems extends StatelessWidget {
  const CategoryItems({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 100,
        width: 100,
        child: Column(
          children: [
            Image.network("",fit: BoxFit.cover,),
            Text("Laptop")
          ],
        ),
      ),
    );
  }
}
