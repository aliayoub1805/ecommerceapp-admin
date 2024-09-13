import 'dart:typed_data'; // لاستخدام Uint8List
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

class UploadBannerScreen extends StatefulWidget {
  static const String routeName = "/UploadBannerScreen";

  @override
  State<UploadBannerScreen> createState() => _UploadBannerScreenState();
}

class _UploadBannerScreenState extends State<UploadBannerScreen> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Uint8List? _image; // لتخزين بيانات الصورة
  String? _fileName; // لتخزين اسم الملف
  bool _isUploading = false; // لتتبع حالة التحميل
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        // قراءة الصورة كبيانات بايت
        final imageBytes = await pickedFile.readAsBytes();
        setState(() {
          _image = imageBytes;
          _fileName = pickedFile.name; // الحصول على اسم الملف
        });
      }
    } catch (e) {
      print("Error picking file: $e");
    }
  }

  Future<String> _uploadBannersToStorage(Uint8List image) async {
    final ref = _storage.ref().child('Banners').child(_fileName!);

    final uploadTask = ref.putData(image);
    final snapshot = await uploadTask;
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> uploadToFireStore() async {

    EasyLoading.show(status: 'Uploading...');
    if (_image != null) {
      setState(() {
        _isUploading = true; // بدء التحميل
      });

      try {
        final imageUrl = await _uploadBannersToStorage(_image!);
        await _firestore.collection('banners').doc(_fileName).set({
          'image': imageUrl,
        }).whenComplete(() {
          EasyLoading.dismiss(); // إيقاف شريط التقدم
        });

        // عرض رسالة النجاح
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تم رفع الصورة بنجاح'),
            backgroundColor: Colors.green,
          ),
        );

        // إعادة الصورة إلى الوضع الأصلي
        setState(() {
          _image = null;
          _fileName = null;
          _isUploading = false; // إيقاف التحميل
        });
      } catch (e) {
        print("Error uploading to Firestore: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('فشل في رفع الصورة'),
            backgroundColor: Colors.red,
          ),
        );

        setState(() {
          _isUploading = false; // إيقاف التحميل
        });
        EasyLoading.dismiss(); // إيقاف شريط التقدم في حالة الخطأ
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('مسار الصورة فارغ'),
          backgroundColor: Colors.red,
        ),
      );
      EasyLoading.dismiss(); // إيقاف شريط التقدم في حالة المسار الفارغ
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Banners',
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
                      child: _image != null
                          ? Image.memory(
                        _image!,
                        fit: BoxFit.cover, // لتناسب الصورة مع الحاوية
                      )
                          : Center(
                        child: Text('Banners'),
                      ),
                    ),
                    SizedBox(height: 10),
                    if (_fileName != null)
                      Text(
                        'File: $_fileName',
                        style: TextStyle(fontSize: 12),
                      ),
                    SizedBox(height: 15),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                      ),
                      onPressed: pickImage,
                      child: Text(
                        'Upload banner',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
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
                      uploadToFireStore();
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
        ],
      ),
    );
  }
}