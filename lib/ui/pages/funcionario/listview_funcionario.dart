import 'package:alcaldia/model/funcionario.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../flutter_flow/flutter_flow_animations.dart';
import '../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';

import 'package:flutter_animate/flutter_animate.dart';

import '../../../utils/auth_helper.dart';
import 'funcionario_information.dart';
import 'funcionario_screen.dart';

class ListViewFuncionario extends StatefulWidget {
  const ListViewFuncionario({Key key}) : super(key: key);

  @override
  _ListViewFuncionarioState createState() => _ListViewFuncionarioState();
}

class _ListViewFuncionarioState extends State<ListViewFuncionario>
    with TickerProviderStateMixin {
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
  TextEditingController _textBusqueda = TextEditingController();
  FocusNode _focusNode = FocusNode();
  bool _mostrarBusqueda = false;
  @override
  void initState() {
    super.initState();
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(40, 0, 20, 80),
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
                        builder: (context) => FuncionarioScreen(Funcionario(
                            null, '', '', '', '', '', '', '', '', '', ''))),
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
      backgroundColor: Color.fromARGB(255, 223, 231, 235),
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
                                      'Funcionarios',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 25, 116, 28),
                                        fontSize: 25,
                                        fontFamily: 'Poppins-bold',
                                      ),
                                    ),
                                  ),
                                  if (responsiveVisibility(
                                    context: context,
                                    tabletLandscape: false,
                                    desktop: false,
                                  ))
                                    if(!_mostrarBusqueda)
                                    FlutterFlowIconButton(
                                      borderColor: Colors.transparent,
                                      borderRadius: 30,
                                      borderWidth: 1,
                                      buttonSize: 60,
                                      icon: Icon(
                                        Icons.search_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryColor,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        print('Busqueda...');
                                        setState(() {
                                          _focusNode.requestFocus();
                                          _mostrarBusqueda = true;
                                        });
                                      },
                                    ),
                                ],
                              ),
                            ),
                            if(_mostrarBusqueda)
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16,3,16,12),
                              child: Container(
                                height: 60,
                                decoration:BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                blurRadius: 3,
                                                                color: Color.fromARGB(55, 24, 66, 40),
                                                                offset:
                                                                    Offset(0, 1),
                                                              )
                                                            ],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(12),
                                                          ),
                      
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: TextFormField(
                          focusNode: _focusNode,
                          controller: _textBusqueda,
                          onChanged: (_) => EasyDebounce.debounce(
                              '_textBusqueda',
                              Duration(milliseconds: 50),
                              () => setState(() {}),
                          ),
                          obscureText: false,
                          decoration: InputDecoration(
                             
                              labelStyle: FlutterFlowTheme.of(context)
                                  .bodyText2
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.of(context).primaryColor,
                                    fontSize: 18,
                                    
                                    fontWeight: FontWeight.normal,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodyText2Family),
                                  ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryColor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  
                                  color: Color.fromARGB(0, 252, 33, 33),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(0, 255, 5, 5),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(0, 0, 255, 76),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              prefixIcon: Icon(
                                Icons.search_rounded,
                                color: FlutterFlowTheme.of(context).primaryColor,
                              ),
                          ),
                          style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: 'Poppins',
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodyText1Family),
                                ),
                          maxLines: null,
                        ),
                      ),
                    ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.94,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 24),
                                  child: Container(
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        border: Border.all(
                                            color: Color.fromARGB(
                                                255, 25, 116, 28),
                                            width: 1),
                                        color:
                                            Color.fromARGB(255, 223, 231, 235),
                                      ),
                                      child: FutureBuilder<List<Funcionario>>(
                                        future: UserHelper()
                                            .loadUser(_textBusqueda.text),
                                        builder:
                                            (BuildContext context, snapshot) {
                                          if (snapshot.connectionState ==
                                                  ConnectionState.done &&
                                              snapshot.data != null) {
                                            return ListView.builder(
                                              padding: EdgeInsets.zero,
                                              scrollDirection: Axis.vertical,
                                              itemCount: snapshot.data.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return SwipeTo(
                                                  iconOnLeftSwipe: Icons.add,
                                                  iconOnRightSwipe:
                                                      Icons.text_fields,
                                                  iconColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryColor,
                                                  onLeftSwipe: () async {},
                                                  onRightSwipe: () {},
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                16, 8, 16, 0),
                                                    child: InkWell(
                                                      onTap: () =>
                                                          _navigateToFuncionario(
                                                              context,
                                                              snapshot
                                                                  .data[index]),
                                                      onLongPress: () async {},
                                                      child: Container(
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 3,
                                                              color: Color(
                                                                  0x20000000),
                                                              offset:
                                                                  Offset(0, 1),
                                                            )
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(8,
                                                                      8, 12, 8),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                child: '${snapshot.data[index].funcionarioImage}' ==
                                                                        ''
                                                                    ? Text(
                                                                        'No image')
                                                                    : Image
                                                                        .network(
                                                                        '${snapshot.data[index].funcionarioImage}' +
                                                                            '?alt=media',
                                                                        width:
                                                                            70,
                                                                        height:
                                                                            70,
                                                                        fit: BoxFit
                                                                            .fitHeight,
                                                                      ),
                                                              ),
                                                              Expanded(
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              16,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                      child:
                                                                          Text(
                                                                        snapshot
                                                                            .data[index]
                                                                            .nombre
                                                                            .toString(),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .subtitle1,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              16,
                                                                              2,
                                                                              0,
                                                                              0),
                                                                      child:
                                                                          Text(
                                                                        snapshot
                                                                            .data[index]
                                                                            .role
                                                                            .toString(),
                                                                        style: FlutterFlowTheme.of(context)
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
                                                                        right:
                                                                            20),
                                                                child:
                                                                    IconButton(
                                                                  icon: Icon(
                                                                    Icons
                                                                        .delete_outline,
                                                                    color: Colors
                                                                        .red,
                                                                    size: 24,
                                                                  ),
                                                                  onPressed: () =>
                                                                      _showDialog(
                                                                          snapshot
                                                                              .data[index],
                                                                          context),
                                                                ),
                                                              ),
                                                              IconButton(
                                                                  icon: Icon(
                                                                    Icons
                                                                        .mode_edit_outline,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryColor,
                                                                    size: 24,
                                                                  ),
                                                                  onPressed: () =>
                                                                      _navigateToFuncionarioInformation(
                                                                          context,
                                                                          snapshot
                                                                              .data[index])),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ).animateOnPageLoad(
                                                        animationsMap[
                                                            'containerOnPageLoadAnimation']),
                                                  ),
                                                );
                                              },
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                      )),
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

  void _showDialog(Funcionario funcionario, context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Advertencia'),
          content: Text('¿Está seguro de que desea eliminar este funcionario?'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () async {
                await UserHelper().eliminarFuncionario(funcionario.email);
                setState(() {
                  Navigator.of(context).pop();
                });
              },
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

  void _deleteFuncionario(items, BuildContext context, Funcionario funcionario,
      int position) async {
    await UserHelper().eliminarFuncionario(funcionario.id).then((_) {
      setState(() {
        items.removeAT(position);
        Navigator.of(context).pop();
      });
    });
  }

  void _navigateToFuncionarioInformation(
      BuildContext context, Funcionario funcionario) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FuncionarioScreen(funcionario)),
    );
  }

  void _navigateToFuncionario(
      BuildContext context, Funcionario funcionario) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => FuncionarioInformation(funcionario)),
    );
  }

  void _createNewFuncionario(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => FuncionarioScreen(
              Funcionario(null, '', '', '', '', '', '', '', '', '', ''))),
    );
  }
}
