import 'package:flutter/material.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';

class ShopinglyChoiceChip extends StatelessWidget {
  const ShopinglyChoiceChip({
    super.key, required this.text, required this.selected, this.onSelected,
  });
  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final isColor = ShopinglyHelperFunctions.getColor(text) != null;
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        label: isColor ? SizedBox() : Text(text,),
        selected: selected,
        onSelected: onSelected,
        labelStyle: TextStyle(color: selected ? ShopinglyColors.white : null),
        avatar: isColor ? ShopinglyCircularContainer(width: 50, height: 50, backgroundColor: ShopinglyHelperFunctions.getColor(text)!) : null,
        shape: isColor ? CircleBorder() : null,
        backgroundColor: isColor ? ShopinglyHelperFunctions.getColor(text) : null,
        labelPadding: isColor ? EdgeInsets.zero : null,
        padding: isColor ? EdgeInsets.zero : null,
      ),
    );
  }
}
