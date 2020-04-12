import 'package:bamboozle_flutter/signin.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
      uri: 'http://192.168.0.87:4000/graphql',
    );

    final AuthLink authLink = AuthLink(
      getToken: () async =>
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0eXBlIjoidXNlciIsImZyaWVuZHMiOltdLCJzZW50UmVxdWVzdHMiOltdLCJwZW5kaW5nUmVxdWVzdHMiOltdLCJ2ZXJpZmllZCI6ZmFsc2UsIl9pZCI6IjVlNzc0NmY2YWI5NTRkMDE1Y2M0MjE1ZCIsImZpcnN0TmFtZSI6IkFtaXQiLCJsYXN0TmFtZSI6Ik1pdHRhbCIsImVtYWlsIjoibWl0dGFsbWFpbGJveEBnbWFpbC5jb20iLCJwYXNzd29yZCI6IiQyYiQwNSQ5NzlYTm50S1lZSmV3NjJReGVMN0Z1MWtuTXhyYUE0VGEyYUJSRldNbWNjOWVpU3hCSUhGZSIsInVzZXJuYW1lIjoiYWttaXR0YWwiLCJjcmVhdGVkIjoiMjAyMC0wMy0yMlQxMTowNzozNC41MzJaIiwiX192IjowLCJpYXQiOjE1ODY1MjQ0ODQsImV4cCI6MTU4NzEyOTI4NH0.U0_jvs7XSBH0SYjAOnxz6WMC2Tc8FORd2OpO-evg1qo',
    );

    final Link link = authLink.concat(httpLink);

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        cache: InMemoryCache(),
        link: link,
      ),
    );
    return GraphQLProvider(
        client: client,
        child: MaterialApp(
          title: 'Bamboozle',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SignIn(),
        ));
  }
}
