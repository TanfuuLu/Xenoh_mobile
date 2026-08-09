import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_dimens.dart';

typedef XnCarouselItemBuilder<T> =
    Widget Function(
      BuildContext context,
      T item, {
      required bool selected,
    });
typedef XnCarouselLabelBuilder<T> =
    String Function(BuildContext context, T item);

class XnCardCarousel<T> extends StatefulWidget {
  const XnCardCarousel({
    required this.items,
    required this.height,
    required this.semanticLabel,
    required this.indexLabelBuilder,
    required this.itemBuilder,
    this.initialIndex = 0,
    this.onIndexChanged,
    super.key,
  });

  final List<T> items;
  final double height;
  final String semanticLabel;
  final XnCarouselLabelBuilder<T> indexLabelBuilder;
  final XnCarouselItemBuilder<T> itemBuilder;
  final int initialIndex;
  final ValueChanged<int>? onIndexChanged;

  @override
  State<XnCardCarousel<T>> createState() => _XnCardCarouselState<T>();
}

class _XnCardCarouselState<T> extends State<XnCardCarousel<T>> {
  late PageController _pageController;
  late int _selectedIndex;

  int _safeIndex(int requested) {
    if (widget.items.isEmpty) return 0;
    return requested.clamp(0, widget.items.length - 1);
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = _safeIndex(widget.initialIndex);
    _pageController = PageController(
      initialPage: _selectedIndex,
      viewportFraction: 0.9,
    );
  }

  @override
  void didUpdateWidget(covariant XnCardCarousel<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.items.length == oldWidget.items.length) return;
    final nextIndex = _safeIndex(_selectedIndex);
    if (nextIndex == _selectedIndex) return;
    _selectedIndex = nextIndex;
    if (_pageController.hasClients) {
      _pageController.jumpToPage(nextIndex);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _setSelectedIndex(int index) {
    if (_selectedIndex == index) return;
    setState(() => _selectedIndex = index);
    widget.onIndexChanged?.call(index);
  }

  Future<void> _selectFromIndex(int index) async {
    final disableAnimations =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    if (disableAnimations) {
      _pageController.jumpToPage(index);
      _setSelectedIndex(index);
      return;
    }
    await _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) return const SizedBox.shrink();
    final disableAnimations =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    final animationDuration = disableAnimations
        ? Duration.zero
        : const Duration(milliseconds: 280);

    return Semantics(
      container: true,
      label: widget.semanticLabel,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            child: Row(
              children: [
                for (var index = 0; index < widget.items.length; index++) ...[
                  Semantics(
                    key: ValueKey('xn-card-carousel-index-$index'),
                    button: true,
                    selected: index == _selectedIndex,
                    child: ChoiceChip(
                      label: Text(
                        widget.indexLabelBuilder(
                          context,
                          widget.items[index],
                        ),
                      ),
                      selected: index == _selectedIndex,
                      showCheckmark: false,
                      onSelected: (_) => _selectFromIndex(index),
                    ),
                  ),
                  if (index != widget.items.length - 1)
                    const SizedBox(width: AppSpacing.sm),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: widget.height,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.items.length,
              padEnds: false,
              onPageChanged: _setSelectedIndex,
              itemBuilder: (context, index) {
                final selected = index == _selectedIndex;
                return Padding(
                  key: ValueKey('xn-card-carousel-page-$index'),
                  padding: const EdgeInsets.only(right: AppSpacing.md),
                  child: AnimatedOpacity(
                    duration: animationDuration,
                    curve: Curves.easeOutCubic,
                    opacity: disableAnimations || selected ? 1 : 0.72,
                    child: AnimatedScale(
                      duration: animationDuration,
                      curve: Curves.easeOutCubic,
                      alignment: Alignment.centerLeft,
                      scale: disableAnimations || selected ? 1 : 0.96,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.shadow,
                              blurRadius: 18,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        child: widget.itemBuilder(
                          context,
                          widget.items[index],
                          selected: selected,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
