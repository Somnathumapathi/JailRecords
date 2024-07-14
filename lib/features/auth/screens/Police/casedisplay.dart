import 'package:flutter/material.dart';

class CaseDetailsPage extends StatelessWidget {
  final Map<String, dynamic> caseData;
  final int caseIndex;

  CaseDetailsPage({required this.caseData, required this.caseIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Case Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Case $caseIndex Details',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text('Prisoner Name: ${caseData['Prisoners']['name']}'),
            Text('Prisoner Status: ${caseData['Prisoners']['status']}'),
            Text('Court Name: ${caseData['Court']['name']}'),
            Text('Court Location: ${caseData['Court']['location']}'),
            Text('Police Name: ${caseData['Police']['name']}'),
            Text('Police Badge: ${caseData['Police']['badge']}'),
            Text('Lawyer Name: ${caseData['Lawyer']['name']}'),
            Text('Lawyer Contact: ${caseData['Lawyer']['contact']}'),
            Text('Lawyer Email: ${caseData['Lawyer']['email_id']}'),
            Text('Documents: ${caseData['documents']}'),
          ],
        ),
      ),
    );
  }
}
