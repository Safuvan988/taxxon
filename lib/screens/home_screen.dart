import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxxon/providers/dashboard_provider.dart';
import 'package:taxxon/providers/auth_provider.dart';
import 'package:taxxon/screens/login_screen.dart';

final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavIndexProvider);

    ref.listen(authProvider, (previous, next) {
      if (!next.isAuthenticated) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
        );
      }
    });

    final authState = ref.watch(authProvider);
    if (!authState.isAuthenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
        );
      });
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final dashboardAsyncValue = ref.watch(dashboardProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF00629F),
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white54),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Row(
                children: [
                  Text(
                    'Syfton Innovations',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Icon(Icons.keyboard_arrow_down, color: Colors.white),
                ],
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu, color: Colors.white, size: 32),
            ),
          ],
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: currentIndex == 0
            ? KeyedSubtree(
                key: const ValueKey('home'),
                child: dashboardAsyncValue.when(
                  loading: () => const Center(
                    child: CircularProgressIndicator(color: Color(0xFF00629F)),
                  ),
                  error: (error, stack) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 48,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Failed to load dashboard',
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          error.toString(),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => ref.invalidate(dashboardProvider),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                  data: (dashboardData) => Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today_outlined, size: 20),
                            const SizedBox(width: 8),
                            const Text(
                              '3rd Quarter 2025',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Icon(Icons.keyboard_arrow_down),
                            const Spacer(),
                            TextButton.icon(
                              onPressed: () {},
                              icon: const Text(
                                'Download',
                                style: TextStyle(color: Color(0xFF00629F)),
                              ),
                              label: const Icon(
                                Icons.download,
                                color: Color(0xFF00629F),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            _buildVatCard(
                              context,
                              'Input VAT',
                              'AED ${dashboardData.summary.inputVat.toStringAsFixed(0)}',
                              'Total purchase',
                              'AED ${dashboardData.summary.totalPurchase.toStringAsFixed(0)}',
                              const Color(0xFFFFEBEE),
                              const Color(0xFFD32F2F),
                            ),
                            const SizedBox(width: 12),
                            _buildVatCard(
                              context,
                              'Output VAT',
                              'AED ${dashboardData.summary.outputVat.toStringAsFixed(0)}',
                              'Total sales',
                              'AED ${dashboardData.summary.totalSales.toStringAsFixed(0)}',
                              const Color(0xFFE8F5E9),
                              const Color(0xFF388E3C),
                            ),
                            const SizedBox(width: 12),
                            _buildVatCard(
                              context,
                              'VAT Payable',
                              'AED ${dashboardData.summary.vatPayable.toStringAsFixed(0)}',
                              'Due On',
                              dashboardData.summary.dueDate,
                              const Color(0xFFE1F5FE),
                              const Color(0xFF0288D1),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: dashboardData.transactions.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final transaction =
                                dashboardData.transactions[index];
                            return _buildTransactionItem(context, transaction);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 60),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  backgroundColor: const Color(
                                    0xFFC62828,
                                  ).withValues(alpha: 0.8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  elevation: 0,
                                ),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Purchase',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          'Expense',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 60),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  backgroundColor: const Color(0xFF4CAF50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  elevation: 0,
                                ),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Sales',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : KeyedSubtree(
                key: const ValueKey('profile'),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundColor: Color(0xFFE1F5FE),
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: Color(0xFF00629F),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'My Profile',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00629F),
                        ),
                      ),
                      const SizedBox(height: 48),
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            ref.read(authProvider.notifier).logout();
                          },
                          icon: const Icon(Icons.logout),
                          label: const Text(
                            'Log Out',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD32F2F),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) =>
            ref.read(bottomNavIndexProvider.notifier).state = index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home, color: Color(0xFF00629F)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person, color: Color(0xFF00629F)),
            label: 'Profile',
          ),
        ],
        selectedItemColor: const Color(0xFF00629F),
      ),
    );
  }

  Widget _buildVatCard(
    BuildContext context,
    String title,
    String mainValue,
    String subTitle,
    String subValue,
    Color bgColor,
    Color textColor,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: (screenWidth - 60) / 3,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            mainValue,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: textColor,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            subTitle,
            style: TextStyle(
              fontSize: 11,
              color: textColor.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subValue,
            style: TextStyle(
              fontSize: 11,
              color: textColor.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(BuildContext context, Transaction transaction) {
    final isPurchase = transaction.type == 'purchase';
    final tagBgColor = isPurchase
        ? const Color(0xFFFFEBEE)
        : const Color(0xFFE8F5E9);
    final tagTextColor = isPurchase
        ? const Color(0xFFD32F2F)
        : const Color(0xFF2E7D32);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.supplierName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'In NO: ${transaction.invoiceNo}',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  transaction.date,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          Expanded(
            child: _buildAmountTag(
              'Before Tax',
              transaction.beforeTax,
              tagBgColor,
              tagTextColor,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: _buildAmountTag(
              'After Tax',
              transaction.afterTax,
              tagBgColor,
              tagTextColor,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: _buildAmountTag(
              'Tax Amt',
              transaction.taxAmount,
              tagBgColor,
              tagTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountTag(
    String label,
    double amount,
    Color bgColor,
    Color textColor,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 10, color: Colors.black87),
          ),
          const SizedBox(height: 2),
          Text(
            amount.toStringAsFixed(2),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
