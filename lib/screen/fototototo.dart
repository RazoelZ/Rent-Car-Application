import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class FotoPage extends StatefulWidget {
  const FotoPage({super.key});

  @override
  State<FotoPage> createState() => _FotoPageState();
}

class _FotoPageState extends State<FotoPage> {
  File? _imageBBM;
  File? _imageTol;

  Future getImageGallery() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _imageBBM = File(image!.path);
    });
  }

  Future getImageCamera() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _imageBBM = File(image!.path);
    });
  }

  Future uploadImage(File imageFile) async {
    var stream = new http.ByteStream(imageFile.openRead());
    var length = await imageFile.length();
    var uri = Uri.parse("http://192.168.0.109/rent_car/public/api/uploadImage");

    var request = new http.MultipartRequest("POST", uri);

    var MultiPartFile = new http.MultipartFile("peminjaman", stream, length,
        filename: basename(imageFile.path));

    request.files.add(MultiPartFile);

    var response = await request.send();
    if (response.statusCode == 200) {
      print(response.statusCode);
      print("Image Uploaded");
    } else {
      print(response.statusCode);
      print("Upload Failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Foto"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 250,
              height: 250,
              child: Center(
                child: _imageBBM == null
                    ? Text("No image selected.")
                    : Image.file(_imageBBM!),
              ),
            ),
            Center(
              child: _imageTol == null
                  ? Text("No image selected.")
                  : Image.file(_imageBBM!),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      getImageGallery();
                    },
                    child: Text("gallery")),
                ElevatedButton(
                    onPressed: () {
                      getImageCamera();
                    },
                    child: Text("camera")),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  uploadImage(_imageBBM!);
                },
                child: Text("Upload"))
          ],
        ),
      ),
    );
  }
}
