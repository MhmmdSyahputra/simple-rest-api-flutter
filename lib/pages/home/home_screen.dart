import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_flutter/provider/note_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Panggil fetchData saat widget pertama kali dimuat
    Provider.of<NoteProvider>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final prov_schedule = Provider.of<NoteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'My Note With API',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: prov_schedule.noteList.map((data) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    data.title,
                    maxLines: 1,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    data.body,
                    maxLines: 2,
                  ),
                  trailing: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
