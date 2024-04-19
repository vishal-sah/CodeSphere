import 'package:codesphere/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateHackathonPage extends StatefulWidget {
  const CreateHackathonPage({super.key});

  @override
  State<CreateHackathonPage> createState() => _CreateHackathonPageState();
}

class _CreateHackathonPageState extends State<CreateHackathonPage> {
  final _formKey = GlobalKey<FormState>();

  // Define variables to hold user data
  String? _name;
  String? _collegeName;
  String? _about;
  List<String?> _themes = [];
  List<String?> _prizes = [];
  int? _maxTeamSize;
  int? _minTeamSize;
  String? _linkedinLink;
  String? _instagramLink;
  String? _website;
  String? _email;
  DateTime? _applicationStartDate;
  DateTime? _applicationEndDate;
  DateTime? _startDate;
  DateTime? _endDate;
  DateTime? _midEvaluationDate;
  DateTime? _resultDate;
  List<String?> _partners = [];
  List<List<String?>> _faqs = [];

  Future<void> _selectDate(
    BuildContext context,
    DateTime? initialDate,
    Function(DateTime?) onChanged,
  ) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: initialDate ?? DateTime.now(),
      lastDate: DateTime(2100),
    );

    setState(() {
      onChanged(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
        children: [
          const SizedBox(height: 20.0),
          const Text(
            'Organize Hackathon',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          CustomTextField(
            labelText: 'HACKATHON NAME',
            onChanged: (value) => _name = value,
          ),
          CustomTextField(
            labelText: 'COLLEGE NAME',
            onChanged: (value) => _collegeName = value,
          ),
          CustomTextField(
            labelText: 'ABOUT',
            maxLines: 5,
            onChanged: (value) => _about = value,
          ),
          CustomTextField(
            labelText: 'MIN TEAM SIZE',
            onChanged: (value) => _minTeamSize = int.tryParse(value),
          ),
          CustomTextField(
            labelText: 'MAX TEAM SIZE',
            onChanged: (value) => _maxTeamSize = int.tryParse(value),
          ),
          CustomTextField(
            labelText: 'THEMES (Comma separated)',
            maxLines: 3,
            onChanged: (value) => _themes = value.split(','),
          ),
          CustomTextField(
            labelText: 'LINKEDIN',
            onChanged: (value) => _linkedinLink = value,
          ),
          CustomTextField(
            labelText: 'INSTAGRAM',
            onChanged: (value) => _instagramLink = value,
          ),
          CustomTextField(
            labelText: 'WEBSITE',
            onChanged: (value) => _website = value,
          ),
          CustomTextField(
            labelText: 'EMAIL',
            onChanged: (value) => _email = value,
          ),
          buildDateField(
            'APPLICATION START DATE',
            _applicationStartDate,
            (value) => _applicationStartDate = value,
          ),
          buildDateField(
            'APPLICATION END DATE',
            _applicationEndDate,
            (value) => _applicationEndDate = value,
          ),
          buildDateField(
            'START DATE',
            _startDate,
            (value) => _startDate = value,
          ),
          buildDateField(
            'END DATE',
            _endDate,
            (value) => _endDate = value,
          ),
          buildDateField(
            'MID EVALUATION DATE',
            _midEvaluationDate,
            (value) => _midEvaluationDate = value,
          ),
          buildDateField(
            'RESULT DATE',
            _resultDate,
            (value) => _resultDate = value,
          ),
          CustomTextField(
            labelText: 'PARTNERS (Comma separated)',
            onChanged: (value) => _partners = value.split(','),
          ),
          CustomTextField(
            labelText: 'PRIZES (Comma separated)',
            maxLines: 3,
            onChanged: (value) => _prizes = value.split(','),
          ),
          CustomTextField(
            labelText: 'FAQs (Comma separated) e.g. Q1:A1,Q2:A2',
            maxLines: 3,
            onChanged: (value) {
              final faqs = value.split(',');
              _faqs = faqs.map((faq) => faq.split(':')).toList();
            },
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.25),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Save data to database
                }
              },
              child: const Text('CREATE HACKATHON'),
            ),
          ),
          const SizedBox(height: 40.0),
        ],
      ),
    );
  }

  Widget buildDateField(
    String labelText,
    DateTime? value,
    Function(DateTime?) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: ListTile(
        leading: const Icon(Icons.calendar_today),
        title: Text(labelText),
        subtitle: Text(value != null
            ? DateFormat('dd-MM-yyyy').format(value)
            : 'Select date'),
        onTap: () => _selectDate(context, value, onChanged),
      ),
    );
  }
}

