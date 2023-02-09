import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/app_theme.dart';

class TermsOfUsePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          "Terms Of Use",
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
          padding: const EdgeInsets.only(top: 0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            '\nWelcome to KARAMA, a networking app developed and published by TECHBAY SARL-AU. The following terms and conditions govern your use of the KARAMA App and the services provided through it. \n\n',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              useGoogleFonts: false,
                            ),
                      ),
                      TextSpan(
                        text:
                            '1. Agreement to Terms: By downloading and using the KARAMA App, you agree to be bound by these terms of use. If you do not agree to these terms, do not use the KARAMA App. \n\n',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              useGoogleFonts: false,
                            ),
                      ),
                      TextSpan(
                        text:
                            '2. User Account: To use the KARAMA App, you must create an account and provide accurate and complete information. You are responsible for maintaining the confidentiality of your account and password, and you are responsible for all activities that occur under your account. You agree to immediately notify KARAMA of any unauthorized use of your account. \n\n',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              useGoogleFonts: false,
                            ),
                      ),
                      TextSpan(
                        text:
                            '3. User Conduct: When using the KARAMA App, you must comply with all applicable laws and regulations, and you may not engage in any behavior that could be harmful to KARAMA or its users, including but not limited to, transmitting or uploading any harmful or unauthorized content. \n\n',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              useGoogleFonts: false,
                            ),
                      ),
                      TextSpan(
                        text:
                            '4. Intellectual Property: The KARAMA App, including its software, content, and trademarks, is protected by intellectual property laws and is the property of TECHBAY SARL-AU. You may not copy, modify, or reverse engineer any part of the KARAMA App without the express written consent of TECHBAY SARL-AU. \n\n',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              useGoogleFonts: false,
                            ),
                      ),
                      TextSpan(
                        text:
                            '5. Disclaimer of Warranties: TECHBAY SARL-AU provides the KARAMA App "as is" and does not make any warranties, express or implied, regarding the use of the KARAMA App, including without limitation, any warranties of merchantability or fitness for a particular purpose. \n\n',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              useGoogleFonts: false,
                            ),
                      ),
                      TextSpan(
                        text:
                            '6. Limitation of Liability: In no event will TECHBAY SARL-AU be liable for any damages, including without limitation, direct. \n\n',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              useGoogleFonts: false,
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
