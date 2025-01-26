import 'package:flutter/material.dart';
import 'package:taskly/ui/screens/update_profile_screen.dart';
import 'package:taskly/ui/utils/app_colors.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget{
  const TMAppBar({
    super.key,
    this.fromUpadeProfile = false,
  });

  final bool fromUpadeProfile;

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;

    return AppBar(
      backgroundColor: AppColors.themeColor,
      title: Row(
        children: [
          CircleAvatar(),
          const SizedBox(width: 10),
          Expanded(
            child: GestureDetector(
              onTap: (){
                if(!fromUpadeProfile) {
                  Navigator.pushNamed(context, UpdateProfileScreen.name);
                }

              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Fatin Istiak Polok', style: textTheme.titleSmall?.copyWith(color: Colors.white),),
                  Text('istiak@polok.site',style: textTheme.bodySmall?.copyWith(color: Colors.white),),

                ],
              ),
            ),
          ),
          IconButton(onPressed: (){}, icon: Icon(Icons.logout))
        ],
      ),
    );
  }

  @override

  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
