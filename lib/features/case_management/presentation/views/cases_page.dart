import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_search_text_field.dart';
import '../../../../../core/utils/app_router.dart';
import '../../domain/entities/case.dart';
import '../widgets/case_card.dart';
import '../widgets/empty_state.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../features/home/presentation/widgets/bottom_navigation_bar.dart';

class CasesPage extends StatefulWidget {
  const CasesPage({super.key});

  @override
  State<CasesPage> createState() => _CasesPageState();
}

class _CasesPageState extends State<CasesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  // Filter states
  bool _isSearching = false;
  String _searchQuery = '';

  // Mock data for cases with different statuses
  final List<Case> _waitingApprovalCases = [
    Case(
      id: '1',
      title: 'طلب استشارة قانونية حول عقد إيجار',
      description:
          'أرغب في الحصول على استشارة قانونية بشأن عقد إيجار تجاري مع شروط غير واضحة',
      caseNumber: '2023-156',
      caseType: 'استشارة قانونية',
      status: 'بانتظار الموافقة',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Case(
      id: '2',
      title: 'طلب مراجعة عقد عمل',
      description:
          'أحتاج إلى مراجعة عقد العمل الخاص بي قبل التوقيع عليه للتأكد من عدم وجود بنود مجحفة',
      caseNumber: '2023-157',
      caseType: 'قانون العمل',
      status: 'بانتظار الموافقة',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];

  final List<Case> _approvedCases = [
    Case(
      id: '3',
      title: 'دعوى مطالبة مالية',
      description: 'دعوى للمطالبة بمستحقات مالية متأخرة من شركة سابقة',
      caseNumber: '2023-120',
      caseType: 'قضايا مدنية',
      status: 'موافق عليه',
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      assignedLawyerId: 'محمد أحمد',
    ),
  ];

  final List<Case> _closedCases = [
    Case(
      id: '4',
      title: 'استشارة قانونية حول قضية إرث',
      description:
          'تم تقديم استشارة قانونية حول كيفية توزيع الإرث وفقاً للقانون',
      caseNumber: '2023-098',
      caseType: 'أحوال شخصية',
      status: 'مغلق',
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      assignedLawyerId: 'خالد محمود',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Add listener to update UI when tab changes
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // Filter cases based on search query
  List<Case> _getFilteredCasesList() {
    final List<Case> allCases = [
      ..._waitingApprovalCases,
      ..._approvedCases,
      ..._closedCases,
    ];

    if (_searchQuery.isEmpty) {
      // If no search query, return cases based on current tab
      switch (_tabController.index) {
        case 0:
          return _waitingApprovalCases;
        case 1:
          return _approvedCases;
        case 2:
          return _closedCases;
        default:
          return _waitingApprovalCases;
      }
    } else {
      // If searching, filter by case number across all cases
      return allCases
          .where((caseItem) =>
              caseItem.caseNumber.contains(_searchQuery) ||
              caseItem.title.contains(_searchQuery))
          .toList();
    }
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _isSearching = query.isNotEmpty;
    });
  }

  void _onClearSearch() {
    setState(() {
      _searchController.clear();
      _searchQuery = '';
      _isSearching = false;
    });
  }

  void _navigateToPublishCase() {
    // Navigate to publish case page
    AppRouter.instance.navigateToPublishCase(context);
  }

  void _navigateToCaseDetails(Case caseItem) {
    // Navigate to case details page
    AppRouter.instance.navigateToCaseDetails(context, caseItem);
  }

  @override
  Widget build(BuildContext context) {
    final List<Case> currentCases = _getFilteredCasesList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.ScreenBackground,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'قضاياي',
            style: TextStyle(
              color: AppColors.primary,
              fontFamily: 'Almarai',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            // Search Field
            CustomSearchTextField(
              controller: _searchController,
              hintText: 'ابحث برقم القضية...',
              onChanged: _onSearchChanged,
              showFilterButton: false,
            ),

            // Tab Navigation (only visible when not searching)
            if (!_isSearching)
              TabBar(
                controller: _tabController,
                indicatorColor: const Color(0xFFC8A45D), // Gold color
                labelColor: AppColors.primary,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(text: 'بانتظار الموافقة'),
                  Tab(text: 'موافق عليها'),
                  Tab(text: 'مغلقة'),
                ],
              ),

            // Cases List or Empty State
            Expanded(
              child: _isSearching
                  ? _buildCasesList(currentCases, isSearchResult: true)
                  : TabBarView(
                      controller: _tabController,
                      children: [
                        _buildCasesList(_waitingApprovalCases),
                        _buildCasesList(_approvedCases),
                        _buildCasesList(_closedCases),
                      ],
                    ),
            ),
          ],
        ),
        bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 3),
      ),
    );
  }

  Widget _buildCasesList(List<Case> cases, {bool isSearchResult = false}) {
    if (cases.isEmpty) {
      return _buildEmptyState(isSearchResult);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: cases.length,
      itemBuilder: (context, index) {
        return CaseCard(
          caseItem: cases[index],
          onTap: () => _navigateToCaseDetails(cases[index]),
        );
      },
    );
  }

  Widget _buildEmptyState(bool isSearchResult) {
    if (isSearchResult) {
      return EmptyState(
        title: 'لا توجد نتائج',
        message:
            'لم نتمكن من العثور على قضايا مطابقة للبحث، يرجى تجربة كلمات بحث أخرى',
        iconPath: 'assets/images/search.svg',
        buttonText: 'مسح البحث',
        onButtonPressed: _onClearSearch,
      );
    }

    switch (_tabController.index) {
      case 0:
        return EmptyState(
          title: 'لا توجد قضايا بانتظار الموافقة',
          message: 'ليس لديك أي قضايا بانتظار الموافقة حالياً',
          iconPath: 'assets/images/case.svg',
          buttonText: 'إنشاء قضية جديدة',
          onButtonPressed: _navigateToPublishCase,
        );
      case 1:
        return EmptyState(
          title: 'لا توجد قضايا موافق عليها',
          message: 'ليس لديك أي قضايا موافق عليها حالياً',
          iconPath: 'assets/images/case.svg',
          buttonText: 'إنشاء قضية جديدة',
          onButtonPressed: _navigateToPublishCase,
        );
      case 2:
        return EmptyState(
          title: 'لا توجد قضايا مغلقة',
          message: 'ليس لديك أي قضايا مغلقة حالياً',
          iconPath: 'assets/images/folder.svg',
          buttonText: 'إنشاء قضية جديدة',
          onButtonPressed: _navigateToPublishCase,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
