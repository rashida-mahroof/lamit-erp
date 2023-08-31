import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lamit/widget/customeappbar.dart';
import '../leaddetails/views/leaddetails_view.dart';
import 'api.dart';
import 'popupitemWidget.dart';

class EngineerListView extends StatefulWidget {
  const EngineerListView({super.key});

  @override
  State<EngineerListView> createState() => _EngineerListViewState();
}

class _EngineerListViewState extends State<EngineerListView> {
  var dataList;
  final nameController = TextEditingController();
  var selectedKey = 'all';
  var searchText = '';

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size(MediaQuery.of(context).size.width, kToolbarHeight),
          child: CustomAppBar(
            title: 'Leads Converted to engineer',
            actions: [
              PopupMenuButton<int>(
                position: PopupMenuPosition.under,
                itemBuilder: (context) => [
                  PopupMenuItem(
                      value: 0,
                      enabled: false,
                      child: Text(
                        'Filter By',
                        style: TextStyle(fontSize: 11, color: Colors.black45),
                      )),
                  const PopupMenuDivider(),
                  const PopupMenuItem<int>(
                      value: 1,
                      child: PopUpMenuItemWidget(
                        icon: CupertinoIcons.person,
                        title: 'Name',
                      )),
                  const PopupMenuItem<int>(
                      value: 2,
                      child: PopUpMenuItemWidget(
                        icon: CupertinoIcons.phone,
                        title: 'Mobile',
                      )),
                  const PopupMenuItem<int>(
                      value: 3,
                      child: PopUpMenuItemWidget(
                        icon: CupertinoIcons.line_horizontal_3_decrease,
                        title: 'All',
                      )),
                ],
                onSelected: (item) => SelectedItem(context, item),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Visibility(
              visible: selectedKey == 'all' ? false : true,
              child: DropdownSearch<dynamic>(
                  showSearchBox: true,
                  popupTitle: Text('Select $selectedKey'),
                  popupElevation: 1,
                  maxHeight: MediaQuery.of(context).size.height / 1.2,
                  showClearButton: true,

                  // showSelectedItems: true,
                  clearButtonBuilder: (context) {
                    return IconButton(
                        onPressed: () {
                          setState(() {
                            searchText = '';
                          });
                        },
                        icon: Icon(Icons.close));
                  },
                  searchFieldProps: TextFieldProps(),
                  popupShape: BeveledRectangleBorder(),
                  // popupProps: PopupProps.dialog(),
                  items: (selectedKey == 'name') ? engNameList : engMobileList,
                  onChanged: (Value) {
                    setState(() {
                      if (selectedKey == 'name') {
                        searchText = Value.toString().split(' (').first;
                      } else {
                        searchText = Value.toString();
                      }
                    });
                  },
                  selectedItem:
                      searchText == '' ? 'Select $selectedKey' : searchText),
            ),
            Expanded(
              child: FutureBuilder(
                  future: selectedKey == 'all'
                      ? fetchData(1)
                      : filterData(1, selectedKey, searchText),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if(snapshot.data.length > 0){
                         return ListView.separated(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) {
                          return ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                            onTap: () {
                              Get.to(LeaddetailsView(
                                snapshot.data[i]["name1"],
                                "new",
                                0,
                                "",
                                snapshot.data[i]["email"],
                                snapshot.data[i]["lead_id"],
                              ));
                            },
                            title: Text(
                              snapshot.data[i]["name1"]
                                  .toString()
                                  .toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 13),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 6,
                                ),
                                if (snapshot.data[i]["mobile"] != null)
                                  Text(snapshot.data[i]["mobile"].toString()),
                                if (snapshot.data[i]["email"] != null)
                                  Text(snapshot.data[i]["email"].toString())
                              ],
                            ),
                            trailing: (snapshot.data[i]["mobile"] != null)
                                ? Text(snapshot.data[i]["creation"]
                                    .toString()
                                    .split(" ")
                                    .first)
                                : Text(''),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider();
                        },
                      );
                    
                      }else{
                        return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.grey.shade300,
                                  size: 100,
                                ),
                                Text(
                                  'No Leads Available',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black45),
                                )
                              ],
                            ),
                          );
                      }
                     } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          ],
        ));
  }

  SelectedItem(BuildContext context, item) {
    switch (item) {
      case 1:
        setState(() {
          selectedKey = 'name';
          searchText = '';
        });
        break;
      case 2:
        setState(() {
          selectedKey = 'mobile';
          searchText = '';
        });
        break;
      case 3:
        setState(() {
          selectedKey = 'all';
          searchText = '';
        });
        break;
    }
  }
}
