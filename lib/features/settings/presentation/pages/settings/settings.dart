import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:karama/flutter_flow/flutter_flow_theme.dart';
import 'package:ndialog/ndialog.dart';
import '../../../../auth/presentation/bloc/auth/bloc/auth_bloc.dart';
import '../../../../auth/presentation/bloc/logout/bloc/logout_bloc.dart';
import '../../widgets/settings_tile.dart';
import 'package:flutter/cupertino.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          "Settings",
          style: FlutterFlowTheme.of(context).bodyText1.override(
                fontFamily: 'Poppins',
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w400,
                useGoogleFonts: false,
              ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is LoadedUserState) {
                    return SettingsTile(
                      color: FlutterFlowTheme.of(context).primaryColor,
                      icon: Ionicons.pencil_outline,
                      title: "Edit Profile",
                      onTap: () {
                        context.push('/editProfile', extra: state.user);
                      },
                    );
                  }
                  return Container();
                },
              ),
              const SizedBox(height: 40),
              SettingsTile(
                color: FlutterFlowTheme.of(context).primaryColor,
                icon: Ionicons.pulse,
                title: "Terms Of Use",
                onTap: () {
                  context.push('/termsOfUse');
                },
              ),
              const SizedBox(
                height: 10,
              ),
              SettingsTile(
                color: FlutterFlowTheme.of(context).primaryColor,
                icon: Ionicons.lock_closed,
                title: "Privacy Policy",
                onTap: () {
                  context.push('/privacyPolicy');
                },
              ),
              const SizedBox(
                height: 40,
              ),
              SettingsTile(
                color: FlutterFlowTheme.of(context).primaryColor,
                icon: Ionicons.trash_outline,
                title: "Delete Account",
                onTap: () {
                  NAlertDialog(
                    dialogStyle: DialogStyle(titleDivider: true),
                    title: Text(
                      "Delete Account",
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            useGoogleFonts: false,
                          ),
                    ),
                    content: Text(
                      "Deleting your account is permanent.",
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            useGoogleFonts: false,
                          ),
                    ),
                    actions: <Widget>[
                      TextButton(
                          child: Text("Delete",
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.red,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    useGoogleFonts: false,
                                  )),
                          onPressed: () => Navigator.pop(context)),
                      TextButton(
                          child: Text("Cancel",
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    useGoogleFonts: false,
                                  )),
                          onPressed: () => Navigator.pop(context)),
                    ],
                  ).show(context);
                },
              ),
              const SizedBox(
                height: 40,
              ),
              SettingsTile(
                color: Colors.red,
                icon: Ionicons.log_out_outline,
                title: "Logout",
                onTap: () {
                  NAlertDialog(
                    dialogStyle: DialogStyle(titleDivider: true),
                    title: Text(
                      "Logout",
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            useGoogleFonts: false,
                          ),
                    ),
                    content: Text(
                      "Are you sure you want to logout ?",
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            useGoogleFonts: false,
                          ),
                    ),
                    actions: <Widget>[
                      TextButton(
                          child: Text("Logout",
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.red,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    useGoogleFonts: false,
                                  )),
                          onPressed: () => {
                                BlocProvider.of<LogoutBloc>(context)
                                    .add(PostLoginOutEvent())
                              }),
                      TextButton(
                          child: Text("Cancel",
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    useGoogleFonts: false,
                                  )),
                          onPressed: () => Navigator.pop(context)),
                    ],
                  ).show(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
