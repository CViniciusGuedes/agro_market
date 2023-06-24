import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUsers(
    String email,
    String fullName,
    String phoneNumber,
    String password,
  ) async {
    String res = 'Algo deu errado';

    try {
      if (email.isNotEmpty &&
          fullName.isNotEmpty &&
          phoneNumber.isNotEmpty &&
          password.isNotEmpty) {
        //Criar conta
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        await _firestore.collection('buyers').doc(cred.user!.uid).set({
          'email': email,
          'fullName': fullName,
          'phoneNumber': phoneNumber,
          'buyerId': cred.user!.uid,
          'address': '',
        });

        res = 'success';
      } else {
        res = 'Os campos não podem estar vazios';
      }
    } catch (e) {}
    return res;
  }
}
