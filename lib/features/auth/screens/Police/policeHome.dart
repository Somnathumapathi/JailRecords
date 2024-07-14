import 'package:flutter/material.dart';
import 'package:jailerecord/features/auth/screens/Police/casedisplay.dart';

class PoliceHome extends StatefulWidget {
  const PoliceHome({super.key});

  @override
  State<PoliceHome> createState() => _PoliceHomeState();
}

class _PoliceHomeState extends State<PoliceHome> {
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
        title: const Text('Cases'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: cases.length,
          itemBuilder: (context, index) {
            var caseData = cases[index];
            return ListTile(
              title:
                  Text('Case ${index + 1}: ${caseData['Prisoners']['name']}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CaseDetailsPage(
                        caseData: caseData, caseIndex: index + 1),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // This is the add New case button
        },
        tooltip: 'Add new case',
        child: const Icon(Icons.add),
      ),
    );
  }
}
