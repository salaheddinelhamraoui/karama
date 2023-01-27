import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:karama/core/widgets/loading_widget.dart';

import '../../../../../core/app_theme.dart';
import '../../../../../core/util/snackbar_message.dart';
import '../../../../../flutter_flow/flutter_flow_widgets.dart';
import '../../bloc/check_contacts/bloc/check_contacts_bloc.dart';
import '../../bloc/contacts/bloc/contacts_bloc.dart';
import 'package:share_plus/share_plus.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckContactsBloc, CheckContactsState>(
      builder: (context, state) {
        if (state is CheckContactsLoadingState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.79,
            child: LoadingWidget(),
          );
        } else if (state is CheckContactsLoadedState) {
          return _body(state.contacts);
        }
        return Container(
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
                  'There was an error retrieving your contact list.',
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
                      BlocProvider.of<ContactsBloc>(context)
                          .add(GetContactsEvent());
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
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<ContactsBloc>(context).add(GetContactsEvent());
  }

  Widget _body(checkedContacts) {
    if (checkedContacts.length > 0) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.79,
        child: RefreshIndicator(
          onRefresh: () => _onRefresh(context),
          child: ListView.builder(
              itemCount: checkedContacts.length,
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
                                    child: checkedContacts[index].avatar ==
                                                null ||
                                            checkedContacts[index].avatar == ''
                                        ? Image.asset(
                                            'assets/images/user_avatar.png',
                                            fit: BoxFit.contain,
                                          )
                                        : CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl:
                                                checkedContacts[index].avatar,
                                            placeholder: (context, url) =>
                                                new CircularProgressIndicator(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryColor,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
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
                                              checkedContacts[index]
                                                  .contactName,
                                              style: FlutterFlowTheme.of(
                                                      context)
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
                                                  checkedContacts[index]
                                                      .contactNumber,
                                                  style: FlutterFlowTheme.of(
                                                          context)
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
                              (!checkedContacts[index].invited &&
                                      !checkedContacts[index].invitationSent)
                                  ? FFButtonWidget(
                                      onPressed: () {
                                        BlocProvider.of<ContactsBloc>(context)
                                            .add(InviteContactEvent(
                                                mobileNumber:
                                                    checkedContacts[index]
                                                        .contactNumber));
                                        Share.share(
                                            'Dowanload Karama App https://kara.ma');
                                      },
                                      text: 'Invite',
                                      options: FFButtonOptions(
                                        width: 70,
                                        height: 30,
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
                                    )
                                  : Container()
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
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/contacts.png',
              fit: BoxFit.fitWidth,
              width: MediaQuery.of(context).size.width * 0.8,
            ),
            Text(
              'Your Contact List Is Empty.',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    useGoogleFonts: false,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
