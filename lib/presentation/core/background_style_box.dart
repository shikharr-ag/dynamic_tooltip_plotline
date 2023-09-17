import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'helper.dart';
import 'my_dropdown.dart';
import 'my_textbox_template.dart';

import '../../application/tooltip/data_provider.dart';
import '../../domain/core/errors.dart';
import '../../domain/tooltip/background_style.dart';
import '../../domain/tooltip/my_color.dart';
import '../../infrastructure/core/api_call_constants.dart';
import 'build_helper_widgets.dart';
import 'constants.dart';
import 'style_elements.dart';

class BackgroundStyleBox extends StatefulWidget {
  final String id;
  const BackgroundStyleBox({super.key, required this.id});

  @override
  State<BackgroundStyleBox> createState() => _BackgroundStyleBoxState();
}

class _BackgroundStyleBoxState extends State<BackgroundStyleBox>
    with SingleTickerProviderStateMixin {
  Color _defaultColor = Colors.white;
  bool showText = true;
  String hintText = '';
  late TabController ctrl;
  Map<String, Widget> sourceAndWidget = {};
  late DataProvider prov;

  void updateTabIndex(int i) {
    prov.updateTabIndex(i);
  }

  void initialiseVariables() {
    prov = Provider.of<DataProvider>(context, listen: false);
    ctrl = TabController(length: 2, vsync: this);
    Object? j = prov.getValFromParams(widget.id);
    String? s = j?.toString();
    BackgroundStyle? obj =
        s == null ? null : BackgroundStyle().getObjectFromString(s);
    _defaultColor = prov.getBackgroundStyleColor(widget.id);
    hintText = obj == null ? 'Input' : BackgroundStyle().genHintText(obj);
  }

  @override
  void initState() {
    initialiseVariables();
    ctrl.addListener(() {
      updateTabIndex(ctrl.index);
    });
    super.initState();
  }

  Widget buildTab(double width2, int index, int stateIndex) {
    const List<IconData> tabs = [Icons.brush, Icons.photo];
    return SizedBox(
      height: 50,
      width: width2 / 3 - 20,
      child: Icon(
        tabs[index],
        color: stateIndex == index ? Colors.black : Colors.grey,
      ),
    );
  }

  Widget getWidgetForSource(
      DataProvider prov, bool isGallery, bool isCustom, bool isLogo) {
    if (isGallery) {
      return TextButton(
        child: Text('Pick from gallery'),
        onPressed: () {
          ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
            log('Got $value');
            if (value == null) {
            } else {
              prov.setFilePath(value.path);
            }
          });
        },
      );
    } else if (isLogo) {
      return MyDropdown(
        items: APICallConsts.companyAndDomains.keys.toList(),
        updateBackgroundStyleState: true,
        // updateLogoUrl: (String url) {
        //   prov.setLogoUrl(url);
        // },
      );
    } else if (isCustom) {
      return MyTextboxTemplate(
        type: KeyboardType.alphabet,
        id: '',
        onSubmit: (x) {
          prov.setLogoUrl(x);
        },
      );
    }
    return Container();
  }

  Widget buildBackgroundStyleDialog(
      double height2, double width2, Color? color, BuildContext context) {
    // DataProvider prov = Provider.of<DataProvider>(context, listen: false);
    return Consumer<DataProvider>(builder: (context, prov, _) {
      log('Rebuilt with states: ${prov.isSrcGallery}');

      return AlertDialog(
        title: const Text(
          'Choose Background Style',
          style: headlineMedium,
        ),
        content: SingleChildScrollView(
          child: SizedBox(
            height: height2,
            width: width2,
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: TabBarView(
                    controller: ctrl,
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child:
                                buildMyColorPicker(color ?? Colors.black, (p0) {
                              color = p0;
                            }),
                          ),
                          buildTextButton(doneIcon, 'Select Color', () {
                            prov.add(Helper.getJsonKeyFromHeadline(widget.id),
                                color ?? Colors.black);
                            Navigator.of(context)
                                .pop(BackgroundStyle(color: color));
                          }),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: buildCustomDialogRow(
                              'Source',
                              MyDropdown(
                                items: prov
                                    .backgroundStyleSourceAndHeadlines.keys
                                    .toList(),
                                updateBackgroundStyleSourceState: true,
                                // updateSource: (x) => prov.setSource(x),
                              ),
                            ),
                          ),
                          prov.backgroundStyleSourceState.isEmpty
                              ? Container()
                              : Expanded(
                                  child: buildCustomDialogRow(
                                    prov.backgroundStyleSourceAndHeadlines[
                                        prov.backgroundStyleSourceState]!,
                                    getWidgetForSource(prov, prov.isSrcGallery,
                                        prov.isSrcCustom, prov.isSrcLogos),
                                  ),
                                ),
                          if (prov.isSrcReady)
                            Expanded(
                              child: buildTextButton(
                                Icons.search,
                                'Preview Image',
                                () {
                                  prov.clearImage();
                                  prov.showImage();
                                  log('Current State: ${prov.backgroundStyleSourceState}');
                                },
                              ),
                            ),
                          Expanded(
                            flex: 6,
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              decoration: defaultContainerDecoration,
                              child: buildImageBasedOnSrc(prov),
                            ),
                          ),
                          buildTextButton(
                              doneIcon,
                              'Select Image',
                              () => Navigator.of(context).pop(BackgroundStyle(
                                  src: prov.setImageAndGetText()))),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  width: double.infinity,
                  decoration: const ShapeDecoration(
                    color: Colors.white,
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.0),
                          topRight: Radius.circular(5.0)),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: TabBar(
                    tabAlignment: TabAlignment.center,
                    controller: ctrl,
                    onTap: (_) {
                      prov.updateTabIndex(_);
                    },
                    tabs: List.generate(
                        2,
                        (index) =>
                            buildTab(width2, index, prov.dialogTabIndex)),
                    indicatorColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget buildImageBasedOnSrc(DataProvider prov) {
    log('Logo URL :${prov.logoUrl}');
    return Center(
      child: prov.previewImage
          ? prov.isSrcGallery
              ? Image.file(File(prov.filePath))
              : (prov.isSrcCustom || prov.isSrcLogos)
                  ? Image.network(
                      prov.logoUrl,
                      loadingBuilder: (context, child, loadingProgress) =>
                          loadingProgress == null ? child : buildLoader(),
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Text(ImageError(error).toString()),
                        );
                      },
                    )
                  : Text('Some Error Occured.Retry.')
          : Text('Image will be previewed here..'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      // color: Colors.white,
      decoration: defaultContainerDecoration,
      child: Row(
        children: [
          Expanded(
            child: Container(
              constraints: const BoxConstraints.expand(),
              padding: const EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                color: _defaultColor,
                borderRadius: BorderRadius.circular(6.0),
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                hintText,
                style: hintText == 'Input' ? bodySmall : bodyMedium,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              BackgroundStyle? obj = await showDialog(
                  context: context,
                  builder: (context) {
                    Color? color;
                    var width2 = MediaQuery.of(context).size.width * 0.7;
                    var height2 = MediaQuery.of(context).size.height * 0.7;
                    return buildBackgroundStyleDialog(
                        height2, width2, color, context);
                  });

              setState(() {
                hintText =
                    obj == null ? 'Input' : BackgroundStyle().genHintText(obj);
                _defaultColor =
                    obj == null ? Colors.white : obj.color ?? Colors.white;
              });
            },
          ),
        ],
      ),
    );
  }
}
