import 'package:flutter/material.dart';
import 'package:goshopping/homePage/categoryItem.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> Category = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Row(
              children: [
                const Expanded(
                    child: SearchBar(
                  leading: Icon(Icons.search),
                  hintText: "Search on GoShopping",
                )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                      size: 35,
                    ))
              ],
            ),
            ListView(
              scrollDirection: Axis.horizontal,
              children: [
                CategoryItems()
              ],
            )
          ],
        ),
      ),
    );
  }
}
