import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../home_page/home_page_widget.dart';
import '../login_page/login_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPageWidget extends StatefulWidget {
  SignUpPageWidget({Key key}) : super(key: key);

  @override
  _SignUpPageWidgetState createState() => _SignUpPageWidgetState();
}

class _SignUpPageWidgetState extends State<SignUpPageWidget> {
  TextEditingController confirmPassController;
  bool confirmPassVisibility;
  TextEditingController emailController;
  TextEditingController fullnameController;
  TextEditingController _usernameController = TextEditingController(text: "");
  TextEditingController _passwordController = TextEditingController(text: "");
  bool passwordVisibility;
  bool _loadingButton = false;
  dynamic signupResult;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    confirmPassController = TextEditingController();
    confirmPassVisibility = false;
    emailController = TextEditingController();
    fullnameController = TextEditingController();
    passwordVisibility = false;
  }


  final _formkey = GlobalKey<FormState>();

  String _validateName(String value) {
    if (value.isEmpty)
      return 'This is required';
  }
  String _validateUsername(String value) {
    if (value.length < 8)
      return 'Must be unique';
  }
  String _validateEmail(String value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value))
      return 'Enter a valid email address';
    else
      return null;
  }
  String _validatePassword(String value) {
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    if (value == null || value.isEmpty || !regExp.hasMatch(value))
      return 'Must use a capital letter, numeric & symbol';
  }
  String _validateConfirmPassword(String value) {
    if (value != _passwordController.text)
      return 'Password does not match';
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
        child: SingleChildScrollView(
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
              Column(
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
                             signupResult = await authSignupCall(
                               username: _usernameController.text,
                               fullName: fullnameController.text,
                               email: emailController.text,
                               password: _passwordController.text,
                             );
                             if (getJsonField(signupResult, r'''$.status''') == 1) {
                               print(getJsonField(signupResult, r'''$.status'''));
                               await Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                   builder: (context) => HomePageWidget(
                                     userData: signupResult,
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
                        text: 'SIGNUP',
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
              Image.asset(
                'assets/images/Assets-1-02.png',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.85,
                fit: BoxFit.cover,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.9,
                child: SingleChildScrollView(
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/Assets-1-05.png',
                          height: h*0.25,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 10,),
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
                                  controller: fullnameController,
                                  obscureText: false,
                                  validator: _validateName,
                                  decoration: InputDecoration(
                                    hintText: 'FULLNAME',
                                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0x00000000), width: 1,),),
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0x00000000), width: 1,),),
                                    focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0x00000000), width: 1,),),
                                    errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0x00000000), width: 1,),),
                                    hintStyle: FlutterFlowTheme.subtitle1.override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.tertiaryColor,
                                      fontWeight: FontWeight.normal,
                                    ),
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
                                  controller: _usernameController,
                                  obscureText: false,
                                  validator: _validateUsername,
                                  decoration: InputDecoration(
                                    hintText: 'USERNAME',
                                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0x00000000), width: 1,),),
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0x00000000), width: 1,),),
                                    focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0x00000000), width: 1,),),
                                    errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0x00000000), width: 1,),),
                                    hintStyle: FlutterFlowTheme.subtitle1.override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.tertiaryColor,
                                      fontWeight: FontWeight.normal,
                                    ),
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
                                  controller: emailController,
                                  obscureText: false,
                                  validator: _validateEmail,
                                  decoration: InputDecoration(
                                    hintText: 'EMAIL ADDRESS',
                                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0x00000000), width: 1,),),
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0x00000000), width: 1,),),
                                    focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0x00000000), width: 1,),),
                                    errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0x00000000), width: 1,),),
                                    hintStyle: FlutterFlowTheme.subtitle1.override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.tertiaryColor,
                                      fontWeight: FontWeight.normal,
                                    ),

                                  ),
                                  style: FlutterFlowTheme.subtitle1.override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.tertiaryColor,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.emailAddress,
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
                                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0x00000000), width: 1,),),
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0x00000000), width: 1,),),
                                    focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0x00000000), width: 1,),),
                                    errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0x00000000), width: 1,),),
                                    hintStyle: FlutterFlowTheme.subtitle1.override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.tertiaryColor,
                                      fontWeight: FontWeight.normal,
                                    ),

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
                                        size: 22,
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
                                  controller: confirmPassController,
                                  obscureText: !confirmPassVisibility,
                                  validator: _validateConfirmPassword,
                                  decoration: InputDecoration(
                                    hintText: 'PASSWORD',
                                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0x00000000), width: 1,),),
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0x00000000), width: 1,),),
                                    focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0x00000000), width: 1,),),
                                    errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0x00000000), width: 1,),),
                                    hintStyle: FlutterFlowTheme.subtitle1.override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.tertiaryColor,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.ten_k,
                                      color: Colors.transparent,
                                    ),
                                    suffixIcon: InkWell(
                                      onTap: () => setState(
                                        () => confirmPassVisibility =
                                            !confirmPassVisibility,
                                      ),
                                      child: Icon(
                                        confirmPassVisibility
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
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 20),
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
                                      builder: (context) => LoginPageWidget(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Login',
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
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
