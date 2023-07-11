import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddItems extends StatefulWidget {
  const AddItems({super.key});

  @override
  State<AddItems> createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  XFile? selectedImage;
  final _itemNameController = TextEditingController();
  final _itemDescriptionController = TextEditingController();
  final _itemPriceController = TextEditingController();

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickImage != null) {
      setState(() {
        selectedImage = pickImage;
      });
    }
  }

  Future<void> saveItem() async{

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 350,
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white54),
                child: Column(
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: _pickImage,
                      child: selectedImage != null
                          ? Image.file(
                              File(selectedImage!.path),
                              fit: BoxFit.cover,
                            )
                          : Icon(
                              Icons.image,
                              size: 70,
                            ),
                    )),
                    Text("Click the Icon above to Select Item Image")
                  ],
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _itemNameController,
                decoration: InputDecoration(
                    labelText: "Item Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _itemDescriptionController,
                decoration: InputDecoration(
                    labelText: "Item Description",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _itemPriceController,
                decoration: InputDecoration(
                    labelText: " Item Price",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: (){
                saveItem();
              }, child: Text("Save Item"))
            ],
          ),
        ),
      ),
    ));
  }
}
