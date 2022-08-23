import 'package:clothing_waste_app/utils/notifications.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget with PreferredSizeWidget{
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchBarState extends State<SearchBar> {
  Icon _searchIcon = const Icon(Icons.search);
  dynamic _searchText = const Text("Search for...");
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: _searchText,
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              if (_searchIcon.icon == Icons.search) {
                _searchIcon = const Icon(Icons.cancel);
                TextField field = TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: "Type in item name",
                  ),
                );
                _searchText = field;
                print(_searchController.text);
              } else {
                _searchText = const Text("Search for...");
                _searchIcon = const Icon(Icons.search);
              }
            });
          },
          icon: _searchIcon,
        ),
      ],
      centerTitle: true,
    );
  }
}
