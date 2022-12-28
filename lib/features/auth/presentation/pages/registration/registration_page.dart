import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/app_theme.dart';
import '../../../../../flutter_flow/flutter_flow_widgets.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class RegistrationWidget extends StatefulWidget {
  const RegistrationWidget({Key? key}) : super(key: key);

  @override
  _RegistrationWidgetState createState() => _RegistrationWidgetState();
}

class _RegistrationWidgetState extends State<RegistrationWidget> {
  TextEditingController? textController1;
  TextEditingController? textController2;
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    textController1?.dispose();
    textController2?.dispose();
    super.dispose();
  }

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'MA';
  PhoneNumber number = PhoneNumber(isoCode: 'MA');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(80, 0, 80, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    decoration: BoxDecoration(),
                    child: SvgPicture.asset(
                      'assets/images/Logo_Karama.svg',
                      width: 100,
                      height: 100,
                      fit: BoxFit.fill,
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
                      Text(
                        'Enter your phone',
                        style: FlutterFlowTheme.of(context).title3,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                        child: Text(
                          'In publishing and graphic design, Lorem ipsum is a placeholder text commonly.',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 20, 15, 0),
                        child: InternationalPhoneNumberInput(
                          onInputChanged: (PhoneNumber number) {
                            print(number.phoneNumber);
                          },
                          onInputValidated: (bool value) {
                            print(value);
                          },
                          selectorConfig: SelectorConfig(
                            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                          ),
                          ignoreBlank: false,
                          autoValidateMode: AutovalidateMode.disabled,
                          selectorTextStyle: TextStyle(color: Colors.black),
                          initialValue: number,
                          textFieldController: controller,
                          formatInput: false,
                          keyboardType: TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          inputBorder: OutlineInputBorder(),
                          inputDecoration: InputDecoration(
                            hintText: 'Phone Number',
                            hintStyle:
                                FlutterFlowTheme.of(context).bodyText2.override(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      useGoogleFonts: false,
                                    ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            filled: true,
                            fillColor: FlutterFlowTheme.of(context).gray,
                          ),
                          onSaved: (PhoneNumber number) {
                            print('On Saved: $number');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 10),
                  child: FFButtonWidget(
                    onPressed: () {},
                    text: 'Verify',
                    options: FFButtonOptions(
                      width: 150,
                      height: 50,
                      color: FlutterFlowTheme.of(context).primaryColor,
                      textStyle:
                          FlutterFlowTheme.of(context).subtitle1.override(
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
            ),
          ),
        ),
      ),
    );
  }
}
