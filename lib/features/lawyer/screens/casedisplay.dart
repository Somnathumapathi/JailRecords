import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:jailerecord/features/lawyer/services/lawyerSrevices.dart';
import 'package:jailerecord/models/case.dart';
import 'package:jailerecord/provider/laywerProvider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CaseDetailsPage extends StatefulWidget {
  // final Map<String, dynamic> caseData;
  final Case caseData;

  const CaseDetailsPage({required this.caseData});

  @override
  State<CaseDetailsPage> createState() => _CaseDetailsPageState();
}

class _CaseDetailsPageState extends State<CaseDetailsPage> {
  String? _downloadUrl;

  Future<void> _pickAndUploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    File file = File(result.files.single.path!);

    try {
      String fileName = result.files.single.name;
      Reference storageRef =
          FirebaseStorage.instance.ref().child('uploads/$fileName');
      UploadTask uploadTask = storageRef.putFile(file);

      TaskSnapshot snapshot = await uploadTask;

      String downloadUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        _downloadUrl = downloadUrl;
      });

      print('File uploaded successfully: $downloadUrl');
      LawyerServices.addDocument(
          context: context,
          docUrl: _downloadUrl!,
          caseId: widget.caseData.caseId!);
    } catch (e) {
      print('Failed to upload file: $e');
    }
  }

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
              Text(
                'Case ${widget.caseData.caseId} Details',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
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
              // _buildDetailRow('Documents', widget.caseData.documents?[0] ?? []),
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
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.only(bottom: 30.0),
        child: ElevatedButton(
          onPressed: () async {
            widget.caseData.lawyer?.id ==
                    Provider.of<LawyerProvider>(context, listen: false)
                        .laywer
                        .id
                ? await _pickAndUploadFile()
                : LawyerServices.joinCase(
                    context: context,
                    caseId: widget.caseData.caseId!,
                    lawyerId:
                        Provider.of<LawyerProvider>(context, listen: false)
                            .laywer
                            .id);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 16),
          ),
          child: Text(
            widget.caseData.lawyer?.id ==
                    Provider.of<LawyerProvider>(context, listen: false)
                        .laywer
                        .id
                ? 'Add Document'
                : 'Join Case',
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
