class Orders {
  String? sId;
  User? user;
  Checkout? checkout;
  Payment? payment;
  String? trackingNumber;
  List<Foods>? foods;
  String? status;
  String? note;
  String? createdAt;
  String? updatedAt;
  String? distance;
  String? phoneNumber;
  int? iV;
  String? shippingAddress;

  Orders(
      {this.sId,
        this.user,
        this.checkout,
        this.phoneNumber,
        this.payment,
        this.trackingNumber,
        this.foods,
        this.note,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.distance,
        this.iV,
        this.shippingAddress});

  Orders.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'] != null
        ? User.fromJson(json['user'])
        : null;
    checkout = json['checkout'] != null
        ? Checkout.fromJson(json['checkout'])
        : null;
    payment =
    json['payment'] != null ? Payment.fromJson(json['payment']) : null;
    trackingNumber = json['trackingNumber'];
    distance = json['distance'];
    phoneNumber = json['phone'];
    note = json['note'];
    if (json['foods'] != null) {
      foods = <Foods>[];
      json['foods'].forEach((v) {
        foods!.add(Foods.fromJson(v));
      });
    }
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    shippingAddress = json['shipping_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (checkout != null) {
      data['checkout'] = checkout!.toJson();
    }
    if (payment != null) {
      data['payment'] = payment!.toJson();
    }
    data['trackingNumber'] = trackingNumber;
    data['note'] = note;
    data['distance'] = distance;
    if (foods != null) {
      data['foods'] = foods!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['phone'] = phoneNumber;
    data['__v'] = iV;
    data['shipping_address'] = shippingAddress;
    return data;
  }
}

class Checkout {
  int? totalPrice;
  int? totalApplyDiscount;
  int? feeShip;
  int? total;
  String? sId;

  Checkout({this.totalPrice, this.totalApplyDiscount, this.feeShip, this.sId, this.total});

  Checkout.fromJson(Map<String, dynamic> json) {
    totalPrice = json['totalPrice'];
    totalApplyDiscount = json['totalApplyDiscount'];
    feeShip = json['feeShip'];
    sId = json['_id'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalPrice'] = totalPrice;
    data['totalApplyDiscount'] = totalApplyDiscount;
    data['feeShip'] = feeShip;
    data['_id'] = sId;
    data['total'] = total;
    return data;
  }
}

class User{
  String? userId;
  String? userName;
  String? avt;

  User({this.userId, this.userName});

  User.fromJson(Map<String, dynamic> json){
    userId = json['_id'];
    userName = json['name'];
    avt = json['avatar'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = userId;
    data['name'] = userName;
    data['avatar'] = avt;
    return data;
  }
}

class Payment {
  String? method;

  Payment({this.method});

  Payment.fromJson(Map<String, dynamic> json) {
    method = json['method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['method'] = method;
    return data;
  }
}

class Foods {
  FoodOfOrder? food;
  int? quantity;
  String? sId;

  Foods({this.food, this.quantity, this.sId});

  Foods.fromJson(Map<String, dynamic> json) {
    food = json['food'] != null ? FoodOfOrder.fromJson(json['food']) : null;
    quantity = json['quantity'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['food'] = food?.toJson();
    data['quantity'] = quantity;
    data['_id'] = sId;
    return data;
  }
}

class FoodOfOrder{
  String? id;
  String? name;
  String? rating;

  FoodOfOrder({this.id, this.name, this.rating});

  FoodOfOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['rating'] = rating;
    return data;
  }
}