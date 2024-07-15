import 'package:flutter/material.dart';

class CaseDetailsPage extends StatelessWidget {
  final Map<String, dynamic> caseData;
  final int caseIndex;

  const CaseDetailsPage({required this.caseData, required this.caseIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Case Details', style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromARGB(255, 83, 135, 232),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Case $caseIndex Details',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),
              _buildDetailRow('Prisoner Name', caseData['Prisoners']['name']),
              _buildDetailRow('Prisoner Status', caseData['Prisoners']['status'].toString()),
              _buildDetailRow('Court Name', caseData['Court']['name']),
              _buildDetailRow('Court Location', caseData['Court']['location']),
              _buildDetailRow('Police Name', caseData['Police']['name']),
              _buildDetailRow('Police Badge', caseData['Police']['badge']),
              _buildDetailRow('Lawyer Name', caseData['Lawyer']['name']),
              _buildDetailRow('Lawyer Contact', caseData['Lawyer']['contact']),
              _buildDetailRow('Lawyer Email', caseData['Lawyer']['email_id']),
              _buildDetailRow('Documents', caseData['documents']),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.only(bottom: 30.0),
        child: ElevatedButton(
          onPressed: () {
            // onclick
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 83, 135, 232),
            padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 16),
          ),
          child: const Text(
            'Add Document',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, dynamic value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 17,
            ),
          ),
          Expanded(
            child: Text(
              value.toString(),
              style: const TextStyle(color: Colors.black, fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }
}
