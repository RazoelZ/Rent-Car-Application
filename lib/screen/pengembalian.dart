import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rentvehicle_application/core/repository.dart';

class PengembalianPage extends StatefulWidget {
  const PengembalianPage({super.key});

  @override
  State<PengembalianPage> createState() => _PengembalianPageState();
}

class _PengembalianPageState extends State<PengembalianPage> {
  int _index = 0;
  PeminjamanRepository peminjamanRepository = PeminjamanRepository();

  TextEditingController _id = TextEditingController();
  TextEditingController _tanggalkembaliController = TextEditingController();
  TextEditingController _jamkembaliController = TextEditingController();
  TextEditingController _saldotolakhir = TextEditingController();
  TextEditingController _kmakhir = TextEditingController();
  TextEditingController _hargabbm = TextEditingController();
  TextEditingController _lampirantol = TextEditingController();
  TextEditingController _lampiranbbm = TextEditingController();

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
                    controller: _id,
                    inputFormatters: [],
                    decoration: InputDecoration(
                        labelText: "Id",
                        icon: Icon(Icons.indeterminate_check_box)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Masukan id user Anda!";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _tanggalkembaliController,
                    decoration: InputDecoration(
                        labelText: "Tanggal Kembali",
                        icon: Icon(Icons.calendar_month)),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2015),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _tanggalkembaliController.text =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                        });
                      }
                    },
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
                    controller: _jamkembaliController,
                    readOnly: true,
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                      );
                      if (pickedTime != null) {
                        setState(() {
                          _jamkembaliController.text =
                              pickedTime.format(context);
                        });
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Masukan Jam Kembali!";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _kmakhir,
                    decoration: InputDecoration(
                      suffixText: "KM",
                      labelText: "KM Akhir",
                      icon: Icon(Icons.speed_rounded),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Masukan KM Akhir!";
                      } else {
                        return null;
                      }
                    },
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
                    controller: _saldotolakhir,
                    decoration: InputDecoration(
                      labelText: "Saldo Tol Akhir",
                      prefixText: "Rp. ",
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
                    controller: _hargabbm,
                    decoration: InputDecoration(
                      prefixText: "Rp. ",
                      labelText: "Saldo bensin yang digunakan",
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
                    controller: _lampirantol,
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
                    controller: _lampiranbbm,
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
                          onPressed: () async {
                            bool response =
                                await peminjamanRepository.putPeminjamanData(
                                    _id.text,
                                    _tanggalkembaliController.text,
                                    _jamkembaliController.text,
                                    _kmakhir.text,
                                    _saldotolakhir.text,
                                    _hargabbm.text,
                                    _lampirantol.text,
                                    _lampiranbbm.text);
                            if (response) {
                              SnackBar(
                                content: Text("Berhasil"),
                              );
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => HomePage()));
                            } else {
                              SnackBar(
                                content: Text("Gagal"),
                              );
                            }
                          },
                          child: Text("Submit")))
                ],
              ),
            )),
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pengisian Form Pengembalian'),
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
            // type: StepperType.horizontal,
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
