import 'package:flutter/material.dart';

class PengembalianPage extends StatefulWidget {
  const PengembalianPage({super.key});

  @override
  State<PengembalianPage> createState() => _PengembalianPageState();
}

class _PengembalianPageState extends State<PengembalianPage> {
  int _index = 0;
  List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];
  List<Step> steps() => [
        Step(
            isActive: _index >= 0 ? true : false,
            title: const Text('Langkah 1'),
            content: Form(
              key: _formKeys[0],
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Tanggal Kembali",
                        icon: Icon(Icons.calendar_month)),
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return "Masukan Tanggal Kembali!";
                    //   } else {
                    //     return null;
                    //   }
                    // },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Jam Kembali",
                        icon: Icon(Icons.punch_clock_outlined)),
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return "Masukan Jam Kembali!";
                    //   } else {
                    //     return null;
                    //   }
                    // },
                  ),
                ],
              ),
            )),
        Step(
            isActive: _index >= 1 ? true : false,
            title: const Text('Langkah 2'),
            content: Form(
              key: _formKeys[1],
              child: Column(
                children: <Widget>[
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
                      child: ElevatedButton(
                          onPressed: () {}, child: Text("Submit")))
                ],
              ),
            )),
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pengisian Form Peminjaman'),
        ),
        body: Stepper(
            controlsBuilder: (context, _) {
              return Row(
                children: <Widget>[
                  Container(
                    child: TextButton(
                      onPressed: onStepContinue,
                      child: const Text('Selanjutnya'),
                    ),
                  ),
                  Container(
                    child: TextButton(
                      onPressed: onStepCancel,
                      child: const Text('Sebelumnya'),
                    ),
                  ),
                ],
              );
            },
            currentStep: _index,
            type: StepperType.horizontal,
            steps: steps()));
  }

  void onStepContinue() {
    if (!_formKeys[_index].currentState!.validate()) {
      return null;
    }
    if (_index < steps().length - 1) {
      setState(() {
        _index += 1;
      });
    }
  }

  void onStepCancel() {
    if (_index == 0) {
      return null;
    } else {
      setState(() {
        _index -= 1;
      });
    }
  }
}

// 
              