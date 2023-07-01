import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class VendorController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Salvar imagem no firebase
  _uploadVendorImage(Uint8List? image) async {
    Reference ref =
        _storage.ref().child('storeImage').child(_auth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(image!);

    TaskSnapshot snapshot = await uploadTask;

    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  pickStoreImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();

    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      print('Nenhuma Imagem Selecionada');
    }
  }

  Future<String> registerVendor(
    String businessName,
    String cpfCnpj,
    String email,
    String phone,
    String countryValue,
    String stateValue,
    String cityValue,
    String cep,
    String address,
    String ville,
    Uint8List? image,
  ) async {
    String res = 'Algo Deu Errado';

    try {
      String storeImage = await _uploadVendorImage(image);
      //Salvar dados no cloudfirestore

      await _firestore.collection('vendors').doc(_auth.currentUser!.uid).set({
        'businessName': businessName,
        'cpfCnpj': cpfCnpj,
        'email': email,
        'phone': phone,
        'countryValue': countryValue,
        'stateValue': stateValue,
        'cityValue': cityValue,
        'cep': cep,
        'address': address,
        'ville': ville,
        'storeImage': storeImage,
        'approved': false,
        'vendorId': _auth.currentUser!.uid,
      });

      ;
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
