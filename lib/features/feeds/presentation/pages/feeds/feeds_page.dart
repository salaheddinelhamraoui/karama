import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import '../../../../contacts/presentation/pages/feeds/contacts_page.dart';
import '../../../../friendsRequests/presentation/pages/feeds/friends _page.dart';
import '../../../../notifications/presentation/pages/feeds/Notifications _page.dart';
import '../../../../profile/presentation/pages/profile/profile_page.dart';
import '../../widgets/actions_bottom_sheet.dart';
import './feeds_body.dart';
import '../../../../../core/app_theme.dart';

class FeedsPage extends StatefulWidget {
  const FeedsPage({super.key});

  @override
  State<FeedsPage> createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage> {
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home',
      style: optionStyle,
    ),
    Text(
      'Likes',
      style: optionStyle,
    ),
    Text(
      'Search',
      style: optionStyle,
    ),
    Text(
      'Profile',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 8,
            activeColor: Colors.black,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: FlutterFlowTheme.of(context).gray,
            color: Colors.black,
            tabs: [
              GButton(
                leading: SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset("assets/images/action.png"),
                ),
                icon: LineIcons.syncIcon,
                text: 'Actions',
              ),
              GButton(
                leading: SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset("assets/images/rss.png"),
                ),
                icon: LineIcons.home,
                text: 'Feeds',
              ),
              GButton(
                leading: SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset("assets/images/contact-book.png"),
                ),
                icon: LineIcons.users,
                text: 'Contacts',
              ),
              GButton(
                leading: SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset("assets/images/user.png"),
                ),
                icon: LineIcons.user,
                text: 'Profile',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) async {
              if (index == 0) {
                await showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  enableDrag: false,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: ActionsBottomSheet(),
                    );
                  },
                ).then((value) => setState(() {}));
              } else {
                setState(() {
                  _selectedIndex = index;
                });
              }
            }),
        body: SafeArea(
          child: _body(_selectedIndex, context),
        ),
      ),
    );
  }

  Widget _body(index, context) {
    if (index == 0) {
    } else if (index == 1) {
      // Open Feeds page
      return Container(
        child: FeedsBody(),
      );
      // return FeedsBody();
    } else if (index == 2) {
      // Open Contacts Page
      return ContactsPage();
    } else if (index == 3) {
      // Open Profile Page
      return ProfilePage();
    }

    return Container();
  }
}
