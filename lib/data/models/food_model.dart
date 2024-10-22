// class FoodNutrient {
//   String nutrientName;
//   String unitName;
//   String derivationDescription;
//   double value;

//   FoodNutrient({
//     required this.nutrientName,
//     required this.unitName,
//     required this.derivationDescription,
//     required this.value,
  
//   });

//   factory FoodNutrient.fromJson(Map<String, dynamic> json) {
//     return FoodNutrient(
//       nutrientName: json['nutrientName'],
//       unitName: json['unitName'],
//       derivationDescription: json['derivationDescription'],
//       value: json['value'].toDouble(),
      
//     );
//   }

  
// }

// class FoodItem {
//   int fdcId;
//   String description;
//   String dataType;
//   String gtinUpc;
//   String publishedDate;
//   String brandOwner;
//   String brandName;
//   String ingredients;
//   String marketCountry;
//   String foodCategory;
//   String modifiedDate;
//   String dataSource;
//   String packageWeight;
//   String servingSizeUnit;
//   double servingSize;
//   String householdServingFullText;
//   List<FoodNutrient> foodNutrients;

//   FoodItem({
//     required this.fdcId,
//     required this.description,
//     required this.dataType,
//     required this.gtinUpc,
//     required this.publishedDate,
//     required this.brandOwner,
//     required this.brandName,
//     required this.ingredients,
//     required this.marketCountry,
//     required this.foodCategory,
//     required this.modifiedDate,
//     required this.dataSource,
//     required this.packageWeight,
//     required this.servingSizeUnit,
//     required this.servingSize,
//     required this.householdServingFullText,
//     required this.foodNutrients,
//   });

//   factory FoodItem.fromJson(Map<String, dynamic> json) {
//     return FoodItem(
//       fdcId: json['fdcId'],
//       description: json['description'],
//       dataType: json['dataType'],
//       gtinUpc: json['gtinUpc'],
//       publishedDate: json['publishedDate'],
//       brandOwner: json['brandOwner'],
//       brandName: json['brandName'],
//       ingredients: json['ingredients'],
//       marketCountry: json['marketCountry'],
//       foodCategory: json['foodCategory'],
//       modifiedDate: json['modifiedDate'],
//       dataSource: json['dataSource'],
//       packageWeight: json['packageWeight'],
//       servingSizeUnit: json['servingSizeUnit'],
//       servingSize: json['servingSize'].toDouble(),
//       householdServingFullText: json['householdServingFullText'],
//       foodNutrients: (json['foodNutrients'] as List)
//           .map((i) => FoodNutrient.fromJson(i))
//           .toList(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'fdcId': fdcId,
//       'description': description,
//       'dataType': dataType,
//       'gtinUpc': gtinUpc,
//       'publishedDate': publishedDate,
//       'brandOwner': brandOwner,
//       'brandName': brandName,
//       'ingredients': ingredients,
//       'marketCountry': marketCountry,
//       'foodCategory': foodCategory,
//       'modifiedDate': modifiedDate,
//       'dataSource': dataSource,
//       'packageWeight': packageWeight,
//       'servingSizeUnit': servingSizeUnit,
//       'servingSize': servingSize,
//       'householdServingFullText': householdServingFullText,
//       'foodNutrients': foodNutrients.map((i) => i.toJson()).toList(),
//     };
//   }

//   // Method to fetch specific nutrients
 
// }


