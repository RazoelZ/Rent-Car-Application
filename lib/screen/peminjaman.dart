import 'package:flutter/material.dart';
import 'package:rentvehicle_application/core/repository.dart';
import 'package:rentvehicle_application/model/KendaraanModel.dart';

class RentPage extends StatefulWidget {
  const RentPage({super.key});

  @override
  State<RentPage> createState() => _RentPageState();
}

class _RentPageState extends State<RentPage> {
  List<KendaraanModel> kendaraanModel = [];
  Repository repository = Repository();

  getData() async {
    var data = await repository.getData();
    setState(() {
      kendaraanModel = data;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Peminjaman"),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text((kendaraanModel != null)
                ? kendaraanModel[index].tipe_kendaraan.toString()
                : "Loading..."),
            subtitle: Text((kendaraanModel != null)
                ? kendaraanModel[index].jenis_kendaraan.toString()
                : "Loading..."),
            trailing: Text((kendaraanModel != null)
                ? kendaraanModel[index].nomor_polisi.toString()
                : "Loading..."),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(height: 0.5);
        },
        itemCount: kendaraanModel.length,
      ),
    );
  }
}

// kendaraanModel[index].jenis_kendaraan.toString()
