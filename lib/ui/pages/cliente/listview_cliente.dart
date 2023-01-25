import 'package:alcaldia/model/funcionario.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:alcaldia/model/cliente.dart';
import 'package:alcaldia/ui/pages/cliente/cliente_information.dart';
import 'package:alcaldia/ui/pages/cliente/cliente_screen.dart';
import 'package:logger/logger.dart';
import 'package:colombia_holidays/colombia_holidays.dart';
import '../../../flutter_flow/flutter_flow_animations.dart';
import '../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';
import 'dart:async';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import '../../../utils/auth_helper.dart';
import 'cliente_information.dart';
import 'cliente_screen.dart';

class ListViewCliente extends StatefulWidget {
  const ListViewCliente({Key key}) : super(key: key);

  @override
  _ListViewClienteState createState() => _ListViewClienteState();
}

final clienteReference = FirebaseDatabase.instance.reference().child('cliente');

class _ListViewClienteState extends State<ListViewCliente>
    with TickerProviderStateMixin {
  List<Cliente> items;
  List<Cliente> _itemsBackup = [];
  List<DateTime> _listadiasFestivos = [];
  StreamSubscription<Event> _onClienteAddedSubscription;
  StreamSubscription<Event> _onClienteChangedSubscription;
  AnimationController _controller;
  DateRangePickerController _controllerDatePicker = DateRangePickerController();
  ColombiaHolidays holidays = ColombiaHolidays();
  DateTime fechaInicial;
  DateTime fechaFinal;

  final animationsMap = {
    'containerOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 1.ms),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 300.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 300.ms,
          begin: Offset(0, 20),
          end: Offset(0, 0),
        ),
      ],
    ),
  };
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Funcionario> listaFuncionarios = [];

  @override
  void initState() {
    super.initState();
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
    items = new List();
    _onClienteAddedSubscription =
        clienteReference.onChildAdded.listen(_onClienteAdded);
    _onClienteChangedSubscription =
        clienteReference.onChildChanged.listen(_onClienteUpdate);
    _cargarDiasFestivos();
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
    _onClienteAddedSubscription.cancel();
    _onClienteChangedSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(40, 0, 20, 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AbsorbPointer(
              absorbing: false,
              child: FloatingActionButton(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                backgroundColor: FlutterFlowTheme.of(context).primaryColor,
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ClienteScreen(
                            Cliente(null, '', '', '', '', '', ''))),
                  ).then((value) {
                    setState(() {});
                  });
                },
              ),
            )
          ],
        ),
      ),
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: false
          ? AppBar(
              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
              automaticallyImplyLeading: false,
              title: Text(
                'Page Title',
                style: FlutterFlowTheme.of(context).title2.override(
                      fontFamily: 'Poppins',
                      color: FlutterFlowTheme.of(context).darkSeaGreen,
                      fontSize: 22,
                    ),
              ),
              actions: [],
              centerTitle: false,
              elevation: 2,
            )
          : null,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 16, 0, 0),
                                    child: Text(
                                      'Clientes',
                                      style:
                                         TextStyle(
                                    color: Color.fromARGB(255, 25, 116, 28), fontSize: 25, fontFamily: 'Poppins-bold',
                                    ),
                                    ),
                                  ),
                                  if (responsiveVisibility(
                                    context: context,
                                    tabletLandscape: false,
                                    desktop: false,
                                  ))
                                  
                                    FlutterFlowIconButton(
                                      borderColor: Colors.transparent,
                                      borderRadius: 30,
                                      borderWidth: 1,
                                      buttonSize: 60,
                                      icon: Icon(
                                        Icons.filter_list,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return _datePickerRango(context,
                                                  _controllerDatePicker);
                                            });
                                      },
                                    ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.94,
                                decoration: BoxDecoration(),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 24),
                                  child: Container(
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                    ),
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.vertical,
                                      itemCount: items.length,
                                      itemBuilder:
                                          (BuildContext context, position) {
                                        return SwipeTo(
                                          iconOnLeftSwipe: Icons.add,
                                          iconOnRightSwipe: Icons.text_fields,
                                          iconColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryColor,
                                          onLeftSwipe: () async {},
                                          onRightSwipe: () {},
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 8, 16, 0),
                                            child: InkWell(
                                              onTap: () => _navigateToCliente(
                                                  context, items[position]),
                                              onLongPress: () async {},
                                              child: Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 3,
                                                      color: Color(0x20000000),
                                                      offset: Offset(0, 1),
                                                    )
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(8, 8, 12, 8),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child: Text(
                                                          '${position + 1}',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 21.0,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16,
                                                                          0,
                                                                          0,
                                                                          0),
                                                              child: Text(
                                                                '${items[position].nombre}',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .subtitle1,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16,
                                                                          2,
                                                                          0,
                                                                          0),
                                                              child: Text(
                                                                '${items[position].fecha}',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText2,
                                                              ),
                                                            ),
                                                            /*Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              16,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                      child: Text(
                                                                        'ACME Co.',
                                                                        style: FlutterFlowTheme.of(
                                                                                context)
                                                                            .bodyText2
                                                                            .override(
                                                                              fontFamily:
                                                                                  'Poppins',
                                                                              color:
                                                                                  FlutterFlowTheme.of(context).primaryColor,
                                                                              fontSize:
                                                                                  12,
                                                                            ),
                                                                      ),
                                                                    ),*/
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 20),
                                                        child: IconButton(
                                                          icon: Icon(
                                                            Icons
                                                                .delete_outline,
                                                            color: Colors.red,
                                                            size: 24,
                                                          ),
                                                          onPressed: () =>
                                                              _showDialog(
                                                                  context,
                                                                  position),
                                                        ),
                                                      ),
                                                      IconButton(
                                                          icon: Icon(
                                                            Icons
                                                                .mode_edit_outline,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryColor,
                                                            size: 24,
                                                          ),
                                                          onPressed: () =>
                                                              _navigateToClienteInformation(
                                                                  context,
                                                                  items[
                                                                      position])),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ).animateOnPageLoad(animationsMap[
                                                'containerOnPageLoadAnimation']),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog(context, position) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Advertencia'),
          content: Text('¿Está seguro de que desea eliminar este cliente?'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () => _deleteCliente(
                context,
                items[position],
                position,
              ),
            ),
            new TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToClienteInformation(
      BuildContext context, Cliente cliente) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ClienteScreen(cliente)),
    );
  }

  _cargarDiasFestivos() async {
    if (_listadiasFestivos.length == 0) {
      DateTime fecha_fin = DateTime.now().add(Duration(days: 90));
      final holidaysByYear2022 = await holidays.getHolidays(year: 2022);
      for (var holiday in holidaysByYear2022) {
        List<String> res = holiday.date.toString().split('/');
        _listadiasFestivos.add(
            DateTime(int.parse(res[2]), int.parse(res[1]), int.parse(res[0])));
        if (_listadiasFestivos.last.isAfter(fecha_fin)) {
          break;
        }
      }
      final holidaysByYear2023 = await holidays.getHolidays(year: 2023);
      for (var holiday in holidaysByYear2023) {
        List<String> res = holiday.date.toString().split('/');
        _listadiasFestivos.add(
            DateTime(int.parse(res[2]), int.parse(res[1]), int.parse(res[0])));
        if (_listadiasFestivos.last.isAfter(fecha_fin)) {
          break;
        }
      }
      setState(() {});
    }
  }

  Widget getDateRangePicker() {
    return Container(
        height: 250,
        child: Card(
            child: SfDateRangePicker(
          view: DateRangePickerView.month,
          selectionMode: DateRangePickerSelectionMode.single,
          onSelectionChanged: selectionChanged,
        )));
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    SchedulerBinding.instance.addPostFrameCallback((duration) {
      setState(() {});
    });
  }

  void filtrarLista(DateTime fechaInicial, DateTime fechaFinal) {
    if (_itemsBackup.length < 1) {
      _itemsBackup = items;
    }
    var listaFiltrada = _itemsBackup
        .where((cliente) =>
            cliente.fechaPicked >= fechaInicial.millisecondsSinceEpoch &&
            cliente.fechaPicked <= fechaFinal.millisecondsSinceEpoch)
        .toList();

    setState(() {
      items = listaFiltrada;
    });
  }

  void _onClienteAdded(Event event) {
    setState(() {
      items.add(new Cliente.fromSnapShot(event.snapshot));
    });
  }

  void _onClienteUpdate(Event event) {
    var oldClienteValue =
        items.singleWhere((cliente) => cliente.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldClienteValue)] =
          new Cliente.fromSnapShot(event.snapshot);
    });
  }

  void _deleteCliente(
      BuildContext context, Cliente cliente, int position) async {
    await clienteReference.child(cliente.id).remove().then((_) {
      setState(() {
        items.removeAt(position);
        Navigator.of(context).pop();
      });
    });
  }

  void _navigateToCliente(BuildContext context, Cliente cliente) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ClienteInformation(cliente)),
    );
  }

  void _createNewCliente(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              ClienteScreen(Cliente(null, '', '', '', '', '', ''))),
    );
  }

  Widget _datePickerRango(
      BuildContext context, DateRangePickerController _controller) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: 360.0,
        height: 360.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SfDateRangePicker(
                    onSelectionChanged:
                        (DateRangePickerSelectionChangedArgs args) async {
                      //Accion a realizar al cambiar las fechas
                      _controller.selectedRange.endDate;
                    },
                    initialDisplayDate: DateTime.now(),
                    controller: _controller,
                    minDate: DateTime.utc(2022, 1, 1),
                    initialSelectedDate: DateTime.now(),
                    selectableDayPredicate: (DateTime dateTime) {
                      if (dateTime.weekday == 7 ||
                          dateTime.weekday == 6 ||
                          (_listadiasFestivos.where(
                              (element) => element == dateTime)).isNotEmpty) {
                        return false;
                      }
                      return true;
                    },
                    enablePastDates: true,
                    toggleDaySelection: true,
                    showNavigationArrow: true,
                    monthCellStyle: DateRangePickerMonthCellStyle(
                      blackoutDatesDecoration: BoxDecoration(
                          color: Colors.red,
                          border: Border.all(
                              color: const Color(0xFFF44436), width: 1),
                          shape: BoxShape.circle),
                      weekendDatesDecoration: BoxDecoration(
                          border: Border.all(width: 1), shape: BoxShape.circle),
                      specialDatesDecoration: BoxDecoration(
                          color: const Color.fromARGB(255, 6, 113, 122),
                          border: Border.all(
                              color: const Color(0xFF2B732F), width: 1),
                          shape: BoxShape.circle),
                      blackoutDateTextStyle: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.lineThrough),
                      specialDatesTextStyle:
                          const TextStyle(color: Colors.white),
                    ),
                    monthViewSettings: DateRangePickerMonthViewSettings(
                        specialDates: _listadiasFestivos,
                        dayFormat: 'EEE',
                        numberOfWeeksInView: 5,
                        firstDayOfWeek: 7,
                        enableSwipeSelection: true,
                        showTrailingAndLeadingDates: true),
                    view: DateRangePickerView.month,
                    selectionMode: DateRangePickerSelectionMode.range,
                    initialSelectedRange:
                        PickerDateRange(DateTime.now(), DateTime.now()),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: MaterialButton(
                    child: Text("Cancelar"),
                    onPressed: () {
                      if (_itemsBackup.isNotEmpty) {
                        setState(() {
                          _controllerDatePicker = DateRangePickerController();
                          items = _itemsBackup;
                        });
                      }
                      Navigator.pop(context);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: MaterialButton(
                    child: Text("OK"),
                    onPressed: () {
                      if (_controller != null) {
                        fechaInicial = _controller.selectedRange.startDate;
                        fechaFinal = (_controller.selectedRange.endDate == null)
                            ? fechaInicial
                            : _controller.selectedRange.endDate;
                        Navigator.pop(context);
                        Logger().i('FechaInicial: $fechaInicial');
                        Logger().i('FechaFinal: $fechaFinal');
                        filtrarLista(fechaInicial, fechaFinal);
                      } else {
                        if (_itemsBackup.isNotEmpty) {
                          items = _itemsBackup;
                        }
                      }
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
