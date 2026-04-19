import 'dart:math';

import 'package:geniuses_school/data/models/payment_card_model.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:geniuses_school/presentation/state/payments_cards_provider.dart';
import 'package:geniuses_school/presentation/state/profit_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfitManageScreen extends ConsumerStatefulWidget {
  const ProfitManageScreen({super.key});

  @override
  ConsumerState<ProfitManageScreen> createState() => _ProfitManageScreenState();
}

class _ProfitManageScreenState extends ConsumerState<ProfitManageScreen> {
  // This will be replaced with real data from API
  // For now we'll use sample data, but ideally the wallet model should include this
  late List<double> weeklyIncome;

  Future<void> _onRefresh() async {
    await ref.read(profitProvider.notifier).loadWallet();
    await ref.read(paymentCardProvider.notifier).refresh();
  }

  @override
  void initState() {
    super.initState();
    // Initialize with sample data - in production, this should come from API
    weeklyIncome = [150, 200, 180, 220, 170, 300, 200];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onRefresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profitState = ref.watch(profitProvider);
    final cardsAsync = ref.watch(paymentCardProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.myWallet),
        foregroundColor: Colors.white,
        backgroundColor: theme.primaryColor,
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              profitState.wallet.when(
                loading: () => const SizedBox(
                  height: 170,
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (e, s) => SizedBox(
                  height: 170,
                  child: Center(
                    child: Text(
                      "${AppLocalizations.of(context)!.walletLoadError}: $e",
                    ),
                  ),
                ),
                data: (wallet) => SizedBox(
                  height: 170,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      SizedBox(
                        width: 180,
                        child: AnimatedProfitCard(
                          title: AppLocalizations.of(context)!.totalBalance,
                          icon: Icons.account_balance_wallet,
                          color: Colors.blue,
                          amount: wallet.balance,
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 180,
                        child: AnimatedProfitCard(
                          title: AppLocalizations.of(context)!.withdrawable,
                          icon: Icons.attach_money,
                          color: Colors.green,
                          amount: wallet.balance,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Weekly income chart
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.weeklyIncome,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 180,
                      child: LineChart(
                        LineChartData(
                          gridData: const FlGridData(show: true),
                          titlesData: const FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: _getTitlesWidget,
                                interval: 1,
                              ),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                              spots: List.generate(
                                weeklyIncome.length,
                                (index) => FlSpot(
                                  index.toDouble(),
                                  weeklyIncome[index],
                                ),
                              ),
                              isCurved: true,
                              gradient: const LinearGradient(
                                colors: [Colors.blue, Colors.lightBlueAccent],
                              ),
                              barWidth: 4,
                              dotData: const FlDotData(show: true),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Transactions
              Text(
                AppLocalizations.of(context)!.recentTransactions,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              profitState.wallet.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(
                  child: Text("${AppLocalizations.of(context)!.error}: $error"),
                ),
                data: (wallet) {
                  final withdrawals = wallet.withdrawals;
                  if (withdrawals.isEmpty) {
                    return Center(
                      child: Text(AppLocalizations.of(context)!.noTransactions),
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: withdrawals.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final tx = withdrawals[index];
                      return TransactionTile(
                        title: AppLocalizations.of(context)!.withdraw,
                        date: tx.requestedAt.toString().split(' ')[0],
                        amount: tx.amount,
                        type: "expense",
                        status: tx.status,
                        onCancel: () async {
                          final confirm =
                              await showDialog<bool>(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: Text(
                                    AppLocalizations.of(context)!.cancelRequest,
                                  ),
                                  content: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.confirmCancelWithdrawal,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(ctx, false),
                                      child: Text(
                                        AppLocalizations.of(context)!.no,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(ctx, true),
                                      child: Text(
                                        AppLocalizations.of(context)!.yesCancel,
                                        style: const TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ) ??
                              false;

                          if (confirm) {
                            try {
                              await ref
                                  .read(profitProvider.notifier)
                                  .cancelWithdrawal(tx.id);
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.requestCancelled,
                                    ),
                                  ),
                                );
                              }
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "${AppLocalizations.of(context)!.error}: $e",
                                    ),
                                  ),
                                );
                              }
                            }
                          }
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
        onPressed: () => _showWithdrawSheet(cardsAsync.value ?? []),
        icon: const Icon(Icons.wallet_giftcard),
        label: Text(AppLocalizations.of(context)!.withdrawProfits),
      ),
    );
  }

  static Widget _getTitlesWidget(double value, TitleMeta meta) {
    const days = ["Sat", "Sun", "Mon", "Tue", "Wed", "Thu", "Fri"];
    int index = value.toInt();
    if (index >= 0 && index < days.length) {
      return Text(days[index], style: const TextStyle(fontSize: 12));
    }
    return const Text("");
  }

  void _showWithdrawSheet(List<PaymentCard> banks) {
    if (banks.isEmpty) {
      // No bank accounts - show dialog and offer to add one
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.noBankAccounts),
          content: Text(AppLocalizations.of(context)!.addBankAccountPrompt),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.pushNamed(context, '/payment-manage');
              },
              child: Text(AppLocalizations.of(context)!.addBankAccount),
            ),
          ],
        ),
      );
      return;
    }

    final amountController = TextEditingController();
    PaymentCard? selectedBank = banks.firstWhere(
      (b) => b.isDefault == true,
      orElse: () => banks.first,
    );
    final profitState = ref.read(profitProvider);
    final available = profitState.wallet.value?.balance ?? 0.0;

    // Don't set default amount - let user decide
    amountController.clear();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
                left: 20,
                right: 20,
                top: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.withdrawRequest,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${AppLocalizations.of(context)!.availableBalance}: ${available.toStringAsFixed(2)} ${AppLocalizations.of(context)!.currency}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.green[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Bank Selection Dropdown
                  DropdownButtonFormField<PaymentCard>(
                    initialValue: selectedBank,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(
                        context,
                      )!.selectBankAccount,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      helperText: AppLocalizations.of(context)!.selectBankHint,
                    ),
                    items: banks
                        .map(
                          (bank) => DropdownMenuItem(
                            value: bank,
                            child: Text(
                              "${bank.bankName?.name ?? AppLocalizations.of(context)!.bank} - ${(bank.iban ?? bank.cardNumber ?? "").substring(max(0, (bank.iban ?? bank.cardNumber ?? "").length - 4))}",
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (val) => setModalState(() => selectedBank = val),
                  ),

                  const SizedBox(height: 16),
                  TextFormField(
                    controller: amountController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.withdrawalAmount,
                      prefixText: '${AppLocalizations.of(context)!.currency} ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      helperText: AppLocalizations.of(
                        context,
                      )!.minWithdrawalHint,
                      hintText: '0.00',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    onChanged: (_) => setModalState(() {}),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        // Validate amount
                        final amountText = amountController.text.trim();
                        final amount = double.tryParse(amountText);

                        if (amountText.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                AppLocalizations.of(context)!.enterAmount,
                              ),
                            ),
                          );
                          return;
                        }

                        if (amount == null || amount <= 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                AppLocalizations.of(
                                  context,
                                )!.amountMustBePositive,
                              ),
                            ),
                          );
                          return;
                        }

                        if (amount < 10) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                AppLocalizations.of(
                                  context,
                                )!.minWithdrawalError,
                              ),
                            ),
                          );
                          return;
                        }

                        if (amount > available) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                AppLocalizations.of(
                                  context,
                                )!.insufficientBalance(
                                  available.toStringAsFixed(2),
                                ),
                              ),
                            ),
                          );
                          return;
                        }

                        if (selectedBank == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                AppLocalizations.of(context)!.errorSelectBank,
                              ),
                            ),
                          );
                          return;
                        }

                        try {
                          await ref
                              .read(profitProvider.notifier)
                              .requestWithdrawal(amount, selectedBank!.id!);
                          if (sheetContext.mounted) {
                            Navigator.pop(sheetContext);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.withdrawalRequested,
                                  ),
                                ),
                              );
                            }
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "${AppLocalizations.of(context)!.error}: $e",
                                ),
                              ),
                            );
                          }
                        }
                      },
                      child: Text(
                        AppLocalizations.of(context)!.confirmWithdrawal,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

// Animated Profit Card Widget
class AnimatedProfitCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final double amount;

  const AnimatedProfitCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: amount),
      duration: const Duration(seconds: 1),
      builder: (context, value, _) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.8),
              color.withValues(alpha: 0.3),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "${AppLocalizations.of(context)!.currency} ${value.toStringAsFixed(2)}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Transaction Tile Widget
class TransactionTile extends StatelessWidget {
  final String title;
  final String date;
  final double amount;
  final String type; // income or expense
  final String? status;
  final VoidCallback? onCancel;

  const TransactionTile({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    required this.type,
    this.status,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final color = type == "income" ? Colors.green : Colors.red;
    final statusColor = _getStatusColor(status);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.2),
            child: Icon(
              type == "income" ? Icons.arrow_downward : Icons.arrow_upward,
              color: color,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    if (status != null) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          _translateStatus(context, status!),
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(date, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${type == "income" ? '+' : '-'} ${AppLocalizations.of(context)!.currency} ${amount.toStringAsFixed(2)}",
                style: TextStyle(color: color, fontWeight: FontWeight.bold),
              ),
              if (status?.toLowerCase() == 'pending' && onCancel != null)
                TextButton(
                  onPressed: onCancel,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 30),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.cancel,
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'completed':
      case 'approved':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _translateStatus(BuildContext context, String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return AppLocalizations.of(context)!.statusCompleted;
      case 'approved':
        return AppLocalizations.of(context)!.statusApproved;
      case 'pending':
        return AppLocalizations.of(context)!.statusPending;
      case 'rejected':
        return AppLocalizations.of(context)!.statusRejected;
      case 'cancelled':
        return AppLocalizations.of(context)!.statusCancelled;
      default:
        return status;
    }
  }
}
