import 'package:flutter/material.dart';
import 'package:medical_piece/core/constants/app_constants.dart';

class UrlInputBottomSheet extends StatefulWidget {
  const UrlInputBottomSheet({super.key});

  @override
  State<UrlInputBottomSheet> createState() => _UrlInputBottomSheetState();
}

class _UrlInputBottomSheetState extends State<UrlInputBottomSheet> {
  final TextEditingController _urlController = TextEditingController();

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  void _saveUrl() {
    setState(() {
      apiUrl = _urlController.text.trim();
    });
    print('apiUrl');
    print(apiUrl);
    if (apiUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid URL')),
      );
      Navigator.of(context).pop(); // close the bottom sheet
      return;
    }

    // TODO: Save the URL (e.g., send to Firestore, local state, etc.)
    print('URL saved: $apiUrl');
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text('URL saved: $apiUrl')),
    );
    Navigator.of(context).pop(); // close the bottom sheet
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        left: 16,
        right: 16,
        top: 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Enter URL', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          TextField(
            controller: _urlController,
            decoration: const InputDecoration(
              hintText: 'https://example.com',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.url,
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: _saveUrl,
            icon: const Icon(Icons.save),
            label: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
