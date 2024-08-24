class CompaignModel {
  CompaignModel({
    required this.status,
    required this.message,
    required this.campaignData,
    required this.balance,
  });

  final bool? status;
  final String? message;
  final String? balance;
  final CampaignData? campaignData;

  factory CompaignModel.fromJson(Map<String, dynamic> json) {
    return CompaignModel(
      status: json["status"],
      message: json["message"],
      balance: json["balance"],
      campaignData: json["campaign_data"] == null
          ? null
          : CampaignData.fromJson(json["campaign_data"]),
    );
  }
}

class CampaignData {
  CampaignData({
    required this.proId,
    required this.dailySpent,
    required this.totalBudget,
    required this.leads,
    required this.avgCpl,
    required this.campaigns,
  });

  final int? proId;
  final double? dailySpent;
  final double? totalBudget;
  final String? leads;
  final double? avgCpl;
  final List<Campaign> campaigns;

  factory CampaignData.fromJson(Map<String, dynamic> json) {
    return CampaignData(
      proId: json["pro_id"],
      dailySpent: json["daily_spent"],
      totalBudget: json["total_budget"],
      leads: json["leads"],
      avgCpl: json["avg_cpl"],
      campaigns: json["campaigns"] == null
          ? []
          : List<Campaign>.from(
              json["campaigns"]!.map((x) => Campaign.fromJson(x))),
    );
  }
}

class Campaign {
  Campaign({
    required this.campaignName,
    required this.sumResults,
    required this.sumCostPerResults,
    required this.sumAmountSpent,
    required this.sumAdSetBudget,
    required this.sumCplSc,
    required this.sumSpentSc,
    required this.sumBudgetSc,
    required this.sumCplGst,
    required this.sumSpentGst,
    required this.projectCode,
    required this.projectName,
    required this.date,
  });

  final String? campaignName;
  final String? sumResults;
  final String? sumCostPerResults;
  final String? sumAmountSpent;
  final String? sumAdSetBudget;
  final String? sumCplSc;
  final String? sumSpentSc;
  final String? sumBudgetSc;
  final String? sumCplGst;
  final String? sumSpentGst;
  final String? projectCode;
  final String? projectName;
  final DateTime? date;

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      campaignName: json["campaign_name"],
      sumResults: json["sum_results"],
      sumCostPerResults: json["sum_cost_per_results"].toString(),
      sumAmountSpent: json["sum_amount_spent"].toString(),
      sumAdSetBudget: json["sum_ad_set_budget"].toString(),
      sumCplSc: json["sum_cpl_sc"].toString(),
      sumSpentSc: json["sum_spent_sc"].toString(),
      sumBudgetSc: json["sum_budget_sc"].toString(),
      sumCplGst: json["sum_cpl_gst"].toString(),
      sumSpentGst: json["sum_spent_gst"].toString(),
      projectCode: json["project_code"].toString(),
      projectName: json["project_name"].toString(),
      date: DateTime.tryParse(json["date"] ?? ""),
    );
  }
}
