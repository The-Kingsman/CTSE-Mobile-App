import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teach_rate/providers/RateProvider.dart';
import 'package:teach_rate/screens/rating/add_rating_screen.dart';
import 'package:teach_rate/screens/rating/view_rating_screen.dart';
import 'package:teach_rate/widgets/common/app_drawer.dart';
import 'package:teach_rate/widgets/rating/rate_tile.dart';

class RatingScreen extends StatefulWidget {
  final String teacherId;
  const RatingScreen(this.teacherId);

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isAdmin = false;

  bool loading = false;
  String searchText = '';
  late Timer searchOnStoppedTyping;
  final _controller = ScrollController();

  @override
  initState() {
    checkAdmin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<RateProvider>(context, listen: false)
        .fetchRatingByTeacher(widget.teacherId);

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text(''),
        elevation: 1.0,
        centerTitle: false,
      ),
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => addRate(widget.teacherId.toString()),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: Consumer<RateProvider>(
                builder: (context, provider, child) => ListView.builder(
                  padding: const EdgeInsets.only(
                      bottom: kFloatingActionButtonMargin + 48),
                  controller: _controller,
                  itemCount: provider.ratings.length,
                  itemBuilder: (context, index) => Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      deleteRateDialog(provider.ratings[index].id);
                    },
                    direction: DismissDirection.endToStart,
                    background: const Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ViewRatingScreen(provider.ratings[index]),
                          ),
                        );
                      },
                      child: RateTile(provider.ratings[index]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  checkAdmin() async {
    final prefs = await SharedPreferences.getInstance();
    var role = prefs.getString('role');
    if (role.toString() == 'ADMIN') {
      setState(() {
        isAdmin = true;
      });
    }
  }

  deleteRateDialog(id) {
    showDialog(
      context: context,
      builder: (ctx) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: AlertDialog(
          elevation: 0.0,
          title: Row(
            children: const [
              Icon(
                Icons.delete,
                size: 25,
              ),
              SizedBox(
                width: 10,
              ),
              Text("Delete Rate"),
            ],
          ),
          content: const Text(
            'Are you sure you want to do this ?',
            style: TextStyle(fontSize: 14),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  setState(() {});
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.grey[600]),
                )),
            TextButton(
                onPressed: () {
                  deleteRate(id);
                },
                child: const Text(
                  "Delete",
                  style: TextStyle(color: Colors.red),
                ))
          ],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  deleteRate(rateID) async {
    await Provider.of<RateProvider>(context, listen: false)
        .deleteRating(rateID)
        .then(
      (result) {
        Navigator.pop(context);
        if (result is String) {
          Fluttertoast.showToast(
            msg: result,
            backgroundColor: Colors.red.shade500,
            toastLength: Toast.LENGTH_SHORT,
          );
        } else {
          Provider.of<RateProvider>(context, listen: false).fetchRating(rateID);
        }
      },
      onError: (message) {
        Navigator.pop(context);
        Fluttertoast.showToast(
          msg: message,
          backgroundColor: Colors.red.shade500,
          toastLength: Toast.LENGTH_SHORT,
        );
      },
    );
  }
}
