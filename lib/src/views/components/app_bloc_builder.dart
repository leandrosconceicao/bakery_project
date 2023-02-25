import '../../../libraries/models.dart';
import '../../../libraries/utils.dart';
import '../../../libraries/views.dart';

class AppBlocBuilder<T> extends StatelessWidget {

  final StreamController<ApiRes<T?>> bloc;
  final Widget Function(T?) child;

  const AppBlocBuilder({super.key, required this.bloc, required this.child});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.stream,
      builder: (context, AsyncSnapshot<ApiRes<T?>?> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          ApiRes<T?> snap = snapshot.data!;
          if (!snap.result) {
            return Center(child: Text(snap.message));
          }
          return child(snap.data);
        }
      },
    );
  }
}