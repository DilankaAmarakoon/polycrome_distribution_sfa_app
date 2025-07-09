

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qcom_erp/theme/theme_data.dart';
import 'package:responsive_table/responsive_table.dart';
import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;
import '../data_models/common_model.dart';
import '../data_models/common_model_string.dart';

class MyDropDown {
  MyDropDown({
    required this.items,
    required this.selectedItem,
    required this.label,
    required this.onChanged,
    this.showSearchBox = false,
    this.enabled = true,
    this.isMandatory, this.popupItemBuilder,
    this.height,
    this.fontSize
  });

  List<CommonModel> items = [];
  CommonModel? selectedItem;
  bool enabled = true;
  String label;
  bool showSearchBox = false;
  bool? isMandatory;
  double? height;
  double? fontSize;
  ValueChanged<CommonModel?> onChanged;

  Widget Function(BuildContext context, CommonModel? item, bool isSelected)? popupItemBuilder;

  ThemeDataMap themeData = ThemeDataMap();
  Widget get() {
    return Container(
      height: height ?? 26,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5)),
        //  border: InputBorder() ,
      ),
      child: Theme(
          data: ThemeData(
            primaryColor: Colors.black45,
            primaryColorDark: Colors.black,
          ),
          child: DropdownSearch<CommonModel>(
            // mode: Mode.MENU,
              enabled: enabled,
              items: items,
              popupProps: PopupProps.menu(
                scrollbarProps: ScrollbarProps(),
                emptyBuilder: (context, searchEntry) {
                  return const SizedBox();
                },
                fit: FlexFit.tight,
                showSearchBox: (items.length > 5),
                containerBuilder: (context, popupWidget) {
                  return Container(height: 145, child: popupWidget,);
                },
                itemBuilder: popupItemBuilder ?? (context, item, isSelected) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      item.name ?? '',
                      // style: GoogleFonts.titilliumWeb(
                      //     fontSize: fontSize ?? 12,
                      //     color: Colors.black,
                      //     fontWeight: FontWeight.w600,
                      // ),
                      style: themeData.getTextStyle(TextStyleType.nonTopic),
                    ),
                  );
                },

                searchFieldProps: TextFieldProps(

                  decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder()
                  ),
                  padding: EdgeInsets.zero,
                    autofocus: true,
                    // style: TextStyle(
                    //   color: Colors.black,
                    //   fontSize: fontSize ?? 12,
                    //   fontWeight: FontWeight.bold,
                    // ),
                  style: themeData.getTextStyle(TextStyleType.nonTopic),
                  // decoration: InputDecoration(
                  //   isDense: true,
                  //   border: UnderlineInputBorder(
                  //     borderSide: BorderSide(color: Colors.grey),
                  //   ),
                  //   focusedBorder: UnderlineInputBorder(
                  //     borderSide: BorderSide(color: Colors.grey),
                  //   ),
                  //   prefixIcon: Icon(Icons.search, color: Colors.grey), // Search icon
                  //   hintText: '', // No hint text
                  // ),
                ),
              ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                    counterText: '',
                    labelText: label,
                    // labelStyle: GoogleFonts.titilliumWeb(
                    //   fontWeight: FontWeight.w600,
                    //   fontSize: 12,
                    //   color: Colors.blueGrey,
                    // ),
                    labelStyle: themeData.getTextStyle(TextStyleType.nonTopic),
                    // floatingLabelStyle: GoogleFonts.titilliumWeb(
                    //     fontSize: fontSize ?? 12,
                    //     color: Colors.blueGrey,
                    //     fontWeight: FontWeight.w600),
                    floatingLabelStyle: themeData.getTextStyle(TextStyleType.nonTopic),
                    prefixIcon: isMandatory != null ? isMandatory! ? const Icon(
                      Icons.star, color: Colors.red, size: 8,) : null : null,

                  )
              ),
              // dropdownSearchBaseStyle: GoogleFonts.titilliumWeb(
              //     fontSize: fontSize ?? 12,
              //     color: Colors.black,
              //     fontWeight: FontWeight.w600),
              //   label: label,

            itemAsString: (CommonModel? item) => item?.name ?? '',
            dropdownBuilder: selectedItem != null ? _customDropDownText : null,
            dropdownButtonProps:  DropdownButtonProps(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                icon: Icon(Icons.arrow_drop_down, size: 12, color: ThemeDataMap().primaryDarkBluColor,),
            ),
          // dropDownButton: _customDropDownButton(),

          // popupItemBuilder: popupItemBuilder ?? (context, item, isSelected) {
          //   return Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Text(
          //       item.name ?? '',
          //       style: GoogleFonts.titilliumWeb(
          //           fontSize: fontSize ?? 12,
          //           color: Colors.black,
          //           fontWeight: FontWeight.w600),
          //     ),
          //   );
          // },
          selectedItem: selectedItem,
          // popupBarrierColor: Colors.black54,
          // showSearchBox: (items.length > 5),
          onChanged: onChanged,
          ),
    ),);
  }

  Widget _customDropDownText(BuildContext context, CommonModel? item) {
    return Text(
      item!.name ?? '',
      // style: GoogleFonts.titilliumWeb(
      //     fontSize: 13, color: Colors.black, fontWeight: FontWeight.w600),
      style: themeData.getTextStyle(TextStyleType.nonTopic),
    );
  }

  Widget _customDropDownButton() {
    return const Icon(Icons.arrow_drop_down, size: 12);
  }
}

class MyDropDownCommonString {
  MyDropDownCommonString({
    required this.items,
    required this.selectedItem,
    required this.label,
    required this.onChanged,
    this.showSearchBox = false,
    this.enabled = true,
    this.isMandatory = false,
  });

  List<CommonModelString> items = [];
  CommonModelString? selectedItem;
  bool enabled = true;
  String label;
  bool showSearchBox = false;
  ValueChanged<CommonModelString?> onChanged;
  bool? isMandatory;

  ThemeDataMap themeData = ThemeDataMap();
  Widget get() {
    return Container(
      height: 26,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5)),
        //border: Border.all(color: Colors.grey),
      ),
      child: DropdownSearch<CommonModelString>(
          // mode: Mode.MENU,
          enabled: enabled,
          items: items,
          // label: label,
          // searchFieldProps: TextFieldProps(autofocus: true,
          //     style: const TextStyle(
          //         color: Colors.black,
          //         fontSize: 13,
          //         fontWeight: FontWeight.bold)),
          popupProps: PopupProps.menu(
            menuProps: MenuProps(
              // positionCallback: (RenderBox popupButtonObject,
              //     RenderBox overlay,) {
              //   log("positionCallback");
              //   return RelativeRect.fromSize(Rect.zero, Size(25,25));
              // },
            ),
            emptyBuilder: (context, searchEntry) {
              return const SizedBox();
            },
            containerBuilder: (context, popupWidget) {
              return Container(height: 140, child: popupWidget,);
            },
            showSearchBox: (items.length > 5),
            itemBuilder: (context, item, isSelected) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  item.name ?? '',
                  // style: GoogleFonts.titilliumWeb(
                  //     fontSize:   12,
                  //     color: Colors.black,
                  //     fontWeight: FontWeight.w600),
                  style: themeData.getTextStyle(TextStyleType.nonTopic),
                ),
              );
            },
            searchFieldProps:  TextFieldProps(autofocus: true,
                // style: TextStyle(
                //   color: Colors.black,
                //   fontSize:   12,
                //   fontWeight: FontWeight.bold,)
                style: themeData.getTextStyle(TextStyleType.nonTopic),

            ),
          ),
          dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                counterText: '',
                labelText: label,
                // labelStyle: const TextStyle(
                //     color: Colors.blueGrey, fontSize: 13,
                //     fontWeight: FontWeight.w600),
                labelStyle: themeData.getTextStyle(TextStyleType.nonTopic),
                // floatingLabelStyle: GoogleFonts.titilliumWeb(
                //     fontSize:  12,
                //     color: Colors.blueGrey,
                //     fontWeight: FontWeight.w600),
                floatingLabelStyle: themeData.getTextStyle(TextStyleType.nonTopic),
                prefixIcon: isMandatory != null ? isMandatory! ? const Icon(
                  Icons.star, color: Colors.red, size: 8,) : null : null,

              )
          ),
          itemAsString: (CommonModelString? item) => item?.name ?? '',
          dropdownBuilder: _customDropDownText,
          // dropDownButton: _customDropDownButton(),
          dropdownButtonProps:  const DropdownButtonProps(icon: Icon(Icons.arrow_drop_down, size: 12)),
          selectedItem: selectedItem,
          // popupBarrierColor: Colors.black54,
          // showSearchBox: (items.length > 5),
          onChanged: onChanged
      ),
    );
  }

  Widget _customDropDownText(BuildContext context, CommonModelString? item) {
    return Container(
      child: Row(
        children: [
          // isMandatory! ? const Padding(
          //   padding: EdgeInsets.only(right: 6.0),
          //   child: Icon(Icons.star, color: Colors.red, size: 8,),
          // ) : const SizedBox(),
          Text(
            item?.name ?? '',
            // style: GoogleFonts.titilliumWeb(fontSize: 13, color: Colors.black,),
            style: themeData.getTextStyle(TextStyleType.nonTopic),
          ),
        ],
      ),
    );
  }

  Widget _customDropDownButton() {
    return const Icon(Icons.arrow_drop_down, size: 18);
  }
}
