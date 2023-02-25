import '/libraries/models.dart';

import '/libraries/utils.dart';
import '/libraries/views.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(16.0),
              bottomRight: Radius.circular(16.0))),
      child: Column(
        children: [
          UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: MyPallete.defaultColor,
                child: const Icon(Icons.person),
              ),
              accountName: Text(app.loggedUser.value?.nome ?? ''),
              accountEmail: Text(app.loggedUser.value?.email ?? '')),
          menuItems(
              onTap: () => Get.toNamed(Routes.home),
              leading: const Icon(Icons.home),
              label: 'Página inicial',
              subtitle: ''),
          menuItems(
              onTap: () => Get.toNamed(Routes.configs),
              leading: const Icon(Icons.settings),
              label: 'Configurações',
              subtitle: 'Definição de metas de ganho e tempo de trabalho'),
          menuItems(
              onTap: () {},
              leading: const Icon(Icons.account_balance),
              label: 'Despesas',
              subtitle: 'Minhas despesas'),
          menuItems(
              onTap: () {},
              leading: const Icon(Icons.receipt_long),
              label: 'Receitas',
              subtitle: 'Criação de receitas'),
          menuItems(
              onTap: () => Get.toNamed(Routes.ingredients),
              leading: const Icon(Icons.label),
              label: 'Ingredientes',
              subtitle: 'Criação de ingredientes para as receitas'),
        ],
      ),
    );
  }

  ListTile menuItems({
    Icon? leading,
    required String label,
    String? subtitle,
    void Function()? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: leading ?? const Icon(Icons.label),
      title: Text(label),
      subtitle: Text(subtitle ?? ''),
    );
  }
}
