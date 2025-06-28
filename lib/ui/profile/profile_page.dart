import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:top_quotes/core/theme/app_text_styles.dart';
import 'bloc/profile_bloc.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    context.read<ProfileBloc>().add(FetchProfileEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return Skeletonizer(
            enabled: state.isLoading,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(state.profile.picUrl),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            state.profile.login,
                            style: AppTextStyles.caption.copyWith(fontFamily: GoogleFonts.alkalami().fontFamily),
                          ),
                          Text(
                            state.profile.accountDetails.email,
                            style: AppTextStyles.caption.copyWith(fontFamily: GoogleFonts.alkalami().fontFamily),

                          ),
                          Text(
                            "${state.profile.publicFavoritesCount} ❤",
                            style: AppTextStyles.caption.copyWith(fontFamily: GoogleFonts.alkalami().fontFamily),
                          )
                          // _buildInfoTile('Username', state.profile.login),
                          // _buildInfoTile('Email', state.profile.accountDetails.email),
                          // _buildInfoTile('Public Favorites', state.profile.publicFavoritesCount.toString()),
                        ],
                      )
                    ],
                  ),

                  SizedBox(height: 20),
                  // User Info



                  // Pro Status
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoTile(String title, String value) {
    return ListTile(
      title: Text(title, style: AppTextStyles.body),
      trailing: Text(value, style: AppTextStyles.caption),
    );
  }
}