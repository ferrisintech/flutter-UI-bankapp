import 'dart:io';

import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  HomePage createState() => HomePage();
}

class HomePage extends State<Home> with TickerProviderStateMixin {
  bool isSelected = false;
  double normalfont = 30;
  double bigfont = 40;
  int _index = 2;
  final List<Color> colores = [
    Colors.white,
    Colors.white,
  ];

  // Animation<double> animation;
  Animation<Offset> navAnimation, delayAnimation;
  AnimationController navController;

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () => exit(0), //Navigator.of(context).pop(true),
                child: Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  void initState() {
    super.initState();

    navController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..forward(from: 0.0);

    navAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: navController,
      curve: Curves.linear,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    navController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // resizeToAvoid: false,

        extendBodyBehindAppBar: true,
        extendBody: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.account_circle_outlined),
            iconSize: 30,
            color: Colors.grey[200],
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.list),
              iconSize: 30,
              color: Colors.grey[200],
              onPressed: () {},
            ),
          ],
        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFF00FF),
                    Color(0xFF7FCDCD),
                    // Color(0xFFFF00FF), // team1
                    // Color(0xFF5BB3B0), // team1
                    // Color(0xFF0F4C81), //classic blue
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 280,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: buildLineChart(),
                  ),
                  SlideTransition(
                    position: navAnimation,
                    child: Container(
                      height: 440,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(
                        top: 40,
                        bottom: 20,
                      ), // left: 10, right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30)),
                      ),
                      child: buildListView(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedIconTheme: IconThemeData(
                  size: 30,
                  color: Colors.blue,
                ),
                iconSize: 26,
                unselectedItemColor: Colors.grey[400],
                unselectedFontSize: 12,
                selectedFontSize: 15,
                currentIndex: _index,
                onTap: (int idx) {
                  setState(() {
                    _index = idx;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.money_rounded),
                    label: "Operations",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_balance),
                    label: "Account",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.send),
                    label: "Pay",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.history),
                    label: "History",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.info),
                    label: "Info",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ListView buildListView(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      shrinkWrap: false,
      scrollDirection: Axis.vertical,
      children: [
        buildListItem(context),
        buildListItem2(context),
        buildListItem3(context),
        buildListItem4(context),
        buildListItem5(context),
        buildListItem6(context),
        buildListItem7(context),
        buildListItem8(context),
      ],
    );
  }

  Container buildListItem(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [Colors.blueGrey[300], Colors.blueGrey[100]],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Icon(Icons.arrow_circle_up_rounded,
                color: Colors.green[800], size: 30),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              '+ 400 USD',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  Container buildListItem2(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [Colors.blueGrey[300], Colors.blueGrey[100]],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Icon(Icons.arrow_circle_up_rounded,
                color: Colors.green[800], size: 30),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              '+ 1200 USD',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  Container buildListItem3(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [Colors.blueGrey[300], Colors.blueGrey[100]],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Icon(Icons.arrow_circle_down_rounded,
                color: Colors.red[800], size: 30),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              '- 2700 USD',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  Container buildListItem4(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [Colors.blueGrey[300], Colors.blueGrey[100]],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Icon(Icons.arrow_circle_up_rounded,
                color: Colors.green[800], size: 30),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              '+ 950 USD',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  Container buildListItem5(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [Colors.blueGrey[300], Colors.blueGrey[100]],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Icon(Icons.arrow_circle_down_rounded,
                color: Colors.red[800], size: 30),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              '- 500 USD',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  Container buildListItem6(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [Colors.blueGrey[300], Colors.blueGrey[100]],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: Icon(Icons.arrow_circle_up_rounded,
                  color: Colors.green[800], size: 30)),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              '+ 300 USD',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  Container buildListItem7(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [Colors.blueGrey[300], Colors.blueGrey[100]],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Icon(Icons.arrow_circle_down_rounded,
                color: Colors.red[800], size: 30),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              '- 300 USD',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  Container buildListItem8(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [Colors.blueGrey[300], Colors.blueGrey[100]],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Icon(Icons.arrow_circle_down_rounded,
                color: Colors.red[800], size: 30),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              '- 100 USD',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  LineChart buildLineChart() {
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: 6,
        minY: 0,
        maxY: 7,
        gridData: FlGridData(
          show: false,
        ),
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 2),
              FlSpot(1, 4),
              FlSpot(2, 1),
              FlSpot(3, 3),
              FlSpot(4, 5),
              FlSpot(5, 1),
              FlSpot(6, 4),
            ],
            isCurved: true,
            colors: colores,
            barWidth: 2,

            belowBarData: BarAreaData(
              show: true,
              colors: colores.map((color) => color.withOpacity(0.2)).toList(),
            ),
            //dotData: FlDotData(show: false),
          ),
        ],
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: Color(0xFF0F4C81),
          ),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          bottomTitles: SideTitles(
            margin: 30,
            showTitles: true,
            reservedSize: 6,
            getTextStyles: (value) =>
                TextStyle(fontSize: 14, color: Colors.white),
            getTitles: (value) {
              switch (value.toInt()) {
                case 0:
                  return "MON";
                case 1:
                  return "TUE";
                case 2:
                  return "WEN";
                case 3:
                  return "THU";
                case 4:
                  return "FRI";
                case 5:
                  return "SAT";
                case 6:
                  return "SUN";
                default:
                  return "";
              }
            },
          ),
          leftTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
    );
  }
}
