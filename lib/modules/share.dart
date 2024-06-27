import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ShareApp extends StatefulWidget {
  const ShareApp({super.key});

  @override
  State<ShareApp> createState() => _ShareAppState();
}

class _ShareAppState extends State<ShareApp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  get formKey => _formKey;
  TextEditingController textController = TextEditingController();
  File? imagePick;
  final _picker = ImagePicker();

  Future getImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      setState(() {
        imagePick = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
// app bar
      appBar: AppBar(
        title: const Text(
          "Share App",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                // pick image
                InkWell(
                  onTap: () => getImage(),
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                    width: 320,
                    height: 320,
                    child: Center(
                        child:
// image icon
                            imagePick == null
                                ? const SizedBox(
                                    height: 80,
                                    child: Icon(
                                      Icons.image,
                                      color: Colors.grey,
                                      size: 60,
                                    ),
                                  )
                                : Image.file(
                                    File(imagePick!.path),
                                    fit: BoxFit.contain,
                                  )),
                  ),
                ),
                const SizedBox(height: 20,),
// enter text
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                          controller: textController,
                          decoration: const InputDecoration(
                            label: Text(
                              "Enter Text",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            )),
                          ),
                          maxLines: null,
                          minLines: 1,
                          validator: (value) {
                            if ((value ?? "").isEmpty) {
                              return 'text is required';
                            }
                            return null;
                          }),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
// share button
                Container(
                  margin: const EdgeInsets.all(10),
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) {
                        // await Share.share('text!');
                        }
                      // ignore: avoid_print
                      print('share');
                    },
                    style: const ButtonStyle(
                      elevation: WidgetStatePropertyAll(3),
                      backgroundColor:
                          WidgetStatePropertyAll(Color(0xFF0787FF)),
                    ),
                    child: const Text(
                      "Share",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

