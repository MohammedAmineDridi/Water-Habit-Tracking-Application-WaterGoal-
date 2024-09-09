import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';
import '../themes/appStyles.dart';
import '../../data_layer/models/accomplishement.dart';

class Chart {

  DChartBarCustom createCustomChartBars(List<Accomplishement> listaccomplishements) { // date,percentage

  List<DChartBarDataCustom> chartsbarsListAccomplishements = [];

    print("wsélt hné");

    for (var accomplishement in listaccomplishements) {
    double waterPercentageValue = accomplishement.percentageWaterValue!.toDouble();
    String waterPercentageDate = accomplishement.percentageDate!;
    print("water percentage value = "+waterPercentageValue.toString()+" / date = "+waterPercentageDate);
    chartsbarsListAccomplishements.add(DChartBarDataCustom(valueCustom: Container(alignment:Alignment.topCenter,child:Text(waterPercentageValue.toString()+" %",style:AppStyles.textchartBarTextStyle)),value:waterPercentageValue, label:waterPercentageDate,color: AppStyles.chartBarsColor,showValue: true));
    }
  
    return DChartBarCustom(
                //showDomainLabel: true,
                //showMeasureLabel: true,
                showMeasureLine: true,
                showDomainLine: true,
                spaceBetweenItem: 10,
                spaceDomainLinetoChart: 4,
                spaceMeasureLinetoChart: 4,
                radiusBar: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5)),
                max: 100, // 100%
                listData: chartsbarsListAccomplishements
                );
  }

}