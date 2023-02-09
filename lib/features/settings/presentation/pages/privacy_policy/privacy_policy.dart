import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/app_theme.dart';

class PrivacyPolicyPage extends StatelessWidget {
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
          "Privacy Policy",
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
                            '\nThe KARAMA App is committed to protecting the privacy of its users. This Privacy Policy outlines the types of information we collect, how we use it, and the measures we take to protect it. \n\n',
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
                            '1. Information Collection: We may collect personal information such as your name, email address, and profile information when you create an account on the KARAMA App. We may also collect information about your usage of the KARAMA App, such as the date and time you use the app and the features you access. \n\n',
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
                            '2. Use of Information: The information we collect is used to provide you with a personalized experience on the KARAMA App and to improve our services. We may use your personal information to send you updates, news, and promotions related to the KARAMA App.  \n\n',
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
                            '3. Sharing of Information: We will not share your personal information with third parties, except as required by law or in the case of a merger, acquisition, or bankruptcy.  \n\n',
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
                            '4. Data Security: We take appropriate measures to protect your personal information from unauthorized access, use, or disclosure. We also implement technical and organizational measures to protect your personal information from loss, theft, and unauthorized access.  \n\n',
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
                            '5. Third-Party Links: The KARAMA App may contain links to third-party websites. We are not responsible for the privacy practices or content of these websites.  \n\n',
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
                            '6. Changes to Privacy Policy: We reserve the right to modify this Privacy Policy at any time. Any changes to this Privacy Policy will be posted on the KARAMA App website. Your continued use of the KARAMA App following the posting of changes constitutes your acceptance of those changes.  \n\n',
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
