import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../home_page/home_page_widget.dart';
import '../sign_up_page/sign_up_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPageWidget extends StatefulWidget {
  LoginPageWidget({Key key}) : super(key: key);

  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  TextEditingController _passwordController = TextEditingController(text: "");
  bool passwordVisibility;
  TextEditingController _usernameController = TextEditingController(text: "");
  bool _loadingButton = false;
  dynamic loginResult;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _storage = new FlutterSecureStorage();


  Future<void> _readFromStorage()async {
    _usernameController.text = await _storage.read(key: "KEY_USERNAME") ?? "";
    _passwordController.text = await _storage.read(key: "KEY_PASSWORD") ?? "";
    try {
      loginResult = await authLoginCall(
        username: _usernameController.text,
        password: _passwordController.text,
      );
      if (getJsonField(loginResult, r'''$.status''')==1) {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePageWidget(
              userData: loginResult,
            ),
          ),
        );
      }

      setState(() {});
    } finally {
      setState(() => _loadingButton = false);
    }

  }

  @override
  void initState() {
    super.initState();
    _readFromStorage();
    passwordVisibility = false;
  }

  final _formkey = GlobalKey<FormState>();

  String _validateName(String value) {
    if (value.isEmpty)
      return 'This is required';
  }
  String _validatePassword(String value) {
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    if (value == null || value.isEmpty || !regExp.hasMatch(value))
      return 'Incorrect password';
  }

  @override
  Widget build(BuildContext context) {

    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF5F5F5),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 1,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
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
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset(
                    'assets/images/Assets-1-01.png',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.85,
                    fit: BoxFit.cover,
                  ),
                  Align(
                    alignment: AlignmentDirectional(-0.7, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                      child: FFButtonWidget(
                        onPressed: () async {
                         if(_formkey.currentState.validate()){
                           setState(() => _loadingButton = true);
                           await _storage.write(key: "KEY_USERNAME", value:
                           _usernameController.text);
                           await _storage.write(key: "KEY_PASSWORD", value:
                           _passwordController.text);
                           try {
                             loginResult = await authLoginCall(
                               username: _usernameController.text,
                               password: _passwordController.text,
                             );
                             if (getJsonField(loginResult, r'''$.status''')==1) {
                               await Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                   builder: (context) => HomePageWidget(
                                     userData: loginResult,
                                   ),
                                 ),
                               );
                             }

                             setState(() {});
                           } finally {
                             setState(() => _loadingButton = false);
                           }
                         }

                        },
                        text: 'LOGIN',
                        options: FFButtonOptions(
                          width: 170,
                          height: 45,
                          color: Colors.black,
                          textStyle: FlutterFlowTheme.subtitle2.override(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: 55,
                        ),
                        loading: _loadingButton,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Image.asset(
              'assets/images/Assets-1-02.png',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.85,
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.85,
                decoration: BoxDecoration(
                  color: Color(0x00EEEEEE),
                ),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, h*0.1, 0, 50),
                        child: Image.asset(
                          'assets/images/Assets-1-05.png',
                          height: h*0.3,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: 73,
                          child: Stack(
                            children: [
                              Image.asset(
                                'assets/images/Assets-1-03.png',
                                width: MediaQuery.of(context).size.width * 0.7,
                                height: 50,
                                fit: BoxFit.contain,
                              ),
                              TextFormField(
                                controller: _usernameController,
                                obscureText: false,
                                validator: _validateName,
                                decoration: InputDecoration(
                                  hintText: 'USERNAME',
                                  hintStyle: FlutterFlowTheme.subtitle1.override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.tertiaryColor,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0x00000000), width: 1,),),
                                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0x00000000), width: 1,),),
                                  focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0x00000000), width: 1,),),
                                  errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0x00000000), width: 1,),),
                                ),
                                style: FlutterFlowTheme.subtitle1.override(
                                  fontFamily: 'Poppins',
                                  color: FlutterFlowTheme.tertiaryColor,
                                  fontWeight: FontWeight.normal,
                                ),
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.name,
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: 73,
                          child: Stack(
                            children: [
                              Image.asset(
                                'assets/images/Assets-1-03.png',
                                width: MediaQuery.of(context).size.width * 0.7,
                                height: 50,
                                fit: BoxFit.contain,
                              ),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: !passwordVisibility,
                                validator: _validatePassword,
                                decoration: InputDecoration(
                                  hintText: 'PASSWORD',
                                  hintStyle: FlutterFlowTheme.subtitle1.override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.tertiaryColor,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0x00000000), width: 1,),),
                                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0x00000000), width: 1,),),
                                  focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0x00000000), width: 1,),),
                                  errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0x00000000), width: 1,),),
                                  prefixIcon: Icon(
                                    Icons.ten_k,
                                    color: Colors.transparent,
                                  ),
                                  suffixIcon: InkWell(
                                    onTap: () => setState(
                                      () => passwordVisibility =
                                          !passwordVisibility,
                                    ),
                                    child: Icon(
                                      passwordVisibility
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: Color(0xFF757575),
                                      size: 20,
                                    ),
                                  ),
                                ),
                                style: FlutterFlowTheme.subtitle1.override(
                                  fontFamily: 'Poppins',
                                  color: FlutterFlowTheme.tertiaryColor,
                                  fontWeight: FontWeight.normal,
                                ),
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.visiblePassword,
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(100, 10, 0, 0),
                        child: Text(
                          //'FORGOT PASSWORD?',
                          '',
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 50),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                              child: Text(
                                'Don\'t have an account?',
                                style: FlutterFlowTheme.bodyText2.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpPageWidget(),
                                  ),
                                );
                              },
                              child: Text(
                                'Sign Up',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFFFFCE00),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      // Text(
                      //   getJsonField(loginResult, r'''$.status''').toString(),
                      //   style: FlutterFlowTheme.bodyText1.override(
                      //     fontFamily: 'Poppins',
                      //     color: Color(0xFFFF4700),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
