import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ResimView extends StatefulWidget {
  final String ppURL;
  final String ogretmenAdi;
  final String messageId;
  ResimView(this.ppURL, this.ogretmenAdi, this.messageId);
  @override
  _ResimViewState createState() => _ResimViewState();
}

class _ResimViewState extends State<ResimView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.ogretmenAdi),
      ),
      body: Container(
        child: PhotoView(
          heroAttributes: PhotoViewHeroAttributes(tag: widget.messageId),
          imageProvider: NetworkImage(widget.ppURL),
        ),
      ),
    );
  }
}
