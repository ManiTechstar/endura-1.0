import 'package:endura_app/core/constants/color_constants.dart';
import 'package:endura_app/core/constants/font_family_constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SearchSelectionDialogView extends StatefulWidget {
  SearchSelectionDialogView({
    Key? key,
    required this.items,
    required this.searchHint,
    required this.title,
    this.function,
  }) : super(key: key);

  List<String> items = [];
  String searchHint = '';
  String title = '';
  final Function(int index)? function;

  List<String> filteredItems = [];

  @override
  State<StatefulWidget> createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchSelectionDialogView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    widget.filteredItems.addAll(widget.items);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        height: widget.items.isEmpty
            ? 150.0
            : widget.items.length <= 3
                ? 300
                : 500.0,
        width: double.maxFinite,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            color: ColorConstants.black1.withOpacity(0.8),
            width: double.infinity,
            padding: const EdgeInsets.all(18.0),
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(117, 25, 3, 0.13)),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: ColorConstants.black1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: ColorConstants.black1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        hintText: widget.searchHint,
                        suffixIcon: _searchController.text.isEmpty
                            ? const SizedBox()
                            : InkWell(
                                onTap: () {
                                  _searchController.clear();
                                  setState(() {
                                    widget.filteredItems = widget.items;
                                  });
                                },
                                child: const Icon(
                                  Icons.clear,
                                  color: ColorConstants.black1,
                                ))),
                    onChanged: (value) {
                      // Filter the list based on the search text
                      setState(() {
                        widget.filteredItems = widget.items
                            .where((item) => item
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                            .toList();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: widget.filteredItems.isNotEmpty
                ? ListView.separated(
                    separatorBuilder: (context, index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: const Divider(
                        thickness: .1,
                        color: ColorConstants.black1,
                      ),
                    ),
                    shrinkWrap: true,
                    itemCount: widget.filteredItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          widget.filteredItems[index],
                          textAlign: TextAlign.center,
                        ),
                        onTap: () {
                          // Do something when an item is selected
                          if (widget.function != null) widget.function!(index);
                          Get.back(result: widget.filteredItems[index]);
                        },
                      );
                    },
                  )
                : Center(
                    child: Text(
                      "No data available",
                      style: TextStyle(
                          color: ColorConstants.black1.withOpacity(0.7),
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          fontFamily: FontFamilyConstants.mulishExtraBold),
                    ),
                  ),
          ),
        ]),
      ),
    );
  }
}
