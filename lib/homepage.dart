import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:json_to_message/bottomAnimation.dart';
import 'package:json_to_message/listtile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List jsonData = [];
  String userName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Json To Messages"),
        actions: [
          IconButton(
            icon: Icon(
              Icons.archive,
            ),
            onPressed: () async {
              try {
                File jsonFile = await FilePicker.getFile(
                  type: FileType.custom,
                  allowedExtensions: ['json'],
                );
                if (jsonFile != null) {
                  String mesaj1, mesaj2, mesaj3, mesaj4;
                  setState(() {
                    String jsonStr = jsonFile.readAsStringSync();
                    jsonData = json.decode(jsonStr);
                    if (jsonData[0]["participants"].length > 2) {
                      mesaj1 = jsonData[1]["participants"][0];
                      mesaj2 = jsonData[1]["participants"][1];
                      mesaj3 = jsonData[2]["participants"][0];
                      mesaj4 = jsonData[2]["participants"][1];
                    } else if (jsonData[1]["participants"].length > 2) {
                      mesaj1 = jsonData[2]["participants"][0];
                      mesaj2 = jsonData[2]["participants"][1];
                      mesaj3 = jsonData[3]["participants"][0];
                      mesaj4 = jsonData[3]["participants"][1];
                    } else {
                      mesaj1 = jsonData[0]["participants"][0];
                      mesaj2 = jsonData[0]["participants"][1];
                      mesaj3 = jsonData[1]["participants"][0];
                      mesaj4 = jsonData[1]["participants"][1];
                    }
                    if (mesaj1 == mesaj3) {
                      userName = mesaj1;
                    } else if (mesaj1 == mesaj4) {
                      userName = mesaj1;
                    } else {
                      userName = mesaj2;
                    }
                    print("mesajların sahibi $userName");
                  });
                }
              } catch (e) {
                print(e);
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: jsonData.length,
        itemBuilder: (context, index) {
          Map message = jsonData[index];
          if (message["participants"].length > 1) {
            if (message["participants"].length > 2) {
              return WidgetAnimator(
                CardTasarimi(
                  title: "Grup sohbeti",
                  messages: message["conversation"],
                  userName: userName,
                ),
              );
            } else if (message["participants"][0] == userName) {
              return WidgetAnimator(
                CardTasarimi(
                  title: "${message["participants"][1]}",
                  messages: message["conversation"],
                  userName: userName,
                ),
              );
            } else {
              return WidgetAnimator(
                CardTasarimi(
                  title: "${message["participants"][0]}",
                  messages: message["conversation"],
                  userName: userName,
                ),
              );
            }
          } else {
            return WidgetAnimator(
              CardTasarimi(
                title: "${message["participants"][0]}",
                messages: message["conversation"],
                userName: userName,
              ),
            );
          }
        },
      ),
    );
  }
}
