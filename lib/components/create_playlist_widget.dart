import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreatePlaylistWidget extends StatefulWidget {
  CreatePlaylistWidget({
    Key key,
    this.userData,
  }) : super(key: key);

  final dynamic userData;

  @override
  _CreatePlaylistWidgetState createState() => _CreatePlaylistWidgetState();
}

class _CreatePlaylistWidgetState extends State<CreatePlaylistWidget> {
  TextEditingController descController;
  TextEditingController playlistNameController;
  bool _loadingButton = false;
  dynamic createPlaylistResult;

  @override
  void initState() {
    super.initState();
    descController = TextEditingController();
    playlistNameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 5),
          child: TextFormField(
            controller: playlistNameController,
            obscureText: false,
            decoration: InputDecoration(
              hintText: 'Playlist Name',
              hintStyle: FlutterFlowTheme.bodyText1,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF838383),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF838383),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            style: FlutterFlowTheme.bodyText1,
            keyboardType: TextInputType.name,
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 5),
          child: TextFormField(
            controller: descController,
            obscureText: false,
            decoration: InputDecoration(
              hintText: 'Description',
              hintStyle: FlutterFlowTheme.bodyText1,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF838383),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF838383),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            style: FlutterFlowTheme.bodyText1,
            maxLines: 5,
            keyboardType: TextInputType.multiline,
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
          child: FFButtonWidget(
            onPressed: () async {
              setState(() => _loadingButton = true);
              try {
                createPlaylistResult = await createPlaylistCall(
                  name: playlistNameController.text,
                  desc: descController.text,
                  userid: getJsonField(widget.userData, r'''$.id''').toString(),
                  key: getJsonField(widget.userData, r'''$.key''').toString(),
                );
                if (getJsonField(createPlaylistResult, r'''$.status''')) {
                  Navigator.pop(context);
                }

                setState(() {});
              } finally {
                setState(() => _loadingButton = false);
              }
            },
            text: 'CREATE',
            options: FFButtonOptions(
              width: 130,
              height: 40,
              color: FlutterFlowTheme.primaryColor,
              textStyle: FlutterFlowTheme.subtitle2.override(
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
              borderRadius: 12,
            ),
            loading: _loadingButton,
          ),
        )
      ],
    );
  }
}
