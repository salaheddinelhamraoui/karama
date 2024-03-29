import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karama/features/requests/domain/entities/tag.dart';

import '../../../../core/app_theme.dart';
import '../../../../flutter_flow/flutter_flow_widgets.dart';
import '../../domain/entities/tag_category.dart';

class TagsSheetWidget extends StatefulWidget {
  final List<TagCategory> tags;
  Function submittedTagsCallBack;

  TagsSheetWidget(
      {Key? key, required this.tags, required this.submittedTagsCallBack})
      : super(key: key);

  @override
  _TagsSheetWidgetState createState() => _TagsSheetWidgetState();
}

class _TagsSheetWidgetState extends State<TagsSheetWidget> {
  TextEditingController? textController;
  int? selectedPersonalCategory;
  int? selectedProCategory;
  List<Tag> selectedTags = [];
  List<TagCategory> filteredTags = [];
  List<Tag> filteredTags2 = [];

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    filteredTags = widget.tags;
  }

  @override
  void dispose() {
    textController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: TextFormField(
                    controller: textController,
                    onChanged: (value) {
                      _filterSelectedTags(value);
                    },
                    autofocus: true,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Tag Name',
                      hintStyle: FlutterFlowTheme.of(context).bodyText2,
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
                      suffixIcon: IconButton(
                        onPressed: () {
                          textController?.clear();
                          _filterSelectedTags('');
                        },
                        icon: Icon(
                          Icons.highlight_off_sharp,
                          color: Color(0xFF757575),
                          size: 22,
                        ),
                      ),
                    ),
                    style: FlutterFlowTheme.of(context).bodyText1,
                  ),
                ),
              ),
              filteredTags.length > 0
                  ? Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 0, 15, 10),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                shape: BoxShape.rectangle,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  6, 0, 0, 0),
                                          child: Text(
                                            'Categories',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  useGoogleFonts: false,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          filteredTags.length > 0
                              ? Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15, 0, 15, 0),
                                  child: Container(
                                    height: 32,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(),
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: filteredTags.length,
                                      itemBuilder: (context, index) {
                                        if (filteredTags[index].type == 2) {
                                          return Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 10, 0),
                                            child: Container(
                                              decoration: selectedProCategory !=
                                                          null &&
                                                      selectedProCategory ==
                                                          index
                                                  ? BoxDecoration(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .gray,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                        color: Colors.black,
                                                        width: 1,
                                                      ),
                                                    )
                                                  : BoxDecoration(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .gray,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(8, 4, 8, 4),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      selectedProCategory =
                                                          index;
                                                    });
                                                  },
                                                  child: Text(
                                                    filteredTags[index].name,
                                                    textAlign: TextAlign.center,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                          );
                                        } else {
                                          return SizedBox();
                                        }
                                      },
                                    ),
                                  ),
                                )
                              : Container(),
                          selectedProCategory != null
                              ? filteredTags[selectedProCategory ?? 0]
                                          .tags
                                          .length >
                                      0
                                  ? Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15, 10, 15, 0),
                                      child: Container(
                                        height: 25,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(),
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: filteredTags[
                                                  selectedProCategory ?? 0]
                                              .tags
                                              .length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 6, 0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(8, 4, 8, 4),
                                                  child: InkWell(
                                                    onTap: () {
                                                      bool tagExists =
                                                          selectedTags.any((tag) =>
                                                              tag.id ==
                                                              filteredTags[
                                                                      selectedProCategory ??
                                                                          0]
                                                                  .tags[index]
                                                                  .id);

                                                      if (!tagExists) {
                                                        Tag tag = Tag(
                                                            id: filteredTags[
                                                                    selectedProCategory ??
                                                                        0]
                                                                .tags[index]
                                                                .id,
                                                            tagName: filteredTags[
                                                                    selectedProCategory ??
                                                                        0]
                                                                .tags[index]
                                                                .tagName);
                                                        setState(() {
                                                          selectedTags.add(tag);
                                                        });
                                                      }
                                                    },
                                                    child: Text(
                                                      filteredTags[
                                                              selectedProCategory ??
                                                                  0]
                                                          .tags[index]
                                                          .tagName,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBtnText,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                useGoogleFonts:
                                                                    false,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  : Container()
                              : Container(),
                          filteredTags2.length > 0
                              ? Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15, 15, 15, 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          shape: BoxShape.rectangle,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                6, 0, 0, 0),
                                                    child: Text(
                                                      'Tags',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                useGoogleFonts:
                                                                    false,
                                                              ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15, 0, 15, 0),
                                      child: Container(
                                        height: 25,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(),
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: filteredTags2.length,
                                          itemBuilder: (context, index) {
                                            return Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 6, 0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  8, 4, 8, 4),
                                                      child: InkWell(
                                                        onTap: () {
                                                          bool tagExists =
                                                              selectedTags.any((tag) =>
                                                                  tag.id ==
                                                                  filteredTags2[
                                                                          index]
                                                                      .id);

                                                          if (!tagExists) {
                                                            Tag tag = Tag(
                                                                id: filteredTags2[
                                                                        index]
                                                                    .id,
                                                                tagName:
                                                                    filteredTags2[
                                                                            index]
                                                                        .tagName);
                                                            setState(() {
                                                              selectedTags
                                                                  .add(tag);
                                                            });
                                                          }
                                                        },
                                                        child: Text(
                                                          filteredTags2[index]
                                                              .tagName,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBtnText,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                useGoogleFonts:
                                                                    false,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                          selectedTags.length > 0
                              ? Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15, 15, 15, 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          shape: BoxShape.rectangle,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                6, 0, 0, 0),
                                                    child: Text(
                                                      'Selected',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                useGoogleFonts:
                                                                    false,
                                                              ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15, 0, 15, 0),
                                      child: Container(
                                        height: 25,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(),
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: selectedTags.length,
                                          itemBuilder: (context, index) {
                                            return Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 6, 0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  8, 4, 8, 4),
                                                      child: InkWell(
                                                        child: Text(
                                                          selectedTags[index]
                                                              .tagName,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBtnText,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                useGoogleFonts:
                                                                    false,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 15, 0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      List<Tag> filteredTags =
                                                          selectedTags
                                                              .where((item) =>
                                                                  item.id !=
                                                                  selectedTags[
                                                                          index]
                                                                      .id)
                                                              .toList();
                                                      setState(() {
                                                        selectedTags =
                                                            filteredTags;
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
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                    )
                  : Container(),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FFButtonWidget(
                        onPressed: () {
                          widget.submittedTagsCallBack(selectedTags);
                        },
                        text: 'Add',
                        options: FFButtonOptions(
                          width: 130,
                          height: 40,
                          color: FlutterFlowTheme.of(context).primaryColor,
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    useGoogleFonts: false,
                                  ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
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

  void _filterSelectedTags(value) {
    List<TagCategory> results = [];
    List<Tag> tagsResult = [];
    for (TagCategory obj in widget.tags) {
      if (obj.name.toLowerCase().contains(value.toLowerCase())) {
        results.add(obj);
      }

      for (Tag tag in obj.tags) {
        if (tag.tagName.toLowerCase().contains(value.toLowerCase())) {
          tagsResult.add(tag);
        }
      }
    }

    setState(() {
      filteredTags = results;
      filteredTags2 = tagsResult;
      selectedProCategory = null;
      selectedPersonalCategory = null;
    });
  }
}
