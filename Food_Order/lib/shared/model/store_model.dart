import 'package:google_maps_flutter/google_maps_flutter.dart';

class Store {
  String name;
  String address;
  String description;
  String thumbNail;
  LatLng locationCoords;
  Store(
      {this.name,
      this.address,
      this.description,
      this.thumbNail,
      this.locationCoords});
}

final List<Store> coffeeShops = [
  Store(
      name: 'Stumptown Coffee Roasters',
      address: 'KTX khu A',
      description:
          'Coffee bar chain offering house-roasted direct-trade coffee, along with brewing gear & whole beans',
      locationCoords: LatLng(10.8782661, 106.8040605),
      thumbNail:
          'https://lh5.googleusercontent.com/p/AF1QipNNzoa4RVMeOisc0vQ5m3Z7aKet5353lu0Aah0a=w90-h90-n-k-no'),
  Store(
      name: 'Andrews Coffee Shop',
      address: 'KTX khu B',
      description:
          'All-day American comfort eats in a basic diner-style setting',
      locationCoords: LatLng(10.8836065, 106.7793254),
      thumbNail:
          'https://lh5.googleusercontent.com/p/AF1QipOfv3DSTkjsgvwCsUe_flDr4DBXneEVR1hWQCvR=w90-h90-n-k-no'),
  Store(
      name: 'Third Rail Coffee',
      address: 'UIT',
      description:
          'Small spot draws serious caffeine lovers with wide selection of brews & baked goods.',
      locationCoords: LatLng(10.8699237, 106.8016194),
      thumbNail:
          'https://lh5.googleusercontent.com/p/AF1QipPGoxAP7eK6C44vSIx4SdhXdp78qiZz2qKp8-o1=w90-h90-n-k-no'),
  Store(
      name: 'Hi-Collar',
      address: 'USSH',
      description:
          'Snazzy, compact Japanese cafe showcasing high-end coffee & sandwiches, plus sake & beer at night.',
      locationCoords: LatLng(10.7859898, 106.7011475),
      thumbNail:
          'https://lh5.googleusercontent.com/p/AF1QipNhygtMc1wNzN4n6txZLzIhgJ-QZ044R4axyFZX=w90-h90-n-k-no'),
  Store(
      name: 'Everyman Espresso',
      address: 'BKU',
      description:
          'Compact coffee & espresso bar turning out drinks made from direct-trade beans in a low-key setting.',
      locationCoords: LatLng(10.7733796, 106.6584306),
      thumbNail:
          'https://lh5.googleusercontent.com/p/AF1QipOMNvnrTlesBJwUcVVFBqVF-KnMVlJMi7_uU6lZ=w90-h90-n-k-no')
];
