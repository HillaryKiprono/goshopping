import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';


class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}


class _AddCategoryState extends State<AddCategory> {
  XFile? selectedCategoryImage;
  final _categoryItemNameController = TextEditingController();
  final _database=FirebaseDatabase.instance.ref();
  final DatabaseReference database = FirebaseDatabase.instance.reference();


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
    final String catName=_categoryItemNameController.text.trim();
    if(catName.isEmpty){
      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: Text("Error"),
              content: Text("Please fill in Category Name"),
              actions: [
                ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text("OK"))
              ],
            );
          });
    }
    else if(selectedCategoryImage==null)
      {
        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title: Text("Error"),
            content: Text("Please Select a Category Image"),
            actions: [
              ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text("Ok"))
            ],
          );
        });
      }
    else{
      // Upload the image to Firebase Storage and get the download URL
      final File imageFile = File(selectedCategoryImage!.path);
      final String imagePath = "item_images/${DateTime.now().microsecondsSinceEpoch}.jpg";
      final Reference storageReference = FirebaseStorage.instance.ref().child(imagePath);
      final UploadTask uploadTask = storageReference.putFile(imageFile);
      try{
        await uploadTask.whenComplete(() async {
          final String imageUrl=await  storageReference.getDownloadURL();
          //save the Category item details to the realTime

          final Map<String,dynamic> categoryData={
            'name':catName,
            'imageUrl':imageUrl,
          };
          database.child('categories').push().set(categoryData);
          // Show success dialog or navigate to a different screen
          showDialog(
              context: context,
              builder: (BuildContext context){
                return AlertDialog(
                  title: Text("Success"),
                  content: Text("Category Saved Successfully"),
                  actions: [
                    ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text("OK"))
                  ],
                );
              });
        });
      }
      catch(e){
        // Handle error if any occurs during image upload
        showDialog(
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                title: Text("Error"),
                content: Text("Failed to upload image. Please try again."),
                actions: [
                  ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text("OK"))
                ],
              );
            });
      }



    }

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
