import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class FotoPage extends StatefulWidget {
  const FotoPage({super.key});

  @override
  State<FotoPage> createState() => _FotoPageState();
}

class _FotoPageState extends State<FotoPage> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;

  Future getImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    } else {
      print('No image selected.');
    }
  }

  Future<void> UploadImage() async {
    setState(() {
      showSpinner = true;
    });
    var stream = new http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();
    var uri = Uri.parse('http://192.168.0.100/rent_car/public/api/peminjaman');
    var request = new http.MultipartRequest("POST", uri);

    request.fields['id_peminjaman'] = "1";

    var multipartFile = new http.MultipartFile(
      'foto',
      stream,
      length,
    );

    var response = await request.send();

    if (response.statusCode == 200) {
      setState(() {
        showSpinner = false;
      });
      print("Image Uploaded");
    } else {
      print("Upload Failed");
      setState(() {
        showSpinner = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Foto"),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  child: image == null
                      ? Center(
                          child: Text("No Image Selected"),
                        )
                      : Container(
                          child: Center(
                            child: Image.file(
                              File(image!.path).absolute,
                              height: 300,
                              width: 300,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
              SizedBox(height: 150),
              GestureDetector(
                onTap: () {
                  UploadImage();
                },
                child: Container(
                  height: 50,
                  color: Colors.blue,
                  child: Text('Upload'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
