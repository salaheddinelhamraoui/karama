import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:karama/features/auth/presentation/bloc/auth/bloc/auth_bloc.dart';
import '../../../../../core/app_theme.dart';
import '../../../../../core/util/snackbar_message.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../../../flutter_flow/flutter_flow_radio_button.dart';
import '../../../../../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../auth/domain/entities/user.dart';

class EditProfilePage extends StatefulWidget {
  final User user;
  const EditProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  ImagePicker picker = ImagePicker();
  String? genderValue;
  TextEditingController? firstNameController;
  TextEditingController? lastNameController;
  String? countryValue;
  String? stateValue;
  String? cityValue;
  XFile? image;
  String? userPreAvatar;
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController()..text = widget.user.firstName;
    lastNameController = TextEditingController()..text = widget.user.lastName;
    genderValue = widget.user.gender;
    countryValue = widget.user.country;
    stateValue = '';
    cityValue = widget.user.city;
    userPreAvatar = widget.user.avatar;
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    firstNameController?.dispose();
    lastNameController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(),
            child: SingleChildScrollView(
                child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is LoadingUserState) {
                  return LoadingWidget();
                }
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 20, 15, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 70,
                        decoration: BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Edit Profile',
                              style: FlutterFlowTheme.of(context).title3,
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Text(
                                'Set your personal info',
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Stack(
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                width: 100,
                                height: 100,
                                child: image == null
                                    ? Image.network(
                                        (userPreAvatar != '' &&
                                                userPreAvatar != null)
                                            ? userPreAvatar ?? ''
                                            : 'https://cdn-icons-png.flaticon.com/512/145/145974.png',
                                        fit: BoxFit.contain,
                                      )
                                    : Image.file(File(image!.path)),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.22, 1),
                              child: GestureDetector(
                                onTap: () => {pickImage()},
                                child: Icon(
                                  Icons.edit_outlined,
                                  color: Colors.black,
                                  size: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 20, 15, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: TextFormField(
                                  controller: firstNameController,
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'First Name',
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .bodyText2
                                        .override(
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
                                    fillColor:
                                        FlutterFlowTheme.of(context).gray,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        useGoogleFonts: false,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 20, 15, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: TextFormField(
                                  controller: lastNameController,
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'Last Name',
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .bodyText2
                                        .override(
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
                                    fillColor:
                                        FlutterFlowTheme.of(context).gray,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        useGoogleFonts: false,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 20, 15, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  FlutterFlowRadioButton(
                                    initialValue: genderValue ?? '',
                                    options:
                                        ['Male', 'Female', "Other"].toList(),
                                    onChanged: (val) =>
                                        setState(() => genderValue = val),
                                    optionHeight: 25,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          useGoogleFonts: false,
                                        ),
                                    buttonPosition: RadioButtonPosition.left,
                                    direction: Axis.horizontal,
                                    radioButtonColor:
                                        FlutterFlowTheme.of(context)
                                            .primaryColor,
                                    inactiveRadioButtonColor: Color(0x8A000000),
                                    toggleable: false,
                                    horizontalAlignment: WrapAlignment.start,
                                    verticalAlignment: WrapCrossAlignment.start,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 20, 15, 0),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  SelectState(
                                    // style: TextStyle(color: Colors.red),
                                    onCountryChanged: (value) {
                                      setState(() {
                                        countryValue = value;
                                      });
                                    },
                                    onStateChanged: (value) {
                                      setState(() {
                                        stateValue = value;
                                      });
                                    },
                                    onCityChanged: (value) {
                                      setState(() {
                                        cityValue = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                      child: FFButtonWidget(
                        onPressed: () {
                          handleSubmit(state);
                        },
                        text: 'Edit',
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
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                      child: GestureDetector(
                        onTap: () => {Navigator.pop(context)},
                        child: Text(
                          'Cancel',
                          style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                      ),
                    )
                  ],
                );
              },
            )),
          ),
        ),
      ),
    );
  }

  void pickImage() async {
    XFile? imageData = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = imageData;
    });
  }

  void handleSubmit(state) async {
    Uint8List? fileBytes = await image?.readAsBytes();
    if (fileBytes != null) {
      String encodedImage = base64Encode(fileBytes.toList());
      if (firstNameController?.text == '' ||
          lastNameController?.text == '' ||
          genderValue == null) {
        SnackBarMessage().showErrorSnackBar(
            message: 'Please fill out all required fields.', context: context);
      } else {
        print('firstName: ' + firstNameController!.text);
        print('lastNameController: ' + lastNameController!.text);
        print('genderValue: ' + genderValue!);
        print('countryValue: ' + countryValue!);
        print('state: ' + stateValue!);
        print('city: ' + cityValue!);
        print('token: ' + state.token);

        // BlocProvider.of<TempBloc>(context).add(SubmitOnboardingDataEvent(
        //   avatar: encodedImage,
        //   firstName: firstNameController!.text,
        //   lastName: lastNameController!.text,
        //   gender: genderValue ?? '',
        //   country: countryValue ?? '',
        //   state: stateValue ?? '',
        //   city: cityValue ?? '',
        //   token: state.token,
        //   mobileNumber: state.mobileNumber,
        //   password: state.password,
        // ));
      }
    } else {
      if (firstNameController?.text == '' ||
          lastNameController?.text == '' ||
          genderValue == null) {
        SnackBarMessage().showErrorSnackBar(
            message: 'Please fill out all required fields.', context: context);
      } else {
        print('firstName: ' + firstNameController!.text);
        print('lastNameController: ' + lastNameController!.text);
        print('genderValue: ' + genderValue!);
        print('countryValue: ' + countryValue!);
        print('state: ' + stateValue!);
        print('city: ' + cityValue!);
        print('token: ' + state.token);
        // BlocProvider.of<TempBloc>(context).add(SubmitOnboardingDataEvent(
        //   avatar: '',
        //   firstName: firstNameController!.text,
        //   lastName: lastNameController!.text,
        //   gender: genderValue ?? '',
        //   country: countryValue ?? '',
        //   state: stateValue ?? '',
        //   city: cityValue ?? '',
        //   token: state.token,
        //   mobileNumber: state.mobileNumber,
        //   password: state.password,
        // ));
      }
    }
  }
}
