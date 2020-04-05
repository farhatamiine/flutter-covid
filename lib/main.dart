import 'package:covid_morocco/components/DetailsPage.dart';
import 'package:covid_morocco/models/Covid.dart';
import 'package:covid_morocco/services/covid_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid Info',
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(primarySwatch: Colors.blue, backgroundColor: Colors.white),
      home: Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBar: AppBar(
          title: Text("Covid"),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          elevation: 0.1,
          leading: Icon(FontAwesomeIcons.virus),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(FontAwesomeIcons.sync),
            )
          ],
        ),
        body: FutureBuilder<List<Covid>>(
          future: getAllInfo(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Covid> data = snapshot.data;
              return _covidListView(data, context);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  ListView _covidListView(data, BuildContext context) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return makeCard(data[index], context);
        });
  }

  makeCard(Covid data, BuildContext context) => Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
          child: makeListTile(data, context),
        ),
      );

  ListTile makeListTile(Covid data, BuildContext context) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        title: Text(data.country,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Row(
          children: <Widget>[
            Text(data.cases.toString(),
                style: TextStyle(color: Colors.yellowAccent)),
            Text(" Cases", style: TextStyle(color: Colors.white))
          ],
        ),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DetailPage(covid: data)));
        },
        trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
        leading: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 44,
            minHeight: 44,
            maxWidth: 64,
            maxHeight: 64,
          ),
          child: Image.network(data.countryInfo.flag, fit: BoxFit.cover),
        ),
      );
}
