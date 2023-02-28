
import '../../../libraries/views.dart';

class NumberField extends StatelessWidget {
  final String label;
  final FocusNode? focus;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final Widget? subtitle;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;

  const NumberField(this.label, {super.key, this.focus, this.controller, this.inputType, this.subtitle, this.validator, this.onFieldSubmitted,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          label,
          style: Get.textTheme.bodyMedium,
        ),
        subtitle: subtitle,
        trailing: SizedBox(
          width: Get.width * 0.3,
          child: TextFormField(
            onFieldSubmitted: onFieldSubmitted,
            validator: validator,
            decoration: const InputDecoration(filled: true),
            controller: controller,
            focusNode: focus,
            keyboardType: inputType,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}