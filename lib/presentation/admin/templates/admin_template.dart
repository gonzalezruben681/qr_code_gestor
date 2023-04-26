import 'package:flutter/material.dart';
import 'package:qr_code_gestor/presentation/admin/molecules/add_option_molecule.dart';
import 'package:qr_code_gestor/presentation/admin/organisms/admin_organism.dart';
import 'package:qr_code_gestor/presentation/atoms/card_atom.dart';
import 'package:qr_code_gestor/presentation/utils/qr_utils.dart';

class AdminTemplate extends StatelessWidget {
  const AdminTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CardAtom(
          color: QRUtils.greyBackground,
          child: AddOptionMolecule(),
        ),
        const AdminOrganism()
      ],
    );
  }
}
