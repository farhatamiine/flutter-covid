import 'package:charts_flutter/flutter.dart' as charts;
import 'package:covid_morocco/models/Covid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'SimpleBarChart.dart';

class DetailPage extends StatelessWidget {
  DetailPage({this.covid});

  final Covid covid;

  @override
  Widget build(BuildContext context) {
    var data = [
      ClicksPerYear('Cases', covid.todayCases, Colors.deepOrange),
      ClicksPerYear('Death', covid.todayDeaths, Colors.red),
      ClicksPerYear('Recovred', covid.recovered, Colors.green),
    ];
    var series = [
      charts.Series(
        domainFn: (ClicksPerYear clickData, _) => clickData.year,
        measureFn: (ClicksPerYear clickData, _) => clickData.clicks,
        colorFn: (ClicksPerYear clickData, _) => clickData.color,
        id: 'Clicks',
        data: data,
      ),
    ];
    var chart = charts.BarChart(
      series,
      animate: true,
    );
    var chartWidget = Padding(
      padding: EdgeInsets.all(20.0),
      child: SizedBox(
        height: 250.0,
        child: chart,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        elevation: 0.1,
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color.fromRGBO(58, 66, 86, 1.0),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 44,
                      minHeight: 44,
                      maxWidth: 150,
                      maxHeight: 150,
                    ),
                    child: Image.network(covid.countryInfo.flag,
                        fit: BoxFit.cover),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(covid.country,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30)),
                  Text(
                      DateTime.fromMillisecondsSinceEpoch(covid.updated)
                          .toUtc()
                          .toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.syringe,
                              color: Colors.deepOrange,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(covid.cases.toString(),
                                style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                            Text("Cases",
                                style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.smile,
                              color: Colors.green,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(covid.recovered.toString(),
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                            Text("Recovered",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.dizzy,
                              color: Colors.redAccent,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(covid.deaths.toString(),
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                            Text("Deaths",
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text("Graph", style: TextStyle(color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 25)),
          chartWidget
        ],
      ),
    );
  }
}
