import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karama/core/widgets/loading_widget.dart';
import 'package:karama/features/contacts/domain/entities/contact.dart';
import 'package:karama/features/friendsRequests/domain/entities/invitation.dart';

import '../../../../../core/app_theme.dart';
import '../../../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../../contacts/presentation/bloc/contacts/bloc/contacts_bloc.dart';
import '../../bloc/invitations/bloc/invitations_bloc.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
      ),
      body: SafeArea(
          child: BlocConsumer<InvitationsBloc, InvitationsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is InvitationsLoadingState) {
            return LoadingWidget();
          } else if (state is InvitationsLoadedState) {
            if (state.invitations.length == 0) {
              return _emptyListWidget(context);
            } else {
              return _body(context, state.invitations);
            }
          } else if (state is ErrorLoadingInvitationsState) {
            return _errorWidget(context);
          } else {
            return _emptyListWidget(context);
          }
        },
      )),
    );
  }

  Widget _errorWidget(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/error.png',
                  fit: BoxFit.fitWidth,
                  width: MediaQuery.of(context).size.width * 0.79,
                ),
                Text(
                  'There was an error retrieving your invitations list.',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        useGoogleFonts: false,
                      ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                  child: FFButtonWidget(
                    onPressed: () {
                      _onRefresh(context);
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
        ));
  }

  Widget _emptyListWidget(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/contacts.png',
              fit: BoxFit.fitWidth,
              width: MediaQuery.of(context).size.width * 0.7,
            ),
            Text(
              'Your Invitations List Is Empty.',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    useGoogleFonts: false,
                  ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
              child: FFButtonWidget(
                onPressed: () {
                  BlocProvider.of<InvitationsBloc>(context)
                      .add(GetInvitationsEvent());
                },
                text: 'Refresh',
                options: FFButtonOptions(
                  width: 100,
                  height: 40,
                  color: FlutterFlowTheme.of(context).primaryColor,
                  textStyle: FlutterFlowTheme.of(context).subtitle2.override(
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
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<InvitationsBloc>(context).add(GetInvitationsEvent());
  }

  Widget _body(BuildContext context, List<Invitation> invitations) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.79,
      child: RefreshIndicator(
        onRefresh: () => _onRefresh(context),
        child: ListView.builder(
            itemCount: invitations.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).gray,
                    borderRadius: BorderRadius.circular(5),
                    shape: BoxShape.rectangle,
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 55,
                                  height: 55,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: invitations[index].avatar == null ||
                                          invitations[index].avatar == ''
                                      ? Image.asset(
                                          'assets/images/user_avatar.png',
                                          fit: BoxFit.contain,
                                        )
                                      : CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: invitations[index].avatar!,
                                          placeholder: (context, url) =>
                                              new CircularProgressIndicator(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryColor,
                                          ),
                                          errorWidget: (context, url, error) =>
                                              new Icon(Icons.error),
                                        ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  6, 0, 0, 0),
                                          child: Text(
                                            invitations[index].first_name +
                                                ' ' +
                                                invitations[index].last_name,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  useGoogleFonts: false,
                                                ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(6, 0, 0, 0),
                                              child: Text(
                                                invitations[index].phone,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          useGoogleFonts: false,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: FFButtonWidget(
                                    onPressed: () {
                                      BlocProvider.of<InvitationsBloc>(context)
                                          .add(InvitationActionEvent(
                                              invitation: invitations[index],
                                              invitations: invitations,
                                              status: true));
                                      BlocProvider.of<InvitationsBloc>(context)
                                          .add(GetInvitationsEvent());
                                    },
                                    text: 'Accept',
                                    options: FFButtonOptions(
                                      width: 65,
                                      height: 25,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                      textStyle: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                          fontSize: 4),
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                                FFButtonWidget(
                                  onPressed: () {
                                    BlocProvider.of<InvitationsBloc>(context)
                                        .add(InvitationActionEvent(
                                            invitation: invitations[index],
                                            invitations: invitations,
                                            status: false));
                                    BlocProvider.of<InvitationsBloc>(context)
                                        .add(GetInvitationsEvent());
                                  },
                                  text: 'Decline',
                                  options: FFButtonOptions(
                                    width: 65,
                                    height: 25,
                                    color: FlutterFlowTheme.of(context).gray,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .subtitle2
                                        .override(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            useGoogleFonts: false,
                                            fontSize: 8),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
