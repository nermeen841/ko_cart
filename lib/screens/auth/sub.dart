// import 'package:date_time_picker/date_time_picker.dart';
// import 'package:dio/dio.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'package:rounded_loading_button/rounded_loading_button.dart';
// import 'package:kocart/lang/change_language.dart';
// import 'package:kocart/models/bottomnav.dart';
// import 'package:kocart/models/constants.dart';
// import 'package:kocart/models/country.dart';
//
//
// class Subscription extends StatefulWidget {
//   @override
//   _SubscriptionState createState() => _SubscriptionState();
// }
//
// class _SubscriptionState extends State<Subscription> {
//   final _formKey = GlobalKey<FormState>();
//   final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();
//   bool _visibility = true;
//   String? date,verificationId;
//   List<String> _hint = language=='en'?[
//   'Full name','','E-mail','phone number','University','Major','Password','Student Id'
//   ]:[
//   'Nama lengkap','','Surel','nomor telepon','Universitas','Besar','Kata sandi','Identitas Siswa'
//   ];
//   Future register()async{
//     final String url = domain+'register-students';
//     FormData formData = FormData.fromMap({
//       'name':_listEd[0].text,
//       'email':_listEd[2].text,
//       'phone':_listEd[3].text,
//       'date':date,
//       'university':_listEd[4].text,
//       'major':_listEd[5].text,
//       'password':_listEd[6].text,
//       'university_id':_listEd[7].text,
//     });
//     try {
//       Response response = await Dio().post(url,
//         data: formData,
//       );
//       if(response.data['status']==0){
//         String data ='';
//         if(language=='ar'){
//           response.data['message'].forEach((e){
//             data += e + '\n';
//           });
//         }else{
//           response.data['message'].forEach((e){
//             data += e + '\n';
//           });
//         }
//         final snackBar = SnackBar(
//           content: Text(data),
//           action: SnackBarAction(
//             label: translate(context,'snack_bar','undo'),
//             disabledTextColor: Colors.yellow,
//             textColor: Colors.yellow,
//             onPressed: () {
//               ScaffoldMessenger.of(context).hideCurrentSnackBar();
//             },
//           ),
//         );
//         _btnController.stop();
//         ScaffoldMessenger.of(context).showSnackBar(snackBar);
//         return null;
//       }
//       if(response.statusCode==200&&response.data['data']['status']==1){
//         _btnController.stop();
//         // alertSuccess(context);
//         succSub(context);
//       }
//     } catch (e) {
//       print('e');
//       print(e);
//       _btnController.error();
//       await Future.delayed(const Duration(seconds: 2));
//       _btnController.stop();
//     }
//   }
//   // Future fireSms(context,String phone,RoundedLoadingButtonController _btnController)async{
//   //   final TextEditingController sms = TextEditingController();
//   //   try{
//   //     String ph=countryCode+phone;
//   //     Future<PhoneVerificationFailed?> verificationFailed  (FirebaseAuthException authException)async{
//   //       _btnController.error();
//   //       await Future.delayed(const Duration(milliseconds: 1000));
//   //       _btnController.stop();
//   //       customError(context,translate(context,'fire_base','error1'));
//   //     }
//   //     Future<PhoneCodeAutoRetrievalTimeout?> autoTimeout  (String varId)async{
//   //       verificationId = varId;
//   //       _btnController.stop();
//   //     }
//   //     await FirebaseAuth.instance.verifyPhoneNumber(phoneNumber: ph,
//   //         timeout: const Duration(seconds: 90),
//   //         verificationCompleted: (AuthCredential credential)async{
//   //           try{
//   //             var  result = await FirebaseAuth.instance.signInWithCredential(credential);
//   //             var ha = result.user;
//   //             if(ha!=null){
//   //               print('not');
//   //               await register();
//   //             }
//   //           }catch(e)
//   //           {
//   //             _btnController.error();
//   //             await Future.delayed(const Duration(milliseconds: 1000));
//   //             _btnController.stop();
//   //             customError(context,translate(context,'fire_base','error2'));
//   //           }
//   //         },
//   //         verificationFailed: verificationFailed,
//   //         codeSent: (String verificationId,[int? forceResendingToken]){
//   //           showDialog(
//   //               context: context,
//   //               barrierDismissible: false,
//   //               builder: (dialogContext){
//   //                 return AlertDialog(
//   //                   title: Align(alignment: Alignment.topLeft,child: IconButton(
//   //                     icon: const Icon(Icons.close),
//   //                     onPressed: (){
//   //                       Navigator.pop(dialogContext);
//   //                     },
//   //                   ),),
//   //                   titlePadding: const EdgeInsets.only(left: 0,bottom: 0),
//   //                   shape: const RoundedRectangleBorder(
//   //                     borderRadius: BorderRadius.all(Radius.circular(32.0)),
//   //                   ),
//   //                   content: SizedBox(
//   //                     height: h*30/100,
//   //                     child: Column(
//   //                       children: <Widget>[
//   //                         Align(child: Text(translate(context,'sms','title'),style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: w*5/100),),alignment: Alignment.center,),
//   //                         SizedBox(height: h*2/100,),
//   //                         Directionality(
//   //                           textDirection: getDirection(),
//   //                           child: TextField(
//   //                             controller: sms,
//   //                             decoration: new InputDecoration(
//   //                               border: new OutlineInputBorder(
//   //                                   borderSide: new BorderSide(color: Colors.black),
//   //                                   borderRadius: BorderRadius.circular(10)
//   //                               ),
//   //                               hintText: translate(context,'sms','hint'),
//   //                               contentPadding: EdgeInsets.zero,
//   //                               prefixIcon: Icon(
//   //                                 Icons.mail,
//   //                                 color: mainColor,
//   //                               ),
//   //                             ),
//   //                             keyboardType: TextInputType.number,
//   //                           ),
//   //                         ),
//   //                         SizedBox(height: h*1.5/100,),
//   //                         InkWell(
//   //                           child: Container(
//   //                             width: w*30/100,
//   //                             height: h*6/100,
//   //                             decoration: BoxDecoration(
//   //                                 borderRadius: BorderRadius.circular(7),
//   //                                 border: Border.all(color: Colors.black)
//   //                             ),
//   //                             child: Center(
//   //                               child: Text(translate(context,'buttons','send'),style: TextStyle(color: mainColor,fontSize: w*4.5/100,fontWeight: FontWeight.bold),),
//   //                             ),
//   //                           ),
//   //                           onTap: ()async{
//   //                             if(sms.text!=''){
//   //                               try{
//   //                                 FocusScope.of(context).unfocus();
//   //                                 AuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: sms.text);
//   //                                 var  result = await FirebaseAuth.instance.signInWithCredential(credential);
//   //                                 var ha = result.user;
//   //                                 if(ha!=null){
//   //                                   sms.text = '';
//   //                                   Navigator.pop(dialogContext,'ok');
//   //                                   await register();
//   //                                 }
//   //                               }catch(e){
//   //                                 customError(context,translate(context,'fire_base','error2'));
//   //                                 _btnController.error();
//   //                                 await Future.delayed(const Duration(milliseconds: 1000));
//   //                                 _btnController.stop();
//   //                               }
//   //                             }
//   //                           },
//   //                         ),
//   //                       ],
//   //                     ),
//   //                   ),
//   //                   contentPadding: EdgeInsets.only(top: 0,right: w*2/100,left: w*2/100,bottom: 0),
//   //                 );
//   //               }
//   //           ).then((value) {
//   //             if(value==null){
//   //               _btnController.reset();
//   //             }
//   //           });
//   //         },
//   //         codeAutoRetrievalTimeout: autoTimeout);
//   //   }catch (e)
//   //   {
//   //     // showBar(context, e, e);
//   //     _btnController.error();
//   //     await Future.delayed(const Duration(milliseconds: 1000));
//   //     _btnController.stop();
//   //     showDialog(context: context,
//   //         builder:(context)=> AlertDialog(
//   //           shape: const RoundedRectangleBorder(
//   //             borderRadius: BorderRadius.all(Radius.circular(60)),
//   //           ),
//   //           content: SizedBox(
//   //               height: h*0.5,
//   //               width: h/3.5,
//   //               child: SingleChildScrollView(
//   //                 child: Column(
//   //                   children: [
//   //                     Text(e.toString())
//   //                   ],
//   //                 ),
//   //               )
//   //           ),
//   //         )
//   //     );
//   //
//   //   }
//   // }
//   List<FocusNode> _listFocus = List<FocusNode>.generate(8, (_) => new FocusNode()) ;
//   List<TextEditingController> _listEd = List<TextEditingController>.generate(8, (_) => new TextEditingController());
//   @override
//   Widget build(BuildContext context) {
//     double h = MediaQuery.of(context).size.height;
//     double w = MediaQuery.of(context).size.width;
//     return Form(
//       key: _formKey,
//       child: GestureDetector(
//         onTap: (){
//           FocusScope.of(context).requestFocus(new FocusNode());
//         },
//         child: Scaffold(
//           backgroundColor: Colors.white,
//           appBar: AppBar(
//             backgroundColor: Colors.white,
//             systemOverlayStyle: st,
//             title: Text(translate(context,'sub','title'), style: TextStyle(fontSize: w * 0.05, color: mainColor,fontWeight: FontWeight.bold),),
//             actions: [
//               Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: BackButton(color: mainColor,),
//               ),
//             ],
//             automaticallyImplyLeading: false,
//             centerTitle: true,
//             elevation: 0,
//           ),
//           body: Center(
//             child: Container(
//               width: w*0.9,
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     // Container(
//                     //   width: w*0.9,
//                     //   child: FormField(
//                     //     builder: (state){
//                     //       return Column(
//                     //         mainAxisSize: MainAxisSize.min,
//                     //         crossAxisAlignment: CrossAxisAlignment.start,
//                     //         children: [
//                     //           Container(
//                     //             width: w*0.6,
//                     //             child: DateTimePicker(
//                     //               type: DateTimePickerType.date,
//                     //               dateMask: 'd MMM, yyyy',
//                     //               initialValue: DateTime.now().toString(),
//                     //               firstDate: DateTime(1940),
//                     //               lastDate: DateTime(DateTime.now().year),
//                     //               icon: Icon(Icons.event),
//                     //               dateLabelText: translate(context,'inputs','day'),
//                     //               selectableDayPredicate: (date) {
//                     //                 return true;
//                     //               },
//                     //               onChanged: (val) {
//                     //                 String year = val.split('-').first;
//                     //                 String month = val.split('-')[1];
//                     //                 String day = val.split('-')[2];
//                     //                 String fullDate = day+'-'+month+'-'+year;
//                     //                 setState(() {
//                     //                   date = fullDate;
//                     //                 });
//                     //               },
//                     //               onSaved: (val) {
//                     //                 if(val!=null){
//                     //                   String year = val.split('-').first;
//                     //                   String month = val.split('-')[1];
//                     //                   String day = val.split('-')[2];
//                     //                   String fullDate = day+'-'+month+'-'+year;
//                     //                   setState(() {
//                     //                     date = fullDate;
//                     //                   });
//                     //                 }
//                     //               },
//                     //             ),
//                     //           ),// your widget
//                     //           if(state.errorText!=null)Text(
//                     //             state.errorText ?? '',
//                     //             style: TextStyle(
//                     //               color: Theme.of(context).errorColor,
//                     //             ),
//                     //           ),
//                     //         ],
//                     //       );
//                     //     },
//                     //     validator: (val){
//                     //       if(date==null){
//                     //         return translate(context,'validation','date');
//                     //       }
//                     //       return null;
//                     //     },
//                     //   ),
//                     // ),
//                     SizedBox(height: h*.01,),
//                     Column(
//                       children: List.generate(_listFocus.length, (index) {
//                         return Column(
//                           children: [
//                             SizedBox(height: h*0.03,),
//                             if(index!=1)TextFormField(
//                               cursorColor: Colors.black,
//                               controller: _listEd[index],
//                               focusNode: _listFocus[index],
//                               textInputAction: index<_listEd.length-1?TextInputAction.next:TextInputAction.done,
//                               obscureText: index==6?_visibility:false,
//                               keyboardType: index==2?TextInputType.emailAddress:index==3||index==7?TextInputType.number:TextInputType.text,
//                               inputFormatters:index!=2?null:[
//                                 FilteringTextInputFormatter.allow(RegExp(r"[0-9 a-z  @ .]")),
//                               ],
//                               onEditingComplete: (){
//                                 _listFocus[index].unfocus();
//                                 if(index!=1){
//                                   if(index<_listEd.length-1){
//                                     FocusScope.of(context).requestFocus(_listFocus[index+1]);
//                                   }
//                                 }
//                               },
//                               validator: (value){
//                                 if (value!.isEmpty) {
//                                   return translate(context,'validation','field');
//                                 }
//                                 if(index==2){
//                                   if (value.length<4||!value.endsWith('.com')||'@'.allMatches(value).length!=1){
//                                     return translate(context,'validation','valid_email');
//                                   }
//                                 }
//                                 if(index==3){
//                                   if (!countryNumber.contains(value.length)){
//                                     return translate(context,'validation','phone');
//                                   }
//                                 }
//                                 if(index==6){
//                                   if (value.length<8) {
//                                     return translate(context,'validation','pass');
//                                   }
//                                 }
//                                 return null;
//                               },
//                               decoration: InputDecoration(
//                                 focusedBorder: form(),
//                                 enabledBorder: form(),
//                                 errorBorder: form(),
//                                 focusedErrorBorder: form(),
//                                 hintText: _hint[index],
//                                 hintStyle: TextStyle(color: Colors.grey[400]),
//                                 suffixIcon: index==6?IconButton(
//                                   icon: !_visibility?Icon(Icons.visibility,color: mainColor,):Icon(Icons.visibility_off,color: mainColor,),
//                                   onPressed: (){
//                                     setState(() {
//                                       _visibility=!_visibility;
//                                     });
//                                     if(!_listFocus[index].hasFocus){
//                                       _listFocus[index].unfocus();
//                                       _listFocus[index].canRequestFocus = false;
//                                     }
//                                   },
//                                 ):SizedBox(),
//                               ),
//                             ),
//                             if(index==1)Container(
//                               width: w*0.9,
//                               child: FormField(
//                                 builder: (state){
//                                   return Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         width: w*0.9,
//                                         height: h*0.09,
//                                         decoration: BoxDecoration(
//                                           border: Border.all(color: mainColor, width: 1.5),
//                                           borderRadius: BorderRadius.circular(15),
//                                         ),
//                                         child: Padding(
//                                           padding: EdgeInsets.symmetric(horizontal: w*0.02),
//                                           child: DateTimePicker(
//                                             type: DateTimePickerType.date,
//                                             decoration: InputDecoration(
//                                               border: InputBorder.none,
//                                               icon: Icon(Icons.event,color: mainColor,),
//                                             ),
//                                             dateMask: 'd MMM, yyyy',
//                                             locale: Provider.of<AppLanguage>(context,listen: false).appLocal,
//                                             initialValue: DateTime.now().toString(),
//                                             firstDate: DateTime(1940),
//                                             lastDate: DateTime(2022),
//                                             icon: Icon(Icons.event,color: mainColor,),
//                                             style: TextStyle(color: Colors.grey[400]),
//                                             dateLabelText: null,
//                                             // dateLabelText: translate(context,'inputs','day'),
//                                             selectableDayPredicate: (date) {
//                                               return true;
//                                             },
//                                             onChanged: (val) {
//                                               String year = val.split('-').first;
//                                               String month = val.split('-')[1];
//                                               String day = val.split('-')[2];
//                                               String fullDate = day+'-'+month+'-'+year;
//                                               setState(() {
//                                                 date = fullDate;
//                                               });
//                                             },
//                                             onSaved: (val) {
//                                               if(val!=null){
//                                                 String year = val.split('-').first;
//                                                 String month = val.split('-')[1];
//                                                 String day = val.split('-')[2];
//                                                 String fullDate = day+'-'+month+'-'+year;
//                                                 setState(() {
//                                                   date = fullDate;
//                                                 });
//                                               }
//                                             },
//                                           ),
//                                         ),
//                                       ),// your widget
//                                       SizedBox(height: h*0.01,),
//                                       if(state.errorText!=null)Text(
//                                         state.errorText ?? '',
//                                         style: TextStyle(
//                                           color: Theme.of(context).errorColor,
//                                         ),
//                                       ),
//                                     ],
//                                   );
//                                 },
//                                 validator: (val){
//                                   if(date==null){
//                                     return translate(context,'validation','date');
//                                   }
//                                   return null;
//                                 },
//                               ),
//                             ),
//                           ],
//                         );
//                       }),
//                     ),
//                     SizedBox(height: h*.04,),
//                     RoundedLoadingButton(
//                       child: Container(
//                         width: w*0.9,
//                         height: h*0.07,
//                         child: Center(child: Text(translate(context,'buttons','send'),style: TextStyle(color: Colors.white,fontSize: w*0.05),)),
//                       ),
//                       controller: _btnController,
//                       successColor: mainColor,
//                       color: mainColor,
//                       disabledColor: mainColor,
//                       errorColor: Colors.red,
//                       onPressed: ()async{
//                         FocusScope.of(context).requestFocus(new FocusNode());
//                         if (_formKey.currentState!.validate()){
//                           register();
//                         }else{
//                           _btnController.error();
//                           await Future.delayed(Duration(seconds: 2));
//                           _btnController.stop();
//                         }
//                       },
//                     ),
//                     SizedBox(height: h*.05,),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//   InputBorder form() {
//     return new OutlineInputBorder(
//         borderSide: BorderSide(color: mainColor, width: 1.5),
//         borderRadius: BorderRadius.circular(15),
//     );
//   }
// }
// void succSub(context){
//   showDialog(
//     context: context,
//     barrierDismissible: true,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(5.0)),
//         ),
//         title: Text('Your Request sent \n successfully',style: TextStyle(color: mainColor,fontSize: w*0.05),),
//         titlePadding: EdgeInsets.all(w*0.05),
//       );
//     },
//   ).then((value) {
//     navPop(context);
//   });
// }
//
