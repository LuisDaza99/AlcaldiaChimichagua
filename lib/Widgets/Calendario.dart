import 'package:alcaldia/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:table_calendar/table_calendar.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../utils/auth_helper.dart';
import '../ui/views/HomePage/state/homepageScrollListner.dart';

class Calendario extends StatefulWidget {
  @override
  _CalendarioState createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  ScrollController _mainScrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _model = HomepageSrollListner.initialise(_mainScrollController);
  }

  HomepageSrollListner _model;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            child: Stack(
              children: [
                TableCalendar(
                  onHeaderTapped: (focusedDay) {},
                  onHeaderLongPressed: (focusedDay) {},
                  onFormatChanged: (format) {
                    print('2 weeks');
                  
                  },
                  calendarFormat: CalendarFormat.month,
                  locale: 'es_CO',
                  firstDay: DateTime.utc(2010, 10, 20),
                  lastDay: DateTime.utc(2040, 10, 20),
                  focusedDay: DateTime.now(),
                  headerVisible: true,
                  daysOfWeekVisible: true,
                  sixWeekMonthsEnforced: true,
                  shouldFillViewport: false,
                  headerStyle: HeaderStyle(
                      titleTextStyle: TextStyle(
                          fontSize: 20,
                          color: FlutterFlowTheme.of(context).primaryColor,
                          fontWeight: FontWeight.w800)),
                  calendarStyle: CalendarStyle(
                      todayTextStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
                AnimatedBuilder(
                    animation: _model,
                    builder: (context, child) {
                      return Positioned(
                          bottom: _model.bottom,
                          right: 22,
                          left: 22,
                          child: Container(
                            padding: EdgeInsets.only(left: 12, right: 12),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 15,
                                      color: Colors.black.withOpacity(0.4))
                                ],
                                borderRadius: BorderRadius.circular(45)),
                            height: 75,
                            alignment: Alignment.center,
                            child: Material(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.home_rounded,
                                        size: 36,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryColor.withOpacity(0.35)),
                                    onPressed: () => Get.toNamed("/home"),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.calendar_today_rounded,
                                        size: 36,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryColor
                                            ),
                                    onPressed: () => Get.toNamed("/calendario"),
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.search,
                                          size: 36,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryColor
                                              .withOpacity(0.35)),
                                      onPressed: () {}),
                                  IconButton(
                                      icon: Icon(Icons.logout,
                                          size: 36,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryColor
                                              .withOpacity(0.35)),
                                      onPressed: () {
                                        AuthHelper.logOut();
                                      })
                                ],
                              ),
                            ),
                          ));
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
