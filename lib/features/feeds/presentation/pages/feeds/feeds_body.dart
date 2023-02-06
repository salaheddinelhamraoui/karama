import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karama/core/widgets/loading_widget.dart';
import 'package:karama/features/feeds/presentation/bloc/feeds/bloc/feed_bloc.dart';
import '../../../../../core/util/string_casing.dart';
import '../../../../../core/app_theme.dart';
import '../../../../../core/util/snackbar_message.dart';
import '../../../../../flutter_flow/flutter_flow_widgets.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../auth/presentation/bloc/logout/bloc/logout_bloc.dart';
import '../../widgets/view_feed_bottom_sheet.dart';

class FeedsBody extends StatefulWidget {
  const FeedsBody({Key? key}) : super(key: key);

  @override
  _FeedsBodyState createState() => _FeedsBodyState();
}

class _FeedsBodyState extends State<FeedsBody> {
  TextEditingController? textController;
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    BlocProvider.of<FeedBloc>(context).add(GetFeedsEvent());
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    textController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          BlocConsumer<FeedBloc, FeedState>(
            listener: (context, state) {
              if (state is ErrorLoadingFeedsState) {
                if (state.message == 'Unauthorized') {
                  BlocProvider.of<LogoutBloc>(context).add(PostLoginOutEvent());
                } else {
                  SnackBarMessage().showErrorSnackBar(
                      message: state.message, context: context);
                }
              }
            },
            builder: (context, state) {
              if (state is FeedLoadingState || state is FeedInitial) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: LoadingWidget(),
                );
              } else if (state is FeedLoadedState) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: RefreshIndicator(
                    onRefresh: () => _onRefresh(context),
                    child: state.feeds.length > 0
                        ? ListView.builder(
                            itemCount: state.feeds.length,
                            itemBuilder: (context, index) {
                              if (state.feeds.length == index + 1) {
                                return Column(
                                  children: [
                                    _feedCard(state.feeds[index]),
                                    SizedBox(
                                      height: 120,
                                    ),
                                  ],
                                );
                              }
                              return _feedCard(state.feeds[index]);
                            },
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/empty.png',
                                    fit: BoxFit.fitWidth,
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                  ),
                                  Text(
                                    'There are no feeds available.',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          useGoogleFonts: false,
                                        ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 15, 0, 0),
                                    child: FFButtonWidget(
                                      onPressed: () {
                                        BlocProvider.of<FeedBloc>(context)
                                            .add(GetFeedsEvent());
                                      },
                                      text: 'Refresh',
                                      options: FFButtonOptions(
                                        width: 100,
                                        height: 40,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryColor,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .subtitle2
                                            .override(
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                                useGoogleFonts: false,
                                                fontSize: 14),
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                );
              }

              return Container(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/empty.png',
                        fit: BoxFit.fitWidth,
                        width: MediaQuery.of(context).size.width * 0.8,
                      ),
                      Text(
                        'There are no feeds available.',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              useGoogleFonts: false,
                            ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                        child: FFButtonWidget(
                          onPressed: () {
                            BlocProvider.of<FeedBloc>(context)
                                .add(GetFeedsEvent());
                          },
                          text: 'Refresh',
                          options: FFButtonOptions(
                            width: 100,
                            height: 40,
                            color: FlutterFlowTheme.of(context).primaryColor,
                            textStyle: FlutterFlowTheme.of(context)
                                .subtitle2
                                .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    useGoogleFonts: false,
                                    fontSize: 14),
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<FeedBloc>(context).add(GetFeedsEvent());
  }

  Widget _feedCard(item) {
    return GestureDetector(
      onTap: () {
        showFeedModel(item);
      },
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 4),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: 18,
                          height: 18,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: item.avatar,
                            placeholder: (context, url) =>
                                new CircularProgressIndicator(
                              color: FlutterFlowTheme.of(context).primaryColor,
                            ),
                            errorWidget: (context, url, error) =>
                                new Icon(Icons.error),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                          child: Text(
                            item.firstName.replaceFirst(item.firstName[0],
                                    item.firstName[0].toUpperCase()) +
                                ' ' +
                                item.lastName.replaceFirst(item.firstName[0],
                                    item.firstName[0].toUpperCase()),
                            style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: 'Poppins',
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  useGoogleFonts: false,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        timeago.format(item.createdDate),
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              useGoogleFonts: false,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).gray,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                item.title.replaceFirst(
                                    item.title[0], item.title[0].toUpperCase()),
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      useGoogleFonts: false,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(),
                        child: Text(
                          item.description.replaceFirst(item.description[0],
                              item.description[0].toUpperCase()),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    useGoogleFonts: false,
                                  ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Image.asset(
                                    'assets/images/placeholder.png',
                                    width: 16,
                                    height: 16,
                                    fit: BoxFit.cover,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        4, 0, 0, 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBtnText,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            4, 2, 4, 2),
                                        child: Text(
                                          item.area.replaceFirst(item.area[0],
                                              item.area[0].toUpperCase()),
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
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Image.asset(
                                      'assets/images/Group_32.png',
                                      width: 16,
                                      height: 16,
                                      fit: BoxFit.cover,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          4, 0, 0, 0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBtnText,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  4, 2, 4, 2),
                                          child: Text(
                                            item.pereference.replaceFirst(
                                                item.pereference[0],
                                                item.pereference[0]
                                                    .toUpperCase()),
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
                                  ],
                                ),
                              ),
                            ],
                          ),
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
    );
  }

  void showFeedModel(item) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: false,
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: ViewFeedBottomSheet(feed: item),
        );
      },
    ).then((value) => setState(() {}));
  }
}
