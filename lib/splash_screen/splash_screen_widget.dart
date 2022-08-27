import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../login_page/login_page_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreenWidget extends StatefulWidget {
  SplashScreenWidget({Key key}) : super(key: key);

  @override
  _SplashScreenWidgetState createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget> {
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF5F5F5),
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              )
            ],
          ),
          Image.asset(
            'assets/images/Assets-1-01.png',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.85,
            fit: BoxFit.cover,
          ),
          Image.asset(
            'assets/images/Assets-1-02.png',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.85,
            fit: BoxFit.cover,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              color: Color(0x00EEEEEE),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'assets/images/Assets-1-05.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0x00EEEEEE),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.35,
                  decoration: BoxDecoration(
                    color: Color(0x00EEEEEE),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.35,
                        decoration: BoxDecoration(
                          color: Color(0x00EEEEEE),
                        ),
                        child: AutoSizeText(
                          'Music is The Best Strongest Form of Magic',
                          textAlign: TextAlign.start,
                          style: GoogleFonts.getFont(
                            'Roboto',
                            color: Colors.white,
                            fontSize: 41,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.35,
                        decoration: BoxDecoration(
                          color: Color(0x00EEEEEE),
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-0.7, -0.6),
                  child: FFButtonWidget(
                    onPressed: () async {
                      setState(() => _loadingButton = true);
                      try {
                        await Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 300),
                            reverseDuration: Duration(milliseconds: 300),
                            child: LoginPageWidget(),
                          ),
                          (r) => false,
                        );
                      } finally {
                        setState(() => _loadingButton = false);
                      }
                    },
                    text: 'START',
                    options: FFButtonOptions(
                      width: 200,
                      height: 50,
                      color: Colors.black,
                      textStyle: FlutterFlowTheme.subtitle2.override(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 0,
                      ),
                      borderRadius: 55,
                    ),
                    loading: _loadingButton,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
