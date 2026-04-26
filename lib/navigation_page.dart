import 'package:ecommerce_app/core/theme/app_palette.dart';
import 'package:ecommerce_app/features/produits/presentation/widgets/cart.dart';
import 'package:ecommerce_app/features/shop/home_page.dart';
import 'package:ecommerce_app/notification.dart';
import 'package:ecommerce_app/settings.dart';
import 'package:flutter/material.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentIndex = 0; // L'onglet sélectionné par défaut

  final List<Widget> _pages = [
    const Homepage(),
    const NotificationPage(),
    const Cart(),
    const Settings(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade100, width: 1)),
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        //configuration visuelle
        type: BottomNavigationBarType
            .fixed, // empêche les icônes de "bouger" ou de s'agrandir bizarrement quand on clique dessus. Tout reste stable.
        backgroundColor: Colors.white,
        selectedItemColor:
            AppPalette.primaryColor, //qand on clique sur un onglet,
        unselectedItemColor: Colors.grey, // couleur par défaut des éléments,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0, // on enlève l'ombre par défaut
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Accueil",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            label: "Notifications",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: "Commandes",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}
