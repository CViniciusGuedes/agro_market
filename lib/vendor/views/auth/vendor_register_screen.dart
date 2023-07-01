import 'dart:typed_data';

import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'controllers/vendor_registrer_controller.dart';

class VendorRegistrationScreen extends StatefulWidget {
  @override
  State<VendorRegistrationScreen> createState() =>
      _VendorRegistrationScreenState();
}

class _VendorRegistrationScreenState extends State<VendorRegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final VendorController _vendorController = VendorController();

  late String businessName;
  late String cpfCnpj;
  late String email;
  late String phone;
  late String cep;
  late String address;
  late String ville;

  late String countryValue;
  late String stateValue;
  late String cityValue;

  Uint8List? _image;

  selectGalleryImage() async {
    Uint8List im = await _vendorController.pickStoreImage(ImageSource.gallery);

    setState(() {
      _image = im;
    });
  }

  selectCameraImage() async {
    Uint8List im = await _vendorController.pickStoreImage(ImageSource.camera);

    setState(() {
      _image = im;
    });
  }

  _saveVendorDetail() async {
    EasyLoading.show(status: 'Aguarde');
    if (_formKey.currentState!.validate()) {
      await _vendorController
          .registerVendor(businessName, cpfCnpj, email, phone, countryValue,
              stateValue, cityValue, cep, address, ville, _image)
          .whenComplete(() {
        EasyLoading.dismiss();
      });
    } else {
      print('Algo deu Errado');
      EasyLoading.dismiss();
      //_resetFormFields();

      /*setState(() {
        _formKey.currentState!.reset();
        _image = null;
      });*/
    }
  }

  void _resetFormFields() {
    setState(() {
      _formKey.currentState!.reset();
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 200,
            flexibleSpace: LayoutBuilder(builder: (context, constraints) {
              return FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.green,
                        Colors.green.shade900,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: _image != null
                              ? Image.memory(_image!)
                              : IconButton(
                                  onPressed: () {
                                    selectGalleryImage();
                                  },
                                  icon: Icon(CupertinoIcons.photo)),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        businessName = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por Favor, Insira o Nome do Seu Negócio';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Nome do Negócio',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      onChanged: (value) {
                        cpfCnpj = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por Favor, Insira um CPF ou CNPJ';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'CPF/CNPJ',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por Favor, Insira um Endereço de E-mail';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      onChanged: (value) {
                        phone = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por Favor, Insira um Número de Celular ou Telefone';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Celular/Telefone',
                      ),
                    ),
                    SizedBox(height: 10),
                    SelectState(
                      onCountryChanged: (value) {
                        setState(() {
                          countryValue = value;
                        });
                      },
                      onStateChanged: (value) {
                        setState(() {
                          stateValue = value;
                        });
                      },
                      onCityChanged: (value) {
                        setState(
                          () {
                            cityValue = value;
                          },
                        );
                      },
                    ),
                    TextFormField(
                      onChanged: (value) {
                        cep = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por Favor, Insira um CEP';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'CEP',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      onChanged: (value) {
                        address = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por Favor, Insira um Endereço';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Endereço',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      onChanged: (value) {
                        ville = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por Favor, Insira um Bairro';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Bairro',
                      ),
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        _saveVendorDetail();
                        _resetFormFields();
                      },
                      child: Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width - 40,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Salvar',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
