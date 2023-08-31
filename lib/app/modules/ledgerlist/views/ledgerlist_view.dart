import 'package:flutter/material.dart';

class LedgerlistView extends StatefulWidget {
  const LedgerlistView({Key? key}) : super(key: key);

  @override
  State<LedgerlistView> createState() => _LedgerlistViewState();
}

class _LedgerlistViewState extends State<LedgerlistView> {
  @override
  void initState() {
    print("haai");
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'LedgerList',
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
        //title: const Text('LedgerlistView'),
        // centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Card(
                    color: Colors.blue[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 5,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    "Mobile ",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text("Ob  ", style: TextStyle(fontSize: 15)),
                                  Text("Vat Num",
                                      style: TextStyle(fontSize: 15)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ":",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    ":",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text(":", style: TextStyle(fontSize: 15)),
                                  Text(":", style: TextStyle(fontSize: 15)),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    // ledgerList[index]['name'],
                                    "name",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                      // ledgerList[index]['grou'],
                                      "group",
                                      style: TextStyle(fontSize: 15)),
                                  Text("balace",
                                      //  ledgerList[index]['balance'].toString(),
                                      style: TextStyle(fontSize: 15)),
                                  Text("descripction",
                                      //ledgerList[index]['des'],
                                      style: TextStyle(fontSize: 15)),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      //deleteConfirm(index);
                                    });
                                  },
                                  icon: Icon(Icons.delete),
                                  iconSize: 20,
                                  color: Colors.red,
                                ),
                                IconButton(
                                  onPressed: () {
                                    // Navigator.pushReplacement(
                                    //     context,
                                    //     CupertinoPageRoute(
                                    //         builder: (context) => Ledger(
                                    //               id.toString(),
                                    //               "isEDIT",
                                    //               name.toString(),
                                    //               grou.toString(),
                                    //               balance.toString(),
                                    //               des.toString(),
                                    //             )));
                                  },
                                  icon: Icon(Icons.edit),
                                  iconSize: 20,
                                  color: Colors.green,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
