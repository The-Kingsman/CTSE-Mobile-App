import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final Function updateSearchText;
  final String searchType;

  const SearchBar(this.updateSearchText, this.searchType);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      style: const TextStyle(
        fontSize: 12.0,
      ),
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.grey,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
            width: 1,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
        hintStyle: const TextStyle(
          fontSize: 12.0,
          color: Colors.grey,
        ),
        hintText: 'Search for a $searchType',
      ),
      onChanged: (value) {
        updateSearchText(value);
      },
    );
  }
}
