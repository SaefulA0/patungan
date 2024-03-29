import 'package:flutter/material.dart';
import 'package:patungan/src/views/home/Home.dart';
import '../../db/sql_helper.dart';

class newGroupContainer extends StatefulWidget {
  const newGroupContainer({Key? key}) : super(key: key);

  @override
  _newGroupContainerState createState() => _newGroupContainerState();
}

class _newGroupContainerState extends State<newGroupContainer> {
  int _counter = 1;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    if (_counter == 1) {
    } else {
      setState(() {
        _counter--;
      });
    }
  }

  //bikinan oji
  List<Map<String, dynamic>> _journals = [];

  bool _isLoading = true;

  // This function is used to fetch all data from the database
  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals(); // Loading the diary when the app starts
  }

  final TextEditingController _namaGrupController = TextEditingController();
  final TextEditingController _catatanController = TextEditingController();
  final TextEditingController _namaPesertaController = TextEditingController();

  void _showForm(int? idGrup) async {
    if (idGrup != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      final existingJournal =
          _journals.firstWhere((element) => element['idGrup'] == idGrup);
      _namaGrupController.text = existingJournal['nama_grup'];
      _catatanController.text = existingJournal['catatan'];
      _namaPesertaController.text = existingJournal['nama_peserta'];
    }
  }
  //end oji

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nama Group'),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Masukkan Nama Group',
                        ),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      Text('Deskripsi Group'),
                      TextField(
                        cursorHeight: 20,
                        decoration: InputDecoration(
                          hintText: 'Masukkan deskripsi',
                        ),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      Row(children: [
                        Text('Member'),
                        TextButton(
                          child: Text('Add Column'),
                          onPressed: () => _incrementCounter(),
                        ),
                        TextButton(
                          child: Text(
                            'Delete Column',
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () => _decrementCounter(),
                        ),
                      ]),
                      Expanded(
                          child: ListView.builder(
                              itemCount: _counter,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return new TextField(
                                  cursorHeight: 20,
                                  decoration: InputDecoration(
                                    hintText: 'Masukkan deskripsi',
                                  ),
                                );
                              })),
                      TextButton(
                        child: Text(
                          'Simpan',
                          style: TextStyle(color: Colors.blue),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        },
                      ),
                    ],
                  ),
                ))));
  }
}
