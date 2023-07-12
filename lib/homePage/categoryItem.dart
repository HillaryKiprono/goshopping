import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:goshopping/model/fetchCategory.dart';

class CategoryItems extends StatelessWidget {
  const CategoryItems({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DatabaseEvent>(
        future: FirebaseDatabase.instance.reference().child('categories').once(),
        builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (snapshot.hasData) {
            List<FetchCategory> items = [];

            var data = snapshot.data!.snapshot;
            if (data != null) {
              Map<dynamic, dynamic>? values = data.value as Map?;

              if (values != null) {
                values.forEach((key, value) {
                  items.add(FetchCategory(
                    imageUrl: value['imageUrl'],
                    name: value['name'],
                  ));
                });
              }
            }

            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 100,
                  width: 100,
                  child: Row(
                    children: [
                      Image.network(items[index].imageUrl, fit: BoxFit.cover,height: 70,),
                      Text(items[index].name),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
