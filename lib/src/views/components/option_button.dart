
import 'package:bakery/libraries/models.dart';

import '../../../libraries/views.dart';

class OptionsButton extends StatelessWidget {
  final void Function(ActionTypes)? onSelected;
  final List<ActionsData> actionsData;
  final Icon? icon;
  final double? size;

  const OptionsButton({super.key, 
    this.onSelected,
    required this.actionsData,
    this.icon,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: MyPallete.defaultColor,
      icon: icon,
      iconSize: size,
      onSelected: onSelected,
      itemBuilder: (context) => actionsData
          .map(
            (e) => PopupMenuItem(
              value: e.value,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                      getIcon(e.value),
                      color: Colors.white),
                  Text(e.title ?? '')
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  IconData getIcon(ActionTypes? e) {
    switch (e) {
      case ActionTypes.edit:
        return Icons.edit_attributes;
      case ActionTypes.del:
        return Icons.delete;
      case ActionTypes.inputImage:
        return Icons.add_a_photo;
      case ActionTypes.input:
        return Icons.input;
      case ActionTypes.transfer:
        return Icons.sync_alt;
      case ActionTypes.add:
        return Icons.new_label;
      case ActionTypes.lock:
        return Icons.check;
      case ActionTypes.print:
        return Icons.print;
      case ActionTypes.open:
        return Icons.open_in_browser;
      case ActionTypes.acceptOrder:
        return Icons.thumb_up_rounded;
      case ActionTypes.denyOrder:
        return Icons.thumb_down_rounded;
      default:
        return Icons.send;
    }
  }
}


enum ActionTypes {edit, del, inputImage, input, transfer, add, lock, print, open, acceptOrder, denyOrder}

class ActionsData {
  ActionTypes? value;
  String? title;

  ActionsData({required this.value, required this.title});

}