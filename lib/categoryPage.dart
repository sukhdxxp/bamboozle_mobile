import 'package:bamboozle_flutter/category.dart';
import 'package:bamboozle_flutter/hexColor.dart';
import 'package:bamboozle_flutter/myrooms.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String readRepositories = """
      query categories {
          categories {
          name
          icon
          primaryColor
          }
      }
    """;
    return Query(
      options: QueryOptions(
        documentNode: gql(readRepositories),
      ),
      builder: (QueryResult result,
          {VoidCallback refetch, FetchMore fetchMore}) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }

        if (result.loading) {
          return Text('Loading');
        }

        List repositories = result.data['categories'];

        return Scaffold(
          appBar: AppBar(
            title: Text("title"),
          ),
          body: Center(
            child: GridView.count(
                crossAxisCount: 2,
                children: repositories
                    .map((repo) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyRooms()),
                            );
                          },
                          child: Category(repo["name"],
                              HexColor(repo["primaryColor"]), repo["icon"]),
                        ))
                    .toList()),
          ),
        );
      },
    );
  }
}
