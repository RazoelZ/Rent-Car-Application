import 'package:flutter/material.dart';
import 'package:DESARMADA/core/repository.dart';
import 'package:DESARMADA/model/HistoryModel.dart';
import 'package:DESARMADA/screen/peminjamandetail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPeminjamanPage extends StatefulWidget {
  const HistoryPeminjamanPage({super.key});

  @override
  State<HistoryPeminjamanPage> createState() => _HistoryPeminjamanPageState();
}

class _HistoryPeminjamanPageState extends State<HistoryPeminjamanPage> {
  List<HistoryLogModel> historylog = [];
  HistoryRepository historyRepository = HistoryRepository();

  String? _iduser;
  //mengambil data login
  pref() async {
    final prefs = await SharedPreferences.getInstance();
    _iduser = prefs.getString("id_user")!;
  }

  //mengambil data history
  getData() async {
    var data = await historyRepository.getData();
    setState(() {
      data.forEach((element) {
        if (element.id_user.toString() == _iduser) {
          historylog.add(element);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    pref();
    getData();
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
            hoverColor: Colors.grey,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPeminjamanPage(
                    id: historylog[index].id_user.toString(),
                    idKendaraan: historylog[index].idKendaraan.toString(),
                    namaDepartemen: historylog[index].namaDepartemen.toString(),
                    jeniskendaraan: historylog[index].jenisKendaraan.toString(),
                    tipeKendaraan: historylog[index].tipeKendaraan.toString(),
                    tglPeminjaman: historylog[index].tglPeminjaman.toString(),
                    tglPengembalian: historylog[index].tglKembali.toString(),
                    jamPeminjaman: historylog[index].jamPeminjaman.toString(),
                    jamKembali: historylog[index].jamKembali.toString(),
                    kmAwal: historylog[index].kmAwal.toString(),
                    kmAkhir: historylog[index].kmAkhir.toString(),
                    tujuan: historylog[index].tujuan.toString(),
                    keperluan: historylog[index].keperluan.toString(),
                    driver: historylog[index].driver.toString(),
                    platNomor: historylog[index].nomorPolisi.toString(),
                  ),
                ),
              );
            },
            title: Text((historylog != null)
                ? historylog[index].tipeKendaraan.toString()
                : "Loading..."),
            subtitle: Text((historylog != null)
                ? "Driver : ${historylog[index].driver}"
                : "Loading..."),
            trailing: Text((historylog != null)
                ? (historylog[index].tglKembali.toString() == "null")
                    ? "Belum dikembalikan"
                    : "Sudah dikembalikan\n${historylog[index].tglPeminjaman}"
                : "Loading..."),
            shape: Border(
              bottom: BorderSide(color: Colors.grey),
            ),
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
