import 'package:flutter/material.dart';

class AddForm extends StatefulWidget {
  const AddForm({super.key});

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _prisonerIdController = TextEditingController();
  final TextEditingController _courtIdController = TextEditingController();
  final TextEditingController _lawyerIdController = TextEditingController();
  final TextEditingController _documentsController = TextEditingController();
  final TextEditingController _policeIdController = TextEditingController();

  @override
  void dispose() {
    _prisonerIdController.dispose();
    _courtIdController.dispose();
    _lawyerIdController.dispose();
    _documentsController.dispose();
    _policeIdController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Handle form submission
      final formData = {
        'prisoner_id': _prisonerIdController.text,
        'court_id': _courtIdController.text,
        'lawyer_id': _lawyerIdController.text,
        'documents': _documentsController.text,
        'police_id': _policeIdController.text,
      };
      print(formData);
      // You can add your own functionality to handle form submission
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Case Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _prisonerIdController,
                decoration: const InputDecoration(labelText: 'Prisoner ID'),
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
                decoration: const InputDecoration(labelText: 'Court ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a court ID';
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
              TextFormField(
                controller: _policeIdController,
                decoration: const InputDecoration(labelText: 'Police ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a police ID';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
