import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:lamit/app/modules/collectionreport/views/collectionreport_view.dart';
import 'package:lamit/app/modules/home/views/home_view.dart';

import 'package:lamit/app/modules/salesinvoiceview/views/salesinvoiceview_view.dart';
import 'package:lamit/app/modules/salesorder/views/salesorder_view.dart';
import 'package:lamit/app/routes/constants.dart';
import 'package:lamit/widget/customeappbar.dart';

class CustomerdetailView extends StatefulWidget {
  final String series;
  final String customer;
  final String status;
  final int indexValue;
  CustomerdetailView(this.series, this.customer, this.status, this.indexValue);

  @override
  State<CustomerdetailView> createState() => _CustomerdetailViewState();
}

class _CustomerdetailViewState extends State<CustomerdetailView> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.to(HomeView("1"));
        return false;
      },
      child: Scaffold(
        // // floatingActionButton: FloatingActionButton.extended(
        // //   backgroundColor: Colors.white,
        // //   onPressed: () {
        // //     // Add your onPressed code here!
        // //   },
        //   label: Row(
        //     children: [
        //       Text(
        //         'Add to a customerdet',
        //         style: TextStyle(color: Colors.black),
        //       ),
        //       Text(
        //         ' ?',
        //         style: TextStyle(color: Colors.green),
        //       ),
        //     ],
        //   ),
        //   icon: const Icon(
        //     Icons.people,
        //   ),
        //   //backgroundColor: Colors.green[100],
        // ),
        backgroundColor: HexColor("#EEf3f9"),
        //floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        // floatingActionButton: FloatingActionButton(
        //   // isExtended: true,
        //   child: Column(
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Text(
        //           "TASK",
        //           style: TextStyle(fontSize: 9),
        //         ),
        //       ),
        //       Icon(
        //         Icons.add,
        //         size: 13,
        //         color: Colors.black,
        //       ),
        //     ],
        //   ),
        //   // backgroundColor: Colors.blue,
        //   onPressed: () {
        //     setState(() {
        //       _showMyDialog();
        //     });
        //   },
        // ),
        appBar: PreferredSize(
          preferredSize:
              Size(MediaQuery.of(context).size.width, kToolbarHeight),
          child: CustomAppBar(
            title: 'CUSTOMER DETAIL',
          ),
        ),
        body: Container(
          color: HexColor("#EEf3f9"),
          child: Stack(
            children: [
              Container(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.0),
                        topLeft: Radius.circular(40.0)),
                  ),
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.only(
                  //         topLeft: Radius.circular(40),
                  //         topRight: Radius.circular(40))),

                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    // color: Colors.blue,
                    width: Constants(context).scrnWidth,
                    height: Constants(context).scrnHeight,
                    child: ContainedTabBarView(
                      initialIndex: widget.indexValue,
                      tabs: [
                        Container(
                          child: Text('SALES ORDER',
                              style: TextStyle(fontSize: 9)),
                        ),
                        Container(
                          child: Text('SALES INVOICE',
                              style: TextStyle(fontSize: 9)),
                        ),
                        Container(
                          child: Text('COLLECTIONS',
                              style: TextStyle(fontSize: 9)),
                        ),
                      ],
                      views: [
                        SalesorderView(widget.series, widget.customer),
                        SalesinvoiceviewView(widget.series, 1),
                        CollectionreportView(widget.series, widget.customer)
                      ],
                      onChange: (index) => print(index),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
