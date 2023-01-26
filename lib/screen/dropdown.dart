import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:rentvehicle_application/core/repository.dart';
import 'package:rentvehicle_application/model/DriverModel.dart';

class dropdown extends StatefulWidget {
  const dropdown({super.key});

  @override
  State<dropdown> createState() => _dropdownState();
}

class _dropdownState extends State<dropdown> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Dropdown"),
      ),
      body: Container(
          child: DropdownSearch<String>(
        enabled: true,
        showSearchBox: true,
        onFind: (text) async {
          var response = await http
              .get(Uri.parse('http://192.168.0.102/rent_car/public/driver'));
          if (response.statusCode != 200) {
            return [];
          }
          List data = json.decode(response.body);
          List<String> Listdrivernama = [];
          data.forEach((element) {
            Listdrivernama.add(element['nama']);
          });
          return Listdrivernama;
        },
        onChanged: print,
      )),
    );
  }
}


// kendaraanModel[index].jenis_kendaraan.toString()


// ListView.separated(ListView.separated(
        //   itemBuilder: (context, index) {
        //     return ListTile(
        //       onTap: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => DetailPeminjamanPage(),
        //           ),
        //         );
        //       },
        //       title: Text((historylog != null)
        //           ? historylog[index].tipeKendaraan.toString()
        //           : "Loading..."),
        //       subtitle: Text((historylog != null)
        //           ? historylog[index].driver.toString()
        //           : "Loading..."),
        //       trailing: Text((historylog != null)
        //           ? historylog[index].tglPeminjaman.toString()
        //           : "Loading..."),
        //     );
        //   },
        //   separatorBuilder: (context, index) {
        //     return Divider(height: 0.5);
        //   },
        //   itemCount: historylog.length,
        // )
//         itemBuilder: (context, index) {
//           return ListTile(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => DetailPeminjamanPage(),
//                 ),
//               );
//             },
//             title: Text((historylog != null)
//                 ? historylog[index].tipeKendaraan.toString()
//                 : "Loading..."),
//             subtitle: Text((historylog != null)
//                 ? historylog[index].driver.toString()
//                 : "Loading..."),
//             trailing: Text((historylog != null)
//                 ? historylog[index].tglPeminjaman.toString()
//                 : "Loading..."),
//           );
//         },
//         separatorBuilder: (context, index) {
//           return Divider(height: 0.5);
//         },
//         itemCount: historylog.length,
//       ),
 