import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/user_profile.dart';
import '../widgets/glass_card.dart';

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
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFEC4899),
              onPrimary: Colors.white,
              surface: Color(0xFF131A2E),
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
              primary: Color(0xFFEC4899),
              onPrimary: Colors.white,
              surface: Color(0xFF131A2E),
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
          child: GlassCard(
            backgroundColor: const Color(0xFF0F1629).withValues(alpha: 0.96),
            borderColor: const Color(0xFFEC4899).withValues(alpha: 0.4),
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
                            colors: [Color(0xFFEC4899), Color(0xFF8B5CF6)],
                          ),
                        ),
                        child: const Icon(Icons.favorite, color: Colors.white, size: 22),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.initialPartner != null ? 'Edit Partner Profile' : 'Add Partner Details',
                              style: GoogleFonts.outfit(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Calculate multi-cultural synastry and relationship harmony across 5 ancient traditions.',
                              style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.7)),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close, color: Colors.white54, size: 20),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Partner Name
                  Text(
                    'PARTNER\'S NAME',
                    style: GoogleFonts.outfit(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFEC4899),
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _nameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withValues(alpha: 0.06),
                      hintText: 'e.g., Alex or Partner',
                      hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
                      prefixIcon: const Icon(Icons.person_outline, color: Color(0xFFEC4899), size: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.15)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xFFEC4899), width: 1.5),
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
                              style: GoogleFonts.outfit(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFEC4899),
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(height: 6),
                            InkWell(
                              onTap: _pickDate,
                              borderRadius: BorderRadius.circular(14),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.06),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.calendar_today, color: Color(0xFFEC4899), size: 18),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        '${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}',
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
                              'BIRTH TIME',
                              style: GoogleFonts.outfit(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFEC4899),
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(height: 6),
                            InkWell(
                              onTap: _pickTime,
                              borderRadius: BorderRadius.circular(14),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.06),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.access_time, color: Color(0xFFEC4899), size: 18),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}',
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

                  // Blood Type
                  Text(
                    'BLOOD TYPE (JAPANESE KETSUEKIGATA)',
                    style: GoogleFonts.outfit(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFEC4899),
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
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFFEC4899)
                                    : Colors.white.withValues(alpha: 0.06),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected
                                      ? const Color(0xFFEC4899)
                                      : Colors.white.withValues(alpha: 0.12),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  bt.shortName,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
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

                  // City Name
                  Text(
                    'BIRTH CITY & REGION',
                    style: GoogleFonts.outfit(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFEC4899),
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _cityController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withValues(alpha: 0.06),
                      hintText: 'e.g., Kyoto, Japan or New York, USA',
                      hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
                      prefixIcon: const Icon(Icons.location_city, color: Color(0xFFEC4899), size: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.15)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xFFEC4899), width: 1.5),
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
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: _submit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEC4899),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            elevation: 4,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.favorite, size: 16),
                              const SizedBox(width: 8),
                              Text(
                                'Calculate Synergy',
                                style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ],
                          ),
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
