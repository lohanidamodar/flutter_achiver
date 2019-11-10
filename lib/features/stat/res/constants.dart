enum ChartTimeType {
  DAILY,
  WEEKLY,
  MONTHLY,
  YEARLY
}

isDaily(ChartTimeType chartTimeType) => chartTimeType == ChartTimeType.DAILY;
isWeekly(ChartTimeType chartTimeType) => chartTimeType == ChartTimeType.WEEKLY;
isMonthly(ChartTimeType chartTimeType) => chartTimeType == ChartTimeType.MONTHLY;
isYearly(ChartTimeType chartTimeType) => chartTimeType == ChartTimeType.YEARLY;