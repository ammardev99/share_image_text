import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/modules/widgets.dart';
import 'package:share_plus/share_plus.dart';

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
        title: boldText("Share App"),
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
                sizeBox(20),
// pick image
                InkWell(
                  onTap: () => getImage(),
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                    width: 320,
                    height: 320,
                    child: Center(
                        child: imagePick == null
                            ? getImgIcon()
                            : showImage(imagePick!.path)),
                  ),
                ),
                sizeBox(20),
// enter text
                TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      label: boldText('Enter Text'),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      )),
                    ),
                    minLines: 1,
                    maxLines: null,
                    validator: (value) {
                      if ((value ?? "").isEmpty) {
                        return 'text is required';
                      }
                      return null;
                    }),
                sizeBox(20),
// share button
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      // await Share.share(textController.text);
                      await Share.shareXFiles([XFile(imagePick!.path)],
                          text: textController.text);
                    }
                    // ignore: avoid_print
                    print('press share');
                  },
                  style: const ButtonStyle(
                    minimumSize:
                        WidgetStatePropertyAll(Size(double.infinity, 50)),
                    elevation: WidgetStatePropertyAll(3),
                    backgroundColor: WidgetStatePropertyAll(Color(0xFF0787FF)),
                  ),
                  child: const Text(
                    "Share",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                sizeBox(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
