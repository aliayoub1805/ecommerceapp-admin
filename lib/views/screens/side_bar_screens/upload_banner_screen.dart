

import 'package:flutter/material.dart';

class UploadBannerScreen extends StatelessWidget {
  //const DashboardScreen({super.key});
  static const String routeName = "\UploadBannerScreen";
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
                  fontWeight: FontWeight.w700
              ),
            ),
          ),
          Divider(color: Colors.grey,),
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
                            color: Colors.grey.shade800),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text('Banners'),
                      ),
                    ),
                    SizedBox(height: 15,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                      ),
                      onPressed: (){},
                      child: Text('Upload banner',
                        style: TextStyle(
                        color: Colors.white,
                      ),

                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                ),
                onPressed: (){},
                child: Text('Save',
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
