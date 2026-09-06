import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../theme/hand_drawn_tokens.dart';
import '../widgets/hand_drawn_card.dart';
import '../widgets/hand_drawn_button.dart';

class ProfileSetupDialog extends StatefulWidget {
  final UserProfile? initialProfile;
  final Function(UserProfile) onSave;
  final bool isFirstTime;

  const ProfileSetupDialog({
    super.key,
    this.initialProfile,
    required this.onSave,
    this.isFirstTime = false,
  });

  @override
  State<ProfileSetupDialog> createState() => _ProfileSetupDialogState();
}

class _ProfileSetupDialogState extends State<ProfileSetupDialog> {
  late TextEditingController _nameController;
  late TextEditingController _cityController;
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  late BloodType _selectedBloodType;

  @override
  void initState() {
    super.initState();
    final profile = widget.initialProfile ??
        UserProfile(
          name: 'Cosmic Seeker',
          birthDate: DateTime(2000, 1, 1),
          birthTime: const TimeOfDay(hour: 12, minute: 0),
          bloodType: BloodType.o,
          cityName: 'Tokyo, Japan',
        );

    _nameController = TextEditingController(text: profile.name);
    _cityController = TextEditingController(text: profile.cityName);
    _selectedDate = profile.birthDate;
    _selectedTime = profile.birthTime;
    _selectedBloodType = profile.bloodType;
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
    final name = _nameController.text.trim().isEmpty ? 'Cosmic Seeker' : _nameController.text.trim();
    final city = _cityController.text.trim().isEmpty ? 'Tokyo, Japan' : _cityController.text.trim();

    final profile = UserProfile(
      name: name,
      birthDate: _selectedDate,
      birthTime: _selectedTime,
      bloodType: _selectedBloodType,
      cityName: city,
    );

    widget.onSave(profile);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
                        color: HandDrawnTokens.postItYellow,
                        shape: BoxShape.circle,
                        border: Border.all(color: HandDrawnTokens.pencilBlack, width: 2),
                        boxShadow: HandDrawnTokens.hardShadowSm,
                      ),
                      child: Icon(Icons.auto_awesome, color: HandDrawnTokens.markerRed, size: 22),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.isFirstTime ? 'Welcome to Your Cosmic Field Guide' : 'Edit Your Birth Profile',
                            style: HandDrawnTokens.headingFont(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: HandDrawnTokens.pencilBlack,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.isFirstTime
                                ? 'Add your birth details once to compute your charts across 11 world cultures.'
                                : 'Update your birth information anytime to recalculate your horoscopes.',
                            style: HandDrawnTokens.bodyFont(fontSize: 13, color: HandDrawnTokens.erasedPencil),
                          ),
                        ],
                      ),
                    ),
                    if (!widget.isFirstTime)
                      IconButton(
                        icon: Icon(Icons.close_rounded, color: HandDrawnTokens.pencilBlack, size: 22),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                  ],
                ),
                const SizedBox(height: 20),

                // Name Field
                Text(
                  'Your Name or Nickname',
                  style: HandDrawnTokens.headingFont(fontSize: 14, fontWeight: FontWeight.bold, color: HandDrawnTokens.pencilBlack),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: _nameController,
                  style: HandDrawnTokens.bodyFont(color: HandDrawnTokens.pencilBlack, fontSize: 15),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: HandDrawnTokens.warmPaper,
                    hintText: 'e.g. Alex or Seeker',
                    hintStyle: HandDrawnTokens.bodyFont(color: HandDrawnTokens.erasedPencil),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                  ),
                ),
                const SizedBox(height: 16),

                // Date & Time Row
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Birth Date',
                            style: HandDrawnTokens.headingFont(fontSize: 14, fontWeight: FontWeight.bold, color: HandDrawnTokens.pencilBlack),
                          ),
                          const SizedBox(height: 6),
                          InkWell(
                            onTap: _pickDate,
                            borderRadius: HandDrawnTokens.wobblySm,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                              decoration: BoxDecoration(
                                color: HandDrawnTokens.warmPaper,
                                borderRadius: HandDrawnTokens.wobblySm,
                                border: Border.all(color: HandDrawnTokens.pencilBlack, width: 1.5),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_today_rounded, size: 16, color: HandDrawnTokens.markerRed),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      '${_selectedDate.year}/${_selectedDate.month.toString().padLeft(2, '0')}/${_selectedDate.day.toString().padLeft(2, '0')}',
                                      style: HandDrawnTokens.bodyFont(color: HandDrawnTokens.pencilBlack, fontSize: 14, fontWeight: FontWeight.bold),
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
                            'Birth Time',
                            style: HandDrawnTokens.headingFont(fontSize: 14, fontWeight: FontWeight.bold, color: HandDrawnTokens.pencilBlack),
                          ),
                          const SizedBox(height: 6),
                          InkWell(
                            onTap: _pickTime,
                            borderRadius: HandDrawnTokens.wobblySm,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                              decoration: BoxDecoration(
                                color: HandDrawnTokens.warmPaper,
                                borderRadius: HandDrawnTokens.wobblySm,
                                border: Border.all(color: HandDrawnTokens.pencilBlack, width: 1.5),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.access_time_rounded, size: 16, color: HandDrawnTokens.ballpointBlue),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      _selectedTime.format(context),
                                      style: HandDrawnTokens.bodyFont(color: HandDrawnTokens.pencilBlack, fontSize: 14, fontWeight: FontWeight.bold),
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
                const SizedBox(height: 8),
                Text(
                  'Birth time helps calculate your Rising Sign (Ascendant) and Chinese BaZi hour pillar.',
                  style: HandDrawnTokens.bodyFont(fontSize: 12.5, color: HandDrawnTokens.erasedPencil),
                ),
                const SizedBox(height: 16),

                // Japanese Blood Type Selector
                Text(
                  'Blood Type (Japanese Ketsuekigata)',
                  style: HandDrawnTokens.headingFont(fontSize: 14, fontWeight: FontWeight.bold, color: HandDrawnTokens.pencilBlack),
                ),
                const SizedBox(height: 4),
                Text(
                  'Used in Japan for interpersonal compatibility and temperament advice.',
                  style: HandDrawnTokens.bodyFont(fontSize: 12.5, color: HandDrawnTokens.erasedPencil),
                ),
                const SizedBox(height: 8),
                Row(
                  children: BloodType.values.map((type) {
                    final isSelected = _selectedBloodType == type;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: InkWell(
                          onTap: () => setState(() => _selectedBloodType = type),
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
                                'Type ${type.shortName}',
                                style: HandDrawnTokens.headingFont(
                                  fontSize: 13,
                                  fontWeight: isSelected ? FontWeight.w900 : FontWeight.w500,
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

                // City / Birthplace
                Text(
                  'Birth City or Current Location',
                  style: HandDrawnTokens.headingFont(fontSize: 14, fontWeight: FontWeight.bold, color: HandDrawnTokens.pencilBlack),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: _cityController,
                  style: HandDrawnTokens.bodyFont(color: HandDrawnTokens.pencilBlack, fontSize: 15),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: HandDrawnTokens.warmPaper,
                    hintText: 'e.g. Tokyo, Colombo, London, New York',
                    hintStyle: HandDrawnTokens.bodyFont(color: HandDrawnTokens.erasedPencil),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                  ),
                ),
                const SizedBox(height: 24),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  child: HandDrawnButton(
                    text: 'Calculate My Charts & Daily Horoscope',
                    variant: HandDrawnButtonVariant.primary,
                    onPressed: _submit,
                  ),
                ),
                if (widget.isFirstTime) ...[
                  const SizedBox(height: 10),
                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Explore Default Charts First',
                        style: HandDrawnTokens.bodyFont(
                          fontSize: 14,
                          color: HandDrawnTokens.erasedPencil,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
