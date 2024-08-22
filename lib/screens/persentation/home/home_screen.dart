import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reni/config/styles/colors/app_colors.dart';
import 'package:reni/screens/data/generalCubit/general_cubit.dart';
import 'package:reni/screens/persentation/home/widget/delivered_list.dart';
import 'package:reni/screens/persentation/home/widget/order_list.dart';
import '../../../config/assets/assets_manager.dart';
import '../../data/generalCubit/general_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final GeneralCubit homeCubit;
  final GeneralOrderData state;

  HomeScreen({super.key, required this.homeCubit, required this.state});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
  }

  Future<void> logout(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Clear the login status from SharedPreferences
    await prefs.remove('isLoggedIn');
    // Navigate to the login screen and remove all previous routes
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.homeCubit,
      child: BlocBuilder<GeneralCubit, GeneralState>(builder: (context, states) {
        return WillPopScope(
            onWillPop: () async {
              Navigator.pop(context);
          return true;  // Allows the app to close when the back button is pressed
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false, // Removes the back button
            elevation: 0,
            leading: null,
            leadingWidth: 10.0,
            actions: [
              IconButton(
                icon: Icon(Icons.logout, color: Colors.red),
                onPressed: () async {
                  await logout(context);
                },
              ),
            ],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.monetization_on, color: AppColors.goldColor), // Your icon goes here
                    SizedBox(width: 8.0),
                    Text(
                      (widget.homeCubit.DeliveryBoyData.isNotEmpty && widget.homeCubit.DeliveryBoyData[0].deliveryBoy.totalCommission != null)
                          ? widget.homeCubit.DeliveryBoyData[0].deliveryBoy.totalCommission.toString()
                          : '0',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        color: AppColors.primaryColor,
                        fontSize: 15,
                      ),
                    ),// Your text goes here
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Text(
                    (widget.homeCubit.DeliveryBoyData.isNotEmpty && widget.homeCubit.DeliveryBoyData[0].deliveryBoy.name != null)
                        ? widget.homeCubit.DeliveryBoyData[0].deliveryBoy.name.toString()
                        : 'Delivery Boy',
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ), // Your title text goes here
                ),
              ],
            ),
          ),
          body: PageView(
            reverse: true,
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: [
              OrdersList(context: context, state: widget.state, homeCubit: widget.homeCubit),
              DeliveredList(context: context, state: widget.state, homeCubit: widget.homeCubit),
            ],
          ),
          bottomNavigationBar: Directionality(
            textDirection: TextDirection.rtl,
            child: BottomNavigationBar(
              backgroundColor: AppColors.primaryColor,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: 'الطلبات',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.done_all),
                  label: 'التسليمات',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: AppColors.whiteColor,
              onTap: _onItemTapped,
              ),
          ),
          )
        );
      }),
    );
  }
}