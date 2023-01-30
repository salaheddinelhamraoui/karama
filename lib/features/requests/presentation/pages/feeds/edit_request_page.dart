import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:karama/features/requests/domain/entities/request.dart';
import 'package:karama/features/requests/presentation/bloc/editeRequest/bloc/edit_request_bloc.dart';

import '../../../../../core/app_theme.dart';
import '../../../../../core/util/snackbar_message.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../../../flutter_flow/flutter_flow_drop_down.dart';
import '../../../../../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../auth/presentation/bloc/auth/bloc/auth_bloc.dart';
import '../../../../feeds/domain/entities/feed.dart';
import '../../../../feeds/presentation/bloc/feeds/bloc/feed_bloc.dart';
import '../../../../profile/presentation/bloc/bloc/my_feed_bloc.dart';
import '../../../domain/entities/tag.dart';
import '../../../domain/entities/tag_category.dart';
import '../../bloc/bloc/tags_bloc.dart';
import '../../bloc/request/bloc/request_bloc.dart';
import '../../widgets/tags_bottom_sheet.dart';

class EditRequestPage extends StatefulWidget {
  final Feed feed;
  const EditRequestPage({Key? key, required this.feed}) : super(key: key);

  @override
  _EditRequestPageState createState() => _EditRequestPageState();
}

class _EditRequestPageState extends State<EditRequestPage> {
  String? dropDownValue;
  bool? switchValue1;
  bool? switchValue2;
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // myCustomControllers
  TextEditingController? titleController;
  TextEditingController? descriptionController;
  TextEditingController? cityController;
  List<Tag> submittedTags = [];

  @override
  void initState() {
    BlocProvider.of<TagsBloc>(context).add(GetTagsEvent());
    super.initState();
    titleController = TextEditingController()..text = widget.feed.title;
    descriptionController = TextEditingController()
      ..text = widget.feed.description;
    cityController = TextEditingController()..text = widget.feed.area;
    submittedTags = widget.feed.tags;
    switchValue1 = widget.feed.products.toLowerCase() == 'true';
    switchValue2 = widget.feed.services.toLowerCase() == 'true';
    dropDownValue = widget.feed.pereference;
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    titleController?.dispose();
    descriptionController?.dispose();
    cityController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
            child: _body(context),
          ),
        ),
      ),
    );
  }

  Widget _body(context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
      ),
      child: SingleChildScrollView(
        child: BlocConsumer<TagsBloc, TagsState>(
          listener: (context, state) {
            if (state is TagsLoadedState) {}
          },
          builder: (context, state) {
            if (state is TagsLoadedState) {
              return _content(context, state.tags);
            } else if (state is TagsLoadingState) {
              return const LoadingWidget();
            }
            return _content(context, []);
          },
        ),
      ),
    );
  }

  Widget _content(context, tags) {
    return BlocConsumer<EditRequestBloc, EditRequestState>(
      listener: (context, state) {
        if (state is ErrorEditingRequestState) {
          SnackBarMessage()
              .showErrorSnackBar(message: state.message, context: context);
        } else if (state is RequestEditedState) {
          SnackBarMessage().showSuccessSnackBar(
              message: 'Request Edited  Successfully', context: context);
          BlocProvider.of<FeedBloc>(context).add(GetFeedsEvent());
          BlocProvider.of<MyFeedBloc>(context).add(GetMyFeedEvent());
          context.go('/feeds');
        }
      },
      builder: (context, state) {
        if (state is EditingRequestState) {
          return const LoadingWidget();
        } else {
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                decoration: BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SelectionArea(
                                        child: Text(
                                      'Edit Reaquest',
                                      textAlign: TextAlign.start,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 26,
                                            fontWeight: FontWeight.bold,
                                            useGoogleFonts: false,
                                          ),
                                    )),
                                    SelectionArea(
                                        child: Text(
                                      'Who Are You Looking For',
                                      textAlign: TextAlign.start,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1,
                                    )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 20, 15, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Someone That Provides',
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context).subtitle1,
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      decoration: BoxDecoration(),
                                      child: SelectionArea(
                                          child: Text(
                                        'Products',
                                        textAlign: TextAlign.start,
                                        style: FlutterFlowTheme.of(context)
                                            .subtitle2,
                                      )),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 25,
                                        decoration: BoxDecoration(),
                                        child: Switch.adaptive(
                                          value: switchValue1 ??= true,
                                          onChanged: (newValue) async {
                                            setState(
                                                () => switchValue1 = newValue!);
                                          },
                                          activeColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    decoration: BoxDecoration(),
                                    child: SelectionArea(
                                        child: Text(
                                      'Services',
                                      textAlign: TextAlign.start,
                                      style: FlutterFlowTheme.of(context)
                                          .subtitle2,
                                    )),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 25,
                                      decoration: BoxDecoration(),
                                      child: Switch.adaptive(
                                        value: switchValue2 ??= true,
                                        onChanged: (newValue) async {
                                          setState(
                                              () => switchValue2 = newValue!);
                                        },
                                        activeColor:
                                            FlutterFlowTheme.of(context)
                                                .primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 20, 16, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                child: Text(
                                  'Request Title *',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context).subtitle2,
                                ),
                              ),
                              TextFormField(
                                controller: titleController,
                                autofocus: false,
                                obscureText: false,
                                decoration: _inputDecoration('Title'),
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      useGoogleFonts: false,
                                    ),
                              )
                              // TextInputWidget(
                              //   placeHolder: 'UX / UI Designer',
                              // ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 15, 16, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                child: Text(
                                  ' Request Description *',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context).subtitle2,
                                ),
                              ),
                              TextFormField(
                                controller: descriptionController,
                                autofocus: false,
                                obscureText: false,
                                maxLines: 3,
                                decoration: _inputDecoration('Description'),
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      useGoogleFonts: false,
                                    ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 15, 16, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                child: Text(
                                  'Preference  *',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context).subtitle2,
                                ),
                              ),
                              FlutterFlowDropDown<String>(
                                initialOption: dropDownValue ??=
                                    'Pro Individual',
                                options: [
                                  'Pro Individual',
                                  'Business',
                                  'Student / Learner',
                                  'Whatever'
                                ],
                                onChanged: (val) =>
                                    setState(() => dropDownValue = val),
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      useGoogleFonts: false,
                                    ),
                                hintText: 'Please select...',
                                fillColor: Color(0xFFE2E2EE),
                                elevation: 2,
                                borderColor: Colors.transparent,
                                borderWidth: 0,
                                borderRadius: 0,
                                margin: EdgeInsetsDirectional.fromSTEB(
                                    12, 4, 12, 4),
                                hidesUnderline: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 20, 16, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                child: Text(
                                  'City *',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context).subtitle2,
                                ),
                              ),
                              TextFormField(
                                controller: cityController,
                                autofocus: false,
                                obscureText: false,
                                decoration: _inputDecoration('City'),
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      useGoogleFonts: false,
                                    ),
                              )
                              // TextInputWidget(
                              //   placeHolder: 'UX / UI Designer',
                              // ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 15, 16, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tags  *',
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context).subtitle2,
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                                child: Text(
                                  'Select min two tags to help your network find your offer',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        useGoogleFonts: false,
                                      ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      GestureDetector(
                                        onTap: () async => {
                                          await showModalBottomSheet(
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            enableDrag: false,
                                            context: context,
                                            builder: (context) {
                                              return Padding(
                                                padding: MediaQuery.of(context)
                                                    .viewInsets,
                                                child: TagsSheetWidget(
                                                  tags: tags ?? [],
                                                  submittedTagsCallBack:
                                                      submittedTagsCallBack,
                                                ),
                                              );
                                            },
                                          ).then((value) => setState(() {}))
                                        },
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 10, 0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(8, 4, 8, 4),
                                              child: Text(
                                                'Add Tag',
                                                textAlign: TextAlign.center,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          useGoogleFonts: false,
                                                        ),
                                              ),
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
                      ),
                      submittedTags.length > 0
                          ? Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(15, 15, 15, 0),
                              child: Container(
                                height: 32,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: submittedTags.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 10, 0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .gray,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(8, 4, 8, 4),
                                              child: InkWell(
                                                child: Text(
                                                  submittedTags[index].tagName,
                                                  textAlign: TextAlign.center,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        useGoogleFonts: false,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 15, 0),
                                          child: InkWell(
                                            onTap: () {
                                              List<Tag> filteredTags =
                                                  submittedTags
                                                      .where((item) =>
                                                          item.id !=
                                                          submittedTags[index]
                                                              .id)
                                                      .toList();
                                              setState(() {
                                                submittedTags = filteredTags;
                                              });
                                            },
                                            child: const Icon(
                                              Icons.highlight_off_sharp,
                                              color: Colors.black,
                                              size: 22,
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                ),
                              ),
                            )
                          : Container(),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                        child: FFButtonWidget(
                          onPressed: submitRequest,
                          text: 'Submit',
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
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  InputDecoration _inputDecoration(placeHolder) {
    return InputDecoration(
      hintText: placeHolder,
      hintStyle: FlutterFlowTheme.of(context).bodyText2.override(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.normal,
            useGoogleFonts: false,
          ),
      enabledBorder: UnderlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0x00000000),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0x00000000),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0x00000000),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0x00000000),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      filled: true,
      fillColor: FlutterFlowTheme.of(context).gray,
    );
  }

  void submittedTagsCallBack(tags) {
    setState(() {
      List<Tag> allTags = [...submittedTags, ...tags];
      List<Tag> filteredTags = allTags.toSet().toList();

      submittedTags = filteredTags;
    });

    Navigator.pop(context);
  }

  void submitRequest() {
    if (titleController?.text == '' ||
        descriptionController?.text == '' ||
        cityController?.text == '' ||
        submittedTags.isEmpty) {
      SnackBarMessage().showErrorSnackBar(
          message: 'Please fill out all required fields.', context: context);
    } else {
      Request req = Request(
          id: widget.feed.id,
          area: cityController?.text ?? '',
          description: descriptionController?.text ?? '',
          pereference: dropDownValue ?? '',
          products: switchValue1.toString(),
          services: switchValue2.toString(),
          tags: submittedTags,
          title: titleController?.text ?? '',
          closed: widget.feed.closed);

      BlocProvider.of<EditRequestBloc>(context)
          .add(PostEditRequestEvent(req: req));
    }
  }
}
