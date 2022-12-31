import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/app_theme.dart';
import '../../../../../core/util/snackbar_message.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../../../flutter_flow/flutter_flow_widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/temp/bloc/temp_bloc.dart';

class PhoneVerifWidget extends StatefulWidget {
  const PhoneVerifWidget({Key? key}) : super(key: key);

  @override
  _PhoneVerifWidgetState createState() => _PhoneVerifWidgetState();
}

class _PhoneVerifWidgetState extends State<PhoneVerifWidget> {
  TextEditingController? pinCodeController;
  String pinCode = '';
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    pinCodeController = TextEditingController();
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    pinCodeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: scaffoldKey,
        backgroundColor: Color(0xFFF2F2F2),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: BlocConsumer<TempBloc, TempState>(
                listener: (context, state) {
                  if (state is TempDataState) {
                    if (state.verifyState == null) {
                    } else {
                      context.go('/passSettings');
                    }
                  } else if (state is ErrorTempState) {
                    SnackBarMessage().showErrorSnackBar(
                        message: state.message, context: context);
                  }
                },
                builder: (context, state) {
                  if (state is TempDataState) {
                    return _body(state);
                  } else if (state is LoadingTempState) {
                    return LoadingWidget();
                  } else if (state is ErrorTempState) {
                    return _body(state);
                  }
                  return Container();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _body(state) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          child: Container(
            height: 60,
            decoration: BoxDecoration(),
            child: Image.asset(
              'assets/images/Logo_Karama.png',
              fit: BoxFit.fitWidth,
              width: 200,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'SMS Sent To',
                      style: FlutterFlowTheme.of(context).title3,
                    ),
                    Text(
                      state?.mobileNumber ?? '',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            useGoogleFonts: false,
                          ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: InkWell(
                  onTap: () => {context.go('/register')},
                  child: Text(
                    'Change the phone number',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          color: FlutterFlowTheme.of(context).primaryColor,
                          useGoogleFonts: false,
                        ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15, 20, 15, 0),
                child: PinCodeTextField(
                  autoDisposeControllers: false,
                  appContext: context,
                  length: 6,
                  textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                        fontFamily: 'Poppins',
                        color: FlutterFlowTheme.of(context).primaryColor,
                        useGoogleFonts: false,
                      ),
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  enableActiveFill: false,
                  autoFocus: false,
                  showCursor: true,
                  cursorColor: FlutterFlowTheme.of(context).primaryColor,
                  obscureText: false,
                  hintCharacter: '*',
                  pinTheme: PinTheme(
                    fieldHeight: 50,
                    fieldWidth: 50,
                    borderWidth: 2,
                    borderRadius: BorderRadius.circular(12),
                    shape: PinCodeFieldShape.box,
                    activeColor: FlutterFlowTheme.of(context).primaryColor,
                    inactiveColor: FlutterFlowTheme.of(context).gray,
                    selectedColor: FlutterFlowTheme.of(context).secondaryText,
                    activeFillColor: FlutterFlowTheme.of(context).primaryColor,
                    inactiveFillColor: FlutterFlowTheme.of(context).gray,
                    selectedFillColor:
                        FlutterFlowTheme.of(context).secondaryText,
                  ),
                  controller: pinCodeController,
                  onChanged: (state) => {
                    setState(() {
                      pinCode = state;
                    })
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 10),
          child: FFButtonWidget(
            onPressed: () {
              handleVerify(state.mobileNumber);
            },
            text: 'Verify',
            options: FFButtonOptions(
              width: 150,
              height: 50,
              color: FlutterFlowTheme.of(context).primaryColor,
              textStyle: FlutterFlowTheme.of(context).subtitle1.override(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    useGoogleFonts: false,
                  ),
              elevation: 3,
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void handleVerify(mobileNumber) {
    if (pinCode.length < 6) {
      SnackBarMessage()
          .showErrorSnackBar(message: 'Invalid Pincode', context: context);
    } else {
      BlocProvider.of<TempBloc>(context)
          .add(VerifyUserEvent(mobileNumber: mobileNumber, pinCode: pinCode));
    }
  }
}
