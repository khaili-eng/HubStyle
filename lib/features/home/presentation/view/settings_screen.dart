import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled7/features/home/presentation/widgets/setting_item.dart';

import '../manager/theme_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
      ),
      body:  Padding(
                    padding: const EdgeInsets.all(20),
          child: Column(
               children: [
   //for swith theme
           Card(
           elevation: 2,
           child: Padding(
             padding: const EdgeInsets.all(16),
             child: Row(
               children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                        shape: BoxShape.circle,
    ),
                 child: Icon(
                 Icons.dark_mode,
                 color: Colors.orange.shade600,
                ),
    ),
    const SizedBox(width: 15),
           Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Text(
                       'Dark Mode',
                         style: Theme.of(context).textTheme.titleMedium,
    ),
                    Text(
                         'Switch between light and dark theme',
                         style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade600,
                  ),
               ),
              ],
          ),
    ),
                BlocBuilder<ThemeCubit, ThemeState>(
                  builder: (context, state) {
                     return Switch(
                      value: state.isDarkMode,
                      onChanged: (value) {
                      context.read<ThemeCubit>().toggleTheme(value);
    },
                       activeColor: Theme.of(context).colorScheme.secondary,
                       );
                    },
                 ),
                ],
            ),
         ),
    ),
            const SizedBox(height: 20),
             SettingItem(
              icon: Icons.notifications,
               title: 'Notifications',
               subtitle: 'Manage your notifications'
    ),
    SettingItem(
    icon: Icons.security,
    title: 'Privacy',
    subtitle: 'Control your privacy settings'
    ),
        SettingItem(
        icon: Icons.help,
        title: 'Help & Support',
        subtitle: 'Get help and contact support'
       ),
          SettingItem(
           icon: Icons.info,
          title: 'About',
            subtitle: 'App version 1.0.0',
    ),
    ]
      )
      )
    );

  }
}
