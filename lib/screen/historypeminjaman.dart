import 'package:flutter/material.dart';
import 'package:rentvehicle_application/core/repository.dart';
import 'package:rentvehicle_application/model/HistoryModel.dart';
import 'package:rentvehicle_application/screen/peminjamandetail.dart';

class HistoryPeminjamanPage extends StatefulWidget {
  const HistoryPeminjamanPage({super.key});

  @override
  State<HistoryPeminjamanPage> createState() => _HistoryPeminjamanPageState();
}

class _HistoryPeminjamanPageState extends State<HistoryPeminjamanPage> {
  List<HistoryLogModel> historylog = [];
  HistoryRepository historyRepository = HistoryRepository();

  getData() async {
    var data = await historyRepository.getData();
    setState(() {
      historylog = data;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  //make send data to detail page
  // void sendData(HistoryLogModel historylog) {
  //   Navigator.push(

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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPeminjamanPage(),
                ),
              );
            },
            title: Text((historylog != null)
                ? historylog[index].tipeKendaraan.toString()
                : "Loading..."),
            subtitle: Text((historylog != null)
                ? historylog[index].driver.toString()
                : "Loading..."),
            trailing: Text((historylog != null)
                ? historylog[index].tglPeminjaman.toString()
                : "Loading..."),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(height: 0.5);
        },
        itemCount: historylog.length,
      ),
    );
  }
}

// kendaraanModel[index].jenis_kendaraan.toString()
