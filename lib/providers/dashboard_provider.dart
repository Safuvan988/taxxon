import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardSummary {
  final double inputVat;
  final double outputVat;
  final double vatPayable;
  final double totalPurchase;
  final double totalSales;
  final String dueDate;

  DashboardSummary({
    required this.inputVat,
    required this.outputVat,
    required this.vatPayable,
    required this.totalPurchase,
    required this.totalSales,
    required this.dueDate,
  });
}

class Transaction {
  final String supplierName;
  final String invoiceNo;
  final String date;
  final double beforeTax;
  final double afterTax;
  final double taxAmount;
  final String type;

  Transaction({
    required this.supplierName,
    required this.invoiceNo,
    required this.date,
    required this.beforeTax,
    required this.afterTax,
    required this.taxAmount,
    required this.type,
  });
}

class DashboardState {
  final DashboardSummary summary;
  final List<Transaction> transactions;

  DashboardState({required this.summary, required this.transactions});
}

final dashboardProvider = FutureProvider<DashboardState>((ref) async {
  await Future.delayed(const Duration(seconds: 2));

  return DashboardState(
    summary: DashboardSummary(
      inputVat: 4000.00,
      outputVat: 10000.00,
      vatPayable: 6000.00,
      totalPurchase: 505000.00,
      totalSales: 625000.00,
      dueDate: '28-08-2025',
    ),
    transactions: [
      Transaction(
        supplierName: 'SKN Suppliers',
        invoiceNo: '45982345',
        date: '23-02-2026',
        beforeTax: 4560.50,
        afterTax: 6560.50,
        taxAmount: 2000.00,
        type: 'purchase',
      ),
      Transaction(
        supplierName: 'Abu Suppliers',
        invoiceNo: '58965424',
        date: '20-02-2026',
        beforeTax: 5050.50,
        afterTax: 6000.50,
        taxAmount: 950.00,
        type: 'purchase',
      ),
      Transaction(
        supplierName: 'ADP Enterprises',
        invoiceNo: '87982310',
        date: '18-02-2026',
        beforeTax: 3570.50,
        afterTax: 4580.50,
        taxAmount: 1010.00,
        type: 'sale',
      ),
      Transaction(
        supplierName: 'Alhan Suppliers',
        invoiceNo: '78956556',
        date: '14-02-2026',
        beforeTax: 4560.50,
        afterTax: 6560.50,
        taxAmount: 2000.00,
        type: 'purchase',
      ),
      Transaction(
        supplierName: 'ADP Enterprises',
        invoiceNo: '87982310',
        date: '12-02-2026',
        beforeTax: 3570.50,
        afterTax: 4580.50,
        taxAmount: 1010.00,
        type: 'sale',
      ),
      Transaction(
        supplierName: 'PNK Suppliers',
        invoiceNo: '89585853',
        date: '10-02-2026',
        beforeTax: 3570.50,
        afterTax: 4580.50,
        taxAmount: 1010.00,
        type: 'sale',
      ),
    ],
  );
});
