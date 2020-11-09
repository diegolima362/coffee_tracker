import 'package:coffee_tracker/app/shared/models/restaurant_model.dart';
import 'package:coffee_tracker/app/shared/models/review_model.dart';
import 'package:mobx/mobx.dart';

import 'local_storage_interface.dart';

class LocalStorageMock implements ILocalStorage {
  @observable
  bool isDark = true;

  @override
  Future<bool> get isDarkMode async => isDark;

  @override
  Future<void> setDarkMode(bool isDark) async => this.isDark = isDark;

  @override
  Future<List<RestaurantModel>> getAllRestaurants() async {
    return _restaurants.map((i) => RestaurantModel.fromJson(i)).toList();
  }

  @override
  Future<List<ReviewModel>> getAllReviews() async {
    return _reviews.map((i) => ReviewModel.fromJson(i)).toList();
  }

  final _restaurants = [
    {
      "id": 1,
      "name": "Emporio Kaveh Kanes",
      "rate": 4.5,
      "address": "Av Sete de Setembro 1865",
      "city": "Curitiba",
      "state": "PR",
      "photoURL": "https://picsum.photos/300/300",
      "openDays": "ter - dom"
    },
    {
      "id": 2,
      "name": "Cafeteria Elisee",
      "rate": 4.0,
      "address": "Av das Americas 3255, Tijuca",
      "city": "Rio de Janeiro",
      "state": "RJ",
      "photoURL": "https://picsum.photos/300/300",
      "openDays": "seg - dom"
    },
    {
      "id": 3,
      "name": "Cafeteria Bauducco",
      "rate": 4.0,
      "address": "AL Lorena 1682 Cerqueira Cesar",
      "city": "São Paulo",
      "state": "SP",
      "photoURL": "https://picsum.photos/300/300",
      "openDays": "seg - dom"
    },
    {
      "id": 4,
      "name": "Castigliani Cafés Especiais",
      "rate": 4.0,
      "address": "ESTR do Encanamento 323 Loja 3",
      "city": "Recife",
      "state": "PE",
      "photoURL": "https://picsum.photos/300/300",
      "openDays": "ter - dom"
    },
    {
      "id": 5,
      "name": "Malakoff Cafe",
      "rate": 4.5,
      "address": "AV Abdias de Carvalho, 1142",
      "city": "Recife",
      "state": "PE",
      "photoURL": "https://picsum.photos/300/300",
      "openDays": "seg - sab"
    },
    {
      "id": 6,
      "name": "Emporio Do Grao",
      "rate": 4.0,
      "address": "AV Governador Flavio Ribeiro Coutinho 115 Manaira",
      "city": "João Pessoa",
      "state": "PB",
      "photoURL": "https://picsum.photos/300/300",
      "openDays": "seg - sab"
    },
    {
      "id": 7,
      "name": "Sao Braz Coffee Shop",
      "rate": 4.0,
      "address": "R Maria Carolina 315 Boa Viagem",
      "city": "Recife",
      "state": "PE",
      "photoURL": "https://picsum.photos/300/300",
      "openDays": "seg - dom"
    },
    {
      "id": 8,
      "name": "Tia Fatite",
      "rate": 4.5,
      "address": "R Duque de Caxias 630 Alto Branco",
      "city": "Campina Grande",
      "state": "PB",
      "photoURL": "https://picsum.photos/300/300",
      "openDays": "seg - sab"
    },
    {
      "id": 9,
      "name": "Ristretto Cafeteria & Doceria",
      "rate": 4.5,
      "address": "R Joao Cancio Numero 969",
      "city": "João Pessoa",
      "state": "PB",
      "photoURL": "https://picsum.photos/300/300",
      "openDays": "ter - qui"
    },
    {
      "id": 10,
      "name": "Havanna",
      "rate": 4.0,
      "address": "R Nossa Sra. dos Navegantes",
      "city": "João Pessoa",
      "state": "PB",
      "photoURL": "https://picsum.photos/300/300",
      "openDays": "seg - dom"
    }
  ];

  final _reviews = [
    {
      "restaurantName": "Emporio Kaveh Kanes",
      "restaurantId": 1,
      "rate": 3.5,
      "visitDate": "06/19/2020",
      "reviewDate": "10/17/2020",
      "text": "in consequat ut nulla sed accumsan felis ut at dolor"
    },
    {
      "restaurantName": "Cafeteria Elisee",
      "restaurantId": 2,
      "rate": 4.9,
      "visitDate": "12/24/2019",
      "reviewDate": "10/06/2020",
      "text":
          "platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum"
    },
    {
      "restaurantName": "Cafeteria Bauducco",
      "restaurantId": 3,
      "rate": 3.3,
      "visitDate": "10/30/2020",
      "reviewDate": "11/18/2019",
      "text":
          "placerat praesent blandit nam nulla integer pede justo lacinia eget"
    },
    {
      "restaurantName": "Castigliani Cafés Especiais",
      "restaurantId": 4,
      "rate": 4.4,
      "visitDate": "12/12/2019",
      "reviewDate": "05/09/2020",
      "text":
          "at vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut"
    },
    {
      "restaurantName": "Malakoff Cafe",
      "restaurantId": 5,
      "rate": 4.5,
      "visitDate": "06/16/2020",
      "reviewDate": "12/27/2019",
      "text": "eu massa donec dapibus duis at velit eu est congue elementum in"
    },
    {
      "restaurantName": "Emporio Do Grao",
      "restaurantId": 6,
      "rate": 4.5,
      "visitDate": "04/14/2020",
      "reviewDate": "12/25/2019",
      "text":
          "ligula suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus sit amet sem fusce consequat"
    },
    {
      "restaurantName": "Sao Braz Coffee Shop",
      "restaurantId": 7,
      "rate": 4.2,
      "visitDate": "07/24/2020",
      "reviewDate": "07/17/2020",
      "text":
          "lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis"
    },
    {
      "restaurantName": "Tia Fatite",
      "restaurantId": 8,
      "rate": 4.8,
      "visitDate": "04/27/2020",
      "reviewDate": "06/12/2020",
      "text":
          "ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue"
    },
    {
      "restaurantName": "Ristretto Cafeteria & Doceria",
      "restaurantId": 9,
      "rate": 3.9,
      "visitDate": "07/24/2020",
      "reviewDate": "09/28/2020",
      "text":
          "curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu"
    },
    {
      "restaurantName": "Havanna",
      "restaurantId": 10,
      "rate": 4.1,
      "visitDate": "01/09/2020",
      "reviewDate": "05/22/2020",
      "text":
          "interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit"
    },
    {
      "restaurantName": "Sao Braz Coffee Shop",
      "restaurantId": 7,
      "rate": 3.6,
      "visitDate": "11/15/2019",
      "reviewDate": "03/04/2020",
      "text":
          "turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh"
    },
    {
      "restaurantName": "Ristretto Cafeteria & Doceria",
      "restaurantId": 9,
      "rate": 4.9,
      "visitDate": "08/03/2020",
      "reviewDate": "01/13/2020",
      "text":
          "venenatis lacinia aenean sit amet justo morbi ut odio cras mi pede malesuada"
    },
    {
      "restaurantName": "Cafeteria Elisee",
      "restaurantId": 2,
      "rate": 5.0,
      "visitDate": "06/02/2020",
      "reviewDate": "06/04/2020",
      "text":
          "vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia"
    },
    {
      "restaurantName": "Castigliani Cafés Especiais",
      "restaurantId": 4,
      "rate": 3.8,
      "visitDate": "11/22/2019",
      "reviewDate": "09/24/2020",
      "text":
          "quisque id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et"
    },
    {
      "restaurantName": "Emporio Kaveh Kanes",
      "restaurantId": 1,
      "rate": 4.5,
      "visitDate": "10/30/2020",
      "reviewDate": "05/10/2020",
      "text":
          "lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque"
    },
    {
      "restaurantName": "Cafeteria Bauducco",
      "restaurantId": 3,
      "rate": 4.9,
      "visitDate": "05/28/2020",
      "reviewDate": "06/23/2020",
      "text":
          "nulla suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus"
    },
    {
      "restaurantName": "Ristretto Cafeteria & Doceria",
      "restaurantId": 9,
      "rate": 4.4,
      "visitDate": "04/09/2020",
      "reviewDate": "11/03/2020",
      "text":
          "massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus"
    },
    {
      "restaurantName": "Ristretto Cafeteria & Doceria",
      "restaurantId": 9,
      "rate": 3.6,
      "visitDate": "02/28/2020",
      "reviewDate": "03/07/2020",
      "text":
          "quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt"
    },
    {
      "restaurantName": "Sao Braz Coffee Shop",
      "restaurantId": 7,
      "rate": 4.8,
      "visitDate": "09/15/2020",
      "reviewDate": "04/03/2020",
      "text":
          "diam vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere"
    },
    {
      "restaurantName": "Cafeteria Bauducco",
      "restaurantId": 3,
      "rate": 3.5,
      "visitDate": "10/25/2020",
      "reviewDate": "01/10/2020",
      "text":
          "phasellus sit amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim in"
    }
  ];
}
