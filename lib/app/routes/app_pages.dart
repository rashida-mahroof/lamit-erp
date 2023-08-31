import 'package:get/get.dart';

import '../modules/about/bindings/about_binding.dart';
import '../modules/about/views/about_view.dart';
import '../modules/addactivity/bindings/addactivity_binding.dart';
import '../modules/addactivity/views/addactivity_view.dart';
import '../modules/addaddress/bindings/addaddress_binding.dart';
import '../modules/addaddress/views/addaddress_view.dart';
import '../modules/addbaisicdetail/bindings/addbaisicdetail_binding.dart';
import '../modules/addbaisicdetail/views/addbaisicdetail_view.dart';
import '../modules/addcollect/bindings/addcollect_binding.dart';
import '../modules/addcollect/views/addcollect_view.dart';
import '../modules/addcustomer/bindings/addcustomer_binding.dart';
import '../modules/addcustomer/views/addcustomer_view.dart';
import '../modules/addlocation/bindings/addlocation_binding.dart';
import '../modules/addlocation/views/addlocation_view.dart';
import '../modules/addnote/bindings/addnote_binding.dart';
import '../modules/addnote/views/addnote_view.dart';
import '../modules/addnotes/bindings/addnotes_binding.dart';
import '../modules/addnotes/views/addnotes_view.dart';
import '../modules/addqoutationadd/bindings/addqoutationadd_binding.dart';
import '../modules/addqoutationadd/views/addqoutationadd_view.dart';
import '../modules/addquatat/bindings/addquatat_binding.dart';
import '../modules/addquatat/views/addquatat_view.dart';
import '../modules/addressview/bindings/addressview_binding.dart';
import '../modules/addressview/views/addressview_view.dart';
import '../modules/addtask/bindings/addtask_binding.dart';
import '../modules/addtask/views/addtask_view.dart';
import '../modules/addtaskdash/bindings/addtaskdash_binding.dart';
import '../modules/addtaskdash/views/addtaskdash_view.dart';
import '../modules/baisicdetail/bindings/baisicdetail_binding.dart';
import '../modules/baisicdetail/views/baisicdetail_view.dart';
import '../modules/closed/bindings/closed_binding.dart';
import '../modules/closed/views/closed_view.dart';
import '../modules/collection/bindings/collection_binding.dart';
import '../modules/collection/views/collection_view.dart';
import '../modules/collectionreport/bindings/collectionreport_binding.dart';
import '../modules/collectionreport/views/collectionreport_view.dart';
import '../modules/customerdetail/bindings/customerdetail_binding.dart';
import '../modules/customerdetail/views/customerdetail_view.dart';
import '../modules/customrcreation/bindings/customrcreation_binding.dart';
import '../modules/customrcreation/views/customrcreation_view.dart';
import '../modules/customrlist/bindings/customrlist_binding.dart';
import '../modules/customrlist/views/customrlist_view.dart';
import '../modules/dash/bindings/dash_binding.dart';
import '../modules/dash/views/dash_view.dart';
import '../modules/details/bindings/details_binding.dart';
import '../modules/details/views/details_view.dart';
import '../modules/event/bindings/event_binding.dart';
import '../modules/event/views/event_view.dart';
import '../modules/evetview/bindings/evetview_binding.dart';
import '../modules/evetview/views/evetview_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/hotlead/bindings/hotlead_binding.dart';
import '../modules/hotlead/views/hotlead_view.dart';
import '../modules/lead/bindings/lead_binding.dart';
import '../modules/lead/views/lead_view.dart';
import '../modules/leadadd/bindings/leadadd_binding.dart';
import '../modules/leadadd/views/leadadd_view.dart';
import '../modules/leaddetails/bindings/leaddetails_binding.dart';
import '../modules/leaddetails/views/leaddetails_view.dart';
import '../modules/leadsubprofile/bindings/leadsubprofile_binding.dart';
import '../modules/leadsubprofile/views/leadsubprofile_view.dart';
import '../modules/ledger/bindings/ledger_binding.dart';
import '../modules/ledger/views/ledger_view.dart';
import '../modules/ledgerlist/bindings/ledgerlist_binding.dart';
import '../modules/ledgerlist/views/ledgerlist_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/meentingupdateview/bindings/meentingupdateview_binding.dart';
import '../modules/meentingupdateview/views/meentingupdateview_view.dart';
import '../modules/meetingupdatesadd/bindings/meetingupdatesadd_binding.dart';
import '../modules/meetingupdatesadd/views/meetingupdatesadd_view.dart';
import '../modules/newleads/bindings/newleads_binding.dart';
import '../modules/newleads/views/newleads_view.dart';
import '../modules/opentask/bindings/opentask_binding.dart';
import '../modules/opentask/views/opentask_view.dart';
import '../modules/order/bindings/order_binding.dart';
import '../modules/order/views/order_view.dart';
import '../modules/orderlist/bindings/orderlist_binding.dart';
import '../modules/orderlist/views/orderlist_view.dart';
import '../modules/overdue/bindings/overdue_binding.dart';
import '../modules/overdue/views/overdue_view.dart';
import '../modules/productdetail/bindings/productdetail_binding.dart';
import '../modules/productdetail/views/productdetail_view.dart';
import '../modules/qttnmainviewwww/bindings/qttnmainviewwww_binding.dart';
import '../modules/qttnmainviewwww/views/qttnmainviewwww_view.dart';
import '../modules/qttnview/bindings/qttnview_binding.dart';
import '../modules/qttnview/views/qttnview_view.dart';
import '../modules/reminder/bindings/reminder_binding.dart';
import '../modules/reminder/views/reminder_view.dart';
import '../modules/requirement/bindings/requirement_binding.dart';
import '../modules/requirement/views/requirement_view.dart';
import '../modules/salesdetail/bindings/salesdetail_binding.dart';
import '../modules/salesdetail/views/salesdetail_view.dart';
import '../modules/salesinvoice/bindings/salesinvoice_binding.dart';
import '../modules/salesinvoice/views/salesinvoice_view.dart';
import '../modules/salesinvoicereport/bindings/salesinvoicereport_binding.dart';
import '../modules/salesinvoicereport/views/salesinvoicereport_view.dart';
import '../modules/salesinvoicevieeeeeeeeeeeeeeeeeeew/bindings/salesinvoicevieeeeeeeeeeeeeeeeeeew_binding.dart';
import '../modules/salesinvoicevieeeeeeeeeeeeeeeeeeew/views/salesinvoicevieeeeeeeeeeeeeeeeeeew_view.dart';
import '../modules/salesinvoiceview/bindings/salesinvoiceview_binding.dart';
import '../modules/salesinvoiceview/views/salesinvoiceview_view.dart';
import '../modules/salesorder/bindings/salesorder_binding.dart';
import '../modules/salesorder/views/salesorder_view.dart';
import '../modules/salesordercreate/bindings/salesordercreate_binding.dart';
import '../modules/salesordercreate/views/salesordercreate_view.dart';
import '../modules/salesorderview/bindings/salesorderview_binding.dart';
import '../modules/salesorderview/views/salesorderview_view.dart';
import '../modules/salesreturn/bindings/salesreturn_binding.dart';
import '../modules/salesreturn/views/salesreturn_view.dart';
import '../modules/salesview/bindings/salesview_binding.dart';
import '../modules/salesview/views/salesview_view.dart';
import '../modules/sitestatusadd/bindings/sitestatusadd_binding.dart';
import '../modules/sitestatusadd/views/sitestatusadd_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/statusofsite/bindings/statusofsite_binding.dart';
import '../modules/statusofsite/views/statusofsite_view.dart';
import '../modules/stock/bindings/stock_binding.dart';
import '../modules/stock/views/stock_view.dart';
import '../modules/taskmainview/bindings/taskmainview_binding.dart';
import '../modules/taskmainview/views/taskmainview_view.dart';
import '../modules/taskstatus/bindings/taskstatus_binding.dart';
import '../modules/taskstatus/views/taskstatus_view.dart';
import '../modules/tools/bindings/tools_binding.dart';
import '../modules/tools/views/tools_view.dart';
import '../modules/viewqttiondetail/bindings/viewqttiondetail_binding.dart';
import '../modules/viewqttiondetail/views/viewqttiondetail_view.dart';
import '../modules/viewrequirement/bindings/viewrequirement_binding.dart';
import '../modules/viewrequirement/views/viewrequirement_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(
        "",
      ),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMRCREATION,
      page: () => const CustomrcreationView("", ""),
      binding: CustomrcreationBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMRLIST,
      page: () => const CustomrlistView(),
      binding: CustomrlistBinding(),
      children: [
        GetPage(
          name: _Paths.CUSTOMRLIST,
          page: () => const CustomrlistView(),
          binding: CustomrlistBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.ADDCOLLECT,
      page: () => const AddcollectView(),
      binding: AddcollectBinding(),
    ),
    GetPage(
      name: _Paths.COLLECTIONREPORT,
      page: () => CollectionreportView("", ""),
      binding: CollectionreportBinding(),
    ),
    GetPage(
      name: _Paths.LEDGER,
      page: () => const LedgerView(),
      binding: LedgerBinding(),
    ),
    GetPage(
      name: _Paths.LEDGERLIST,
      page: () => const LedgerlistView(),
      binding: LedgerlistBinding(),
    ),
    GetPage(
      name: _Paths.ORDER,
      page: () => const OrderView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: _Paths.ORDERLIST,
      page: () => const OrderlistView(),
      binding: OrderlistBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => Splash(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.SALESINVOICE,
      page: () => const SalesinvoiceView(),
      binding: SalesinvoiceBinding(),
    ),
    GetPage(
      name: _Paths.SALESINVOICEREPORT,
      page: () => SalesinvoicereportView("", "", "", "", "", 0),
      binding: SalesinvoicereportBinding(),
    ),
    GetPage(
      name: _Paths.SALESRETURN,
      page: () => const SalesreturnView(),
      binding: SalesreturnBinding(),
    ),
    GetPage(
      name: _Paths.LEAD,
      page: () => HotleadView(),
      binding: LeadBinding(),
    ),
    GetPage(
      name: _Paths.LEADDETAILS,
      page: () => LeaddetailsView("", "", 0, "", "", ""),
      binding: LeaddetailsBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT,
      page: () => AboutView("", "", "", "", ""),
      binding: AboutBinding(),
    ),
    GetPage(
      name: _Paths.LEADADD,
      page: () => const LeadaddView(
          "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "",""),
      binding: LeadaddBinding(),
    ),
    GetPage(
      name: _Paths.ADDTASK,
      page: () => const AddtaskView(),
      binding: AddtaskBinding(),
    ),
    GetPage(
      name: _Paths.ADDLOCATION,
      page: () => const AddlocationView(),
      binding: AddlocationBinding(),
    ),
    GetPage(
      name: _Paths.ADDACTIVITY,
      page: () => const AddactivityView(),
      binding: AddactivityBinding(),
    ),
    GetPage(
      name: _Paths.ADDNOTE,
      page: () => AddnoteView("", ""),
      binding: AddnoteBinding(),
    ),
    GetPage(
      name: _Paths.REMINDER,
      page: () => const ReminderView(),
      binding: ReminderBinding(),
    ),
    GetPage(
      name: _Paths.DASH,
      page: () => const DashView("", ""),
      binding: DashBinding(),
    ),
    GetPage(
      name: _Paths.TOOLS,
      page: () => const ToolsView(),
      binding: ToolsBinding(),
    ),
    GetPage(
      name: _Paths.ADDADDRESS,
      page: () =>
          const AddaddressView("", "", "", "", "", "", "", "", "", "", ""),
      binding: AddaddressBinding(),
    ),
    GetPage(
      name: _Paths.REQUIREMENT,
      page: () => RequirementView("", ""),
      binding: RequirementBinding(),
    ),
    GetPage(
      name: _Paths.HOTLEAD,
      page: () => HotleadView(),
      binding: HotleadBinding(),
    ),
    GetPage(
      name: _Paths.ADDNOTES,
      page: () => AddnotesView("", ""),
      binding: AddnotesBinding(),
    ),
    GetPage(
      name: _Paths.MEENTINGUPDATEVIEW,
      page: () => const MeentingupdateviewView("", ""),
      binding: MeentingupdateviewBinding(),
    ),
    GetPage(
      name: _Paths.MEETINGUPDATESADD,
      page: () => MeetingupdatesaddView("", ""),
      binding: MeetingupdatesaddBinding(),
    ),
    GetPage(
      name: _Paths.BAISICDETAIL,
      page: () => const BaisicdetailView(""),
      binding: BaisicdetailBinding(),
    ),
    GetPage(
      name: _Paths.ADDBAISICDETAIL,
      page: () => const AddbaisicdetailView("", "", "", "", "", "", "", "", "",
          "", "", "", "", "", "", "", 0, "", ""),
      binding: AddbaisicdetailBinding(),
    ),
    GetPage(
      name: _Paths.EVENT,
      page: () => EventView("", ""),
      binding: EventBinding(),
    ),
    GetPage(
      name: _Paths.EVETVIEW,
      page: () => EvetviewView("", ""),
      binding: EvetviewBinding(),
    ),
    GetPage(
      name: _Paths.STATUSOFSITE,
      page: () => const StatusofsiteView("", ""),
      binding: StatusofsiteBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCTDETAIL,
      page: () => const ProductdetailView(""),
      binding: ProductdetailBinding(),
    ),
    GetPage(
      name: _Paths.SITESTATUSADD,
      page: () => SitestatusaddView("", ""),
      binding: SitestatusaddBinding(),
    ),
    GetPage(
      name: _Paths.LEADSUBPROFILE,
      page: () => const LeadsubprofileView(),
      binding: LeadsubprofileBinding(),
    ),
    GetPage(
      name: _Paths.SALESDETAIL,
      page: () => SalesdetailView("", "", "", "", "", ""),
      binding: SalesdetailBinding(),
    ),
    GetPage(
      name: _Paths.VIEWREQUIREMENT,
      page: () => ViewrequirementView("", ""),
      binding: ViewrequirementBinding(),
    ),
    GetPage(
      name: _Paths.ADDQOUTATIONADD,
      page: () => AddqoutationaddView("", "", []),
      binding: AddqoutationaddBinding(),
    ),
    GetPage(
      name: _Paths.ADDRESSVIEW,
      page: () => const AddressviewView(
        "",
      ),
      binding: AddressviewBinding(),
    ),
    GetPage(
      name: _Paths.DETAILS,
      page: () => const DetailsView(""),
      binding: DetailsBinding(),
    ),
    GetPage(
      name: _Paths.ADDQUATAT,
      page: () => AddquatatView("", "", []),
      binding: AddquatatBinding(),
    ),
    GetPage(
      name: _Paths.NEWLEADS,
      page: () => const NewleadsView(),
      binding: NewleadsBinding(),
    ),
    GetPage(
      name: _Paths.ADDCUSTOMER,
      page: () => const AddcustomerView(),
      binding: AddcustomerBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMERDETAIL,
      page: () => CustomerdetailView("", "", "", 0),
      binding: CustomerdetailBinding(),
    ),
    GetPage(
      name: _Paths.SALESORDER,
      page: () => SalesorderView("", ""),
      binding: SalesorderBinding(),
    ),
    GetPage(
      name: _Paths.SALESORDERCREATE,
      page: () => SalesordercreateView("", "", ""),
      binding: SalesordercreateBinding(),
    ),
    GetPage(
      name: _Paths.SALESINVOICEVIEW,
      page: () => SalesinvoiceviewView("", 1),
      binding: SalesinvoiceviewBinding(),
    ),
    GetPage(
      name: _Paths.QTTNVIEW,
      page: () => const QttnviewView(),
      binding: QttnviewBinding(),
    ),
    GetPage(
      name: _Paths.COLLECTION,
      page: () => const CollectionView(),
      binding: CollectionBinding(),
    ),
    GetPage(
      name: _Paths.ADDTASKDASH,
      page: () => const AddtaskdashView("", "", "", "", "", "", "", ""),
      binding: AddtaskdashBinding(),
    ),
    GetPage(
      name: _Paths.VIEWQTTIONDETAIL,
      page: () => const ViewqttiondetailView(""),
      binding: ViewqttiondetailBinding(),
    ),
    GetPage(
      name: _Paths.STOCK,
      page: () => StockView(),
      binding: StockBinding(),
    ),
    GetPage(
      name: _Paths.TASKMAINVIEW,
      page: () => const TaskmainviewView(),
      binding: TaskmainviewBinding(),
    ),
    GetPage(
      name: _Paths.QTTNMAINVIEWWWW,
      page: () => const QttnmainviewwwwView("", "", ""),
      binding: QttnmainviewwwwBinding(),
    ),
    GetPage(
      name: _Paths.SALESORDERVIEW,
      page: () => const SalesorderviewView(),
      binding: SalesorderviewBinding(),
    ),
    GetPage(
      name: _Paths.SALESVIEW,
      page: () => const SalesviewView("", "", ""),
      binding: SalesviewBinding(),
    ),
    GetPage(
      name: _Paths.SALESINVOICEVIEEEEEEEEEEEEEEEEEEEW,
      page: () => const SalesinvoicevieeeeeeeeeeeeeeeeeeewView(""),
      binding: SalesinvoicevieeeeeeeeeeeeeeeeeeewBinding(),
    ),
    GetPage(
      name: _Paths.TASKSTATUS,
      page: () => TaskstatusView(),
      binding: TaskstatusBinding(),
    ),
    GetPage(
      name: _Paths.OPENTASK,
      page: () => OpentaskView(),
      binding: OpentaskBinding(),
    ),
    GetPage(
      name: _Paths.CLOSED,
      page: () => const ClosedView(),
      binding: ClosedBinding(),
    ),
    GetPage(
      name: _Paths.OVERDUE,
      page: () => const OverdueView(),
      binding: OverdueBinding(),
    ),
  ];
}
