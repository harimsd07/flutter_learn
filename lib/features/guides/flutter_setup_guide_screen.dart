import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class FlutterSetupGuideScreen extends StatelessWidget {
  const FlutterSetupGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: isDark ? AppColors.darkBackground : AppColors.pageBackground,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Flutter Setup Guide',
            style: GoogleFonts.dmSans(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          bottom: TabBar(
            indicatorColor: AppColors.runButton,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white.withValues(alpha: 0.55),
            dividerColor: Colors.transparent,
            tabs: const [
              Tab(
                icon: Icon(Icons.window_rounded, size: 18),
                text: 'Windows',
              ),
              Tab(
                icon: Icon(Icons.apple_rounded, size: 18),
                text: 'macOS',
              ),
              Tab(
                icon: Icon(Icons.terminal_rounded, size: 18),
                text: 'Linux',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _PlatformGuide(
              platform: 'Windows',
              isDark: isDark,
              requirements: const [
                'Windows 10 or 11 (64-bit)',
                '10 GB of free disk space',
                'PowerShell 5.0+ and Git for Windows installed',
              ],
              steps: const [
                _SetupStep(
                  number: 1,
                  title: 'Download the Flutter SDK',
                  description: 'Get the latest stable release of the Flutter SDK zip bundle.',
                  details: '1. Create a folder like C:\\src to hold your SDK.\n'
                      '2. Avoid extracting into protected system folders like C:\\Program Files.\n'
                      '3. Extract the downloaded zip file into C:\\src\\flutter.',
                  actions: [
                    _StepAction(
                      label: 'Download SDK Zip',
                      url: 'https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.22.2-stable.zip',
                      isDownload: true,
                    ),
                  ],
                ),
                _SetupStep(
                  number: 2,
                  title: 'Update Your Path Variable',
                  description: 'Add the Flutter executable path to your system environment variables so you can run flutter commands in PowerShell/CMD.',
                  details: '1. In the Windows Start Search, type "env" and select "Edit the system environment variables".\n'
                      '2. Click the "Environment Variables..." button.\n'
                      '3. In the "User variables" section, look for a variable named "Path". (Create it if it doesn\'t exist).\n'
                      '4. Select Path and click "Edit...", then click "New" and add C:\\src\\flutter\\bin.\n'
                      '5. Click OK on all windows to save.',
                ),
                _SetupStep(
                  number: 3,
                  title: 'Run Flutter Doctor',
                  description: 'Run the diagnostics tool to see what tools/SDKs you still need to configure.',
                  details: '1. Open a new PowerShell window.\n'
                      '2. Run the command below. It will check your setup and generate a report.',
                  code: 'flutter doctor',
                ),
                _SetupStep(
                  number: 4,
                  title: 'Install Android Studio & SDK',
                  description: 'Configure the Android development environment.',
                  details: '1. Download and install Android Studio.\n'
                      '2. Run Android Studio and complete the "Android Studio Setup Wizard" to install the latest Android SDK, SDK Command-line Tools, and Build-Tools.\n'
                      '3. Open PowerShell and run this command to accept Android licenses:\n'
                      '   flutter doctor --android-licenses\n'
                      '4. In Android Studio, go to SDK Manager -> SDK Tools tab. Check "Android SDK Command-line Tools" and click Apply.',
                  actions: [
                    _StepAction(
                      label: 'Download Android Studio',
                      url: 'https://developer.android.com/studio',
                    ),
                  ],
                ),
                _SetupStep(
                  number: 5,
                  title: 'Set Up VS Code Editor',
                  description: 'Configure Visual Studio Code with the Flutter extension.',
                  details: '1. Open VS Code.\n'
                      '2. Click on the Extensions icon on the left sidebar (Ctrl+Shift+X).\n'
                      '3. Search for "Flutter" and click Install. This automatically installs the Dart extension too.\n'
                      '4. Verify by opening the command palette (Ctrl+Shift+P) and running "Flutter: New Project".',
                ),
              ],
            ),
            _PlatformGuide(
              platform: 'macOS',
              isDark: isDark,
              requirements: const [
                'macOS Catalina (10.15) or later',
                'Apple Silicon (M1/M2/M3) or Intel processor',
                'Xcode 15+ (from App Store) for iOS development',
              ],
              steps: const [
                _SetupStep(
                  number: 1,
                  title: 'Download and Extract SDK',
                  description: 'Download the correct SDK build matching your Mac processor.',
                  details: '1. Create a development directory in your home folder: mkdir ~/development\n'
                      '2. Extract the SDK to that folder:\n'
                      '   cd ~/development\n'
                      '   unzip ~/Downloads/flutter_macos_3.22.2-stable.zip',
                  actions: [
                    _StepAction(
                      label: 'Download Apple Silicon SDK',
                      url: 'https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_arm64_3.22.2-stable.zip',
                      isDownload: true,
                    ),
                    _StepAction(
                      label: 'Download Intel SDK',
                      url: 'https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_3.22.2-stable.zip',
                      isDownload: true,
                    ),
                  ],
                ),
                _SetupStep(
                  number: 2,
                  title: 'Configure Your Shell Path',
                  description: 'Add Flutter to the PATH environment variable so the terminal recognizes it.',
                  details: '1. Open your terminal.\n'
                      '2. For macOS default Zsh, open the profile file: nano ~/.zshrc\n'
                      '3. Add the following line at the end:\n'
                      '   export PATH="\$PATH:\$HOME/development/flutter/bin"\n'
                      '4. Press Ctrl+O then Enter to save, and Ctrl+X to exit.\n'
                      '5. Reload the shell environment: source ~/.zshrc',
                ),
                _SetupStep(
                  number: 3,
                  title: 'Set Up Xcode (iOS Simulator)',
                  description: 'Install and switch Xcode settings to compile for iOS devices.',
                  details: '1. Open the Terminal and run these commands to set up the active Xcode command-line tools:\n'
                      '   sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer\n'
                      '   sudo xcodebuild -runFirstLaunch\n'
                      '2. Agree to the Xcode license terms by running:\n'
                      '   sudo xcodebuild -license\n'
                      '3. Open the iOS Simulator using this command:\n'
                      '   open -a Simulator',
                ),
                _SetupStep(
                  number: 4,
                  title: 'Install CocoaPods',
                  description: 'Install CocoaPods to handle iOS dependency plugins.',
                  details: 'If your Mac runs on Homebrew, run this in Terminal:',
                  code: 'brew install cocoapods',
                ),
                _SetupStep(
                  number: 5,
                  title: 'Verify Setup',
                  description: 'Run diagnostics to verify both Android and iOS configurations.',
                  details: 'Run this in Terminal to see if there are any missing components:',
                  code: 'flutter doctor',
                ),
              ],
            ),
            _PlatformGuide(
              platform: 'Linux',
              isDark: isDark,
              requirements: const [
                'Ubuntu/Debian 64-bit or similar distro',
                'Bash/Zsh shell experience',
                'Git, curl, unzip, and tar installed',
              ],
              steps: const [
                _SetupStep(
                  number: 1,
                  title: 'Install Flutter via Snap Store',
                  description: 'The easiest way to install Flutter on Linux is using Snap.',
                  details: 'Open your terminal and run the following command to download, extract, and path-configure Flutter automatically:',
                  code: 'sudo snap install flutter --classic',
                ),
                _SetupStep(
                  number: 2,
                  title: 'Install Required Linux Build Tools',
                  description: 'Install toolchain libraries required for building desktop applications and compiling assets.',
                  details: 'For Debian/Ubuntu, run this apt command:',
                  code: 'sudo apt-get update && sudo apt-get install -y \\\n'
                      '  clang cmake ninja-build pkg-config \\\n'
                      '  libgtk-3-dev liblzma-dev libstdc++-12-dev',
                ),
                _SetupStep(
                  number: 3,
                  title: 'Manual SDK Path Configuration (Alternative)',
                  description: 'If you downloaded the tarball manually instead of Snap, configure your shell environment.',
                  details: '1. Extract to ~/development:\n'
                      '   tar xf ~/Downloads/flutter_linux_3.22.2-stable.tar.xz -C ~/development\n'
                      '2. Open ~/.bashrc or ~/.zshrc and add:\n'
                      '   export PATH="\$PATH:\$HOME/development/flutter/bin"\n'
                      '3. Reload your profile: source ~/.bashrc',
                ),
                _SetupStep(
                  number: 4,
                  title: 'Install Android Studio',
                  description: 'Configure SDK commands for building Android packages.',
                  details: '1. Download Android Studio tarball.\n'
                      '2. Extract to /opt/ or ~/development/ and launch: ./studio.sh\n'
                      '3. Run Android licenses validation:',
                  code: 'flutter doctor --android-licenses',
                ),
                _SetupStep(
                  number: 5,
                  title: 'Run Diagnostic Check',
                  description: 'Run the developer dashboard tests.',
                  details: 'Check your installation progress in the terminal:',
                  code: 'flutter doctor',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PlatformGuide extends StatelessWidget {
  const _PlatformGuide({
    required this.platform,
    required this.isDark,
    required this.requirements,
    required this.steps,
  });

  final String platform;
  final bool isDark;
  final List<String> requirements;
  final List<_SetupStep> steps;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      children: [
        // Requirements card
        Card(
          color: isDark ? AppColors.darkCard : Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: isDark ? AppColors.darkBorder : const Color(0x12000000)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.info_outline_rounded, color: AppColors.primary, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'System Requirements',
                      style: GoogleFonts.dmSans(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.darkTextPrimary : const Color(0xFF1A1A2E),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ...requirements.map((req) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
                          Expanded(
                            child: Text(
                              req,
                              style: AppTextStyles.bodySmall(
                                color: isDark ? AppColors.darkTextSecondary : const Color(0xFF5C6278),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Step header
        Text(
          'Step-by-Step Installation',
          style: GoogleFonts.dmSans(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.darkTextPrimary : const Color(0xFF1A1A2E),
          ),
        ),
        const SizedBox(height: 16),
        // Steps list builder
        ...steps.map((step) => _StepTile(step: step, isDark: isDark)),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _SetupStep {
  const _SetupStep({
    required this.number,
    required this.title,
    required this.description,
    required this.details,
    this.code,
    this.actions = const [],
  });

  final int number;
  final String title;
  final String description;
  final String details;
  final String? code;
  final List<_StepAction> actions;
}

class _StepAction {
  const _StepAction({
    required this.label,
    required this.url,
    this.isDownload = false,
  });

  final String label;
  final String url;
  final bool isDownload;
}

class _StepTile extends StatelessWidget {
  const _StepTile({required this.step, required this.isDark});

  final _SetupStep step;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline Column
          Column(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${step.number}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Timeline connector line
              Container(
                width: 2,
                height: 130, // static height fallback
                color: isDark ? AppColors.darkBorder : Colors.grey.shade300,
              ),
            ],
          ),
          const SizedBox(width: 14),
          // Content Card
          Expanded(
            child: Card(
              color: isDark ? AppColors.darkCard : Colors.white,
              margin: EdgeInsets.zero,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: isDark ? AppColors.darkBorder : const Color(0x12000000)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step.title,
                      style: GoogleFonts.dmSans(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.darkTextPrimary : const Color(0xFF1A1A2E),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      step.description,
                      style: AppTextStyles.bodySmall(
                        color: isDark ? AppColors.darkTextSecondary : const Color(0xFF5C6278),
                      ),
                    ),
                    const Divider(height: 20),
                    Text(
                      step.details,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        height: 1.5,
                        color: isDark ? AppColors.darkTextPrimary.withValues(alpha: 0.85) : Colors.grey.shade800,
                      ),
                    ),
                    if (step.code != null) ...[
                      const SizedBox(height: 12),
                      _CodeBox(code: step.code!, isDark: isDark),
                    ],
                    if (step.actions.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        children: step.actions
                            .map((act) => ElevatedButton.icon(
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(text: act.url));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('URL copied: ${act.url}'),
                                        duration: const Duration(seconds: 2),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    act.isDownload ? Icons.download_rounded : Icons.open_in_new_rounded,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    act.label,
                                    style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    minimumSize: Size.zero,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                  ),
                                ))
                            .toList(),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeBox extends StatelessWidget {
  const _CodeBox({required this.code, required this.isDark});

  final String code;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F1322) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isDark ? AppColors.darkBorder : Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                code,
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 11,
                  color: isDark ? const Color(0xFF81A1C1) : const Color(0xFF2E3440),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.copy_rounded, size: 14),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: code));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Command copied to clipboard!'),
                  duration: Duration(seconds: 1),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            constraints: const BoxConstraints(),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
