import 'package:bamboozle_flutter/category.dart';
import 'package:bamboozle_flutter/hexColor.dart';
import 'package:bamboozle_flutter/room.dart';
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
        documentNode:
            gql(readRepositories), // this is the query string you just created
        variables: {
          'nRepositories': 50,
        },
        pollInterval: 10,
      ),
      // Just like in apollo refetch() could be used to manually trigger a refetch
      // while fetchMore() can be used for pagination purpose
      builder: (QueryResult result,
          {VoidCallback refetch, FetchMore fetchMore}) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }

        if (result.loading) {
          return Text('Loading');
        }

        // it can be either Map or List
        List repositories = result.data['categories'];

        return Scaffold(
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text("title"),
          ),
          body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: GridView.count(
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                crossAxisCount: 2,
                // Generate 100 widgets that display their index in the List.
                children: repositories
                    .map((repo) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Room()),
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
