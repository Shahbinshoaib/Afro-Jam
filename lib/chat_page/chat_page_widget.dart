import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatPageWidget extends StatefulWidget {
  ChatPageWidget({
    Key key,
    this.chatID,
    this.userData,
    this.personID,
  }) : super(key: key);

  final String chatID;
  final dynamic userData;
  final String personID;

  @override
  _ChatPageWidgetState createState() => _ChatPageWidgetState();
}

class _ChatPageWidgetState extends State<ChatPageWidget> {
  TextEditingController textController;
  dynamic messageStatus;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFFFF4700),
        automaticallyImplyLeading: true,
        title: Text(
          'Chat',
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: FutureBuilder<dynamic>(
              future: getChatCall(
                cid: widget.chatID,
                key: getJsonField(widget.userData, r'''$.key''').toString(),
                userid: getJsonField(widget.userData, r'''$.id''').toString(),
              ),
              builder: (context, snapshot) {
                // Customize what your widget looks like when it's loading.
                if (!snapshot.hasData) {
                  return Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        color: Color(0xFFFF4700),
                      ),
                    ),
                  );
                }
                final listViewGetChatResponse = snapshot.data;
                return Builder(
                  builder: (context) {
                    final message =
                        getJsonField(listViewGetChatResponse, r'''$''')
                                ?.toList() ??
                            [];
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: message.length,
                      itemBuilder: (context, messageIndex) {
                        final messageItem = message[messageIndex];
                        return Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: getJsonField(messageItem, r'''$.user.id''') == getJsonField(widget.userData, r'''$.id''') ?
                              MainAxisAlignment.end : MainAxisAlignment.start,
                              children: [
                                getJsonField(messageItem, r'''$.user.id''') == getJsonField(widget.userData, r'''$.id''') ? Container() :
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      getJsonField(
                                          messageItem, r'''$.avatar'''),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15, 0, 0, 5),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 10, 10, 0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: getJsonField(messageItem, r'''$.user.id''') == getJsonField(widget.userData, r'''$.id''') ? Colors.grey[200] : Color(0xFFFF3F00),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(-1, 0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 10, 10, 10),
                                              child: Text(
                                                getJsonField(messageItem,
                                                        r'''$.message''')
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: FlutterFlowTheme
                                                    .bodyText1
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: getJsonField(messageItem, r'''$.user.id''') == getJsonField(widget.userData, r'''$.id''') ? Color(0xFFFF3F00) : Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Padding(
                                      //   padding: EdgeInsetsDirectional.fromSTEB(
                                      //       0, 2, 0, 0),
                                      //   child: Text(
                                      //     getJsonField(
                                      //             messageItem, r'''$.time''')
                                      //         .toString(),
                                      //     style: FlutterFlowTheme.bodyText1
                                      //         .override(
                                      //       fontFamily: 'Poppins',
                                      //       fontSize: 10,
                                      //     ),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ),
                                getJsonField(messageItem, r'''$.user.id''') == getJsonField(widget.userData, r'''$.id''') ?
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 10, 0),
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      getJsonField(
                                          messageItem, r'''$.avatar'''),
                                    ),
                                  ),
                                ) : Container(),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: TextFormField(
                      controller: textController,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'Enter a message...',
                        hintStyle: FlutterFlowTheme.bodyText1,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                      ),
                      style: FlutterFlowTheme.bodyText1,
                    ),
                  ),
                ),
                FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30,
                  borderWidth: 1,
                  buttonSize: 60,
                  icon: Icon(
                    Icons.send,
                    color: Color(0xFFFF4700),
                    size: 30,
                  ),
                  onPressed: () async {
                    messageStatus = await sendMessageCall(
                      toID: widget.personID,
                      key: getJsonField(widget.userData, r'''$.key''')
                          .toString(),
                      userid:
                          getJsonField(widget.userData, r'''$.id''').toString(),
                      text: textController.text,
                    );
                    textController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Message sent!',
                            style: TextStyle(),
                          ),
                          duration: Duration(milliseconds: 4000),
                          backgroundColor: Colors.black54,
                        ),
                      );


                    setState(() {});
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
