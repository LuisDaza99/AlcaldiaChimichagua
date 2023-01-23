

import 'package:alcaldia/model/funcionario.dart';

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
          onPressed: () async{
            await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => FuncionarioScreen(
              Funcionario(null, '', '', '', '', '', '', '', '', '', ''))),
    ).then((value) {setState(() {
      
    });});
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
                                      'Funcionarios',
                                      style:
                                          FlutterFlowTheme.of(context).title1,
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
                                        Icons.search_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        print('IconButton pressed ...');
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
                                      child: FutureBuilder<List<Funcionario>>(
                                        future:
                                            UserHelper().loadUser(),
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
                                                  onLeftSwipe: () async {
                                                    
                                                  },
                                                  onRightSwipe: () {
                                                    
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                16, 8, 16, 0),
                                                    child: InkWell(
                                                      onTap: () => _navigateToFuncionario(
                                          context, snapshot.data[index]),
                                                      onLongPress: () async {
                                                       
                                                      },
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
                                            ? Text('No image') : Image.network(
                                                                   '${snapshot.data[index].funcionarioImage}' +
                                                    '?alt=media', width: 70,
                                                                  height: 70,
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
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
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
                                                                          style:
                                                                              FlutterFlowTheme.of(context).subtitle1,
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
                                                                padding: const EdgeInsets.only(right: 20),
                                                                child: IconButton(
                                                                  icon: Icon(
                                                                    Icons
                                                                        .delete_outline,
                                                                    color: Colors.red,
                                                                    size: 24,
                                                                    
                                                                  ), onPressed: () => _showDialog(
                                        snapshot.data[index], context),
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
                                                                ), onPressed: () =>
                                            _navigateToFuncionarioInformation(
                                                context, snapshot.data[index])),
                            
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
          title: Text('Alerta'),
          content:
              Text('Esta seguro de que quieres eliminar este funcionario?'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.purple,
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
  
  void _deleteFuncionario( items, BuildContext context, Funcionario funcionario,
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
