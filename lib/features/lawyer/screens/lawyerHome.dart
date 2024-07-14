import 'package:flutter/material.dart';
import 'package:jailerecord/features/police/screens/casedisplay.dart';

class LawyerHome extends StatefulWidget {
  const LawyerHome({super.key});

  @override
  State<LawyerHome> createState() => _LawyerHomeState();
}

class _LawyerHomeState extends State<LawyerHome> {
  final Map<String, dynamic> _jsonData = {
    "msg": "Successful",
    "data": [
      {
        "documents": "gmeet",
        "Prisoners": {"name": "something", "status": true},
        "Court": {
          "id": 3,
          "name": "Karnataka High Court",
          "location": "Bangalore"
        },
        "Police": {"id": 1, "uid": "ok123", "name": "sampee", "badge": "seri"},
        "Lawyer": {
          "id": 1,
          "uid": "ramesh_naidu",
          "name": "Koushik",
          "contact": "ulalaulala",
          "email_id": "ninajjigandusuleghuttdulemunde"
        }
      },
      {
        "documents": "mallika.s",
        "Prisoners": {"name": "Suman Prasad", "status": true},
        "Court": {"id": 2, "name": "Bombay High Court", "location": "Mumbai"},
        "Police": {"id": 1, "uid": "ok123", "name": "sampee", "badge": "seri"},
        "Lawyer": {
          "id": 1,
          "uid": "ramesh_naidu",
          "name": "Koushik",
          "contact": "ulalaulala",
          "email_id": "ninajjigandusuleghuttdulemunde"
        }
      },
      {
        "documents": "mallika.s",
        "Prisoners": {"name": "Suman Prasad", "status": true},
        "Court": {"id": 2, "name": "Bombay High Court", "location": "Mumbai"},
        "Police": {"id": 1, "uid": "ok123", "name": "sampee", "badge": "seri"},
        "Lawyer": {
          "id": 1,
          "uid": "ramesh_naidu",
          "name": "Koushik",
          "contact": "ulalaulala",
          "email_id": "ninajjigandusuleghuttdulemunde"
        }
      },
      {
        "documents": "mallika.s",
        "Prisoners": {"name": "Suman Prasad", "status": true},
        "Court": {"id": 2, "name": "Bombay High Court", "location": "Mumbai"},
        "Police": {"id": 1, "uid": "ok123", "name": "sampee", "badge": "seri"},
        "Lawyer": {
          "id": 1,
          "uid": "ramesh_naidu",
          "name": "Koushik",
          "contact": "ulalaulala",
          "email_id": "ninajjigandusuleghuttdulemunde"
        }
      }
    ]
  };

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> cases =
        List<Map<String, dynamic>>.from(_jsonData['data']);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cases', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 83, 135, 232),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: cases.length,
          itemBuilder: (context, index) {
            var caseData = cases[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 1.0),
                borderRadius: BorderRadius.circular(6.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text(
                  'Case ${index + 1}: ${caseData['Prisoners']['name']}',
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                ),
                trailing: const Icon(Icons.arrow_forward, color: Colors.black),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CaseDetailsPage(
                          caseData: caseData, caseIndex: index + 1),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

