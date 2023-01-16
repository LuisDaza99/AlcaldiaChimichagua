import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:alcaldia/model/cliente.dart';
import 'package:alcaldia/pages/cliente/cliente_information.dart';
import 'package:alcaldia/pages/cliente/cliente_screen.dart';
import 'package:logger/logger.dart';
import 'package:colombia_holidays/colombia_holidays.dart';

class ListViewCliente extends StatefulWidget {
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

  @override
  void initState() {
    super.initState();
    items = new List();
    _onClienteAddedSubscription =
        clienteReference.onChildAdded.listen(_onClienteAdded);
    _onClienteChangedSubscription =
        clienteReference.onChildChanged.listen(_onClienteUpdate);
    _cargarDiasFestivos();
  }

  @override
  void dispose() {
    super.dispose();
    _onClienteAddedSubscription.cancel();
    _onClienteChangedSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 175, 203, 216),
      appBar: AppBar(
        title: Text('Todos los clientes atendidos'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 38, 148, 192),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return _datePickerRango(context, _controllerDatePicker);
                  });
            },
          )
        ],
      ),
      body: Center(
        child: ListView.builder(
            itemCount: items.length,
            padding: EdgeInsets.only(top: 3.0),
            itemBuilder: (context, position) {
              return Column(
                children: <Widget>[
                  Divider(
                    height: 1.0,
                  ),
                  Container(
                    padding: new EdgeInsets.all(15.0),
                    child: Card(
                      elevation: 5,
                      child: Row(
                        children: <Widget>[
                          //nuevo contador
                          CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 175, 203, 216),
                            radius: 17.0,
                            child: Text(
                              '${position + 1}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 21.0,
                              ),
                            ),
                          ),

                          Expanded(
                            child: ListTile(
                                title: Text(
                                  '${items[position].nombre}',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 21.0,
                                  ),
                                ),
                                subtitle: Text(
                                  '${items[position].fecha}',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 56, 52, 52),
                                    fontSize: 21.0,
                                  ),
                                ),
                                onTap: () => _navigateToClienteInformation(
                                    context, items[position])),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () => _showDialog(context, position),
                          ),

                          //onPressed: () => _deleteCliente(context, items[position],position)),
                          IconButton(
                              icon: Icon(
                                Icons.remove_red_eye,
                                color: Colors.blueAccent,
                              ),
                              onPressed: () =>
                                  _navigateToCliente(context, items[position])),
                        ],
                      ),
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    child: Text("Regresar"),
                    onPressed: () {
                      Get.toNamed("/home");
                    },
                  )
                ],
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color.fromARGB(255, 38, 148, 192),
        onPressed: () => _createNewCliente(context),
      ),
    );
  }

  //nuevo para que pregunte antes de eliminar un registro
  void _showDialog(context, position) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alerta'),
          content: Text('Esta seguro de que quieres eliminar este cliente?'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.purple,
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

  void _navigateToClienteInformation(
      BuildContext context, Cliente cliente) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ClienteScreen(cliente)),
    );
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
}
