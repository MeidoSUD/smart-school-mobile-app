import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../l10n/app_localizations.dart';

class LmsAdmissionScreen extends ConsumerStatefulWidget {
  const LmsAdmissionScreen({super.key});

  @override
  ConsumerState<LmsAdmissionScreen> createState() => _LmsAdmissionScreenState();
}

class _LmsAdmissionScreenState extends ConsumerState<LmsAdmissionScreen> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  // Controllers for Student Info
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dobController = TextEditingController();
  // String? _gender;

  // Controllers for Parent Info
  final _fatherNameController = TextEditingController();
  final _fatherPhoneController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    _fatherNameController.dispose();
    _fatherPhoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.applyAdmission),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < 2) {
            setState(() => _currentStep += 1);
          } else {
            // Submit logical
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Admission application submitted!')),
            );
            Navigator.pop(context);
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep -= 1);
          } else {
            Navigator.pop(context);
          }
        },
        steps: [
          Step(
            title: const Text('Student Information'),
            isActive: _currentStep >= 0,
            content: Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(labelText: 'First Name *'),
                  ),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(labelText: 'Last Name'),
                  ),
                  const SizedBox(height: 16),
                  const Text('Select Date of Birth and Gender below...'),
                ],
              ),
            ),
          ),
          Step(
            title: const Text('Parent/Guardian Information'),
            isActive: _currentStep >= 1,
            content: Column(
              children: [
                TextFormField(
                  controller: _fatherNameController,
                  decoration: const InputDecoration(labelText: "Father's Name"),
                ),
                TextFormField(
                  controller: _fatherPhoneController,
                  decoration: const InputDecoration(labelText: "Father's Phone"),
                ),
              ],
            ),
          ),
          Step(
            title: const Text('Contact & Confirmation'),
            isActive: _currentStep >= 2,
            content: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email Address *'),
                ),
                const SizedBox(height: 16),
                const Text('By submitting, you agree to the terms and conditions.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
