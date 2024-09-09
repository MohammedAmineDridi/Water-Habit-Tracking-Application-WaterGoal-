import 'package:printing/printing.dart';
import 'dart:typed_data'; // Import this for ByteData and Uint8List
import 'package:flutter/services.dart' show rootBundle; // Import this to load assets
import 'package:pdf/widgets.dart' as pw;
import 'package:watergoal/data_layer/models/accomplishement.dart';

class Pdf {

    void createPdf(List<Accomplishement> data,String CurrentDate,String userName,String imagePathName,String reportName) async {
      final Set<String> keys = {'Water Percentage', 'Date'};
      final headers = keys.toList();
      // Load image as bytes
      final ByteData bytes = await rootBundle.load(imagePathName);
      final Uint8List logoImage = bytes.buffer.asUint8List();
      // create PDF doc
      final pdf = pw.Document();
      // Add a page to the PDF
      pdf.addPage(
        pw.Page(
        build: (pw.Context context) {
        return pw.Column(
        children: [
          pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
          pw.Text('Hi, '+userName, style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold)),
          // Logo image
          pw.Image(pw.MemoryImage(logoImage), height: 120, width: 120),
          // Current date
          pw.Text(CurrentDate, style: pw.TextStyle(fontSize: 14,fontWeight: pw.FontWeight.bold)),
          ],
          ),
          pw.SizedBox(height: 20),
          pw.Container(alignment: pw.Alignment.center,child:pw.Text(reportName,style: pw.TextStyle(fontSize: 22,fontWeight: pw.FontWeight.bold))),
          pw.SizedBox(height: 20),
          pw.Table.fromTextArray(
          headers: keys.toList(),
          data: data.map((item) {
            return headers.map((header) {
              switch (header) {
                case 'Water Percentage':
                  return item.percentageWaterValue.toString()+" %";
                case 'Date':
                  return item.percentageDate.toString();
                default:
                  return ''; 
              }
            }).toList();
          }).toList(),
          border: pw.TableBorder.all(),
          cellAlignment: pw.Alignment.centerLeft,
          headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          cellHeight: 30,
          columnWidths: {0: pw.FlexColumnWidth(1), 1: pw.FlexColumnWidth(1)},
          cellStyle: pw.TextStyle(fontSize: 22),
          )
          ]
          );
          },
          ),
        );  
        // Print or preview the PDF
        await Printing.layoutPdf(onLayout: (format) async => pdf.save());
    }
  

}