import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:products/common widgets/item_card.dart';

import 'common widgets/item_card.dart';

class Search extends StatelessWidget {
  Search({Key? key}) : super(key: key);

  String searchIcon = "assets/icons/search_icon.svg";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {
          showSearch(
            context: context,
            delegate: CustomSearchDelegate(),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              searchIcon,
            ),
            const SizedBox(
              width: 12,
            ),
            const Text(
              "Search Store",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7C7C7C)),
            )
          ],
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(
            Icons.clear,
          )),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  late List<String> names;
  @override
  Widget buildResults(BuildContext context) {
    for (int i = 0; i < ItemCard.cards.length; i++) {
      names.add(ItemCard.cards.elementAt(i).item.name);
    }
    List<String> matchQuery = [];
    for (var n in names) {
      if (n.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(n);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var n in names) {
      if (n.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(n);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}
