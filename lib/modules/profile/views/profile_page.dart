import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:youappgetxtest/modules/profile/controllers/profile_controller.dart';
import '../../../core/utils.dart';
import '../../../data/models/profile_model.dart';
import '../../../core/assets.dart';
import '../../../core/themes.dart';
import '../../../widgets/custom_back_button.dart';
import '../../../widgets/custom_background.dart';
import '../../../widgets/gradient_text.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController controller = Get.find<ProfileController>();
  final TextEditingController _controller = TextEditingController();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final FocusNode nameFocus = FocusNode();
  final FocusNode heigthFocus = FocusNode();
  final FocusNode weightFocus = FocusNode();
  final FocusNode _focusNode = FocusNode();

  List<String> _tags = [];

  ProfileData profileData = ProfileData();

  int? age;
  int _isFormAbout = 0;

  File? _imageFile;

  String? selectedGender;
  String horoscope = "--", zodiak = "--";

  DateTime? selectedBirthday;

  bool _isIsterest = false, _isDetail = false;

  @override
  void initState() {
    _getProfile();

    super.initState();
  }




  Future<void> _getProfile() async {
    await controller.getProfile();
    final data = controller.profile.value?.data;
    if (data != null) {
      
      setState(() {
        profileData = data;
        nameController.text = data.name ?? '';
        if (data.birthday != null && data.birthday!.isNotEmpty) {
          setState(() {
            _isDetail = true;
          });
          try {
            final parts = data.birthday!.split('/');
            selectedBirthday = DateTime(
              int.parse(parts[2]),
              int.parse(parts[1]),
              int.parse(parts[0]),
            );
            age = Utils.calculateAge(selectedBirthday!);
          } catch (e) {
            selectedBirthday = null;
            age = null;
          }
        }else{
          setState(() {
            _isDetail = false;
          });
        }
        if (data.height != null) {
          heightController.text = data.height?.toString() ?? '';
        }
        if (data.weight != null) {
          weightController.text = data.weight?.toString() ?? '';
        }
        selectedGender = data.gender;
        horoscope = data.horoscope ?? '--';
        zodiak = data.zodiac ?? '--';
        _tags = List<String>.from(data.interests ?? []);
      });
    }
    final localGender = Utils.getProfileGender(profileData.email ?? "");
      if (localGender != null) {
        setState(() {
          selectedGender = localGender;
        });
      }
     if (_imageFile == null) {
    await _loadProfileImage();
    }
  }

  Future<void> _loadProfileImage() async {
    final file = Utils.getProfileImage(profileData.email ?? "");
    if (file != null) {
      setState(() {
        _imageFile = file;
      });
    }
  }

  Future<void> _saveProfile() async {
    if (nameController.text.trim().isEmpty || selectedBirthday == null || heightController.text.trim().isEmpty || weightController.text.trim().isEmpty) {
      Get.snackbar("Error", "Please fill all required fields");
      return;
    }

    final request = ProfileRequest(
      name: nameController.text.trim(),
      birthday: "${selectedBirthday!.day}/${selectedBirthday!.month}/${selectedBirthday!.year}",
      height: int.tryParse(heightController.text),
      weight: int.tryParse(weightController.text),
      interests: _tags
    );
    final success =_isDetail ? await controller.updateProfile(request):await controller.createProfile(request) ;
    
    if (success) {
      Get.snackbar("Success", controller.message.value);
      setState(() {
        _isFormAbout = 0;
        _isDetail = true;
      });
      await _getProfile();
    } else {
      Get.snackbar("Error", controller.message.value);
    }
  }

  Future<void> pickBirthday() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedBirthday ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(colorScheme: ColorScheme.dark(primary: Color(primaryLightColor), onPrimary: Colors.white, surface: Color(primaryColor), onSurface: Colors.white), textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: Colors.teal))),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedBirthday = picked;
        horoscope = Utils.getHoroscope(picked);
        zodiak = Utils.getZodiac(picked);
        age = Utils.calculateAge(picked);
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null && profileData.email != null && profileData.email!.isNotEmpty) {
      final file = File(pickedFile.path);

      final savedImage = await Utils.saveProfileImage(file, profileData.email!);

      if (savedImage != null) {
      await FileImage(savedImage).evict();

      setState(() {
        _imageFile = savedImage;
      });
    }

    } else {
      debugPrint("No image picked or email not available.");
    }

  }




  void _addTag(String tag) {
    if (tag.trim().isEmpty) return;
    setState(() {
      _tags.add(tag.trim());
    });
    _controller.clear();
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    heightController.dispose();
    weightController.dispose();
    nameFocus.dispose();
    heigthFocus.dispose();
    weightFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(primaryDarkColor),
      body: SafeArea(
        child: RefreshIndicator(
            onRefresh: () async {
              await _getProfile();
            },
            child: _isIsterest ? _buildInterest() : _headerProfile()),
      ),
    );
  }

  Widget _headerProfile() {
    final iconHoroscope = Utils.getHoroscopeAsset(horoscope);
    final iconZodiac = Utils.getZodiacAsset(zodiak);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomBackButtonRow(onTap: () {
                  Utils.showLogoutConfirmation();
                }),
                Text("@${profileData.username}", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.white)),
                Container(child:_isFormAbout == 0 && profileData.birthday == null ? Icon(Icons.more_horiz_rounded,color: Colors.white): Container())
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 190,
            decoration: BoxDecoration(color: Color(cardLightColor), borderRadius: BorderRadius.all(Radius.circular(16))),
            child: Stack(
              children: [
                Positioned(top: 0, bottom: 0, left: 0, right: 0, child: _imageFile != null ? ClipRRect(borderRadius: BorderRadius.circular(17.0), child: Image.file(_imageFile!, fit: BoxFit.cover, key: ValueKey(DateTime.now().millisecondsSinceEpoch),)) : Container()),
                Positioned(
                  right: 10,
                  top: 5,
                  child: _isFormAbout == 1 ? Container() : GestureDetector(onTap: () {
                    setState(() {
                      _isFormAbout = 1;
                    });
                  }, child: Image.asset(icEdit,height: 17,width: 17,))),
                Positioned(
                  left: 10,
                  bottom: 10,
                  child:!_isDetail? Text("@${profileData.username}", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: Colors.white)): Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("@${profileData.username}", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: Colors.white)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${selectedGender ?? ''}", style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w400, color: Colors.white)),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(color: Colors.black54,borderRadius: BorderRadius.all(Radius.circular(20))),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(iconHoroscope, height: 20,width: 20,color: Colors.white),
                                    SizedBox(width: 5),
                                    Text("${horoscope}", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.white))
                                  ],
                                )),
                              SizedBox(width: 10),
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(color: Colors.black54,borderRadius: BorderRadius.all(Radius.circular(20))),
                                child: Row(
                                  children: [
                                    Image.asset(iconZodiac, height: 20,width: 20,color: Colors.white),
                                    SizedBox(width: 5),
                                    Text("${zodiak}", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.white)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),                      
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(child: _isFormAbout == 0 ? _buildCard( childCard:_isDetail? _buildDetailProfile(): _hintextProfile("Add in your your to help others know you \nbetter"), label: "About", heightCard: 170,onTap: () {setState(() {_isFormAbout = 1;});},) : _buildFormAbout(),),
          SizedBox(height: 20),
          _buildCard(label: "Interest",childCard: _tags.isNotEmpty? _buildInterestProfile(): _hintextProfile( "Add in your interest to find a better match"),
          heightCard: 109,onTap: () {setState(() {_isIsterest = true;});})
        ],
      ),
    );
  }

  Widget _buildCard({required String label, required double heightCard, required VoidCallback onTap,  Widget? childCard}) {
    return Container(
     width: double.infinity,
     height: heightCard,
     decoration: BoxDecoration(
       color: Color(cardDarkColor).withOpacity(0.9),
       borderRadius: BorderRadius.all(Radius.circular(16))),
     padding: EdgeInsets.only(top: 10, right: 10, left: 15),
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text(label,style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
             InkWell(onTap: onTap,child: Image.asset(icEdit,height: 17,width: 17))
           ],
         ),
         SizedBox(height: 15),
         Container(child: childCard),
       ],
     ),
    );
  }

  Widget _hintextProfile(String hintext) {
    return Text(hintext, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white.withOpacity(0.5)));
  }

  Widget _buildInterestProfile() {
    return Column(
      children: [
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: _tags .map((tag) => Container(
            width: 100,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration( color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.all(Radius.circular(15)),),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(tag,style: TextStyle(color: Colors.white),maxLines: 1,overflow: TextOverflow.ellipsis),
              ],
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildDetailProfile() {
    return Column(
      children: [
        _detailProfileText(label: "Birthday", value: "${profileData.birthday ?? '--'} (${age != null ? 'Age $age' : '--'})"),
        _detailProfileText(label: "Horoscope", value: "${profileData.horoscope ?? '--'}"),
        _detailProfileText(label: "Zodiak", value: "${profileData.zodiac ?? '--'}"),
        _detailProfileText(label: "Height", value: "${profileData.height ?? '--'}"),
        _detailProfileText(label: "Weight", value: "${profileData.weight ?? '--'}"),
      ],
    );
  }

  Widget _detailProfileText({required String label, required String value}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Text("$label: ", style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.33))),
          Text(value, style: TextStyle(fontSize: 13, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildFormAbout() {
    return Container(
     width: double.infinity,
     decoration: BoxDecoration(color: Color(cardDarkColor).withOpacity(0.9), borderRadius: BorderRadius.all(Radius.circular(16))),
     padding: EdgeInsets.only(top: 10, right: 10, left: 15),
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text("About",style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
             GestureDetector(onTap: _saveProfile,child: GradientText("Save & Update", style: TextStyle( fontSize: 12, fontWeight: FontWeight.w500, )))
           ],
         ),
         SizedBox(height: 15),
         Row(
           children: [
             GestureDetector(
               onTap: _showImageSourceDialog,
               child: Container(
               width: 57,
               height: 57,
               decoration: BoxDecoration(color: Colors.white.withOpacity(0.08),borderRadius: BorderRadius.all(Radius.circular(17.0),)),
               child: _imageFile != null ? ClipRRect(borderRadius: BorderRadius.circular(17.0), child: Image.file(_imageFile!, fit: BoxFit.cover , key: ValueKey(DateTime.now().millisecondsSinceEpoch),)) : Icon(Icons.add, color: Color(goldColor)))),
             SizedBox(width: 10),
             Text("Add image",style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white)),
           ],
         ),
         SizedBox(height: 10),
         _textfield(label: "Display name",child: TextField(controller: nameController,focusNode: nameFocus,onTapOutside: (event) => nameFocus.unfocus(),textAlign: TextAlign.right,style: const TextStyle(fontSize: 13,color: Colors.white,fontWeight: FontWeight.w400,),decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: BorderSide.none,),contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),hintText: "Enter name",hintStyle: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13)))),
         SizedBox(height: 8),
         _textfield(
           label: "Gender",
           child: DropdownButtonHideUnderline(
             child: DropdownButton<String>(
               value: selectedGender,
               hint: Align(alignment: Alignment.centerRight, child: Text("Select Gender", textAlign: TextAlign.right, style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13))),
               dropdownColor: Color(primaryColor),
               isExpanded: true,
               isDense: true,
               iconEnabledColor: Colors.white,
               icon: Icon(Icons.keyboard_arrow_down_sharp),
               style: TextStyle(fontSize: 13),
               items: ["Male","Female" ].map((String value) {
                return DropdownMenuItem<String>(
                   value: value,
                   child: Align(alignment: Alignment.centerRight, child: Text(value, textAlign: TextAlign.right, style: TextStyle(color: Colors.white, fontSize: 13))),
                 );
               }).toList(),
               selectedItemBuilder: (BuildContext context) { return [ "Male", "Female" ].map((String value) {
                return Align(
                     alignment: Alignment.centerRight,
                     child: Text(selectedGender ?? value, textAlign: TextAlign.right, style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w400)),
                   );
                 }).toList();
               },
               onChanged: (value) {
                 setState(() {
                   selectedGender = value;
                 });
                 if (profileData.email != null && value != null) {
                    Utils.saveProfileGender(profileData.email!, value);
                  }
               },
             ),
           ),
         ),
         SizedBox(height: 8),
         _textfield(
           label: "Birthday",
           child: InkWell(
             onTap: pickBirthday,
             child: Align(
               alignment: Alignment.centerRight,
               child: Padding(
                 padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                 child: Text(
                   selectedBirthday != null ? "${selectedBirthday!.day}/${selectedBirthday!.month}/${selectedBirthday!.year}" : "DD MM YYYY",
                   textAlign: TextAlign.right,
                   style: TextStyle(color: selectedBirthday != null ? Colors.white : Colors.white.withOpacity(0.5), fontSize: 13),
                 ),
               ),
             ),
           ),
         ),
         SizedBox(height: 8),
         _textfield( label: "Horoscope", child: Container( padding: EdgeInsets.all(8), child: Text( horoscope, textAlign: TextAlign.right, style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13), ))),
         SizedBox(height: 8),
         _textfield(label: "Zodiak", child: Container(padding: EdgeInsets.all(8), child: Text(zodiak, textAlign: TextAlign.right, style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13)))),
         SizedBox(height: 8),
         _textfield(label: "Height",
            child: TextField(
              controller: heightController,
              focusNode: heigthFocus,onTapOutside: (event) => heigthFocus.unfocus(),
              keyboardType: TextInputType.number, 
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 13,color: Colors.white,fontWeight: FontWeight.w400,),
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none,), 
                suffix: heightController.text.isNotEmpty? Text( " cm",style: const TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.w400)): null, 
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),hintText: "Add height",
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13)))),
         SizedBox(height: 8),
         _textfield(label: "Weight", 
            child: TextField( 
              controller: weightController, 
              focusNode: weightFocus, 
              onTapOutside: (event) => weightFocus.unfocus(),
              keyboardType: TextInputType.number, 
              textAlign: TextAlign.right, 
              style: const TextStyle( fontSize: 13, color: Colors.white, fontWeight: FontWeight.w400, ), 
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration( 
                border: OutlineInputBorder( borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none, ),
                suffix: weightController.text.isNotEmpty? Text( " kg",style: const TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.w400)): null, 
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), 
                hintText: "Add height", 
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13),
                ),
              ),
         ),
       ],
     ),
    );
  }

  Widget _textfield({required String label, required Widget child}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 120,
          child: Text( "$label :", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.white.withOpacity(0.3)) )),
        Container(
          width: 202,
          height: 38,
          decoration: BoxDecoration(color: Color(textfieldAboutColor).withOpacity(0.06), borderRadius: BorderRadius.all(Radius.circular(8)), border: Border.all(width: 2, color: Colors.white.withOpacity(0.2))),
          child: child,
        )
      ],
    );
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text("Kamera"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text("Galeri"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInterest() {
    return CustomBackground(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomBackButtonRow(onTap: () {
                    setState(() {
                      _isIsterest = false;
                    });
                  }),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                      _isIsterest = false;
                      });
                    },
                    child: GradientText( "Save", underLine: false, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600), gradient: blueGradient, ))
                ],
              ),
              SizedBox(height: 100),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GradientText( "Tell everyone about yourself", underLine: false, style: TextStyle( fontSize: 14, fontWeight: FontWeight.w700, ), ),
                  Text("What interest you?", style: TextStyle( fontSize: 20.0, fontWeight: FontWeight.w700, color: Colors.white)),
                ],
              ),
              Container(
                decoration: BoxDecoration(color: Color(bgInterestCard),borderRadius: BorderRadius.all(Radius.circular(10)),),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: _tags .map((tag) => Container(
                        width: 100,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration( color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.all(Radius.circular(4)),),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 60,
                              child: Text(tag,style: TextStyle(color: Colors.white),maxLines: 1,overflow: TextOverflow.ellipsis)),
                            InkWell(onTap: () => _removeTag(tag), child: Icon(Icons.close, color: Colors.white))
                          ],
                        ),
                      )).toList(),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            focusNode: _focusNode,
                            onTapOutside: (event) => _focusNode.unfocus(),
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(border: InputBorder.none,contentPadding: EdgeInsets.symmetric(vertical: 8.0),),
                            onSubmitted: _addTag,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
