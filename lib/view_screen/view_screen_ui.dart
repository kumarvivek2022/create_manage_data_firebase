import 'package:flutter/material.dart';

class ViewScreen extends StatefulWidget {
  String? imageUrl;
  String? title;
  String? desc;

  ViewScreen({
    Key? key,
    this.imageUrl,
    this.title,
    this.desc,
  }) : super(key: key);

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 100) ,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5)
            ),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Text(widget.title!),
                Text(widget.desc!),
                Expanded(child: Image.network(widget.imageUrl!))
              ],
            ),
          ),
        ),
      ]),
    ));
  }
}
