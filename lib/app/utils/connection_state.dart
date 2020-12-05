import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class CheckConnection {
  static Future<bool> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (e) {
      throw PlatformException(
        message: 'Sem conexão com a internet',
        code: 'error_connection',
        details: e.toString(),
      );
    } on TimeoutException catch (e) {
      throw PlatformException(
        message: 'Problemas na conexão',
        code: 'error_connection',
        details: e.toString(),
      );
    } catch (e) {
      throw PlatformException(
        message: 'Problemas na conexão',
        code: 'error_connection',
        details: e.toString(),
      );
    }
    return false;
  }
}
