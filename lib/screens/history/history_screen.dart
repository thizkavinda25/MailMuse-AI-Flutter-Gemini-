import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mail_muse/core/constants/app_colors.dart';
import 'package:mail_muse/core/utils/custom_routes.dart';
import 'package:mail_muse/providers/history_provider.dart';
import 'package:mail_muse/screens/home/email_details.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  Color _toneBgColor(String tone) {
    switch (tone) {
      case 'Casual & Friendly':
        return const Color.fromARGB(35, 118, 233, 125);
      case 'Formal & Professional':
        return const Color.fromARGB(24, 89, 69, 205);
      case 'Concise':
        return const Color.fromARGB(27, 141, 6, 168);
      case 'Enthusiastic':
        return const Color.fromARGB(27, 168, 149, 6);
      default:
        return const Color.fromARGB(34, 233, 133, 118);
    }
  }

  Color _toneTextColor(String tone) {
    switch (tone) {
      case 'Casual & Friendly':
        return Colors.green;
      case 'Formal & Professional':
        return const Color.fromARGB(255, 72, 6, 226);
      case 'Concise':
        return const Color.fromARGB(255, 205, 7, 255);
      case 'Enthusiastic':
        return const Color.fromARGB(255, 168, 149, 6);
      default:
        return const Color.fromARGB(255, 233, 133, 118);
    }
  }

  String _toneLabel(String tone) {
    switch (tone) {
      case 'Formal & Professional':
        return 'Formal';
      case 'Casual & Friendly':
        return 'Casual';
      default:
        return tone;
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<HistoryProvider>().loadHistory());
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.background,
        centerTitle: true,
        title: const Text(
          'Your History',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Consumer<HistoryProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.bottomNavSelectColor,
                ),
              );
            }
            final user = FirebaseAuth.instance.currentUser;
            if (provider.emails.isEmpty && user != null) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Icon(Icons.history, size: 80, color: Colors.grey),
                    SizedBox(height: 20),
                    Text(
                      'No history yet',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            if (user == null) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Icon(Icons.history, size: 80, color: Colors.grey),
                    SizedBox(height: 20),
                    Text(
                      'Please log in to view your history',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: 20,
              ),
              itemCount: provider.emails.length,
              itemBuilder: (context, index) {
                final email = provider.emails[index];

                return Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 15,
                  ),
                  margin: const EdgeInsets.only(bottom: 16),
                  width: double.infinity,

                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 10,
                              runSpacing: 6,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _toneBgColor(email.tone),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    _toneLabel(email.tone),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: _toneTextColor(email.tone),
                                    ),
                                  ),
                                ),

                                Text(
                                  email.createdAt != null
                                      ? DateFormat(
                                          'MMM d, yyyy \'●\' h:mm a',
                                        ).format(email.createdAt!)
                                      : '',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            Text(
                              email.topic,
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          CustomRoutes.push(
                            context,
                            EmailDetailScreen(email: email),
                          );
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
