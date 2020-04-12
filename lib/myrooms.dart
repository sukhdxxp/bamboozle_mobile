import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MyRooms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String myRooms = """
  query myRooms {
    myRooms {
      title
      id
      participants{
        userID{
        firstName
      }
      }
    }
  }
""";
    return Query(
      options: QueryOptions(
        documentNode: gql(myRooms), // this is the query string you just created
      ),
      builder: (QueryResult result,
          {VoidCallback refetch, FetchMore fetchMore}) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }

        if (result.loading) {
          return Text('Loading');
        }

        // it can be either Map or List
        List rooms = result.data['myRooms'];

        return Scaffold(
          appBar: AppBar(
            title: Text("title"),
          ),
          body: Center(
            child: Container(
              child: ListView(
                children: rooms
                    .map((room) => RaisedButton(
                          child: Text(room["title"] ?? ""),
                          onPressed: () {},
                          color: Colors.lightBlue,
                        ))
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
