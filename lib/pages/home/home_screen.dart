import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_flutter/provider/note_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchKeyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Panggil fetchData saat widget pertama kali dimuat
    Provider.of<NoteProvider>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final prov_note = Provider.of<NoteProvider>(context);

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
          children: [
            Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: _searchKeyController,
                  onChanged: (value) {
                    // Panggil fungsi filter saat nilai pencarian berubah
                    prov_note.getFilteredNotes(value);
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.clear),
                    labelText: 'Search',
                    hintText: 'hint text',
                    border: OutlineInputBorder(),
                  ),
                )),
            Column(
              children: prov_note.filteredNoteList.map((data) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 44,
                          minHeight: 44,
                          maxWidth: 64,
                          maxHeight: 64,
                        ),
                        child: Image.network(data.image, fit: BoxFit.cover),
                      ),
                      title: Text(
                        data.title,
                        maxLines: 1,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'price: ${data.price.toString()}',
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
          ],
        ),
      ),
    );
  }
}
