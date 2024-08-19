import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../business/saved_data/cache_helper.dart';
import '../model/order_main_model.dart';
import '../model/order_model.dart';
import '../repo/order_repo.dart';
import 'general_state.dart';
import 'dart:convert';
import 'dart:io';

class GeneralCubit extends Cubit<GeneralState> {
  GeneralCubit() : super(InitialGeneralState());

  final OrderDataRepo repo = OrderDataRepo();
  Object? selectOrder = 0;
  bool oneTime = false;
  bool showTextview = false;
  bool showTextviewReceived = false;
  int selectIndexOfOrder = 1;
  String imagePath = "";
  List<Order> DeliveredData = [];
  List<Order> OrderData = [];
  List<OrdersMain> DeliveryBoyData = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> checkPermissionCamera(String statusVal, int orderId, String? notes) async {
    final permission = Permission.camera;
    if (await permission.isDenied) {
      final result = await permission.request();
      if (result.isGranted) {
        openCamera(statusVal, orderId, notes);
        // Permission is granted
      } else if (result.isDenied) {
        // Permission is denied
      } else if (result.isPermanentlyDenied) {
        // Permission is permanently denied
      }
    } else {
      final result = await permission.request();
      if (result.isGranted) {
        openCamera(statusVal, orderId, notes);
        // Permission is granted
      }
    }
  }

  Future<void> openCamera(String statusVal, int orderId, String? notes) async {
    final status = await Permission.camera.status;
    if (status.isGranted) {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        imagePath = image.path;
        if(statusVal == "completed"){
          showTextviewReceived = true;
        } else {
          showTextview = true;
        }
      //  handleImageUpload(statusVal, image.path, orderId, notes);
        }
      } else {
      // Handle permission denied
    }
  }

  Future<void> uploadImage(String statusVal, int orderId, String? notes) async{
    handleImageUpload(statusVal, imagePath, orderId, notes);
  }

  Future<String> compressAndConvertImageToBase64(String imagePath) async {
    // Compress the image
    final compressedImage = await FlutterImageCompress.compressWithFile(
      imagePath,
      minWidth: 800,  // Adjust as needed
      minHeight: 600, // Adjust as needed
      quality: 85,    // Quality between 0 and 100
    );

    if (compressedImage == null) {
      throw Exception("Image compression failed");
    }

    // Convert the compressed image to base64
    return base64Encode(compressedImage);
  }

  Future<void> handleImageUpload(String status, String orderImage, int orderId, String? notes) async {
    bool success = await sendOrderImage(status, orderImage, orderId, notes);
    if (success) {
      print('Image uploaded successfully');
    } else {
      print('Failed to upload image');
    }
  }

  selectOrderFunc(Object item, int index) {
    emit(LoadingOrderState());
    oneTime = true;
    selectOrder = item;
    selectIndexOfOrder = index;
    emit(SuccessOrderLoaded());
  }

  handelShowTextview(){
    emit(LoadingOrderState());
    showTextview = !showTextview;
    emit(SuccessOrderLoaded());
  }

  handelShowTextviewReceived(){
    emit(LoadingOrderState());
    showTextviewReceived = !showTextviewReceived;
    emit(SuccessOrderLoaded());
  }

  Future<GeneralOrderData> fetchOrderData(BuildContext context, String phoneNumber) async {
  //  Loader.start(); // Start the loader here
    try {
      final response = await fetchOrderDataFromApi(context, phoneNumber);
   //   Loader.stop(context); // Stop the loader after fetching data
      return GeneralOrderData(response);
    } catch (e) {
     // Loader.stop(context); // Stop the loader in case of an error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to fetch orders, please try again.")),
      );
      rethrow; // Optionally rethrow the error if needed
    }
  }


  Future <List<OrdersMain>> fetchOrderDataFromApi(BuildContext context, String phone) async {
    bool result = false;
    emit(LoadingOrderState());
    DeliveredData.clear();
    OrderData.clear();
    List<OrdersMain> data = await repo.getOrderData(context, phone);
    data = data.reversed.toList();
    try {
      for(int i = 0; i < data[0].orders.length; i++){
        if(data[0].orders.isNotEmpty){
          if(data[0].orders[i].status != "pending"){
            data[0].orders[i].orderDeliveredData.add(data[0].orders[i]);
            DeliveredData.add(data[0].orders[i]);
        } else if(data[0].orders[i].status == "pending"){
            data[0].orders[i].orderData.add(data[0].orders[i]);
            OrderData.add(data[0].orders[i]);
          }
          DeliveryBoyData.add(data[0]);
        }
      }
      emit(GeneralOrderData(data));
      if(data != null){
        result = true;
     //   Loader.stop(context);
        savePhoneNumber(phone);
        emit(SuccessOrderLoaded());
        return data;
      } else {
      //  Loader.stop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(" من فضلك ادخل رقم الهاتف المسجل بشكل صحيح"),
            ));
        emit(ErrorOrderLoaded());
        return data;
      }
    } catch (e) {
  //    Loader.stop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(" من فضلك ادخل رقم الهاتف المسجل بشكل صحيح"),
          ));
      emit(ErrorOrderLoaded());
      return [];
    }
  }


  Future<bool> sendOrderStatus(String status, int orderId, String? notes) async {
    emit(LoadingOrderState());
    String phone = CacheHelper.getData(key: "phone");
    try {
      await repo.sendOrderStatus(status, orderId,
          notes, phone);
      emit(SuccessOrderDeliveryLoaded());
      return true;
    } on DioError catch (e) {
      print(e);
      print(e.error);
      print(e.message);
      emit(ErrorOrderLoaded());
      return false;
    }
  }

  Future<bool> sendOrderImage(String status, String imagePath, int orderId, String? notes) async {
    emit(LoadingOrderState());

    // Convert image to Base64
    String base64Image = await compressAndConvertImageToBase64(imagePath);

    String phone = CacheHelper.getData(key: "phone");
    try {
      await repo.sendOrderImage("image", base64Image, orderId, "", phone);
      emit(SuccessOrderDeliveryLoaded());
      return true;
    } on DioError catch (e) {
      print(e);
      print(e.error);
      print(e.message);
      emit(ErrorOrderLoaded());
      return false;
    }
  }


  savePhoneNumber(String phone) {
    emit(LoadingOrderState());
      CacheHelper.saveData(key: "phone", value: phone);
      emit(SuccessOrderLoaded());
  }

  Future<void> refreshData(BuildContext context) async {
    emit(LoadingOrderState()); // Add a loading state
    await Future.delayed(Duration(seconds: 2));
    fetchOrderData(context, CacheHelper.getData(key: "phone"));
    emit(SuccessOrderLoaded());
  }

  void makePhoneCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}