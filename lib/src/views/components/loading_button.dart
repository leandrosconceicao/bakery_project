import '../../../libraries/views.dart';

class LoadingButton extends StatelessWidget {
  final Widget? onLoadWidget;
  final FocusNode? focus;
  final Widget label;
  final Function process;

  LoadingButton({
    super.key,
    this.onLoadWidget,
    required this.label,
    required this.process,
    this.focus,
  });

  final onLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FilledButton(
        focusNode: focus,
          onPressed: onLoading.value ? null : () async {
            onLoading.value = true;
            await process();
            onLoading.value = false;
          },
          child: onLoading.value
              ? (onLoadWidget ??
                  Center(
                      child: SizedBox(
                    height: Get.height * 0.02,
                    width: Get.height * 0.02,
                    child: const CircularProgressIndicator(color: Colors.white,),
                  )))
              : label),
    );
  }
}
