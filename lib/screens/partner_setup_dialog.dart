import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../theme/hand_drawn_tokens.dart';
import '../widgets/hand_drawn_card.dart';
import '../widgets/hand_drawn_button.dart';

class PartnerSetupDialog extends StatefulWidget {
  final UserProfile? initialPartner;
  final Function(UserProfile) onSave;
  final VoidCallback? onClear;

  const PartnerSetupDialog({
    super.key,
    this.initialPartner,
    required this.onSave,
    this.onClear,
  });

  @override
  State<PartnerSetupDialog> createState() => _PartnerSetupDialogState();
}

class _PartnerSetupDialogState extends State<PartnerSetupDialog> {
  late TextEditingController _nameController;
  late TextEditingController _cityController;
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  late BloodType _selectedBloodType;

  @override
  void initState() {
    super.initState();
    final p = widget.initialPartner ??
        UserProfile(
          name: 'Partner',
          birthDate: DateTime(2000, 1, 1),
          birthTime: const TimeOfDay(hour: 12, minute: 0),
          bloodType: BloodType.a,
          cityName: 'Kyoto, Japan',
        );

    _nameController = TextEditingController(text: p.name);
    _cityController = TextEditingController(text: p.cityName);
    _selectedDate = p.birthDate;
    _selectedTime = p.birthTime;
    _selectedBloodType = p.bloodType;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: HandDrawnTokens.markerRed,
              onPrimary: HandDrawnTokens.warmPaper,
              surface: HandDrawnTokens.warmPaper,
              onSurface: HandDrawnTokens.pencilBlack,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: HandDrawnTokens.markerRed,
              onPrimary: HandDrawnTokens.warmPaper,
              surface: HandDrawnTokens.warmPaper,
              onSurface: HandDrawnTokens.pencilBlack,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }

  void _submit() {
    final name = _nameController.text.trim().isEmpty ? 'Partner' : _nameController.text.trim();
    final city = _cityController.text.trim().isEmpty ? 'Kyoto, Japan' : _cityController.text.trim();

    final partner = UserProfile(
      name: name,
      birthDate: _selectedDate,
      birthTime: _selectedTime,
      bloodType: _selectedBloodType,
      cityName: city,
    );

    widget.onSave(partner);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: HandDrawnCard(
            decoration: HandDrawnCardDecoration.tape,
            backgroundColor: HandDrawnTokens.cardWhite,
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: HandDrawnTokens.postItYellow,
                          border: Border.all(color: HandDrawnTokens.pencilBlack, width: 2),
                          boxShadow: HandDrawnTokens.hardShadowSm,
                        ),
                        child: Icon(Icons.favorite, color: HandDrawnTokens.markerRed, size: 22),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.initialPartner != null ? 'Edit Partner Profile' : 'Add Partner Details',
                              style: HandDrawnTokens.headingFont(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: HandDrawnTokens.pencilBlack,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Calculate multi-cultural synastry and relationship harmony across 5 ancient traditions.',
                              style: HandDrawnTokens.bodyFont(fontSize: 13, color: HandDrawnTokens.erasedPencil),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(Icons.close, color: HandDrawnTokens.pencilBlack, size: 22),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Partner Name
                  Text(
                    'PARTNER\'S NAME',
                    style: HandDrawnTokens.headingFont(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: HandDrawnTokens.markerRed,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _nameController,
                    style: HandDrawnTokens.bodyFont(color: HandDrawnTokens.pencilBlack, fontSize: 15),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HandDrawnTokens.warmPaper,
                      hintText: 'e.g., Alex or Partner',
                      hintStyle: HandDrawnTokens.bodyFont(color: HandDrawnTokens.erasedPencil),
                      prefixIcon: Icon(Icons.person_outline, color: HandDrawnTokens.pencilBlack, size: 20),
                      border: OutlineInputBorder(
                        borderRadius: HandDrawnTokens.wobblySm,
                        borderSide: BorderSide(color: HandDrawnTokens.pencilBlack, width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: HandDrawnTokens.wobblySm,
                        borderSide: BorderSide(color: HandDrawnTokens.pencilBlack, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: HandDrawnTokens.wobblySm,
                        borderSide: BorderSide(color: HandDrawnTokens.markerRed, width: 2),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Birth Date & Time
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'BIRTH DATE',
                              style: HandDrawnTokens.headingFont(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: HandDrawnTokens.markerRed,
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(height: 6),
                            InkWell(
                              onTap: _pickDate,
                              borderRadius: HandDrawnTokens.wobblySm,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                decoration: BoxDecoration(
                                  color: HandDrawnTokens.warmPaper,
                                  borderRadius: HandDrawnTokens.wobblySm,
                                  border: Border.all(color: HandDrawnTokens.pencilBlack, width: 1.5),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.calendar_today, color: HandDrawnTokens.markerRed, size: 18),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        '${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}',
                                        style: HandDrawnTokens.bodyFont(color: HandDrawnTokens.pencilBlack, fontSize: 13.5, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'BIRTH TIME',
                              style: HandDrawnTokens.headingFont(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: HandDrawnTokens.ballpointBlue,
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(height: 6),
                            InkWell(
                              onTap: _pickTime,
                              borderRadius: HandDrawnTokens.wobblySm,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                decoration: BoxDecoration(
                                  color: HandDrawnTokens.warmPaper,
                                  borderRadius: HandDrawnTokens.wobblySm,
                                  border: Border.all(color: HandDrawnTokens.pencilBlack, width: 1.5),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.access_time, color: HandDrawnTokens.ballpointBlue, size: 18),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}',
                                        style: HandDrawnTokens.bodyFont(color: HandDrawnTokens.pencilBlack, fontSize: 13.5, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Blood Type
                  Text(
                    'BLOOD TYPE (JAPANESE KETSUEKIGATA)',
                    style: HandDrawnTokens.headingFont(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: HandDrawnTokens.markerRed,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: BloodType.values.map((bt) {
                      final isSelected = _selectedBloodType == bt;
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: InkWell(
                            onTap: () => setState(() => _selectedBloodType = bt),
                            borderRadius: HandDrawnTokens.wobblySm,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: isSelected ? HandDrawnTokens.postItYellow : HandDrawnTokens.warmPaper,
                                borderRadius: HandDrawnTokens.wobblySm,
                                border: Border.all(
                                  color: HandDrawnTokens.pencilBlack,
                                  width: isSelected ? 2.2 : 1.5,
                                ),
                                boxShadow: isSelected ? HandDrawnTokens.hardShadowSm : [],
                              ),
                              child: Center(
                                child: Text(
                                  bt.shortName,
                                  style: HandDrawnTokens.headingFont(
                                    fontSize: 14,
                                    fontWeight: isSelected ? FontWeight.w900 : FontWeight.normal,
                                    color: HandDrawnTokens.pencilBlack,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),

                  // City Name
                  Text(
                    'BIRTH CITY & REGION',
                    style: HandDrawnTokens.headingFont(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: HandDrawnTokens.markerRed,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _cityController,
                    style: HandDrawnTokens.bodyFont(color: HandDrawnTokens.pencilBlack, fontSize: 15),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HandDrawnTokens.warmPaper,
                      hintText: 'e.g., Kyoto, Japan or New York, USA',
                      hintStyle: HandDrawnTokens.bodyFont(color: HandDrawnTokens.erasedPencil),
                      prefixIcon: Icon(Icons.location_city, color: HandDrawnTokens.pencilBlack, size: 20),
                      border: OutlineInputBorder(
                        borderRadius: HandDrawnTokens.wobblySm,
                        borderSide: BorderSide(color: HandDrawnTokens.pencilBlack, width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: HandDrawnTokens.wobblySm,
                        borderSide: BorderSide(color: HandDrawnTokens.pencilBlack, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: HandDrawnTokens.wobblySm,
                        borderSide: BorderSide(color: HandDrawnTokens.markerRed, width: 2),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Action Buttons
                  Row(
                    children: [
                      if (widget.initialPartner != null && widget.onClear != null) ...[
                        IconButton(
                          tooltip: 'Remove Partner Profile',
                          onPressed: () {
                            widget.onClear!();
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Expanded(
                        child: HandDrawnButton(
                          text: 'Cancel',
                          variant: HandDrawnButtonVariant.secondary,
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: HandDrawnButton(
                          text: 'Calculate Synergy',
                          icon: Icons.favorite,
                          variant: HandDrawnButtonVariant.primary,
                          onPressed: _submit,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
