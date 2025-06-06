import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:legal_app/app/shared/widgets/custom_button.dart';
import 'package:legal_app/app/shared/widgets/custom_search_text_field.dart';
import 'package:legal_app/app/features/client/home/presentation/widgets/bottom_navigation_bar.dart';
import 'package:legal_app/app/features/client/home/presentation/widgets/lawyer_card.dart';
import 'package:legal_app/app/routes/app_routes.dart';
import 'package:legal_app/app/core/data/models/lawyer.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';
import 'package:legal_app/app/core/utils/app_assets.dart';

class LawyersListingPage extends StatefulWidget {
  const LawyersListingPage({super.key});

  @override
  State<LawyersListingPage> createState() => _LawyersListingPageState();
}

class _LawyersListingPageState extends State<LawyersListingPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedSpecialization = 'الكل';
  String _selectedCity = 'الكل';
  String _searchQuery = '';
  final List<String> _specializations = [
    'الكل',
    'قانون مدني',
    'قانون جنائي',
    'قانون تجاري',
    'قانون الأسرة'
  ];

  final List<String> _cities = [
    'الكل',
    'دمشق',
    'حمص',
    'حلب',
    'حماه',
    'اللاذقية',
  ];

  // Dummy lawyers data
  final List<Lawyer> _lawyers = [
    Lawyer(
      id: '1',
      name: 'محمد أحمد',
      location: 'دمشق',
      description:
          'محامي متخصص في القانون المدني مع خبرة 10 سنوات في مجال العقود والقضايا المدنية',
      price: 50,
      imageUrl: 'assets/images/person.svg',
      specialization: 'قانون مدني',
    ),
    Lawyer(
      id: '2',
      name: 'عمر خالد',
      location: 'حلب',
      description:
          'متخصص في القضايا الجنائية وقضايا الجرائم الالكترونية مع خبرة 8 سنوات',
      price: 75,
      imageUrl: 'assets/images/person.svg',
      specialization: 'قانون جنائي',
    ),
    Lawyer(
      id: '3',
      name: 'سارة محمود',
      location: 'حمص',
      description:
          'متخصصة في قانون الأسرة وقضايا الطلاق والحضانة مع خبرة 12 سنة',
      price: 60,
      imageUrl: 'assets/images/person.svg',
      specialization: 'قانون الأسرة',
    ),
    Lawyer(
      id: '4',
      name: 'ياسر عبدالله',
      location: 'اللاذقية',
      description: 'متخصص في القانون التجاري وتأسيس الشركات والعقود التجارية',
      price: 80,
      imageUrl: 'assets/images/person.svg',
      specialization: 'قانون تجاري',
    ),
    Lawyer(
      id: '5',
      name: 'أحمد علي',
      location: 'حماه',
      description:
          'محامي متخصص في القانون المدني والقضايا العقارية مع خبرة 7 سنوات',
      price: 55,
      imageUrl: 'assets/images/person.svg',
      specialization: 'قانون مدني',
    ),
  ];

  List<Lawyer> get filteredLawyers {
    return _lawyers.where((lawyer) {
      // Filter by search query
      final nameMatches =
          lawyer.name.contains(_searchQuery) || _searchQuery.isEmpty;

      // Filter by specialization
      final specializationMatches = _selectedSpecialization == 'الكل' ||
          lawyer.specialization == _selectedSpecialization;

      // Filter by city
      final cityMatches =
          _selectedCity == 'الكل' || lawyer.location == _selectedCity;

      return nameMatches && specializationMatches && cityMatches;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ScreenBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.ScreenBackground,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'المحامين المتاحين',
          style: TextStyle(
            fontFamily: 'Almarai',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              AppAssets.arrowRight,
              color: AppColors.primary,
            ),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: CustomSearchTextField(
                controller: _searchController,
                hintText: 'ابحث عن محامي...',
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                onFilterPressed: () {
                  _showFilterBottomSheet(context);
                },
              ),
            ),
          ),

          // City filter chips horizontally scrollable
          SingleChildScrollView(
            reverse: true,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 8, bottom: 8),
                    child: const Text(
                      'المدينة:',
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  ..._cities.map(
                    (city) => _buildFilterChip(
                      label: city,
                      isSelected: _selectedCity == city,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCity = city;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Lawyer cards list or empty message
          Expanded(
              child: filteredLawyers.isEmpty
                  ? const Center(
                      child: Text(
                        'لا يوجد محامين بالمواصفات المطلوبة',
                        style: TextStyle(
                          fontFamily: 'Almarai',
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: filteredLawyers.length,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      reverse: false,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: LawyerCard(
                            lawyer: filteredLawyers[index],
                            onConsultTap: () => Get.toNamed(
                              Routes.CONSULTATION_REQUEST,
                              arguments: filteredLawyers[index],
                            ),
                            onRepresentTap: () =>
                                Get.toNamed(Routes.DIRECT_CASE_REQUEST),
                            fullWidth: true,
                          ),
                        );
                      },
                    )),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        key: const ValueKey('lawyers_listing_bottom_nav'),
        currentIndex: 2,
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required Function(bool) onSelected,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: FilterChip(
        label: Text(
          label,
          style: TextStyle(
            fontFamily: 'Almarai',
            fontSize: 13,
            color: isSelected ? Colors.white : AppColors.primary,
          ),
        ),
        selected: isSelected,
        onSelected: onSelected,
        backgroundColor: Colors.white,
        selectedColor: AppColors.primary,
        checkmarkColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
          ),
        ),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'تصفية حسب التخصص',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _specializations.map((spec) {
                      return _buildFilterChip(
                        label: spec,
                        isSelected: _selectedSpecialization == spec,
                        onSelected: (selected) {
                          setState(() {
                            _selectedSpecialization = spec;
                          });
                          // Update main widget state as well
                          this.setState(() {});
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    text: 'تطبيق',
                    backgroundColor: AppColors.primary,
                    textColor: Colors.white,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
