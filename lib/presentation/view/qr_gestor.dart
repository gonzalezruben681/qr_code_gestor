import 'package:barcode_image/barcode_image.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image/image.dart' as im;
import 'package:qr_code_gestor/presentation/view/qr_scan.dart';
import 'package:qr_code_gestor/presentation/widgets/custom_button.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:reactive_forms/reactive_forms.dart';

class QRGestor extends StatefulWidget {
  const QRGestor({super.key});

  @override
  State<QRGestor> createState() => _QRGestorState();
}

class _QRGestorState extends State<QRGestor> {
  String? nombre;
  String? telefono;

  late final FormGroup form;

  @override
  void initState() {
    super.initState();

    // crear el formulario reactivo
    form = FormGroup({
      'nombre': FormControl<String>(validators: [
        Validators.required,
        Validators.pattern(r'^[a-zA-ZñÑ,\sáéíóúÁÉÍÓÚ]+$'),
      ], value: ''),
      'telefono': FormControl<String>(validators: [
        Validators.required,
        Validators.maxLength(10),
        Validators.pattern('[0-9]+'),
      ], value: ''),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrate'),
      ),
      body: ReactiveForm(
        formGroup: form,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (nombre != null && telefono != null)
              QrImage(
                data:
                    'nombre: ${nombre!.trim()}, telefono: ${telefono!.trim()}',
                size: 250,
              ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * .8,
              child: Column(
                children: [
                  ReactiveTextField<String>(
                    formControlName: 'nombre',
                    validationMessages: {
                      ValidationMessage.required: (error) =>
                          'Este campo es requerido',
                      ValidationMessage.pattern: (errror) =>
                          'Solo se permiten letras, comas y espacios',
                    },
                    decoration: const InputDecoration(
                      hintText: 'Ingresa su nombre completo',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ReactiveTextField<String>(
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
                    decoration: const InputDecoration(
                      hintText: 'Ingresa su número de telefono',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  CustomButton(
                      text: 'DESCARGAR QR',
                      onPressed: exportPng,
                      icon: Icons.download),
                  const SizedBox(height: 15),
                  CustomButton(
                      text: 'ESCANEAR QR',
                      // Dentro del widget `FirstRoute`
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const QRScanWiew()),
                        );
                      },
                      icon: Icons.qr_code)
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
            )
          ],
        ),
      ),
    );
  }

  Future<void> exportPng() async {
    // validar el formulario antes de continuar
    if (form.invalid) {
      form.markAllAsTouched();
      return;
    }
    // obtener los valores del formulario
    nombre = form.control('nombre').value!;
    telefono = form.control('telefono').value!;

    final image = im.Image(250, 250);
    im.fill(image, im.getColor(255, 255, 255));
    drawBarcode(image, Barcode.qrCode(),
        'nombre: ${nombre!.trim()}, telefono: ${telefono!.trim()}',
        font: im.arial_48);
    final data = im.encodePng(image);
    if (kIsWeb) {
      final fileName = '$nombre.png';
      final path = await getSavePath(suggestedName: fileName);
      if (path != null) {
        final file = XFile.fromData(
          Uint8List.fromList(data),
          name: fileName,
          mimeType: 'image/png',
        );
        await file.saveTo(path);
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
