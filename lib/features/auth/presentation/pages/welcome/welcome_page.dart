import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/app_theme.dart';
import '../../../../../core/util/snackbar_message.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../../../flutter_flow/flutter_flow_widgets.dart';
import '../../bloc/auth/bloc/auth_bloc.dart';
import '../../bloc/temp/bloc/temp_bloc.dart';

class WelcomeWidget extends StatefulWidget {
  const WelcomeWidget({Key? key}) : super(key: key);

  @override
  _WelcomeWidgetState createState() => _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget> {
  PageController? pageViewController;
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: BlocListener<TempBloc, TempState>(
              listener: (context, state) {
                if (state is TempDataState) {
                  if (state.verifyState != null && state.verifyState == true) {
                    context.go('/passSettings');
                  }
                }
              },
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is LoadedUserState) {
                    context.go('/feeds');
                    // SnackBarMessage().showSuccessSnackBar(
                    //     message: 'Logged Successfully', context: context);
                  }
                },
                builder: (context, state) {
                  if (state is LoadingUserState || state is AuthInitial) {
                    return LoadingWidget();
                  }
                  return _body();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _body() {
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
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.6,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 50),
                child: PageView(
                  controller: pageViewController ??=
                      PageController(initialPage: 0),
                  scrollDirection: Axis.horizontal,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                          child: Image.asset(
                            'assets/images/4627175.png',
                            width: 300,
                            height: 250,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Text(
                          "Let's get started",
                          style: FlutterFlowTheme.of(context).title3,
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                          child: Text(
                            'Unlock the power of your network',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 1),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                  child: smooth_page_indicator.SmoothPageIndicator(
                    controller: pageViewController ??=
                        PageController(initialPage: 0),
                    count: 1,
                    axisDirection: Axis.horizontal,
                    onDotClicked: (i) {
                      pageViewController!.animateToPage(
                        i,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    effect: smooth_page_indicator.ExpandingDotsEffect(
                      expansionFactor: 2,
                      spacing: 8,
                      radius: 16,
                      dotWidth: 16,
                      dotHeight: 16,
                      dotColor: Color(0xFF9E9E9E),
                      activeDotColor: Color(0xFF3F51B5),
                      paintStyle: PaintingStyle.fill,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 10),
          child: FFButtonWidget(
            onPressed: () {
              context.go('/login');
            },
            text: 'Start',
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
}
