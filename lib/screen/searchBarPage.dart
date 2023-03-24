import 'package:design_demo/Routes/visibilityModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../Routes/AppLocalizations.dart';

final FocusNode focusNode = FocusNode();

class searchBarPage extends StatefulWidget {
  const searchBarPage({super.key});

  @override
  State<searchBarPage> createState() => _searchBarPageState();
}

class _searchBarPageState extends State<searchBarPage> {
  final TextEditingController _controller = TextEditingController();
  List<String> myList = [
    'apple',
    'banana',
    'cherry',
    'charr',
    'chrrey',
    'date',
    'elderberry',
    'fig'
  ];

  String _selectedItem = '';

  List<String> filteredList = [];
  @override
  void initState() {
    super.initState();
    filteredList.addAll(myList);
  }

  @override
  void dispose() {
    _controller.dispose();
    //focusNode.dispose();
    super.dispose();
  }

  void filterList(String query) {
    filteredList.clear();
    if (query.isNotEmpty) {
      myList.forEach((item) {
        if (item.toLowerCase().contains(query.toLowerCase())) {
          filteredList.add(item);
        }
      });
    } else {
      filteredList.addAll(myList);
    }
    Provider.of<visibilityModel>(context, listen: false).toggleVisibility(true);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<visibilityModel>(
      builder: (context, value, child) {
        return Container(
          margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
                child: Material(
                  child: TextField(
                    key: const Key('search_textfield'),
                    onChanged: (value) {
                      filterList(value);
                    },
                    focusNode: focusNode,
                    onTap: () {
                      Provider.of<visibilityModel>(context, listen: false)
                          .toggleVisibility(true);
                    },
                    controller: _controller,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText:
                            AppLocalizations.of(context)?.translate('Search') ??
                                'Srch', //loccalizations
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: value.isVisible
                            ? IconButton(
                                onPressed: () {
                                  Provider.of<visibilityModel>(context,
                                          listen: false)
                                      .toggleVisibility(false);
                                  focusNode
                                      .unfocus(); //Errorr here when focousnode dispose it can be used
                                },
                                icon: const Icon(Icons.clear),
                              )
                            : const Text('')),
                  ),
                ),
              ),
              Visibility(
                visible: value.isVisible,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.90,
                  child: ListView.builder(
                    key: const Key('search_listv'),
                    itemCount: filteredList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedItem = filteredList[index];
                            _controller.text = _selectedItem;
                            Provider.of<visibilityModel>(context, listen: false)
                                .toggleVisibility(false);
                            focusNode.unfocus();
                          });
                        },
                        child: Material(
                          child: ListTile(
                            title: Text(filteredList[index]),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
