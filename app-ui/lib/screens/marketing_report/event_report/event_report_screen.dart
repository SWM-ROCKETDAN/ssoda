import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class EventReportScreen extends StatelessWidget {
  const EventReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height * 0.35,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
            ),
          ),
          Container(
              padding: const EdgeInsets.only(top: 30),
              margin: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text('우리가게 SNS 해시태그 이벤트',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  SizedBox(height: 5),
                  Text('마케팅 성과 보고서',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 28)),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: 175,
                            padding: const EdgeInsets.all(20),
                            width: size.width,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                          children: [
                                        TextSpan(text: '총 '),
                                        TextSpan(
                                            text: '384',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 32)),
                                        TextSpan(text: ' 명이 참여했습니다')
                                      ])),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            Icon(
                                              Icons.favorite,
                                              color: Colors.pinkAccent,
                                            ),
                                            Text('7423개',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.pinkAccent)),
                                          ],
                                        ),
                                        Column(children: [
                                          SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: PieChart(PieChartData(
                                                centerSpaceRadius: 12,
                                                sectionsSpace: 0,
                                                sections: [
                                                  PieChartSectionData(
                                                      radius: 12,
                                                      value: 67,
                                                      color: Colors.blueAccent,
                                                      showTitle: false),
                                                  PieChartSectionData(
                                                      radius: 12,
                                                      value: 33,
                                                      color:
                                                          Colors.grey.shade300,
                                                      showTitle: false)
                                                ])),
                                          ),
                                          Text('67%',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.blueAccent))
                                        ]),
                                        Column(
                                          children: [
                                            Icon(
                                              Icons.people,
                                              color: Colors.greenAccent,
                                            ),
                                            Text('57832명',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.greenAccent)),
                                          ],
                                        )
                                      ])
                                ]),
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(1.5, 1.5),
                                    blurRadius: 2,
                                    spreadRadius: 0,
                                  )
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: 150,
                            padding: const EdgeInsets.all(20),
                            width: size.width,
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(1.5, 1.5),
                                    blurRadius: 2,
                                    spreadRadius: 0,
                                  )
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: 150,
                            padding: const EdgeInsets.all(20),
                            width: size.width,
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(1.5, 1.5),
                                    blurRadius: 2,
                                    spreadRadius: 0,
                                  )
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: 150,
                            padding: const EdgeInsets.all(20),
                            width: size.width,
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(1.5, 1.5),
                                    blurRadius: 2,
                                    spreadRadius: 0,
                                  )
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
