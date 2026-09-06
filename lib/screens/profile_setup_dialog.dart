import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/user_profile.dart';
import '../widgets/glass_card.dart';

class ProfileSetupDialog extends StatefulWidget {
  final UserProfile? initialProfile;
  final Function(UserProfile) onSave;

  const ProfileSetupDialog({
    super.key,
    this.initialProfile,
    required this.onSave,
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
          name: 'Seeker',
          birthDate: DateTime(1995, 6, 15),
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
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF9B51E0),
              onPrimary: Colors.white,
              surface: Color(0xFF1B1B2F),
              onSurface: Colors.white,
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
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF9B51E0),
              onPrimary: Colors.white,
              surface: Color(0xFF1B1B2F),
              onSurface: Colors.white,
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
    final name = _nameController.text.trim().isEmpty ? 'Seeker' : _nameController.text.trim();
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
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: GlassCard(
        backgroundColor: const Color(0xFF111428).withValues(alpha: 0.95),
        borderColor: const Color(0xFF9B51E0).withValues(alpha: 0.4),
        borderRadius: 24,
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
                      gradient: const LinearGradient(
                        colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
                      ),
                    ),
                    child: const Icon(Icons.auto_awesome, color: Colors.white, size: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cosmic Origin Setup',
                          style: GoogleFonts.outfit(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Calculates your chart across 11 global traditions',
                          style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.6)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Name Field
              Text(
                'Full Name / Call Sign',
                style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white70),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _nameController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.08),
                  hintText: 'Enter your name',
                  hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.15)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.15)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Color(0xFF9B51E0), width: 1.5),
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
                          style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white70),
                        ),
                        const SizedBox(height: 6),
                        InkWell(
                          onTap: _pickDate,
                          borderRadius: BorderRadius.circular(14),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_today, size: 16, color: Color(0xFFFFD700)),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    '${_selectedDate.year}/${_selectedDate.month.toString().padLeft(2, '0')}/${_selectedDate.day.toString().padLeft(2, '0')}',
                                    style: const TextStyle(color: Colors.white, fontSize: 13),
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
                          style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white70),
                        ),
                        const SizedBox(height: 6),
                        InkWell(
                          onTap: _pickTime,
                          borderRadius: BorderRadius.circular(14),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.access_time_rounded, size: 16, color: Color(0xFF00E5FF)),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    _selectedTime.format(context),
                                    style: const TextStyle(color: Colors.white, fontSize: 13),
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

              // Japanese Blood Type Selector
              Text(
                'Blood Type (Japanese Ketsuekigata)',
                style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white70),
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
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            gradient: isSelected
                                ? const LinearGradient(
                                    colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
                                  )
                                : null,
                            color: isSelected ? null : Colors.white.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected ? const Color(0xFFFFD700) : Colors.white.withValues(alpha: 0.15),
                              width: isSelected ? 1.5 : 1.0,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Type ${type.shortName}',
                              style: GoogleFonts.outfit(
                                fontSize: 13,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                color: isSelected ? Colors.white : Colors.white70,
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
                'Birthplace City (For Timezone & Rising Sign)',
                style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white70),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _cityController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.08),
                  hintText: 'e.g. Tokyo, Kyoto, London, New York',
                  hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.15)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.15)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Color(0xFF9B51E0), width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF416C), Color(0xFF8A2387), Color(0xFFE94057)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF416C).withValues(alpha: 0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Synthesize My Cosmic Profile',
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
