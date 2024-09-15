

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommer_test_mode_admin/views/screens/side_bar_screens/widgets/category_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data'; // لاستخدام Uint8List

class CategoriesScreen extends StatefulWidget {
  //const DashboardScreen({super.key});
  static const String routeName = "\CategoriesScreen";
   // لتخزين اسم الملف

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();
  String?   fileName;
  String? categoryName;
  bool _isUploading = false;
  //final TextEditingController _categoryController = TextEditingController();
  //Uint8List? _image;
 // لتخزين بيانات الصورة
  dynamic _image;
  _pickImage() async{
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(
        allowMultiple: false,
        type: FileType.image
    );

    if(result != null ){
      setState(() {
        _image = result.files.first.bytes;
        fileName = result.files.first.name;
      });
    }
  }

  _uploadCategoryBannerToStorage(dynamic image) async{
      Reference ref = _storage.ref().child('categoryImages').child(fileName!);
      UploadTask uploadTask = ref.putData(image);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
  }
  uploadCategory()async{
    if (_formKey.currentState!.validate()) {
      EasyLoading.show();
      try {
        String imageUrl = await _uploadCategoryBannerToStorage(_image);
        await _firestore.collection('categories').doc(fileName).set({
          'image': imageUrl,
          'categoryName': categoryName,
        }).whenComplete(() {
          setState(() {
            _image = null;
            //_categoryController.clear(); // إعادة تعيين TextEditingController
            _formKey.currentState!.reset();
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Category uploaded successfully'),
              backgroundColor: Colors.green,
            ),
          );
        });
      } catch (e) {

        print("Error uploading category: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error uploading category'),
            backgroundColor: Colors.red,
          ),
        );
      }
      finally{
        EasyLoading.dismiss();
      }
    } else {
      print("Bad");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Category',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Divider(color: Colors.grey),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 140,
                        width: 140,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade500,
                          border: Border.all(
                            color: Colors.grey.shade800,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child:
                             _image != null
                                 ? Image.memory(
                               _image,
                               fit: BoxFit.cover,
                             )
                                 :Center(
                               child:
                               Text("Category"),
                             ),
                      ),

                      SizedBox(height: 15),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                        ),
                        onPressed: (){
                          _pickImage();
                        },
                        child: Text(
                          'Upload Image',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: SizedBox(
                    width: 200,
                    child: TextFormField(
                      //controller: _categoryController,
                      onChanged: (value){
                        categoryName = value;
                      },
                      validator: (value){
                        if(value!.isEmpty){
                          return "Category name must not be empty";
                        }
                        else{
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Enter Category Name",
                        //hintText: "Enter Category Name",
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                      ),
                      onPressed: () {
                        uploadCategory();
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Divider(color: Colors.grey,),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Categories',
                style: TextStyle(
                    fontSize: 26 ,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            CategoryWidget(),
          ],
        ),
      ),
    );
  }
}
