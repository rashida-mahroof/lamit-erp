import 'package:flutter/material.dart';

import 'package:lamit/app/routes/constants.dart';
import 'package:url_launcher/url_launcher.dart';

// adb tcpip 5555
//  adb connect phone ip;

class AboutView extends StatefulWidget {
  final String? name;

  final String? status;

  final String? contacts;
  final String? direction;

  final String? email;

  AboutView(
    this.name,
    this.status,
    this.contacts,
    this.email,
    this.direction,
  );

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  //bool _hasCallSupport = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('AboutView'),
        //   centerTitle: true,
        // ),
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            child: ListTile(
              leading: Container(
                height: 20,
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Text(
                    "A",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              title: Text(widget.name.toString()),
              subtitle: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        widget.status.toString(),
                        style: TextStyle(backgroundColor: Colors.red[100]),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 8),
                      //   child: Icon(
                      //     Icons.edit,
                      //     size: 20,
                      //   ),
                      // )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 1,
              width: Constants(context).scrnWidth,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    _makePhoneCall(widget.contacts == ""
                        ? "No number"
                        : widget.contacts.toString());
                  },
                  child: Container(
                    child: Card(
                      color: Colors.grey[100],
                      child: Column(
                        children: [
                          Icon(
                            Icons.phone,
                            size: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Text(
                                "Contacts",
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    _launchEmail();
                    print("maill");
                  },
                  child: Container(
                    child: Card(
                      color: Colors.grey[100],
                      child: Column(
                        children: [
                          Icon(
                            Icons.email,
                            size: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Email",
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
                Expanded(
                    child: Card(
                  color: Colors.grey[100],
                  child: Column(
                    children: [
                      Icon(
                        Icons.directions,
                        size: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Direction",
                          style: TextStyle(fontSize: 13),
                        ),
                      )
                    ],
                  ),
                )),
                Expanded(
                    child: Card(
                  color: Colors.grey[100],
                  child: Column(
                    children: [
                      Icon(
                        Icons.star,
                        size: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Star",
                          style: TextStyle(fontSize: 13),
                        ),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: Constants(context).scrnWidth,
              child: Card(
                // color: Colors.blue[50],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Name: " + widget.name.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "E-Mail: " + widget.email.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Phone:" + widget.contacts.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "location:" + widget.direction.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ))
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Card(child: ExpansionTile(title: Text('key detail'))),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Card(child: ExpansionTile(title: Text('key detail'))),
          // )
        ],
      ),
    ));
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  _launchEmail() async {
    var a = widget.email;
    // ignore: deprecated_member_use
    if (await canLaunch("mailto:$a")) {
      // ignore: deprecated_member_use
      await launch("mailto:$a");
    } else {
      throw 'Could not launch';
    }
  }
}
