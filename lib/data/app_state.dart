// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:scoped_model/scoped_model.dart';
import 'package:arrival_kc/data/partners.dart';
import 'package:arrival_kc/data/link.dart';

class AppState extends Model {
  List<Business> get allBusinesses => List<Business>.from(ArrivalData.partners);

  Business getBusiness(int id) => ArrivalData.partners.singleWhere((v) => v.id == id);

  List<Business> get availableBusinesses {
    return ArrivalData.partners.where((v) => v.isOpen()).toList();
  }

  List<Business> get unavailableBusinesses {
    return ArrivalData.partners.where((v) => !v.isOpen()).toList();
  }

  List<Business> get favoriteBusinesses =>
      ArrivalData.partners.where((v) => v.isFavorite).toList();

  List<Business> searchBusinesses(String terms) => ArrivalData.partners
      .where((v) => v.name.toLowerCase().contains(terms.toLowerCase()))
      .toList();

  void setFavorite(int id, bool isFavorite) {
    var business = getBusiness(id);
    business.isFavorite = isFavorite;
    notifyListeners();
  }

  static Season _getSeasonForDate(DateTime date) {
    // Technically the start and end dates of seasons can vary by a day or so,
    // but this is close enough for produce.
    switch (date.month) {
      case 1:
        return Season.winter;
      case 2:
        return Season.winter;
      case 3:
        return date.day < 21 ? Season.winter : Season.spring;
      case 4:
        return Season.spring;
      case 5:
        return Season.spring;
      case 6:
        return date.day < 21 ? Season.spring : Season.summer;
      case 7:
        return Season.summer;
      case 8:
        return Season.summer;
      case 9:
        return date.day < 22 ? Season.autumn : Season.winter;
      case 10:
        return Season.autumn;
      case 11:
        return Season.autumn;
      case 12:
        return date.day < 22 ? Season.autumn : Season.winter;
      default:
        throw ArgumentError('Can\'t return a season for month #${date.month}.');
    }
  }
}
