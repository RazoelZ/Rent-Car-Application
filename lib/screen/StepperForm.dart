import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class StepperForm extends StatefulWidget {
  const StepperForm({super.key});

  @override
  State<StepperForm> createState() => _StepperFormState();
}

class _StepperFormState extends State<StepperForm> {
  int _index = 0;

  List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  TextEditingController _jeniskendaraanController = TextEditingController();
  TextEditingController _tipekendaraanController = TextEditingController();
  TextEditingController _nopolisiController = TextEditingController();
  TextEditingController _kmawalController = TextEditingController();
  TextEditingController _tanggalpinjamController = TextEditingController();
  TextEditingController _jampinjamController = TextEditingController();
  TextEditingController _keperluanController = TextEditingController();
  TextEditingController _driverController = TextEditingController();

  List<Step> steps() => [
        Step(
            isActive: _index >= 0 ? true : false,
            title: const Text('Langkah 1'),
            content: Form(
              key: _formKeys[0],
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _jeniskendaraanController,
                    decoration: InputDecoration(
                        labelText: "Jenis Kendaraan",
                        icon: Icon(Icons.car_crash_outlined)),
                  ),
                  TextFormField(
                    controller: _tipekendaraanController,
                    decoration: InputDecoration(
                        labelText: "Tipe Kendaraan",
                        icon: Icon(Icons.car_repair_outlined)),
                  ),
                  TextFormField(
                    controller: _nopolisiController,
                    decoration: InputDecoration(
                        labelText: "Nomor Polisi", icon: Icon(Icons.numbers)),
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
                    controller: _kmawalController,
                    decoration: InputDecoration(
                        labelText: "KM Awal", icon: Icon(Icons.speed)),
                  ),
                  TextFormField(
                    controller: _tanggalpinjamController,
                    decoration: InputDecoration(
                        labelText: "Tanggal Pinjam",
                        icon: Icon(Icons.calendar_month)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Masukan Tanggal Pinjam!";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _jampinjamController,
                    decoration: InputDecoration(
                        labelText: "Jam Pinjam",
                        icon: Icon(Icons.punch_clock_outlined)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Masukan Jam Pinjam!";
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            )),
        Step(
            isActive: _index >= 2 ? true : false,
            title: const Text('Langkah 3'),
            content: Form(
              key: _formKeys[2],
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _keperluanController,
                    decoration: InputDecoration(
                      labelText: "Keperluan",
                      icon: Icon(Icons.text_fields),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Masukan Keperluan Anda!";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _driverController,
                    decoration: InputDecoration(
                        labelText: "Driver", icon: Icon(Icons.person)),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Kota Tujuan",
                        icon: Icon(Icons.location_on_outlined)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Masukan Kota Tujuan Anda!";
                      } else {
                        return null;
                      }
                    },
                  ),
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
                      child: const Text('Kembali'),
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
