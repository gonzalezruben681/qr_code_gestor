import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_code_gestor/domain/models/opcion.dart';
import 'package:qr_code_gestor/presentation/admin/molecules/add_option_molecule.dart';
import 'package:qr_code_gestor/presentation/atoms/card_atom.dart';
import 'package:qr_code_gestor/presentation/atoms/custom_expansion_tile_atom.dart';
import 'package:qr_code_gestor/presentation/utils/qr_utils.dart';
import 'package:qr_code_gestor/providers/option_provider.dart';

class AdminOrganism extends ConsumerStatefulWidget {
  const AdminOrganism({super.key});

  @override
  ConsumerState<AdminOrganism> createState() => _AdminOrganismState();
}

class _AdminOrganismState extends ConsumerState<AdminOrganism> {
  Stream<List<OptionModel>>? _optionsStream;
  List<OptionModel>? _options;

  @override
  void initState() {
    super.initState();
    _optionsStream = ref.read(optionProvider).getOptions();
    _optionsStream?.listen((optionsList) {
      setState(() {
        _options = optionsList;
      });
    });
  }

  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CardAtom(
          color: QRUtils.greyBackground,
          child: AddOptionMolecule(),
        ),
        Container(
          height: 200,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ListView.builder(
            itemCount: _options?.length,
            itemBuilder: (context, index) {
              final option = _options?[index];
              return CustomExpansionTileAtom(
                text: option?.option ?? '',
                index: index,
              );
            },
          ),
        ),
      ],
    );
  }
}
