import 'package:barcode_image/barcode_image.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image/image.dart' as im;
import 'package:qr_code_gestor/presentation/atoms/card_atom.dart';
import 'package:qr_code_gestor/presentation/atoms/custom_input_atom.dart';
import 'package:qr_code_gestor/presentation/utils/qr_utils.dart';
import 'package:qr_code_gestor/presentation/atoms/custom_button_atom.dart';
import 'package:reactive_forms/reactive_forms.dart';

// ignore: must_be_immutable
class QRGestorMolecule extends HookWidget {
  QRGestorMolecule({super.key});
  String? nombre;
  String? telefono;
  final form = FormGroup({
    'nombre': FormControl<String>(validators: [
      Validators.required,
      Validators.pattern(r'^[a-zA-ZñÑ,\sáéíóúÁÉÍÓÚ]+$'),
    ]),
    'telefono': FormControl<String>(validators: [
      Validators.required,
      Validators.maxLength(10),
      Validators.pattern('[0-9]+'),
    ]),
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: form,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CardAtom(
            color: QRUtils.greyBackground,
            child: Column(
              children: [
                const Icon(
                  Icons.person_add,
                  size: 80,
                  color: QRUtils.yellowBackground,
                ),
                CustomInputAtom(
                  style: GoogleFonts.itim(
                    fontSize: 18,
                  ),
                  icon: Icons.person,
                  formControlName: 'nombre',
                  validationMessages: {
                    ValidationMessage.required: (error) =>
                        'Este campo es requerido',
                    ValidationMessage.pattern: (errror) =>
                        'Solo se permiten letras, comas y espacios',
                  },
                  placeholder: 'Ingresa su nombre completo',
                ),
                const SizedBox(height: 15),
                CustomInputAtom(
                  style: GoogleFonts.itim(
                    fontSize: 18,
                  ),
                  icon: Icons.phone_android,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  formControlName: 'telefono',
                  validationMessages: {
                    ValidationMessage.required: (error) =>
                        'Este campo es requerido',
                    ValidationMessage.maxLength: (error) =>
                        'Solo esta permitido hasta 10 números',
                    ValidationMessage.pattern: (error) =>
                        'Solo se permiten números',
                  },
                  placeholder: 'Ingresa su número de telefono',
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: CustomButtonAtom(
                      style: GoogleFonts.itim(
                        fontSize: 20,
                      ),
                      text: 'DESCARGAR QR',
                      onPressed: () => exportPng(context),
                      icon: Icons.download),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
          )
        ],
      ),
    );
  }

  Future<void> exportPng(BuildContext context) async {
    FocusScope.of(context).unfocus();
    // validar el formulario antes de continuar
    if (form.invalid) {
      form.markAllAsTouched();
      return;
    }
    // obtener los valores del formulario
    nombre = form.control('nombre').value!;
    telefono = form.control('telefono').value!;
    final image = im.Image(height: 250, width: 250);
    im.fill(image, color: im.ColorFloat64.rgb(255, 255, 255));
    drawBarcode(image, Barcode.qrCode(),
        'nombre: ${nombre!.trim()}, telefono: ${telefono!.trim()}',
        font: im.arial48);
    final data = im.encodePng(image);
    if (kIsWeb) {
      final fileName = '$nombre.png';
      final location = await getSavePath(suggestedName: fileName);
      if (location != null) {
        final file = XFile.fromData(
          Uint8List.fromList(data),
          name: fileName,
          mimeType: 'image/png',
        );
        await file.saveTo(location);
      }
      _resetForm();
    } else {
// Convierte la imagen a un objeto Uint8List y lo guarda en el celular
      final result = await ImageGallerySaver.saveImage(Uint8List.fromList(data),
          quality: 100, name: nombre);
      _resetForm();

      // mostrar un mensaje de éxito o error según el resultado de guardar la imagen
      final snackBar = result['isSuccess']
          ? const SnackBar(content: Text('QR guardado en galería'))
          : const SnackBar(content: Text('Error al guardar el QR'));
// ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void _resetForm() {
    form.control('nombre').reset();
    form.control('telefono').reset();
  }
}
