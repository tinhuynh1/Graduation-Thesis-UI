import 'package:Food_Order/data/remote/place_service.dart';
import 'package:flutter/material.dart';

class AddressSearch extends SearchDelegate<Suggestion> {
  AddressSearch(this.sessionToken) {
    apiClient = PlaceApiProvider(sessionToken);
  }

  final sessionToken;
  PlaceApiProvider apiClient;
  @override
  String get searchFieldLabel => 'Địa chỉ giao hàng';
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: Colors.white,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
      // //primaryColorBrightness: Brightness.dark,
      textTheme: theme.textTheme.copyWith(
        title: TextStyle(fontWeight: FontWeight.normal),
      ),
    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: query == "" ? null : apiClient.fetchSuggestions(query),
        builder: (context, snapshot) => query == ''
            ? Container(
                padding: EdgeInsets.all(16.0),
                child: Text('Loading...'),
              )
            : snapshot.hasData
                ? ListView.builder(
                    itemBuilder: (context, index) => ListTile(
                      leading: Icon(
                        Icons.location_on,
                      ),
                      title: Text(
                          (snapshot.data[index] as Suggestion).description),
                      onTap: () {
                        close(context, snapshot.data[index] as Suggestion);
                      },
                    ),
                    itemCount: snapshot.data.length,
                  )
                : Container(child: Text('Loading...')),
      ),
    );
  }
}
