import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swarn_holidays_business_main/msssenger/views/chatscreen.dart';
import 'package:swarn_holidays_business_main/widgets/progress.dart';
import '../utilities/constants.dart';

class SearchScreenS extends StatefulWidget {
  const SearchScreenS({
    Key? key,
  }) : super(key: key);

  @override
  _SearchScreenSState createState() => _SearchScreenSState();
}

class _SearchScreenSState extends State<SearchScreenS> {
  Stream<QuerySnapshot>? searchResultsFuture;
  String query = '';
  TextEditingController searchController = TextEditingController();

  handleSearch(String query) {
    Stream<QuerySnapshot> users = FirebaseFirestore.instance
        .collection('users')
        .where('firstName', isGreaterThanOrEqualTo: query)
        .snapshots();

    setState(() {
      searchResultsFuture = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: TextField(
                controller: searchController,
                onChanged: (String val) {
                  setState(() {
                    query = val;
                  });
                  handleSearch(query);
                },
                cursorColor: Colors.grey,
                autofocus: true,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 35),
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          //   WidgetsBinding.instance!.addPostFrameCallback(
                          //   (_) =>
                          searchController.clear();
                          // );
                        },
                        icon: const Icon(Icons.close, color: Colors.white)),
                    border: InputBorder.none,
                    hintText: 'Search',
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        color: Color(0x88ffffff))),
              ),
            ),
            preferredSize: const Size.fromHeight(kToolbarHeight + 20),
          ),
        ),
        body: SingleChildScrollView(
            //ListView(
            //   padding: EdgeInsets.symmetric(horizontal: 20),
            //   child: buildSuggestions(query),
            //  children: [
            child: searchResultsFuture == null
                ? Container()
                : buildSearchResults())
        //   ],
        //  ),
        );
  }

  buildSearchResults() {
    return StreamBuilder(
        stream: searchResultsFuture,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return circularProgress();
          }
          List<Column> searchResults = [];
          for (var doc in snapshot.data!.docs) {
            searchResults.add(Column(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatScreen(
                                  profileId: doc['id'],
                                  currentUserId: currentUserId,
                                  myfirstname: firstName,
                                  mysecondname: secondName,
                                  myprofImg: profileImageUrl,
                                  firstname: doc['firstName'],
                                  secondname: doc['secondName'],
                                  profImg: doc['profileImageUrl'],
                                )));
                  },
                  leading: circleavatar(doc),
                  title: Text(
                    '${doc['firstName']} ${doc['secondName']}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(height: 4, color: Colors.transparent)
              ],
            ));
          }
          return Column(children: searchResults);
        });
  }

  circleavatar(doc) {
    String firstname = doc['firstName'];
    String secondname = doc['secondName'];
    String? profImg = doc['profileImageUrl'];
    bool isProfImg = profImg == null;
    return CircleAvatar(
      backgroundColor: Colors.purple.shade800,
      child: isProfImg
          ? Center(
              child: Text(
                  '${firstname[0].toUpperCase()} ${secondname[0].toUpperCase()}'),
            )
          : CircleAvatar(backgroundImage: CachedNetworkImageProvider(profImg)),
    );
  }
}
