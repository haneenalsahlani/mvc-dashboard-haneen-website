import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:haneen_site__api_dashboard/features/home/providers/narorow_side_menu_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

class MenuItemWidget extends HookConsumerWidget {
  final MenuItems item;

  const MenuItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var activeMenu = ref.watch(activeMenuMemberProvider);
    bool isSelected = activeMenu == item;

    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );

    useEffect(() {
      isSelected
          ? animationController.forward()
          : animationController.reverse();
      return null;
    }, [isSelected]);

    return SizedBox(
      width: 40,
      height: 40,
      child: InkWell(
        onTap: () {
          ref.read(activeMenuMemberProvider.notifier).toggle(item);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutCubic,
          transform: Matrix4.translationValues(isSelected ? 8 : 0, 0, 0),
          child: SizedBox(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      switchInCurve: Curves.easeInOut,
                      switchOutCurve: Curves.easeInOut,
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: ScaleTransition(
                            scale: Tween<double>(begin: 0.7, end: 1.0).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeOutBack,
                              ),
                            ),
                            child: child,
                          ),
                        );
                      },
                      child: Icon(
                        isSelected ? item.icon : item.outLied,
                        key: ValueKey(isSelected),
                        color: isSelected ? Colors.indigo : Colors.black87,
                        size: isSelected ? 20 : 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
