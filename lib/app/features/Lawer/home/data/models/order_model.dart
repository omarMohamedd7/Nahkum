import 'client.dart';
import 'case_item.dart';

class OrderModel {
  final int requestId;
  final String status;
  final String createdAt;
  final CaseItem caseData;
  final Client clientData;

  OrderModel({
    required this.requestId,
    required this.status,
    required this.createdAt,
    required this.caseData,
    required this.clientData,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      requestId: json['request_id'] ?? 0,
      status: json['status'] ?? '',
      createdAt: json['created_at'] ?? '',
      caseData: CaseItem.fromJson(json['case'] ?? {}),
      clientData: Client.fromJson(json['client'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'request_id': requestId,
      'status': status,
      'created_at': createdAt,
      'case': caseData.toJson(),
      'client': clientData.toJson(),
    };
  }

  // Helper methods for UI display
  String getFormattedDate() {
    try {
      final DateTime dateTime = DateTime.parse(createdAt);
      return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
    } catch (e) {
      return createdAt;
    }
  }

  String getLocalizedStatus() {
    switch (status.toLowerCase()) {
      case 'accepted':
        return 'مقبول';
      case 'pending':
        return 'قيد الانتظار';
      case 'rejected':
        return 'مرفوض';
      default:
        return status;
    }
  }
}

// Pagination data class
class OrdersResponse {
  final bool success;
  final String message;
  final List<OrderModel> data;
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  OrdersResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  factory OrdersResponse.fromJson(Map<String, dynamic> json) {
    List<OrderModel> ordersList = [];
    if (json['data'] != null && json['data']['data'] != null) {
      ordersList = List<OrderModel>.from(
        (json['data']['data'] as List).map((item) => OrderModel.fromJson(item)),
      );
    }

    final dataMap = json['data'] as Map<String, dynamic>? ?? {};

    return OrdersResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: ordersList,
      currentPage: dataMap['current_page'] ?? 1,
      lastPage: dataMap['last_page'] ?? 1,
      perPage: dataMap['per_page'] ?? 10,
      total: dataMap['total'] ?? 0,
    );
  }
}
