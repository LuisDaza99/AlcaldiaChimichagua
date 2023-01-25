import 'package:alcaldia/flutter_flow/flutter_flow_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../flutter_flow/flutter_flow_drop_down.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../model/cliente.dart';
import '../../../model/funcionario.dart';

class ClienteInformation extends StatefulWidget {
  
  const ClienteInformation(
    this.cliente,
    {Key key,}) : super(key: key);

final Cliente cliente;
  @override
  _ClienteInformationState createState() => _ClienteInformationState();
}

final clienteReference = FirebaseDatabase.instance.reference().child('cliente');

class _ClienteInformationState extends State<ClienteInformation> {
  List<Cliente> items;
  bool isMediaUploading1 = false;
  String uploadedFileUrl1 = '';

  bool isMediaUploading2 = false;
  String uploadedFileUrl2 = '';

  String companySizeValue;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () async {
            Navigator.pop(context);
          },
          child: Icon(
          Icons.chevron_left_rounded,
          color: FlutterFlowTheme.of(context).primaryText,
          size: 30,
          
        ),
        ),
        
        title: Text(
          'Perfil del cliente',
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Color.fromARGB(255, 25, 116, 28),
            fontSize: 22,
            fontFamily: 'Poppins-bold',
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      
      body: Stack(fit: StackFit.expand, children: <Widget>[
         SingleChildScrollView(
          
          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
          child: Card(
            
          shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                
            elevation: 15,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 12, 10, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Color.fromARGB(255, 35, 122, 38),
                                      width: 1),
                            ),
                            child: InkWell(
                              onTap: () async {},
                              child: Image.asset(
                                'assets/images/user2.jpg',
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                              child: Text(
                                "${widget.cliente.nombre}",
                                style: FlutterFlowTheme.of(context).title3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: FlutterFlowTheme.of(context).lineColor,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                         
                          child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Identificacion',
                          textAlign: TextAlign.start,
                          style: FlutterFlowTheme.of(context).bodyText2,
                        ),
                      ],
                    ),
                  ),
                        ),
                      ],
                      
                    ),
                       new Text(
                  
                   "${widget.cliente.identificacion}",
                  style: FlutterFlowTheme.of(context).title3,
                ),
                    Divider(
                      thickness: 1,
                      color: FlutterFlowTheme.of(context).lineColor,
                    ),
                     Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                         
                          child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Area Encargada',
                          textAlign: TextAlign.start,
                          style: FlutterFlowTheme.of(context).bodyText2,
                        ),
                      ],
                    ),
                  ),
                        ),
                      ],
                      
                    ),
                     new Text(
                    "${widget.cliente.area}",
                    
                  style: FlutterFlowTheme.of(context).title3,
                ),
                    Divider(
                      thickness: 1,
                      color: FlutterFlowTheme.of(context).lineColor,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                         
                          child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Motivo',
                          textAlign: TextAlign.start,
                          style: FlutterFlowTheme.of(context).bodyText2,
                        ),
                      ],
                    ),
                  ),
                        ),
                      ],
                      
                    ),
                      new Text(
                              "${widget.cliente.motivo}",
                
                  style: FlutterFlowTheme.of(context).title3,
                ),
                    Divider(
                      thickness: 1,
                      color: FlutterFlowTheme.of(context).lineColor,
                    ),
                     Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                         
                          child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Fecha',
                          textAlign: TextAlign.start,
                          style: FlutterFlowTheme.of(context).bodyText2,
                        ),
                      ],
                    ),
                  ),
                        ),
                      ],
                      
                    ),
                      new Text(
                              "${widget.cliente.fecha}",
                    
                  style: FlutterFlowTheme.of(context).title3,
                ),
                    Divider(
                      thickness: 1,
                      color: FlutterFlowTheme.of(context).lineColor,
                    ),
                      Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                         
                          child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Hora',
                          textAlign: TextAlign.start,
                          style: FlutterFlowTheme.of(context).bodyText2,
                        ),
                      ],
                    ),
                  ),
                        ),
                      ],
                      
                    ),
                    new Text(
                                "${widget.cliente.hora}",
                   
                  style: FlutterFlowTheme.of(context).title3,
                ),
                      Divider(
                      thickness: 1,
                      color: FlutterFlowTheme.of(context).lineColor,
                    ),
                   
                  ],
                ),
              ),
               Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.end,
                         children: <Widget>[
           
            Image.asset("assets/image_02.png")
          ],
                       )
                        ],
                      ),
                    ),
            ],
            
          ),
          
        ),
          
          ),
      ],
      
        
      ),
    );
  }
}
