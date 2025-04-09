import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({super.key, required this.phoneNumber});

  final String phoneNumber;

  String normalizePhoneNumber(String number) {
    return number.replaceAll(RegExp(r'\D'), '');
  }

  Future<void> requestPermissions() async {
    final status = await Permission.contacts.request();
    if (!status.isGranted) {
      throw Exception('Contacts permission denied');
    }
  }

  Future<Contact?> fetchContact(String phoneNumber) async {
    try {
      await requestPermissions();
      final normalizedPhoneNumber = normalizePhoneNumber(phoneNumber);
      final contacts = await ContactsService.getContacts();

      return contacts.firstWhere(
            (contact) => contact.phones?.any(
              (phone) => normalizePhoneNumber(phone.value ?? '') == normalizedPhoneNumber,
        ) ?? false,
        orElse: () => Contact(displayName: 'Unknown', phones: [Item(value: phoneNumber)]),
      );
    } catch (e) {
      log("Error fetching contact: $e");
      return null;
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    try {
      final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
      } else {
        log('Cannot launch $phoneNumber');
      }
    } catch (e) {
      log('Error while attempting to make a phone call: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Contact?>(
      future: fetchContact(phoneNumber),
      builder: (context, snapshot) {
        if (snapshot.hasError || snapshot.data == null) {
          return _buildInfoCard(
            context,
            title: 'Error',
            subtitle: snapshot.hasError ? 'Could not fetch contact.' : 'Contact not found.',
            icon: Icons.error,
          );
        }

        final contact = snapshot.data!;
        return _buildContactCard(context, contact);
      },
    );
  }

  Widget _buildContactCard(BuildContext context, Contact contact) {
    return Container(
      margin: const EdgeInsets.only(right: 16, left: 16, top: 56),
      decoration: BoxDecoration(
        color: Theme.of(context).appColors.white87,
        border: Border.all(color: Theme.of(context).appColors.secondary),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: contact.avatar != null && contact.avatar!.isNotEmpty
                ? Image.memory(
              contact.avatar!,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            )
                : CircleAvatar(
              backgroundColor: Theme.of(context).appColors.black16,
              child: Icon(Icons.person, color: Theme.of(context).appColors.white87),
            ),
          ),
          title: Text(
            contact.displayName ?? 'Unknown',
            style: Theme.of(context).appTexts.bodyMedium
                .copyWith(color: Theme.of(context).appColors.black87),),
          subtitle: Text(
            contact.phones?.firstWhere(
                  (phone) => normalizePhoneNumber(phone.value ?? '') == normalizePhoneNumber(phoneNumber),
              orElse: () => Item(value: phoneNumber),
            ).value ??
                phoneNumber,
            style: Theme.of(context).appTexts.bodySmall
                .copyWith(color: Theme.of(context).appColors.black60),
          ),
          trailing: IconButton(
            icon: Icon(Icons.call, color: Theme.of(context).appColors.primary,),
            onPressed: () {
              final contactPhoneNumber = contact.phones?.firstWhere(
                    (phone) => normalizePhoneNumber(phone.value ?? '') == normalizePhoneNumber(phoneNumber),
                orElse: () => Item(value: phoneNumber),
              ).value ?? phoneNumber;

              _makePhoneCall(contactPhoneNumber);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, {required String title, required String subtitle, required IconData icon}) {
    return Card(
      margin: const EdgeInsets.only(right: 16, left: 16, top: 56),
      color: Theme.of(context).appColors.white16,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).appColors.white60,
          child: Icon(icon, color: Theme.of(context).appColors.white87),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}