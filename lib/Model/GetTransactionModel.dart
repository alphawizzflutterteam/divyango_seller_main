class GetTransactionModel {
  GetTransactionModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final List<Datum> data;

  factory GetTransactionModel.fromJson(Map<String, dynamic> json) {
    return GetTransactionModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }
}

class Datum {
  Datum({
    required this.id,
    required this.proId,
    required this.amount,
    required this.tdsAmt,
    required this.paidAmount,
    required this.date,
    required this.totalPaid,
    required this.currentBalance,
    required this.invNo,
    required this.receiptNo,
    required this.paymentType,
    required this.transactionId,
    required this.chequeNo,
    required this.bankName,
    required this.paymentInvoice,
    required this.paymentDesc,
    required this.gstNo,
    required this.aId,
    required this.delete,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final int? proId;
  final String? amount;
  final String? tdsAmt;
  final String? paidAmount;
  final DateTime? date;
  final String? totalPaid;
  final String? currentBalance;
  final String? invNo;
  final String? receiptNo;
  final String? paymentType;
  final String? transactionId;
  final dynamic chequeNo;
  final dynamic bankName;
  final String? paymentDesc;
  final String? gstNo;
  final String? paymentInvoice;
  final int? aId;
  final String? delete;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json["id"],
      proId: json["pro_id"],
      amount: json["amount"].toString(),
      tdsAmt: json["tds_amt"].toString(),
      paidAmount: json["paid_amount"].toString(),
      date: DateTime.tryParse(json["date"] ?? ""),
      totalPaid: json["total_paid"].toString(),
      currentBalance: json["current_balance"].toString(),
      invNo: json["inv_no"].toString(),
      receiptNo: json["receipt_no"].toString(),
      paymentType: json["payment_type"].toString(),
      transactionId: json["transaction_id"].toString(),
      chequeNo: json["cheque_no"],
      bankName: json["bank_name"],
      paymentInvoice: json["payment_invoice"],
      paymentDesc: json["payment_desc"],
      gstNo: json["gst_no"].toString(),
      aId: json["a_id"],
      delete: json["delete"].toString(),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}
