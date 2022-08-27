import '../backend/api_requests/api_calls.dart';
import '../components/select_playlist_widget.dart';
import '../flutter_flow/flutter_flow_audio_player.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class SongPageWidget extends StatefulWidget {
  SongPageWidget({
    Key key,
    this.id,
    this.userData,
  }) : super(key: key);

  final String id;
  final dynamic userData;

  @override
  _SongPageWidgetState createState() => _SongPageWidgetState();
}

class _SongPageWidgetState extends State<SongPageWidget> {
  TextEditingController commentTextFieldController;
  bool _loadingButton4 = false;
  bool _loadingButton1 = false;
  bool _loadingButton2 = false;
  bool _loadingButton3 = false;
  dynamic trackRef;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    commentTextFieldController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: getTrackDetailsCall(
        id: widget.id,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Image.asset
            ('assets/images/loading.gif',
            height: 40,);
        }
        final songPageGetTrackDetailsResponse = snapshot.data;
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Stack(
                        alignment: AlignmentDirectional(0, -1),
                        children: [
                          CachedNetworkImage(
                            imageUrl: getJsonField(
                                songPageGetTrackDetailsResponse, r'''$.art'''),
                            width: MediaQuery.of(context).size.width,
                            height: 400,
                            fit: BoxFit.cover,
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 0.85),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 300, 0, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(0),
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                alignment: AlignmentDirectional(0, 1),
                                child: FlutterFlowAudioPlayer(
                                  audio: Audio.network(
                                    'https://afrojam.com.au/${getJsonField(songPageGetTrackDetailsResponse, r'''$.track_file''').toString()}',
                                    metas: Metas(
                                      id: 'df3hg_-uw5tts2g',
                                    ),
                                  ),
                                  titleTextStyle:
                                      FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                        color: Colors.white
                                  ),
                                  playbackDurationTextStyle:
                                      FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF9D9D9D),
                                    fontSize: 12,
                                  ),
                                  fillColor: Color(0x00EEEEEE),
                                  playbackButtonColor:
                                      FlutterFlowTheme.primaryColor,
                                  activeTrackColor: Color(0xFF57636C),
                                  elevation: 0,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 34, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12, 0, 0, 0),
                                    child: FlutterFlowIconButton(
                                      borderColor: Colors.transparent,
                                      borderRadius: 30,
                                      buttonSize: 48,
                                      icon: Icon(
                                        Icons.arrow_back_rounded,
                                        color: Colors.deepOrange,
                                        size: 30,
                                      ),
                                      onPressed: () async {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Color(0x00EEEEEE),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'By ',
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text(
                          getJsonField(songPageGetTrackDetailsResponse,
                                  r'''$.user.full_name''')
                              .toString(),
                          style: TextStyle(color: Colors.white70),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0x00EEEEEE),
                    ),
                    alignment: AlignmentDirectional(-1, 0.19999999999999996),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 5, 5),
                      child: Container(
                        width: 100,
                        height: 100,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://picsum.photos/seed/96/600',
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0x00EEEEEE),
                    ),
                    alignment: AlignmentDirectional(-1, 0.19999999999999996),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FFButtonWidget(
                          onPressed: () async {
                            setState(() => _loadingButton1 = true);
                            try {
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.5,
                                    child: SelectPlaylistWidget(
                                      userData: widget.userData,
                                      trackid: widget.id,
                                    ),
                                  );
                                },
                              );
                            } finally {
                              setState(() => _loadingButton1 = false);
                            }
                          },
                          text: 'Add to Playlist',
                          icon: Icon(
                            Icons.add_circle,
                            color: Colors.black,
                            size: 15,
                          ),

                          options: FFButtonOptions(
                            width: 150,
                            height: 40,
                            color: Colors.deepOrange,
                            textStyle: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                            borderSide: BorderSide(
                              color: Colors.deepOrange[900],
                              width: 1,
                            ),
                            borderRadius: 50,
                          ),
                          loading: _loadingButton1,
                        ),
                        FFButtonWidget(
                          onPressed: () async {
                            setState(() => _loadingButton2 = true);
                            try {
                              await Share.share(getJsonField(
                                      songPageGetTrackDetailsResponse,
                                      r'''$.link''')
                                  .toString());
                            } finally {
                              setState(() => _loadingButton2 = false);
                            }
                          },
                          text: 'Share',
                          options: FFButtonOptions(
                            width: 85,
                            height: 40,
                            color: Colors.deepOrange,
                            textStyle: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                            borderSide: BorderSide(
                              color: Colors.deepOrange[900],
                              width: 1,
                            ),
                            borderRadius: 50,
                          ),
                          loading: _loadingButton2,
                        ),
                        FFButtonWidget(
                          onPressed: () async {
                            setState(() => _loadingButton3 = true);
                            try {
                              trackRef = await downloadTrackCall(
                                id: widget.id,
                              );
                              await launchURL(
                                  getJsonField(trackRef, r'''$.url''')
                                      .toString());

                              setState(() {});
                            } finally {
                              setState(() => _loadingButton3 = false);
                            }
                          },
                          text: '',
                          icon: Icon(
                            Icons.cloud_download_outlined,
                            color: Colors.black,
                            size: 16,
                          ),
                          options: FFButtonOptions(
                            width: 40,
                            height: 40,
                            color: Colors.deepOrange,
                            textStyle: FlutterFlowTheme.subtitle2.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                            borderSide: BorderSide(
                              color: Colors.deepOrange[900],
                              width: 1,
                            ),
                            borderRadius: 50,
                          ),
                          loading: _loadingButton3,
                        )
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.white30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0x00EEEEEE),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 5, 0, 0),
                    child: Text(
                      getJsonField(
                              songPageGetTrackDetailsResponse, r'''$.tag''')
                          .toString(),
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        color: Colors.white70
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                      child: Text(
                        'Comments',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          color: Colors.white70
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.white30,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 110,
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              getJsonField(widget.userData, r'''$.avatar'''),
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: 280,
                                height: 70,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white30,
                                  ),
                                ),
                                child: TextFormField(
                                  controller: commentTextFieldController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'Write something...',
                                    hintStyle: TextStyle(color: Colors.white70),
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
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 0, 0),
                                  ),
                                  style: TextStyle(color: Colors.white70),
                                  keyboardType: TextInputType.multiline,
                                ),
                              ),
                              FFButtonWidget(
                                onPressed: () async {
                                  setState(() => _loadingButton4 = true);
                                  try {
                                    await addCommentCall(
                                      key: getJsonField(
                                              widget.userData, r'''$.key''')
                                          .toString(),
                                      userid: getJsonField(
                                              widget.userData, r'''$.id''')
                                          .toString(),
                                      trackId: widget.id,
                                      message: commentTextFieldController.text,
                                    );
                                  } finally {
                                    setState(() => _loadingButton4 = false);
                                  }
                                },
                                text: 'Post comment',
                                options: FFButtonOptions(
                                  width: 130,
                                  height: 35,
                                  color: FlutterFlowTheme.primaryColor,
                                  textStyle:
                                      FlutterFlowTheme.bodyText2.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: 12,
                                ),
                                loading: _loadingButton4,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    color: Color(0x00EEEEEE),
                  ),
                  child: FutureBuilder<dynamic>(
                    future: getCommentsCall(
                      typeId: widget.id,
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
                      final listViewGetCommentsResponse = snapshot.data;
                      return Builder(
                        builder: (context) {
                          final comment = getJsonField(
                                      listViewGetCommentsResponse, r'''$''')
                                  ?.toList() ??
                              [];
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            itemCount: comment.length,
                            itemBuilder: (context, commentIndex) {
                              final commentItem = comment[commentIndex];
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Divider(
                                    thickness: 1,
                                    color: Colors.white30,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 5, 0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.network(
                                            getJsonField(commentItem,
                                                r'''$.user.avatar'''),
                                            width: 60,
                                            height: 60,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.55,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: Color(0x00EEEEEE),
                                        ),
                                        alignment: AlignmentDirectional(
                                            -1, -0.050000000000000044),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5, 5, 0, 5),
                                              child: Text(
                                                getJsonField(commentItem,
                                                        r'''$.user.username''')
                                                    .toString(),
                                                style: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 12,
                                                  color: Colors.white
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5
                                                  ),
                                              child: Text(
                                                getJsonField(commentItem,
                                                        r'''$.message''')
                                                    .toString(),
                                                style: TextStyle(color: Colors
                                                    .white)
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: Colors
                                                      .white70,
                                                  fontSize: 10,

                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            getJsonField(
                                                    commentItem, r'''$.time''')
                                                .toString(),
                                            style: TextStyle(color: Colors
                                                .white70,fontSize: 10),
                                          ),
                                          Visibility(
                                            visible: (commentIndex) ==
                                                (getJsonField(widget.userData,
                                                    r'''$.id''')),
                                            child: FlutterFlowIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 30,
                                              borderWidth: 1,
                                              buttonSize: 60,
                                              icon: Icon(
                                                Icons.delete_outline,
                                                color: Color(0xFF838383),
                                                size: 25,
                                              ),
                                              onPressed: () async {
                                                await deleteCommentCall(
                                                  key: getJsonField(
                                                          widget.userData,
                                                          r'''$.key''')
                                                      .toString(),
                                                  userid: getJsonField(
                                                          widget.userData,
                                                          r'''$.id''')
                                                      .toString(),
                                                  commentid: getJsonField(
                                                          commentItem,
                                                          r'''$.id''')
                                                      .toString(),
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
