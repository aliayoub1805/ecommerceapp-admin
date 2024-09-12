import 'dart:typed_data'; // لاستخدام Uint8List
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadBannerScreen extends StatefulWidget {
  static const String routeName = "/UploadBannerScreen";

  @override
  State<UploadBannerScreen> createState() => _UploadBannerScreenState();
}

class _UploadBannerScreenState extends State<UploadBannerScreen> {
  Uint8List? _image; // تغيير نوع المتغير إلى Uint8List لتخزين بيانات الصورة
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        // قراءة الصورة كبيانات بايت
        final imageBytes = await pickedFile.readAsBytes();
        setState(() {
          _image = imageBytes;
        });
      }
    } catch (e) {
      print("Error picking file: $e");
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                ),
                onPressed: () {
                  // إضافة منطق الحفظ هنا إذا لزم الأمر
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
    );
  }
}