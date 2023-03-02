import '../../../libraries/utils.dart';
import '../../../libraries/models.dart';
import '../../../libraries/views.dart';

class ReceiptManager extends StatefulWidget {
  final Receipts? data;
  const ReceiptManager({super.key, this.data});

  @override
  State<ReceiptManager> createState() => _ReceiptManagerState();
}

class _ReceiptManagerState extends State<ReceiptManager> {
  @override
  void initState() {
    if (widget.data != null) {
      // recepForm.selectedIngredients.ad;
    }
    super.initState();
  }

  @override
  void dispose() {
    ingreForm.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [

        ],
      ),
    );
  }
}

// String? name;
// DateTime? createdAt;
// List<Ingredients?>? ingredients;
