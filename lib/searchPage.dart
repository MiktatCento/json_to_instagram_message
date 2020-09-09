import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  final List jsonData;
  SearchPage({this.jsonData});
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List jsonData = widget.jsonData;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 5,
        title: TextField(
          controller: _textEditingController,
          autofocus: true,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Aramak için bir şeyler gir',
          ),
          onChanged: (String textData) {
            /*
             int toplamIzlenenFilm = filmListesi
                      .where((filmler) =>
                          filmler["izlenmisMi"].toString().contains("true"))
                      .toList()
                      .length;
            */
            for (Map a in jsonData) {
              print('$a["conversation"]');
            }
            print(jsonData.where(
              (f) => jsonData.contains(textData),
            ));
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.clear,
            ),
            onPressed: () {
              _textEditingController.clear();
            },
          )
        ],
      ),
      body: Container(
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 50,
              height: 50,
              child: Icon(
                Icons.search,
                size: 50,
              ),
            ),
            Text(
              'Enter a wallpaper to search.',
            )
          ],
        )),
      ),
    );
  }
}
