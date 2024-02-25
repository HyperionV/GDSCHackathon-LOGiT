// ignore_for_file: prefer_const_constructors

import 'package:logit/body_part_selector/body_part_selector_ex.dart';
import 'package:flutter/material.dart';
import 'package:logit/model/medical_record.dart';

class ReportSymptomScreen extends StatefulWidget {
  final MedicalRecordData medicalRecord;
  final void Function(String, String) updateSymptom;
  final String Function(String) getBodyPartSymptom;
  const ReportSymptomScreen(
      this.medicalRecord, this.updateSymptom, this.getBodyPartSymptom,
      {super.key});

  @override
  State<ReportSymptomScreen> createState() => _ReportSymptomScreen();
}

class _ReportSymptomScreen extends State<ReportSymptomScreen> {
  BodyParts _bodyParts = const BodyParts();
  late TextEditingController controller;

  void collectContent(String bodyPart, String content) {
    widget.updateSymptom(bodyPart, content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chọn trên cơ thể'),
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Text(
                'Xong',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: BodyPartSelectorTurnable(
          getContent: widget.updateSymptom,
          bodyParts: _bodyParts,
          getBodyPartSymptom: widget.getBodyPartSymptom,
          onSelectionUpdated: (p) => setState(() => _bodyParts = p),
          labelData: const RotationStageLabelData(
            front: 'Trước',
            left: 'Trái',
            right: 'Phải',
            back: 'Sau',
          ),
        ),
      ),
    );
  }
}
