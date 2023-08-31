enum ToWichPage { popularFoodPage, recommendedFoodPage, productHistory }

ToWichPage? stringToToWichPage(String theEnum) {
  switch (theEnum) {
    case 'ToWichPage.popularFoodPage':
      return ToWichPage.popularFoodPage;
    case 'ToWichPage.recommendedFoodPage':
      return ToWichPage.recommendedFoodPage;
    case 'ToWichPage.productHistory':
      return ToWichPage.productHistory;
    default:
      ArgumentError('an invalid enum is provided $theEnum');
  }
  return null;
}
