import '../flutter_flow/flutter_flow_audio_player.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlaylistPageWidget extends StatefulWidget {
  PlaylistPageWidget({
    Key key,
    this.playlistDetails,
  }) : super(key: key);

  final dynamic playlistDetails;

  @override
  _PlaylistPageWidgetState createState() => _PlaylistPageWidgetState();
}

class _PlaylistPageWidgetState extends State<PlaylistPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.primaryColor,
        automaticallyImplyLeading: true,
        title: Text(
          'Search Results',
          style: FlutterFlowTheme.subtitle1.override(
            fontFamily: 'Poppins',
            color: Colors.white,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Builder(
            builder: (context) {
              final playlistTile =
                  getJsonField(widget.playlistDetails, r'''$''')?.toList() ??
                      [];
              return ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount: playlistTile.length,
                itemBuilder: (context, playlistTileIndex) {
                  final playlistTileItem = playlistTile[playlistTileIndex];
                  return Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                    child: Container(
                      width: 200,
                      height: 370,
                      decoration: BoxDecoration(
                        color: Color(0xFFF1F1F1),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 300,
                            decoration: BoxDecoration(
                              color: Color(0x00EEEEEE),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Stack(
                                alignment: AlignmentDirectional(
                                    -0.050000000000000044, 1),
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network(
                                      getJsonField(
                                          playlistTileItem, r'''$.art'''),
                                      width: MediaQuery.of(context).size.width,
                                      height: 300,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  FlutterFlowAudioPlayer(
                                    audio: Audio.network(
                                      'https://afrojam.com.au/${getJsonField(playlistTileItem, r'''$.track.track_file''').toString()}',
                                      metas: Metas(
                                        id: 'df3hg_-o9y9geqm',
                                      ),
                                    ),
                                    titleTextStyle:
                                        FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
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
                                    elevation: 4,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFFEEEEEE),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(2, 2, 2, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 2, 0, 5),
                                    child: Text(
                                      getJsonField(
                                              playlistTileItem, r'''$.name''')
                                          .toString(),
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        getJsonField(playlistTileItem,
                                                r'''$.total_tracks''')
                                            .toString(),
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        ' Tracks | ',
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        getJsonField(playlistTileItem,
                                                r'''$.user.full_name''')
                                            .toString(),
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
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
          ),
        ),
      ),
    );
  }
}
