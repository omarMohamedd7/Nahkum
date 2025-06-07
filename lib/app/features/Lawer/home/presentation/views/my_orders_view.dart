import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';
import 'package:legal_app/app/core/utils/app_assets.dart';
import '../widgets/lawyer_bottom_navigation_bar.dart';
import '../controllers/my_orders_controller.dart';
import '../../data/models/order_model.dart';

class MyOrdersView extends GetView<MyOrdersController> {
  const MyOrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 56),
            _buildTopBar(),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1, color: Color(0xffBFBFBF))),
                  height: 50,
                  child: Center(child: _buildToggleTabs())),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColors.gold),
                    );
                  }

                  if (controller.hasError.value) {
                    return Center(
                      child: Text(
                        controller.errorMessage.value,
                        style: const TextStyle(
                            color: Colors.red, fontFamily: 'Almarai'),
                      ),
                    );
                  }

                  final orders = controller.selectedIndex.value == 0
                      ? controller.caseRequests
                      : controller.consultationRequests;

                  if (orders.isEmpty) {
                    return Center(
                      child: Text(
                        controller.selectedIndex.value == 0
                            ? 'لا توجد طلبات توكيل'
                            : 'لا توجد طلبات استشارة',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontFamily: 'Almarai',
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      return _buildRequestCard(orders[index]);
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const LawyerBottomNavigationBar(currentIndex: 4),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _iconWrapper(AppAssets.unactiveSetting),
              const SizedBox(width: 11),
              _iconWrapper(AppAssets.unactiveMessage),
              const SizedBox(width: 11),
              _iconWrapper(AppAssets.notification),
              const SizedBox(width: 25),
              const Text(
                'طلباتي',
                style: TextStyle(
                  fontFamily: 'Almarai',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(width: 24),
        ],
      ),
    );
  }

  Widget _iconWrapper(String assetPath) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 1, color: const Color(0xffBFBFBF)),
      ),
      child: SvgPicture.asset(assetPath, width: 20, height: 20),
    );
  }

  Widget _buildToggleTabs() {
    return Obx(() {
      final index = controller.selectedIndex.value;
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 13, vertical: 9),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => controller.changeTab(0),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: index == 0 ? AppColors.gold : null,
                  ),
                  child: Text(
                    'طلبات التوكيل',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color:
                          index == 0 ? Colors.white : const Color(0xFFB8B8B8),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => controller.changeTab(1),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: index == 1 ? AppColors.gold : null,
                  ),
                  child: Text(
                    'طلبات الاستشارة',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color:
                          index == 1 ? Colors.white : const Color(0xFFB8B8B8),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildRequestCard(OrderModel order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: _getStatusColor(order.status).withOpacity(0.1),
                ),
                child: Text(
                  order.getLocalizedStatus(),
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: _getStatusColor(order.status),
                  ),
                ),
              ),
              Text(
                order.caseData.caseType,
                style: const TextStyle(
                  fontFamily: 'Almarai',
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'اسم الموكل: ${order.clientData.name}',
            style: const TextStyle(
              fontFamily: 'Almarai',
              fontSize: 12,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 4),
          Text(
            'رقم القضية: ${order.caseData.caseNumber}',
            style: const TextStyle(
              fontFamily: 'Almarai',
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 4),
          Text(
            'تاريخ الطلب: ${order.getFormattedDate()}',
            style: const TextStyle(
              fontFamily: 'Almarai',
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 8),
          Text(
            order.caseData.description,
            style: const TextStyle(
              fontFamily: 'Almarai',
              fontSize: 13,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.right,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => controller.navigateToOrderDetails(order.requestId),
            child: Row(
              children: const [
                Icon(Icons.arrow_back_ios, size: 16, color: AppColors.primary),
                SizedBox(width: 4),
                Text(
                  'تفاصيل',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'accepted':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
