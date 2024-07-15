import 'package:flutter/material.dart';
import 'package:jailerecord/features/auth/services/auth_service.dart';
import 'package:jailerecord/features/police/screens/addcase.dart';
import 'package:jailerecord/features/police/screens/casedisplay.dart';
import 'package:jailerecord/features/police/services/policeservices.dart';

import '../../../models/case.dart';

class PoliceHome extends StatefulWidget {
  const PoliceHome({super.key});

  @override
  State<PoliceHome> createState() => _PoliceHomeState();
}

class _PoliceHomeState extends State<PoliceHome> {

  
  @override
  void initState() {
    getAllCases();
    super.initState();
  }

  List<Case>? allCases;
getAllCases()async {
  allCases = await PoliceServices.getAllCases(context: context);
  setState(() {
    
  });
}
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
        title: const Text('Cases', style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1))),
        backgroundColor: Color.fromARGB(255, 83, 135, 232),
        actions: [TextButton.icon(onPressed: () {
          AuthService.signOut(context: context);
        }, label: Text('Sign Out'), icon: Icon(Icons.exit_to_app),)]
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
      floatingActionButton: Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.only(bottom: 30.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> AddForm()));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 83, 135, 232),
            padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 16),
          ),
          child: const Text(
            'Add Case',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

