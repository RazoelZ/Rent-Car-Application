import 'package:flutter/material.dart';

class PengembalianPage extends StatelessWidget {
  const PengembalianPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Silahkan isi form berikut"),
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Form(
            child: ListView(children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Tanggal Kembali",
                    icon: Icon(Icons.calendar_month)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Masukan Tanggal Kembali!";
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Jam Kembali",
                    icon: Icon(Icons.punch_clock_outlined)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Masukan Jam Kembali!";
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Saldo Tol",
                  icon: Icon(Icons.money),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Masukan Saldo Tol Anda!";
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Saldo Bensin",
                  icon: Icon(Icons.attach_money_outlined),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Masukan Saldo Bensin Anda!";
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Total KM",
                  icon: Icon(Icons.attach_money_outlined),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Masukan Total KM!";
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Lampiran Saldo Tol",
                  icon: Icon(Icons.text_snippet_outlined),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Masukan Saldo Bensin Anda!";
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Lampiran Saldo Bensin",
                  icon: Icon(Icons.text_snippet_outlined),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Masukan Saldo Bensin Anda!";
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
