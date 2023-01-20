import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Form Peminjaman"),
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Form(
            child: ListView(children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Jenis Kendaraan",
                    icon: Icon(Icons.car_crash_outlined)),
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Tipe Kendaraan",
                    icon: Icon(Icons.car_repair_outlined)),
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Nomor Polisi", icon: Icon(Icons.numbers)),
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "KM Awal", icon: Icon(Icons.speed)),
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Tanggal Pinjam",
                    icon: Icon(Icons.calendar_month)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Masukan Tanggal Pinjam!";
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Jam Pinjam",
                    icon: Icon(Icons.punch_clock_outlined)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Masukan Jam Pinjam!";
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Keperluan",
                  icon: Icon(Icons.text_fields),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Masukan Keperluan Anda!";
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Driver", icon: Icon(Icons.person)),
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Kota Tujuan",
                    icon: Icon(Icons.location_on_outlined)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Masukan Kota Tujuan Anda!";
                  } else {
                    return null;
                  }
                },
              ),
              Container(
                  margin: EdgeInsets.only(top: 10),
                  child:
                      ElevatedButton(onPressed: () {}, child: Text("Submit")))
            ]),
          ),
        ));
  }
}
