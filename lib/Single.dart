import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class Single extends StatefulWidget {

  final String title;
  final String image;
  final String content;

  Single(
     {
      Key key,
      @required
      this.title,
      this.image,
      this.content,

    }
  ) : super(key: key);

  @override
  _SingleState createState() => _SingleState();
}



class _SingleState extends State<Single> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child:
          Column(
            children: <Widget>[
              Image.network(widget.image, fit: BoxFit.cover),
              Container(
                child: Text(widget.title)
              ),
              HtmlWidget(
                widget.content,
                /*
                onTapUrl: (url) => showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: Text('onTapUrl'),
                      content: Text(url),
                    ),
                ),
                */
             

              ),
            ],
          ),
)
    );
  }
}