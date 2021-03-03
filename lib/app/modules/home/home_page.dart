import 'package:coffee_tracker/app/modules/home/home_content/home_content_module.dart';
import 'package:coffee_tracker/app/modules/profile/profile_module.dart';
import 'package:coffee_tracker/app/modules/restaurant/restaurant_module.dart';
import 'package:coffee_tracker/app/modules/review/review_module.dart';
import 'package:coffee_tracker/app/shared/components/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  bool dialVisible = true;

  final _pages = [
    HomeContentModule(),
    RestaurantModule(),
    ReviewModule(),
    ProfileModule(),
  ];

  final _buttons = [
    {
      'icon': Icons.home_outlined,
      'active_icon': Icons.home,
      'label': 'Home',
    },
    {
      'icon': Icons.store_outlined,
      'active_icon': Icons.store,
      'label': 'Cafés',
    },
    {
      'icon': Icons.text_snippet_outlined,
      'active_icon': Icons.text_snippet,
      'label': 'Reviews',
    },
    {
      'icon': Icons.person_outlined,
      'active_icon': Icons.person,
      'label': 'Perfil',
    },
  ];

  PageController _pageController;
  bool _isSmall;
  bool _portrait;

  List<Widget> _iconButtons() {
    final data = _buttons
        .asMap()
        .map(
          (i, e) => MapEntry(
            i,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: Observer(builder: (_) {
                return IconButton(
                  tooltip: e['label'],
                  icon: Icon(
                    controller.currentIndex == i ? e['active_icon'] : e['icon'],
                  ),
                  iconSize: 28,
                  onPressed: () => _pageController.jumpToPage(i),
                  color: Theme.of(context).iconTheme.color,
                );
              }),
            ),
          ),
        )
        .values
        .toList();

    data.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(width: ResponsiveWidget.appBarPadding(context)),
    ));

    return data;
  }

  List<BottomNavigationBarItem> get _navItems => _buttons
      .map(
        (e) => BottomNavigationBarItem(
          label: e['label'],
          tooltip: e['label'],
          activeIcon: Icon(e['active_icon']),
          icon: Icon(e['icon']),
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    _isSmall = ResponsiveWidget.isSmallScreen(context);
    _portrait = ResponsiveWidget.isPortrait(context);

    return WillPopScope(
      onWillPop: () => Future.sync(_onWillPop),
      child: Scaffold(
        appBar: _buildAppBar(),
        bottomNavigationBar: _bottomNavigationBar(),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overScroll) {
            overScroll.disallowGlow();
            return false;
          },
          child: _buildContent(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: controller.currentIndex,
    );
  }

  Widget _bottomNavigationBar() {
    if (!_isSmall || !_portrait) {
      return null;
    } else {
      return Observer(builder: (_) {
        return BottomNavigationBar(
          currentIndex: controller.currentIndex,
          items: _navItems,
          selectedItemColor: Theme.of(context).iconTheme.color,
          unselectedItemColor: Theme.of(context).disabledColor,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          iconSize: 28,
          onTap: (index) {
            controller.updateCurrentIndex(index);
            _pageController.jumpToPage(index);
          },
        );
      });
    }
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Padding(
        padding: EdgeInsets.only(
          left: ResponsiveWidget.appBarPadding(context),
        ),
        child: Text(
          'Coffee Tracker',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      automaticallyImplyLeading: false,
      actions: !_isSmall || !_portrait ? _iconButtons() : null,
    );
  }

  Widget _buildContent() {
    return Center(
      child: Container(
        width: ResponsiveWidget.contentWidth(context),
        child: PageView(
          controller: _pageController,
          onPageChanged: (_) {
            controller.updateCurrentIndex(_);
            FocusScope.of(context).unfocus();
          },
          physics: _isSmall ? null : NeverScrollableScrollPhysics(),
          children: _pages,
        ),
      ),
    );
  }

  bool _onWillPop() {
    if (_pageController.page.round() == _pageController.initialPage)
      return true;
    else {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return false;
    }
  }
}
