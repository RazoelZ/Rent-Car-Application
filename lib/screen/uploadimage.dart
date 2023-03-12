import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:DESARMADA/constants.dart';

class FotoPage extends StatefulWidget {
  final String id_peminjaman;
  final String category;
  const FotoPage(
      {required this.id_peminjaman, required this.category, super.key});

  @override
  State<FotoPage> createState() => _FotoPageState();
}

class _FotoPageState extends State<FotoPage> {
  File? _image;
  bool isUploading = false;
  bool isFailed = false;
  //mengambil gambar dari gallery
  Future getImageGallery() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
  }

  //mengambil gambar dari camera
  Future getImageCamera() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(image!.path);
    });
  }

  //function upload image
  Future<String?> uploadImage(
      BuildContext context, File imageFile, String category) async {
    var stream = http.ByteStream(imageFile.openRead());
    var length = await imageFile.length();
    var uri = Uri.parse("$kBASE_URL/api/uploadImage");

    var request = http.MultipartRequest("POST", uri);

    var MultiPartFile = http.MultipartFile(category, stream, length,
        filename: basename(imageFile.path));

    Map<String, String> body = {
      'id': widget.id_peminjaman,
    };

    request.fields.addAll(body);
    request.files.add(MultiPartFile);

    var streamedResponse = await request.send();
    if (streamedResponse.statusCode == 200) {
      print(streamedResponse.statusCode);
      print("Image Uploaded");
      var response = await http.Response.fromStream(streamedResponse);
      Map<String, dynamic> parsed = jsonDecode(response.body);
      return parsed['image_name'];
    } else {
      print(streamedResponse.statusCode);
      print("Upload Failed");
      return null;
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
                child: _image == null
                    ? Text("No image selected.")
                    : Image.file(_image!),
              ),
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
            isUploading == false
                ? ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isUploading = true;
                      });
                      var success =
                          await uploadImage(context, _image!, widget.category);
                      if (success != null) {
                        Navigator.pop(context, success);
                      } else {
                        setState(() {
                          isUploading = false;
                          isFailed = true;
                        });
                      }
                    },
                    child: Text("Upload"))
                : CircularProgressIndicator(),
            isFailed
                ? Text(
                    'Upload gagal',
                    style: TextStyle(color: Colors.redAccent),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
