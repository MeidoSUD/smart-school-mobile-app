import 'package:geniuses_school/core/utils/logger.dart';
import 'package:geniuses_school/data/repositories/order_repository.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:geniuses_school/presentation/widgets/common/ballsWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StudentOrdersScreen extends StatefulWidget {
  const StudentOrdersScreen({super.key});

  @override
  State<StudentOrdersScreen> createState() => _StudentOrdersScreenState();
}

class _StudentOrdersScreenState extends State<StudentOrdersScreen> {
  final OrderRepository _orderRepository = OrderRepository();
  List<dynamic> _orders = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final orders = await _orderRepository.getOrders();
      setState(() {
        _orders = orders;
        _isLoading = false;
      });
    } catch (e) {
      Logger.log("Error loading orders: $e");
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  String _getStatusText(String? status) {
    if (!mounted) return status ?? '';
    final localizations = AppLocalizations.of(context)!;
    switch (status) {
      case 'pending':
        return localizations.pending;
      case 'completed':
        return localizations.completed;
      case 'cancelled':
        return localizations.cancelled;
      default:
        return status ?? localizations.notSpecified;
    }
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return AppLocalizations.of(context)!.notSpecified;
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('yyyy-MM-dd').format(date);
    } catch (e) {
      return dateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.myOrders),
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          BallsWidget(
            size: 40,
            color: const Color(0xFF5170ff),
            alignment: const Alignment(1.1, -0.8),
            opacity: 0.9,
          ),
          BallsWidget(
            size: 100,
            color: theme.primaryColorLight,
            alignment: const Alignment(-1.4, -0.8),
            opacity: 0.9,
          ),
          BallsWidget(
            size: 100,
            color: const Color(0xFF5170ff),
            alignment: const Alignment(-1.3, 1),
            opacity: 0.9,
          ),
          RefreshIndicator(
            onRefresh: _loadOrders,
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _errorMessage != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${AppLocalizations.of(context)!.error}: $_errorMessage',
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _loadOrders,
                          child: Text(AppLocalizations.of(context)!.retry),
                        ),
                      ],
                    ),
                  )
                : _orders.isEmpty
                ? Center(child: Text(AppLocalizations.of(context)!.noOrdersNow))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _orders.length,
                    itemBuilder: (context, index) {
                      final order = _orders[index];
                      return _buildOrderCard(order, theme);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(dynamic order, ThemeData theme) {
    final localizations = AppLocalizations.of(context)!;
    final subject = order['subject'] as Map<String, dynamic>?;
    final subjectName =
        subject?['name_ar']?.toString() ?? localizations.unknownSubject;
    final status = order['status']?.toString() ?? 'pending';
    final applicationsCount = order['applications_count'] ?? 0;
    final availableSlots =
        (order['available_slots'] ?? order['availableSlots']) as List? ?? [];
    final firstSlot = availableSlots.isNotEmpty ? availableSlots[0] : null;
    final minPrice = order['min_price'];
    final maxPrice = order['max_price'];
    final notes = order['notes']?.toString();
    final createdAt = order['created_at']?.toString();

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () => _showOrderDetails(context, order),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      subjectName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(status).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _getStatusColor(status),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      _getStatusText(status),
                      style: TextStyle(
                        color: _getStatusColor(status),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (firstSlot != null) ...[
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${localizations.date}: ${_formatDate(firstSlot['date']?.toString())}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      '${localizations.time}: ${firstSlot['start_time']?.toString() ?? ''} - ${firstSlot['end_time']?.toString() ?? ''}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
              Row(
                children: [
                  const Icon(Icons.people, size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    '${localizations.teachersApplicationsCount}: $applicationsCount',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              if (minPrice != null || maxPrice != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.attach_money,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${localizations.price}: ${minPrice != null ? '$minPrice' : '0'} - ${maxPrice != null ? '$maxPrice' : localizations.notSpecified} ${localizations.currency}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
              if (notes != null && notes.isNotEmpty) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.note, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          notes,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              if (createdAt != null) ...[
                const SizedBox(height: 8),
                Text(
                  '${localizations.creationDate}: ${_formatDate(createdAt)}',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showOrderDetails(BuildContext context, dynamic order) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.orderDetailsNotAvailable),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
