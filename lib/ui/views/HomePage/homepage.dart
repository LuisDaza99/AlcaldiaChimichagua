import 'package:alcaldia/flutter_flow/flutter_flow_theme.dart';
import 'package:alcaldia/model/dependenciaModel.dart';
import 'package:alcaldia/ui/views/ViewDetails/viewDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:alcaldia/components/appbar.dart';
import 'package:alcaldia/components/featuredcard.dart';
import 'package:alcaldia/components/alcaldiadependencia.dart';
import 'package:alcaldia/constants/colors.dart';
import 'package:alcaldia/theme.dart';
import 'package:alcaldia/ui/views/HomePage/components/featurelist.dart';
import 'package:alcaldia/ui/views/HomePage/state/homepageScrollListner.dart';
import 'package:alcaldia/ui/views/HomePage/state/homepageStateProvider.dart';
import 'package:easy_debounce/easy_debounce.dart';

import '../../../utils/auth_helper.dart';

class HomePageUsuario extends StatefulWidget {
  @override
  _HomePageUsuarioState createState() => _HomePageUsuarioState();
}

class _HomePageUsuarioState extends State<HomePageUsuario> {
  ScrollController _mainScrollController = ScrollController();
  TextEditingController textControllerBusqueda = TextEditingController();
  FocusNode _focusNodeBusqeda = FocusNode();
  bool mostrarBusqueda = false;

  final double _bottomBarHeight = 90;
  HomepageSrollListner _model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _model = HomepageSrollListner.initialise(_mainScrollController);
  }

  @override
  Widget build(BuildContext context) {
    HomePageStateProvider homepagestate =
        Provider.of<HomePageStateProvider>(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: HomeAppBar,
      body: Container(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: _mainScrollController,
              child: Column(
                children: [
                  if (mostrarBusqueda)
                    Container(
                      width: 380,
                      child: Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                          child: TextFormField(
                            focusNode: _focusNodeBusqeda,
                            controller: textControllerBusqueda,
                            onChanged: (_) => EasyDebounce.debounce(
                              'textControllerBusqueda',
                              Duration(milliseconds: 50),
                              () => setState(() {}),
                            ),
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Buscar dependencia...',
                              labelStyle: FlutterFlowTheme.of(context)
                                  .bodyText2
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF57636C),
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodyText2Family),
                                  ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              prefixIcon: Icon(
                                Icons.search_rounded,
                                color: Color(0xFF57636C),
                              ),
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: 'Poppins',
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
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
                  if (textControllerBusqueda.text.length < 1)
                    Container(
                      width: size.width,
                      height: size.height * 0.33,
                      child: StreamBuilder<List<DependenciaModel>>(
                          stream: homepagestate
                              .getFeaturedDependencias()
                              .asStream(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData)
                              return Container(
                                  alignment: Alignment.center,
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator());
                            if (snapshot.connectionState ==
                                ConnectionState.waiting)
                              return Container(
                                  alignment: Alignment.center,
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator());

                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () {
                                        switch (snapshot.data[index].id) {
                                          case 1:
                                            Navigator.pushNamed(
                                                context, "/simbolos");
                                            break;
                                          case 2:
                                            Navigator.pushNamed(
                                                context, "/municipio");
                                            break;
                                          case 3:
                                            Navigator.pushNamed(
                                                context, "/nalcaldia");
                                            break;
                                          case 4:
                                            Navigator.pushNamed(
                                                context, "/map");
                                            break;
                                          default:
                                            Navigator.pushNamed(
                                                context, "/home");
                                        }
                                      },
                                      child: FeaturedCard(
                                        dependenciaModel: snapshot.data[index],
                                      ));
                                });
                          }),
                    ),
                  Container(
                    margin: EdgeInsets.only(left: 12, right: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "   Dependencias",
                          style: kAppTheme.textTheme.headline5,
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "Sobre nosotros",
                              style: kAppTheme.textTheme.headline6,
                            ))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(16),
                    child: StreamBuilder<List<DependenciaModel>>(
                        stream: homepagestate
                            .getAllDependencias(textControllerBusqueda.text)
                            .asStream(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container(
                                alignment: Alignment.center,
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator());
                          } else if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.data.length > 0) {
                            return GridView.builder(
                                itemCount: snapshot.data.length,
                                shrinkWrap: true,
                                primary: false,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 16,
                                        crossAxisSpacing: 16,
                                        crossAxisCount: 2),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ViewDetails(
                                              dependencia: snapshot.data[index],
                                            ),
                                          ),
                                        );
                                        return Container();
                                      },
                                      child: areaCard(snapshot.data[index]));
                                });
                          } else if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.data.length == 0 &&
                              textControllerBusqueda.text.length > 0) {
                            return Text('No se encontro esa dependencia');
                          } else {
                            return Container();
                          }
                        }),
                  ),
                ],
              ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.home_rounded,
                                    size: 36,
                                    color: (textControllerBusqueda.text.length>0) ? FlutterFlowTheme.of(context)
                                          .primaryColor.withOpacity(0.35):FlutterFlowTheme.of(context)
                                          .primaryColor
                                          ),
                                onPressed: () => Get.toNamed("/home"),
                              ),
                              IconButton(
                                icon: Icon(Icons.calendar_today_rounded,
                                    size: 36,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryColor
                                        .withOpacity(0.35)),
                                onPressed: () => Get.toNamed("/calendario"),
                              ),
                              IconButton(
                                  icon: Icon(Icons.search,
                                      size: 36,
                                      color:(textControllerBusqueda.text.length>0) ? FlutterFlowTheme.of(context)
                                          .primaryColor:FlutterFlowTheme.of(context)
                                          .primaryColor
                                          .withOpacity(0.35)),
                                  onPressed: () {
                                    setState(() {
                                      mostrarBusqueda = true;
                                      _focusNodeBusqeda.requestFocus();
                                    });
                                  }),
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
    );
  }
}
