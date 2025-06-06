import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientsAppBar extends StatelessWidget {
  const ClientsAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 20, left: 24, right: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Page title
          const Text(
            'الموكلين',
            style: TextStyle(
              color: Color(0xFF000000),
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Almarai',
            ),
          ),

          // Icons row
          Row(
            children: [
              // Settings icon
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFBFBFBF),
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.settings_outlined,
                  color: Color(0xFFB8B8B8),
                  size: 20,
                ),
              ),

              const SizedBox(width: 10),

              // Message icon
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFBFBFBF),
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.message_outlined,
                  color: Color(0xFFB8B8B8),
                  size: 20,
                ),
              ),

              const SizedBox(width: 10),

              // Notification icon
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFBFBFBF),
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.notifications_outlined,
                  color: Color(0xFFBFBFBF),
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
