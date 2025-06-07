import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/clients_controller.dart';
import '../widgets/clients_app_bar.dart';
import '../widgets/client_card.dart';
import '../widgets/lawyer_bottom_navigation_bar.dart';
import '../../data/models/client.dart';
import '../../data/models/case_item.dart';

class ClientsView extends GetView<ClientsController> {
  const ClientsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        body: SafeArea(
          child: Column(
            children: [
              const ClientsAppBar(),

              // Clients List
              Expanded(
                child: _buildClientsListView(),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const LawyerBottomNavigationBar(currentIndex: 1),
      ),
    );
  }

  Widget _buildClientsListView() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(color: Color(0xFFC8A45D)),
        );
      }

      if (controller.hasError.value) {
        return Center(
          child: Text(
            controller.errorMessage.value,
            style: const TextStyle(color: Colors.red, fontFamily: 'Almarai'),
          ),
        );
      }

      if (controller.clients.isEmpty) {
        return const Center(
          child: Text(
            'لا يوجد موكلين',
            style: TextStyle(color: Color(0xFF737373), fontFamily: 'Almarai'),
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        itemCount: controller.clients.length,
        itemBuilder: (context, index) {
          final client = controller.clients[index];

          // Find corresponding case item for this client
          CaseItem? clientCase = _findCaseForClient(client.id);

          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ClientCard(
              client: client,
              caseItem: clientCase,
              onTap: () => controller.navigateToClientDetails(client.id),
            ),
          );
        },
      );
    });
  }

  // Helper method to find case for a client
  CaseItem? _findCaseForClient(int clientId) {
    try {
      return controller.cases
          .firstWhere((caseItem) => caseItem.caseId == clientId);
    } catch (e) {
      // If no case is found, return null
      return null;
    }
  }
}
