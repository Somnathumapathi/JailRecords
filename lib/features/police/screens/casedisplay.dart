import 'package:flutter/material.dart';
import 'package:jailerecord/features/police/services/policeservices.dart';
import 'package:jailerecord/models/case.dart';
import 'package:url_launcher/url_launcher.dart';

class CaseDetailsPage extends StatefulWidget {
  // final Map<String, dynamic> caseData;
  final Case caseData;

  CaseDetailsPage({required this.caseData});

  @override
  State<CaseDetailsPage> createState() => _CaseDetailsPageState();
}

class _CaseDetailsPageState extends State<CaseDetailsPage> {
  bool isImprisoned = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Case Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Case ${widget.caseData.caseId} Details',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.edit_note_outlined),
                      label: Text('Edit case'))
                ],
              ),
              const SizedBox(height: 20),
              _buildDetailRow('Prisoner Name', widget.caseData.prisoner.name),
              _buildDetailRow(
                  'Prisoner Status',
                  widget.caseData.prisoner.status == false
                      ? 'Released'
                      : 'Imprisoned'),
              _buildDetailRow('Court Name', widget.caseData.court.name),
              _buildDetailRow('Court Location', widget.caseData.court.location),
              _buildDetailRow('Police Name', widget.caseData.police.name),
              _buildDetailRow('Police Badge', widget.caseData.police.badge),
              _buildDetailRow(
                  'Lawyer Name', widget.caseData.lawyer?.name ?? '--'),
              _buildDetailRow(
                  'Lawyer Contact', widget.caseData.lawyer?.contact ?? '--'),
              _buildDetailRow(
                  'Lawyer Email', widget.caseData.lawyer?.emailId ?? '--'),
              Text(
                'Documents:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.caseData.documents?.length ?? 0,
                  itemBuilder: (context, index) {
                    final link = widget.caseData.documents![index];
                    return GestureDetector(
                      onTap: () async {
                        print(Uri.parse(link));

                        await launchUrl(Uri.parse(link),
                            mode: LaunchMode.externalApplication);
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        // color: const Color.fromARGB(255, 213, 211, 211),
                        child: Text(
                          link,
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    );
                  }),
              Divider(),
              ElevatedButton(
                  onPressed: () async {
// showDialog(context: context, builder: builder)
                    await showDialog(
                      context: context,
                      builder: (context) =>
                          AlertDialog(title: Text('Prisoner status'), actions: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                isImprisoned = false;
                              });
                              Navigator.pop(context);
                            },
                            child: Text('Free')),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                isImprisoned = true;
                              });
                              Navigator.pop(context);
                            },
                            child: Text('Imprisoned'))
                      ]),
                    );
                    PoliceServices.closeCase(
                        context: context,
                        caseId: widget.caseData.caseId!,
                        isImprisoned: isImprisoned);
                  },
                  child: Text('Close Case'))
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
            backgroundColor: Colors.black,
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
