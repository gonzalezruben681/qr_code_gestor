import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:qr_code_gestor/presentation/admin/molecules/custom_expansion_tile_admin.dart';
import 'package:qr_code_gestor/providers/option_provider.dart';

class AdminOrganism extends HookConsumerWidget {
  const AdminOrganism({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final optionsStream = ref.watch(optionProvider).getOptions();
    final optionsState = useStream(optionsStream, initialData: const []);

    return Container(
      height: 400,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ListView.builder(
        itemCount: optionsState.data?.length,
        itemBuilder: (context, index) {
          final option = optionsState.data?[index];
          return ContactExpansionTileMolecule(
            option: option,
            index: index,
          );
        },
      ),
    );
  }
}
