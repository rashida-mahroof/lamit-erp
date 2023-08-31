import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/orderlist_controller.dart';

class OrderlistView extends GetView<OrderlistController> {
  const OrderlistView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'OrderList',
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
                                      "Date",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      "staff",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text("product",
                                        style: TextStyle(fontSize: 15)),
                                    Text("price",
                                        style: TextStyle(fontSize: 15)),
                                    Text("qouantity",
                                        style: TextStyle(fontSize: 15)),
                                    Text("Total",
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
                                      "Date",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      "staff",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text("product",
                                        style: TextStyle(fontSize: 15)),
                                    Text("price",
                                        style: TextStyle(fontSize: 15)),
                                    Text("qouantity",
                                        style: TextStyle(fontSize: 15)),
                                    Text("Total",
                                        style: TextStyle(fontSize: 15)),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      // setState(() {
                                      //   //deleteConfirm(index);
                                      // });
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
        ));
  }
}
