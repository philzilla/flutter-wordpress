import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'Single.dart';

class HomePage extends StatefulWidget {

  final String title;

  HomePage(
    {
      Key key,
      @required
      this.title
    }
  ) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  final String url = "https://www.frandroid.com/wp-json/wp/v2/posts?per_page=10";

  List dataWP;
  var isLoading = true;

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  Future getData() async {
    var res = await http.get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    List data = jsonDecode(res.body);
    setState(() {
      dataWP = data;
      isLoading = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: isLoading
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
          itemCount: dataWP == null ? 0 : dataWP.length,
          itemBuilder: (BuildContext context, int index) {
          
            // Contenu
         
            //String contentWP = parse((dataWP[index]['content']['rendered']).toString()).documentElement.text;
            String contentWP = dataWP[index]['content']['rendered'];
            DateTime dateTime = DateTime.parse(dataWP[index]['date']);
            String dateformat = DateFormat( "dd.MM.yyyy HH:mm").format(dateTime);
            
            return  Card(
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[

                    ListTile(
                       // leading: Image.network(dataWP[index]['jetpack_featured_media_url'], fit: BoxFit.cover, width: 80.0,),
                        title: Text(dataWP[index]['title']['rendered'], style: TextStyle(fontSize: 20.0)),
                        subtitle: Text(dateformat),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Single(
                              title: dataWP[index]['title']['rendered'],
                            //  image: dataWP[index]['jetpack_featured_media_url'],
                              content: contentWP
                              )
                            ),
                          );
                        },
                    ),
                    
                    
               ],)
             );
          }
        ),
      )
    );
  }
 

}