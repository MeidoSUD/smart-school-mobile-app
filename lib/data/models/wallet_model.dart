class WalletModel {
  final double balance;
  final List<WithdrawalModel> withdrawals;
  final int? currentPage;
  final int? lastPage;

  WalletModel({
    required this.balance,
    required this.withdrawals,
    this.currentPage,
    this.lastPage,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    final withdrawalsObj = json['withdrawals'];
    List<WithdrawalModel> withdrawalsList = [];
    int? current;
    int? last;

    if (withdrawalsObj is Map<String, dynamic>) {
      final data = withdrawalsObj['data'] as List?;
      withdrawalsList =
          data?.map((e) => WithdrawalModel.fromJson(e)).toList() ?? [];
      current = withdrawalsObj['current_page'];
      last = withdrawalsObj['last_page'];
    } else if (withdrawalsObj is List) {
      withdrawalsList = withdrawalsObj
          .map((e) => WithdrawalModel.fromJson(e))
          .toList();
    }

    return WalletModel(
      balance: double.tryParse(json['balance']?.toString() ?? '0') ?? 0.0,
      withdrawals: withdrawalsList,
      currentPage: current,
      lastPage: last,
    );
  }
}

class WithdrawalModel {
  final int id;
  final double amount;
  final String status;
  final DateTime requestedAt;

  WithdrawalModel({
    required this.id,
    required this.amount,
    required this.status,
    required this.requestedAt,
  });

  factory WithdrawalModel.fromJson(Map<String, dynamic> json) {
    return WithdrawalModel(
      id: json['id'],
      amount: double.tryParse(json['amount']?.toString() ?? '0') ?? 0.0,
      status: json['status'],
      requestedAt: DateTime.parse(
        json['requested_at'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }
}
