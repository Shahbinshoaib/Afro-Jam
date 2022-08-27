import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_audio_player.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class ProfilePageWidget extends StatefulWidget {
  ProfilePageWidget({
    Key key,
    this.userData,
  }) : super(key: key);

  final dynamic userData;

  @override
  _ProfilePageWidgetState createState() => _ProfilePageWidgetState();
}

class _ProfilePageWidgetState extends State<ProfilePageWidget> {
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                color: Color(0xFFFF4700),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: AlignmentDirectional(0.15, -0.05),
                          child: Stack(
                            alignment: AlignmentDirectional(0, -1),
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Image.network(
                                  getJsonField(widget.userData, r'''$.cover'''),
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 100, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 10, 0),
                                      child: Card(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        color: Colors.black,
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  1, 1, 1, 1),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.network(
                                              getJsonField(widget.userData,
                                                  r'''$.avatar'''),
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          getJsonField(widget.userData,
                                                  r'''$.full_name''')
                                              .toString(),
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Roboto Condensed',
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 5, 0, 0),
                                          child: FutureBuilder<dynamic>(
                                            future: getFollowersCall(
                                              theuserid: getJsonField(
                                                      widget.userData,
                                                      r'''$.id''')
                                                  .toString(),
                                            ),
                                            builder: (context, snapshot) {
                                              // Customize what your widget looks like when it's loading.
                                              if (!snapshot.hasData) {
                                                return Center(
                                                  child: SizedBox(
                                                    width: 50,
                                                    height: 50,
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Color(0xFFFF4700),
                                                    ),
                                                  ),
                                                );
                                              }
                                              final textGetFollowersResponse =
                                                  snapshot.data;
                                              return Text(
                                                getJsonField(
                                                        textGetFollowersResponse,
                                                        r'''$.email''')
                                                    .toString(),
                                                style: FlutterFlowTheme
                                                    .bodyText1
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * 1,
                                decoration: BoxDecoration(),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.05, 0.1),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 80, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FFButtonWidget(
                                        onPressed: () async {
                                          setState(() => _loadingButton = true);
                                          try {
                                            await Share.share(getJsonField(
                                                    widget.userData,
                                                    r'''$.link''')
                                                .toString());
                                          } finally {
                                            setState(
                                                () => _loadingButton = false);
                                          }
                                        },
                                        text: 'Share',
                                        options: FFButtonOptions(
                                          width: 75,
                                          height: 40,
                                          color: Colors.deepOrange,
                                          textStyle: FlutterFlowTheme.subtitle2
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          elevation: 5,
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                          ),
                                          borderRadius: 55,
                                        ),
                                        loading: _loadingButton,
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 10, 0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            await launchURL(
                                                'https://afrojam.com.au/?p=settings');
                                          },
                                          text: '',
                                          icon: FaIcon(
                                            FontAwesomeIcons.edit,
                                            size: 15,
                                          ),
                                          options: FFButtonOptions(
                                            width: 40,
                                            height: 40,
                                            color: Colors.deepOrange,
                                            textStyle: FlutterFlowTheme
                                                .subtitle2
                                                .override(
                                              fontFamily: 'Poppins',
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            elevation: 5,
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius: 55,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.333,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Color(0x00EEEEEE),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                              child: Text(
                                'Followers',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            FutureBuilder<dynamic>(
                              future: getFollowersCall(
                                theuserid:
                                    getJsonField(widget.userData, r'''$.id''')
                                        .toString(),
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: CircularProgressIndicator(
                                        color: Colors.deepOrange,
                                      ),
                                    ),
                                  );
                                }
                                final List textGetFollowersResponse = snapshot.data;
                                return Text(
                                  '${getJsonField(textGetFollowersResponse.length, r'''$''').toString()}',
                                  style: TextStyle(color: Colors.white70),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.333,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Color(0x00EEEEEE),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                              child: Text(
                                'Following',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Text(
                              getJsonField(
                                      widget.userData, r'''$.is_following''')
                                  .toString(),
                              style: TextStyle(color: Colors.white70),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.33,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Color(0x00EEEEEE),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                              child: Text(
                                'Tracks',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            FutureBuilder<dynamic>(
                              future: getTracksCall(),
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
                                final List textGetTracksResponse = snapshot.data;
                               // textGetTracksResponse = textGetTracksResponse.
                                return Text(
                                  '${getJsonField(textGetTracksResponse.length, r'''$''').toString()}',
                                  style: TextStyle(color: Colors.white70),
                                );
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: Text(
                      'My Playlists',
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.title3.override(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.42,
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
                      child: FutureBuilder<dynamic>(
                        future: myPlaylistCall(
                          userid: getJsonField(widget.userData, r'''$.id''')
                              .toString(),
                        ),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return  Image.asset
                              ('assets/images/loading.gif',
                              height: 40,);
                          }
                          final listViewMyPlaylistResponse = snapshot.data;
                          return Builder(
                            builder: (context) {
                              final playlist = getJsonField(
                                          listViewMyPlaylistResponse, r'''$''')
                                      ?.toList() ??
                                  [];
                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.horizontal,
                                itemCount: playlist.length,
                                itemBuilder: (context, playlistIndex) {
                                  final playlistItem = playlist[playlistIndex];
                                  return Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 10, 10, 10),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.25,
                                            decoration: BoxDecoration(
                                              color: Color(0x00EEEEEE),
                                            ),
                                            child: Align(
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: Stack(
                                                alignment: AlignmentDirectional(
                                                    -0.050000000000000044, 1),
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    child: Image.network(
                                                      getJsonField(playlistItem,
                                                          r'''$.art'''),
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height: 300,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  FlutterFlowAudioPlayer(
                                                    audio: Audio.network(
                                                      'https://afrojam.com.au/${getJsonField(playlistItem, r'''$.track_file''').toString()}',
                                                      metas: Metas(
                                                        id: 'df3hg_-oix1jeak',
                                                      ),
                                                    ),
                                                    titleTextStyle:
                                                        FlutterFlowTheme
                                                            .bodyText1
                                                            .override(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                    playbackDurationTextStyle:
                                                        FlutterFlowTheme
                                                            .bodyText1
                                                            .override(
                                                      fontFamily: 'Poppins',
                                                      color: Color(0xFF9D9D9D),
                                                      fontSize: 12,
                                                    ),
                                                    fillColor:
                                                        Color(0x00EEEEEE),
                                                    playbackButtonColor:
                                                        FlutterFlowTheme
                                                            .primaryColor,
                                                    activeTrackColor:
                                                        Color(0xFF57636C),
                                                    elevation: 4,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.1,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFEEEEEE),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(2, 2, 2, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 2, 0, 5),
                                                    child: Text(
                                                      getJsonField(playlistItem,
                                                              r'''$.name''')
                                                          .toString(),
                                                      style: FlutterFlowTheme
                                                          .bodyText1
                                                          .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        getJsonField(
                                                                playlistItem,
                                                                r'''$.total_tracks''')
                                                            .toString(),
                                                        style: FlutterFlowTheme
                                                            .bodyText1
                                                            .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      Text(
                                                        ' Tracks | ',
                                                        style: FlutterFlowTheme
                                                            .bodyText1
                                                            .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      Text(
                                                        getJsonField(
                                                                playlistItem,
                                                                r'''$.user.full_name''')
                                                            .toString(),
                                                        style: FlutterFlowTheme
                                                            .bodyText1
                                                            .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 12,
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
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
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
