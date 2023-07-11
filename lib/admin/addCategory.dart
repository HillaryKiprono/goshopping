import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}


class _AddCategoryState extends State<AddCategory> {
  XFile? selectedCategoryImage;
  final _categoryItemNameController = TextEditingController();

  Future<void> _pickCategoryImage() async{
    final imagePicker=ImagePicker();
    final pickCategoryImage= await imagePicker.pickImage(source: ImageSource.gallery);
    if(pickCategoryImage!=null){
      setState(() {
        selectedCategoryImage=pickCategoryImage;
      });
    }
  }

  Future<void> saveCategoryItem() async{

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
                              onTap: _pickCategoryImage,
                              child: selectedCategoryImage != null
                                  ? Image.file(
                                File(selectedCategoryImage!.path),
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
                    validator: (value) {
                      if(value!.isEmpty||value==null){
                        return "Name is required";
                      }
                    },
                    controller: _categoryItemNameController,
                    decoration: InputDecoration(
                        labelText: "Category Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  ElevatedButton(onPressed: (){
                    saveCategoryItem();
                  }, child: Text("Save Category"))
                ],
              ),
            ),
          ),
        ));
  }
}
