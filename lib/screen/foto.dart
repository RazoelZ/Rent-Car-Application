import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class foto extends StatefulWidget {
  const foto({super.key});

  @override
  State<foto> createState() => _fotoState();
}

class _fotoState extends State<foto> {
  List<File>? image;

  Future getMultiImage() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? ImagePicked = await _picker.pickMultiImage();
    image = ImagePicked!.map((e) => File(e.path)).toList();
    setState(() {});
  }

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? ImagePicked =
        await _picker.pickImage(source: ImageSource.camera);
    image = [File(ImagePicked!.path)];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Foto"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image != null
                ? Container(
                    height: 200,
                    width: 200,
                    child: ListView.builder(
                      itemCount: image!.length,
                      itemBuilder: (context, index) {
                        return Image.file(image![index]);
                      },
                    ),
                  )
                : Container(),
            ElevatedButton(
              onPressed: () async {
                await getImage();
              },
              child: Text("Ambil Foto"),
            ),
            ElevatedButton(
              onPressed: () async {
                await getMultiImage();
              },
              child: Text("Pilih Foto"),
            ),
          ],
        ),
      ),
    );
  }
}
