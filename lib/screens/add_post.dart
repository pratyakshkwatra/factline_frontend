import 'package:auto_route/auto_route.dart';
import 'package:factline/api/exceptions.dart';
import 'package:factline/api/post.dart';
import 'package:factline/services/auth.dart';
import 'package:factline/widgets/error_snackbar.dart';
import 'package:factline/widgets/normal_snackbar.dart';
import 'package:factline/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

@RoutePage()
class AddPostScreen extends StatefulWidget {
  final AuthService authService;
  final FlutterSecureStorage secureStorage;
  const AddPostScreen({
    super.key,
    required this.authService,
    required this.secureStorage,
  });

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F5E9),
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(18),
        ),
        onPressed: _isLoading
            ? null
            : () async {
                final title = _titleController.text.trim();
                final body = _bodyController.text.trim();

                if (title.isEmpty) {
                  showNormalSnackbar("Please enter a title", context);
                  return;
                }
                if (body.isEmpty) {
                  showNormalSnackbar("Please enter a body", context);

                  return;
                }

                setState(() => _isLoading = true);

                try {
                  await PostAPI().createPost(title, body);

                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                } on APIException catch (error) {
                  if (context.mounted) {
                    showErrorSnackbar(
                      "Error: ${error.message.toString()}",
                      context,
                    );
                  }
                } catch (error) {
                  if (context.mounted) {
                    showErrorSnackbar("Error: ${error.toString()}", context);
                  }
                } finally {
                  if (mounted) setState(() => _isLoading = false);
                }
              },
        backgroundColor: Colors.black,
        isExtended: true,
        extendedPadding: EdgeInsets.symmetric(horizontal: 16),
        label: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Post",
              style: GoogleFonts.merriweather(
                fontWeight: FontWeight.w600,
                fontSize: 22,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 12),
            FaIcon(FontAwesomeIcons.paperPlane, color: Colors.white, size: 20),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Add a News Article",
                          style: GoogleFonts.merriweather(
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    RoundedInputField(
                      controller: _titleController,
                      hintText: "Title",
                      icon: Icons.title,
                      isPassword: false,
                    ),

                    const SizedBox(height: 16),
                    RoundedInputField(
                      controller: _bodyController,
                      hintText: "Body",
                      icon: null,
                      isPassword: false,
                      maxLines: 16,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
