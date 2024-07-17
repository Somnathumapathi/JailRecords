import 'package:flutter/material.dart';
import 'package:jailerecord/features/police/services/policeservices.dart';
import 'package:jailerecord/provider/policeProvider.dart';
import 'package:provider/provider.dart';

class AddForm extends StatefulWidget {
  const AddForm({super.key});

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  final TextEditingController _prisonerIdController = TextEditingController();
  final TextEditingController _courtIdController = TextEditingController();
  final TextEditingController _lawyerIdController = TextEditingController();
  final TextEditingController _documentsController = TextEditingController();
  final TextEditingController _prisonerNameController = TextEditingController();
  // final TextEditingController _policeIdController = TextEditingController();

  @override
  void dispose() {
    _prisonerIdController.dispose();
    _courtIdController.dispose();
    _lawyerIdController.dispose();
    _documentsController.dispose();
    // _policeIdController.dispose();
    super.dispose();
  }

  void _createPrisoner() {
    if (_formKey.currentState?.validate() ?? false) {
      PoliceServices.createPrisoner(
          context: context, prisonerName: _prisonerNameController.text);
    }
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Handle form submission
      final formData = {
        'prisoner_id': _prisonerIdController.text,
        'court_id': _courtIdController.text,
        'lawyer_id': _lawyerIdController.text,
        'documents': _documentsController.text,
        // 'police_id': _policeIdController.text,
      };
      // print(formData);
      // You can add your own functionality to handle form submission
      PoliceServices.addCase(
          context: context,
          prisoner_id: int.parse(_prisonerIdController.text),
          court_name: _courtIdController.text,
          police_id: context.read<PoliceProvider>().police.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Case Form'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _prisonerIdController,
                      decoration:
                          const InputDecoration(labelText: 'Prisoner ID'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a prisoner ID';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _courtIdController,
                      decoration:
                          const InputDecoration(labelText: 'Court Name'),
                      // keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a court name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _lawyerIdController,
                      decoration: const InputDecoration(labelText: 'Lawyer ID'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a lawyer ID';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _documentsController,
                      decoration: const InputDecoration(labelText: 'Documents'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter documents';
                        }
                        return null;
                      },
                    ),
                    // TextFormField(
                    //   controller: _policeIdController,
                    //   decoration: const InputDecoration(labelText: 'Police ID'),
                    //   keyboardType: TextInputType.number,
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter a police ID';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Submit'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Form(
                  key: _formKey1,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _prisonerNameController,
                        decoration:
                            const InputDecoration(labelText: 'Prisoner Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Name';
                          }
                          return null;
                        },
                      ),
                      ElevatedButton(
                        onPressed: _createPrisoner,
                        child: const Text('Add Prisoner'),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
