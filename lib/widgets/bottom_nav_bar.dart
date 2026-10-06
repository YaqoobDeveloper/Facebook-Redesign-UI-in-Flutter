import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Bottom navigation with a big "+" compose button in the middle.
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  /// Tabs shown in the bar. `null` marks where the compose button goes.
  static const items = [
    (icon: Icons.home_rounded, label: 'Home'),
    (icon: Icons.chat, label: 'Inbox'),
    null,
    (icon: Icons.notifications, label: 'Notification'),
    (icon: Icons.person, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.navBar,
        border: Border(top: BorderSide(color: AppColors.navBorder)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 72,
          child: Row(
            children: [
              for (var i = 0; i < items.length; i++)
                Expanded(
                  child: items[i] == null
                      ? const ComposeButton()
                      : NavItem(
                          icon: items[i]!.icon,
                          label: items[i]!.label,
                          selected: currentIndex == i,
                          onTap: () => onTap(i),
                        ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// One tab: icon above a label, blue when selected.
class NavItem extends StatelessWidget {
  const NavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.blue : AppColors.body;

    return InkResponse(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 2),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.visible,
            style: TextStyle(fontSize: 12, color: color),
          ),
        ],
      ),
    );
  }
}

/// The glowing blue "+" button in the middle of the bar.
class ComposeButton extends StatelessWidget {
  const ComposeButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 60,
        height: 52,
        decoration: BoxDecoration(
          color: AppColors.blue,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: AppColors.blue.withValues(alpha: 0.45),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap ?? () {},
            customBorder: const StadiumBorder(),
            child: const Icon(Icons.add, color: Colors.white, size: 32),
          ),
        ),
      ),
    );
  }
}
