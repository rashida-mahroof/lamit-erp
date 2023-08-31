// QuotationPDFView

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/utils.dart';
import 'package:lamit/tocken/config/url.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
// import 'package:number_to_words/number_to_words.dart';

class QuotationPDFView extends StatefulWidget {
  final dynamic Complist;
  final dynamic Productlist;
  final dynamic Leadlist;
  final List Plist;
  QuotationPDFView(
      {Key? key,
      required this.Complist,
      required this.Productlist,
      required this.Leadlist,
      required this.Plist})
      : super(key: key);

  @override
  State<QuotationPDFView> createState() => _QuotationPDFViewState();
}

class _QuotationPDFViewState extends State<QuotationPDFView> {
  @override
  Widget build(BuildContext context) {
    print(widget.Complist);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).canvasColor,
          foregroundColor: Colors.black87,
          elevation: 0,
          title: Text(widget.Productlist["name"]),
        ),
        body: Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xFF393939),
            colorScheme:
                ColorScheme.light(primary: Color.fromARGB(255, 121, 208, 230)),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: PdfPreview(
            canDebug: false,
            previewPageMargin: const EdgeInsets.all(50),
            build: (format) => _generatePdf(format),
          ),
        ),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.robotoBold();
    final imageList = [];

    // for (int i = 0; i < widget.Plist.length; i++) {
    //   if (widget.Plist[i]["image"] != "null") {
    //     //   final netImage =
    //     //       await networkImage('https://lm.erpeaz.com/files/1.png');
    //     //       imageList.add(netImage);
    //     // } else {
    //     final netImage = await networkImage(
    //         'https://lm.erpeaz.com' + widget.Plist[i]["image"]);
    //     imageList.add(netImage);
    //   }
    // }

    final imageByteDatabg = await rootBundle.load('assets/bg1.png');
    final imageUint8Listbg = imageByteDatabg.buffer.asUint8List(
        imageByteDatabg.offsetInBytes, imageByteDatabg.lengthInBytes);
    final imagebg = pw.MemoryImage(imageUint8Listbg);

    final imageByteDatablank = await rootBundle.load('assets/blank.png');
    final imageUint8Listblank = imageByteDatablank.buffer.asUint8List(
        imageByteDatablank.offsetInBytes, imageByteDatablank.lengthInBytes);
    final imageblank = pw.MemoryImage(imageUint8Listblank);

    var imgList = [];
    var netImage;
    for (int i = 0; i < widget.Plist.length; i++) {
      {
        netImage = await networkImage(urlMain + widget.Plist[i]["image"]);
        imgList.add(netImage);
      }
    }

    final imageByteDatatip = await rootBundle.load('assets/l.png');
    final imageUint8Listtip = imageByteDatatip.buffer.asUint8List(
        imageByteDatatip.offsetInBytes, imageByteDatatip.lengthInBytes);
    final imageTip = pw.MemoryImage(imageUint8Listtip);
    const FontWeight fw700 = FontWeight.w700;
    pdf.addPage(
      pw.MultiPage(
        pageFormat:
            PdfPageFormat.a4.applyMargin(left: 0, top: 0, right: 0, bottom: 0),
        margin: pw.EdgeInsets.only(left: 20, top: 12, right: 20, bottom: 10),
        header: (pw.Context context) {
          return pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Expanded(
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Image(imageTip, width: 130),
                      ]),
                ),
              ]);
        },
        build: (pw.Context context) => [
          pw.Container(

              // ignoreMargins: true,
              child: pw.Stack(children: [
            //  pw.Container(
            //   height: double.infinity,
            //   width: double.infinity,

            //   child:
            //     pw.Image(
            //     imagebg,
            //     fit: pw.BoxFit.cover,
            // ),
            //  ),

            pw.Column(children: [
              pw.Container(
                  width: double.infinity,
                  height: 22,
                  decoration: pw.BoxDecoration(
                      color: PdfColors.grey300,
                      border: pw.Border.all(width: 2)),
                  child: pw.Center(child: pw.Text('PROFORMA'))),
              pw.SizedBox(
                height: 10,
              ),
              pw.Row(children: [
                pw.Expanded(
                    child: pw.Container(
                        height: 200,
                        padding: pw.EdgeInsets.all(0),
                        decoration:
                            pw.BoxDecoration(border: pw.Border.all(width: 1)),
                        child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Padding(
                                  padding: pw.EdgeInsets.all(4),
                                  child: pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        // pw.Text('Super Stockist 1',
                                        //     style: pw.TextStyle(
                                        //         fontSize: 14, font: font)),
                                        pw.SizedBox(height: 8),
                                        pw.Text(
                                            widget.Complist["address_title"]
                                                .toString(),
                                            style: pw.TextStyle(
                                                fontSize: 11, font: font)),
                                        pw.Text(
                                            widget.Complist["address_line1"]
                                                    .toString() +
                                                ', ' +
                                                widget.Complist["address_line2"]
                                                    .toString(),
                                            style: pw.TextStyle(fontSize: 11)),
                                        pw.Text(
                                            widget.Complist["city"].toString() +
                                                ', ' +
                                                widget.Complist["state"]
                                                    .toString() +
                                                ', ' +
                                                widget.Complist["country"]
                                                    .toString() +
                                                ', ' +
                                                widget.Complist["pincode"]
                                                    .toString(),
                                            style: pw.TextStyle(fontSize: 11)),
                                        widget.Complist["email_id"] == null
                                            ? pw.Text(' ')
                                            : pw.Text(
                                                widget.Complist["email_id"]
                                                    .toString(),
                                                style: pw.TextStyle(
                                                  fontSize: 10,
                                                )),
                                        widget.Complist["gstin"] == null
                                            ? pw.Text(' ')
                                            : pw.Text(
                                                'GSTIN: ' +
                                                    widget.Complist["gstin"]
                                                        .toString(),
                                                style: pw.TextStyle(
                                                  fontSize: 10,
                                                )),
                                      ])),
                              pw.Divider(),
                              pw.SizedBox(height: 5),
                              pw.Padding(
                                  padding: pw.EdgeInsets.all(4),
                                  child: pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Text('Quotation for',
                                            style: pw.TextStyle(
                                                fontSize: 13, font: font)),
                                        pw.SizedBox(height: 4),
                                        pw.Text(
                                            widget.Leadlist["lead_name"]
                                                .toString(),
                                            style: pw.TextStyle(
                                              fontSize: 12,
                                            )),
                                        pw.Text(
                                            widget.Leadlist["address_line1"]
                                                .toString(),
                                            style: pw.TextStyle(
                                              fontSize: 12,
                                            )),
                                        pw.Text(
                                            widget.Leadlist["address_line2"]
                                                .toString(),
                                            style: pw.TextStyle(
                                              fontSize: 12,
                                            )),
                                        pw.Text(
                                            widget.Leadlist["city"].toString(),
                                            style: pw.TextStyle(
                                              fontSize: 12,
                                            )),
                                      ]))
                            ]))),
                pw.Expanded(
                    child: pw.Container(
                        height: 200,
                        decoration: pw.BoxDecoration(
                            border: pw.Border.all(color: PdfColors.black)),
                        padding: pw.EdgeInsets.only(bottom: 33),
                        child: pw.Expanded(
                            child: pw.Container(
                          child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.SizedBox(
                                  height: 10,
                                ),
                                pw.Padding(
                                    padding: pw.EdgeInsets.only(left: 5)),
                                pw.Padding(
                                  padding: pw.EdgeInsets.only(left: 5),
                                  child: pw.RichText(
                                    text: pw.TextSpan(
                                      text: 'Date: ',
                                      style: pw.TextStyle(fontSize: 11),
                                      children: <pw.TextSpan>[
                                        pw.TextSpan(
                                            text: widget
                                                .Productlist["transaction_date"]
                                                .toString(),
                                            style: pw.TextStyle(fontSize: 10)),
                                      ],
                                    ),
                                  ),
                                ),
                                pw.Padding(
                                  padding: pw.EdgeInsets.only(left: 5),
                                  child: pw.RichText(
                                    text: pw.TextSpan(
                                      text: 'No: ',
                                      style: pw.TextStyle(fontSize: 11),
                                      children: <pw.TextSpan>[
                                        pw.TextSpan(
                                            text: widget.Productlist["name"]
                                                .toString(),
                                            style: pw.TextStyle(fontSize: 10)),
                                      ],
                                    ),
                                  ),
                                ),
                                pw.Divider(),
                                pw.Padding(
                                  padding: pw.EdgeInsets.only(left: 5),
                                  child: pw.RichText(
                                    text: pw.TextSpan(
                                      text: 'QUOTATION MADE BY: ',
                                      style: pw.TextStyle(fontSize: 11),
                                      children: <pw.TextSpan>[
                                        if (widget.Productlist[
                                                "owner_name"] !=
                                            null)
                                          pw.TextSpan(
                                              text: widget.Productlist[
                                                      "owner_name"]
                                                  .toString(),
                                              style:
                                                  pw.TextStyle(fontSize: 10)),
                                      ],
                                    ),
                                  ),
                                ),
                                pw.Divider(),
                                pw.Padding(
                                  padding: pw.EdgeInsets.only(left: 5),
                                  child: pw.RichText(
                                    text: pw.TextSpan(
                                      text: 'CONCERNED STAFF: ',
                                      style: pw.TextStyle(fontSize: 11),
                                      children: <pw.TextSpan>[
                                        if (widget.Productlist[
                                                "asm_name"] !=
                                            null)
                                          pw.TextSpan(
                                              text: widget.Productlist[
                                                      "asm_name"]
                                                  .toString(),
                                              style:
                                                  pw.TextStyle(fontSize: 10)),
                                      ],
                                    ),
                                  ),
                                ),
                                pw.SizedBox(
                                  height: 75,
                                ),
                              ]),
                        ))

                        // decoration: pw.BoxDecoration(border: pw.Border.all(width: 1)),
                        ))
              ]),
              pw.SizedBox(height: 10),
              pw.Container(
                // height: 1000,
                child: pw.Expanded(
                  child: pw.Table(
                      border: pw.TableBorder.symmetric(
                        inside: pw.BorderSide(width: .6),
                        outside: pw.BorderSide(width: .6),
                      ),
                      children: [
                        pw.TableRow(children: [
                          pw.Container(
                              decoration: pw.BoxDecoration(
                                  // border: pw.Border(bottom: pw.BorderSide( width: 2)),
                                  ),
                              child: pw.Container(
                                  child: pw.Padding(
                                    padding: pw.EdgeInsets.all(3),
                                    child: pw.Text('SI No',
                                        style: pw.TextStyle(
                                            fontSize: 10,
                                            color: PdfColors.white),
                                        textAlign: pw.TextAlign.center),
                                  ),
                                  color: PdfColors.deepPurple900)),
                          pw.Container(
                              child: pw.Padding(
                                padding: pw.EdgeInsets.all(3),
                                child: pw.Text('Product',
                                    style: pw.TextStyle(
                                        fontSize: 10, color: PdfColors.white),
                                    textAlign: pw.TextAlign.center),
                              ),
                              color: PdfColors.deepPurple900),
                          pw.Container(
                              child: pw.Padding(
                                padding: pw.EdgeInsets.all(3),
                                child: pw.Text('Series',
                                    style: pw.TextStyle(
                                        fontSize: 10, color: PdfColors.white),
                                    textAlign: pw.TextAlign.center),
                              ),
                              color: PdfColors.deepPurple900),
                          pw.Container(
                              child: pw.Padding(
                                padding: pw.EdgeInsets.all(3),
                                child: pw.Text('Image',
                                    style: pw.TextStyle(
                                        fontSize: 10, color: PdfColors.white),
                                    textAlign: pw.TextAlign.center),
                              ),
                              color: PdfColors.deepPurple900),
                               pw.Container(
                              child: pw.Padding(
                                padding: pw.EdgeInsets.all(3),
                                child: pw.Text('Rate',
                                    style: pw.TextStyle(
                                        fontSize: 10, color: PdfColors.white),
                                    textAlign: pw.TextAlign.center),
                              ),
                              color: PdfColors.deepPurple900),
                          pw.Container(
                              child: pw.Padding(
                                padding: pw.EdgeInsets.all(3),
                                child: pw.Text('Quantity',
                                    style: pw.TextStyle(
                                        fontSize: 10, color: PdfColors.white),
                                    textAlign: pw.TextAlign.center),
                              ),
                              color: PdfColors.deepPurple900),
                             
                          pw.Container(
                              child: pw.Padding(
                                padding: pw.EdgeInsets.all(3),
                                child: pw.Text('GST %',
                                    style: pw.TextStyle(
                                        fontSize: 10, color: PdfColors.white),
                                    textAlign: pw.TextAlign.center),
                              ),
                              color: PdfColors.deepPurple900),
                          pw.Container(
                              child: pw.Padding(
                                padding: pw.EdgeInsets.all(3),
                                child: pw.Text('Total',
                                    style: pw.TextStyle(
                                        fontSize: 10, color: PdfColors.white),
                                    textAlign: pw.TextAlign.center),
                              ),
                              color: PdfColors.deepPurple900)
                        ]),
                        for (int i = 0; i < widget.Plist.length; i++)
                          pw.TableRow(children: [
                            pw.Padding(
                              padding: pw.EdgeInsets.all(3),
                              child: pw.Text(widget.Plist[i]["idx"].toString(),
                                  style: pw.TextStyle(fontSize: 9)),
                            ),
                            pw.Padding(
                                padding: pw.EdgeInsets.all(3),
                                child: pw.SizedBox(
                                  width: 200,
                                  child: pw.Text(
                                      widget.Plist[i]["item_name"].toString(),
                                      style: pw.TextStyle(fontSize: 9)),
                                )),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(3),
                              child: pw.Text(
                                  widget.Plist[i]["item_series"].toString(),
                                  style: pw.TextStyle(fontSize: 9),
                                  textAlign: pw.TextAlign.right),
                            ),
                            // pw.Padding(
                            //   padding: pw.EdgeInsets.all(3),
                            //   child: pw.Text(widget.Plist[i]["image"],
                            //       style: pw.TextStyle(fontSize: 9),
                            //       textAlign: pw.TextAlign.right),
                            // ),
                            pw.Container(
                              height: 26,
                              width: 26,
                              child: pw.Center(child: pw.Image(imgList[i])),
                            ),
 pw.Padding(
                              padding: pw.EdgeInsets.all(3),
                              child: pw.Text(widget.Plist[i]["with_tax_rate"].toString(),
                                  style: pw.TextStyle(fontSize: 9),
                                  textAlign: pw.TextAlign.right),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(3),
                              child: pw.Text(widget.Plist[i]["qty"].toString(),
                                  style: pw.TextStyle(fontSize: 9),
                                  textAlign: pw.TextAlign.right),
                            ),
                            
                            pw.Padding(
                              padding: pw.EdgeInsets.all(3),
                              child: pw.Text(
                                  widget.Plist[i]["tax_percentage"].toString(),
                                  style: pw.TextStyle(fontSize: 9),
                                  textAlign: pw.TextAlign.right),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(3),
                              child: pw.Text(
                                  widget.Plist[i]["with_tax_amount"].toString(),
                                  style: pw.TextStyle(fontSize: 9),
                                  textAlign: pw.TextAlign.right),
                            ),
                          ]),
                      ]),
                ),
              ),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
                pw.Container(
                    width: 230,
                    child: pw.Column(children: [
                      pw.Table(
                          border: pw.TableBorder.symmetric(
                            // inside: pw.BorderSide(width: .6),
                            outside: pw.BorderSide(width: .6),
                          ),
                          children: [
                            pw.TableRow(children: [
                              pw.Container(
                                  child: pw.Padding(
                                    padding: pw.EdgeInsets.all(3),
                                    child: pw.Text(
                                      'NET TOTAL',
                                      style: pw.TextStyle(
                                          fontSize: 9, color: PdfColors.black),
                                      // textAlign: pw.TextAlign.center
                                    ),
                                  ),
                                  color: PdfColors.purple50),
                              pw.Container(
                                  child: pw.Padding(
                                    padding: pw.EdgeInsets.all(3),
                                    child: pw.Text(
                                        widget.Productlist["total"].toString(),
                                        style: pw.TextStyle(
                                            fontSize: 10,
                                            color: PdfColors.black),
                                        textAlign: pw.TextAlign.right),
                                  ),
                                  color: PdfColors.purple50),
                            ])
                          ]),
                      pw.Table(
                          border: pw.TableBorder.symmetric(
                            // inside: pw.BorderSide(width: .6),
                            outside: pw.BorderSide(width: .6),
                          ),
                          children: [
                            pw.TableRow(children: [
                              pw.Container(
                                  child: pw.Padding(
                                    padding: pw.EdgeInsets.all(3),
                                    child: pw.Text(
                                      'TOTAL TAXES AND CHARGES',
                                      style: pw.TextStyle(
                                          fontSize: 9, color: PdfColors.black),
                                      // textAlign: pw.TextAlign.center
                                    ),
                                  ),
                                  color: PdfColors.purple50),
                              pw.Container(
                                  child: pw.Padding(
                                    padding: pw.EdgeInsets.all(3),
                                    child: pw.Text(
                                        widget.Productlist[
                                                "total_taxes_and_charges"]
                                            .toString(),
                                        style: pw.TextStyle(
                                            fontSize: 10,
                                            color: PdfColors.black),
                                        textAlign: pw.TextAlign.right),
                                  ),
                                  color: PdfColors.purple50),
                            ])
                          ]),
                      pw.Table(
                          border: pw.TableBorder.symmetric(
                            // inside: pw.BorderSide(width: .6),
                            outside: pw.BorderSide(width: .6),
                          ),
                          children: [
                            pw.TableRow(children: [
                              pw.Container(
                                  child: pw.Padding(
                                    padding: pw.EdgeInsets.all(3),
                                    child: pw.Text(
                                      'GRAND TOTAL',
                                      style: pw.TextStyle(
                                          fontSize: 9, color: PdfColors.black),
                                      // textAlign: pw.TextAlign.center
                                    ),
                                  ),
                                  color: PdfColors.purple50),
                              pw.Container(
                                  child: pw.Padding(
                                    padding: pw.EdgeInsets.all(3),
                                    child: pw.Text(
                                        widget.Productlist["grand_total"]
                                            .toString(),
                                        style: pw.TextStyle(
                                            fontSize: 10,
                                            color: PdfColors.black),
                                        textAlign: pw.TextAlign.right),
                                  ),
                                  color: PdfColors.purple50),
                            ])
                          ]),
                    pw.Table(
                          border: pw.TableBorder.symmetric(
                            // inside: pw.BorderSide(width: .6),
                            outside: pw.BorderSide(width: .6),
                          ),
                          children: [
                            pw.TableRow(children: [
                              pw.Container(
                                  child: pw.Padding(
                                    padding: pw.EdgeInsets.all(3),
                                    child: pw.Text(
                                      'ROUNDED TOTAL',
                                      style: pw.TextStyle(
                                          fontSize: 9, color: PdfColors.black),
                                      // textAlign: pw.TextAlign.center
                                    ),
                                  ),
                                  color: PdfColors.purple50),
                              pw.Container(
                                  child: pw.Padding(
                                    padding: pw.EdgeInsets.all(3),
                                    child: pw.Text(
                                        widget.Productlist["rounded_total"]
                                            .toString(),
                                        style: pw.TextStyle(
                                            fontSize: 10,
                                            color: PdfColors.black),
                                        textAlign: pw.TextAlign.right),
                                  ),
                                  color: PdfColors.purple50),
                            ])
                          ])
                    
                    ]))
              ]),
              pw.SizedBox(
                height: 10,
              ),
              pw.Container(
                  width: double.infinity,
                  decoration:
                      pw.BoxDecoration(border: pw.Border.all(width: .8)),
                  child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Container(
                            width: double.infinity,
                            height: 20,
                            color: PdfColors.deepPurple900,
                            child: pw.Padding(
                                padding: pw.EdgeInsets.all(4),
                                child: pw.Text('TERMS AND CONDITIONS',
                                    style:
                                        pw.TextStyle(color: PdfColors.white)))),
                        pw.SizedBox(
                          height: 8,
                        ),
                        pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Padding(
                                padding: pw.EdgeInsets.symmetric(horizontal: 6),
                                child: pw.Row(children: [
                                  pw.Container(
                                    width: 1,
                                    height: 1,
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(width: 3),
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  pw.Text(
                                      '  30% of the total amount should be paid in advance and remaining payment paid before material dispatch from',
                                      style: pw.TextStyle(fontSize: 11))
                                ]),
                              ),
                              pw.Text('    depo',
                                  style: pw.TextStyle(fontSize: 11)),
                              pw.Padding(
                                padding: pw.EdgeInsets.symmetric(horizontal: 6),
                                child: pw.Row(children: [
                                  pw.Container(
                                    width: 1,
                                    height: 1,
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(width: 3),
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  pw.Text(
                                      '  This qutation is valid for 15 days',
                                      style: pw.TextStyle(fontSize: 11))
                                ]),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.symmetric(horizontal: 6),
                                child: pw.Row(children: [
                                  pw.Container(
                                    width: 1,
                                    height: 1,
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(width: 3),
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  pw.Text(
                                      '  Based on the site actual measurements final quantities might vary',
                                      style: pw.TextStyle(fontSize: 11))
                                ]),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.symmetric(horizontal: 6),
                                child: pw.Row(children: [
                                  pw.Container(
                                    width: 1,
                                    height: 1,
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(width: 3),
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  pw.Text(
                                      '  Quoted rate is inclusive of all Taxes and GST.',
                                      style: pw.TextStyle(fontSize: 11))
                                ]),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.symmetric(horizontal: 6),
                                child: pw.Row(children: [
                                  pw.Container(
                                    width: 1,
                                    height: 1,
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(width: 3),
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  pw.Text(
                                      '  Transportation is free for first delivery.',
                                      style: pw.TextStyle(fontSize: 11))
                                ]),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.symmetric(horizontal: 6),
                                child: pw.Row(children: [
                                  pw.Container(
                                    width: 1,
                                    height: 1,
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(width: 3),
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  pw.Text(
                                      '  Unloading is parties responsibility.',
                                      style: pw.TextStyle(fontSize: 11))
                                ]),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.symmetric(horizontal: 6),
                                child: pw.Row(children: [
                                  pw.Container(
                                    width: 1,
                                    height: 1,
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(width: 3),
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  pw.Text('  Breakages will be replaced',
                                      style: pw.TextStyle(fontSize: 11))
                                ]),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.symmetric(horizontal: 6),
                                child: pw.Row(children: [
                                  pw.Container(
                                    width: 1,
                                    height: 1,
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(width: 3),
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  pw.Text(
                                      '  Any increase in shipping or purchase charges will result on increase in material price.',
                                      style: pw.TextStyle())
                                ]),
                              ),
                              pw.SizedBox(
                                height: 6,
                              )
                            ])
                      ])),
            ])
          ]))
        ],
      ),
    );
    return pdf.save();
  }
}
