import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karama/features/profile/presentation/bloc/bloc/my_feed_bloc.dart';
import 'package:karama/features/requests/domain/entities/request.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/util/snackbar_message.dart';
import '../../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../feeds/domain/entities/feed.dart';
import '../../../requests/presentation/bloc/editeRequest/bloc/edit_request_bloc.dart';

class ViewMyFeedBottomSheet extends StatefulWidget {
  final Feed feed;
  const ViewMyFeedBottomSheet({Key? key, required this.feed}) : super(key: key);

  @override
  _ViewMyFeedBottomSheetState createState() => _ViewMyFeedBottomSheetState();
}

class _ViewMyFeedBottomSheetState extends State<ViewMyFeedBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<EditRequestBloc, EditRequestState>(
      listener: (context, state) {
        if (state is RequestEditedState) {
          BlocProvider.of<MyFeedBloc>(context).add(GetMyFeedEvent());
          context.pop();
        } else if (state is ErrorEditingRequestState) {}
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                decoration: BoxDecoration(),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SelectionArea(
                                        child: Text(
                                          widget.feed.title,
                                          textAlign: TextAlign.start,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                useGoogleFonts: false,
                                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(4, 0, 0, 0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: widget.feed.closed
                                                      ? FlutterFlowTheme.of(
                                                              context)
                                                          .primaryColor
                                                      : FlutterFlowTheme.of(
                                                              context)
                                                          .gray,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(8, 2, 8, 2),
                                                  child: Text(
                                                    widget.feed.closed
                                                        ? "Enabled"
                                                        : "Disabled",
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize: 12,
                                                            useGoogleFonts:
                                                                false,
                                                            color: widget
                                                                    .feed.closed
                                                                ? Colors.white
                                                                : Colors.black),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: GestureDetector(
                                          onTap: () {
                                            context.push('/editRequest',
                                                extra: widget.feed);
                                            Navigator.pop(context);
                                          },
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 0),
                                            child: Image.asset(
                                              'assets/images/pen.png',
                                              width: 18,
                                              height: 18,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SelectionArea(
                                          child: Text(
                                        widget.feed.pereference,
                                        textAlign: TextAlign.start,
                                        style: FlutterFlowTheme.of(context)
                                            .subtitle1
                                            .override(
                                              fontFamily: 'Poppins',
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                              useGoogleFonts: false,
                                            ),
                                      )),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                        child: Container(
                          decoration: BoxDecoration(),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.feed.description,
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    useGoogleFonts: false,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 28,
                          decoration: BoxDecoration(),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.feed.tags.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 10, 0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context).gray,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 5, 10, 5),
                                      child: Text(
                                        widget.feed.tags[index].tagName,
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText2
                                            .override(
                                                fontFamily: 'Poppins',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                fontWeight: FontWeight.w500,
                                                useGoogleFonts: false,
                                                fontSize: 12),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Image.asset(
                                'assets/images/placeholder.png',
                                width: 24,
                                height: 24,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).gray,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 5, 10, 5),
                                    child: Text(
                                      widget.feed.area,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            useGoogleFonts: false,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(height: 2),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 15),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: FFButtonWidget(
                                  showLoadingIndicator: true,
                                  onPressed: () {
                                    Request req = Request(
                                        id: widget.feed.id,
                                        area: widget.feed.area,
                                        description: widget.feed.description,
                                        pereference: widget.feed.pereference,
                                        products: widget.feed.products,
                                        services: widget.feed.services,
                                        tags: widget.feed.tags,
                                        title: widget.feed.title,
                                        closed: !widget.feed.closed);

                                    BlocProvider.of<EditRequestBloc>(context)
                                        .add(PostEditRequestEvent(req: req));
                                  },
                                  text: widget.feed.closed
                                      ? 'Disable this request'
                                      : 'Enable this request',
                                  options: FFButtonOptions(
                                    width: 150,
                                    height: 35,
                                    color: widget.feed.closed
                                        ? FlutterFlowTheme.of(context).gray
                                        : FlutterFlowTheme.of(context)
                                            .primaryColor,
                                    textStyle: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: widget.feed.closed
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize: 8),
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              Image.asset(
                                'assets/images/send.png',
                                width: 25,
                                height: 25,
                                fit: BoxFit.cover,
                              ),
                              // Container(
                              //   height: 20,
                              //   width: 20,
                              //   child: CircularProgressIndicator(
                              //     color:
                              //         FlutterFlowTheme.of(context).primaryColor,
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
