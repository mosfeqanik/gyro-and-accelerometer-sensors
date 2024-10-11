class ApiEndPoints {
  ApiEndPoints._();

  static const String LOGIN_URI = "/auth/login";
  static const String LOGOUT_URI = "/auth/logout";
  static const String AUTH_ME = "/auth/me";
  static const String GET_PRODUCT = "/representative/item/en/get-all";
  static const String GET_EMPLOYEE_DETAILS =
      "/representative/customer/get-by-attr";
  static const String GET_LOT_DETAILS = "/representative/item-lot/get-all";
  static const String CREATE_RMG_DISTRIBUTION =
      "/representative/rmg/distribution/create";
  static const String CREATE_UFPO_DISTRIBUTION =
      "/representative/ufpo/distribution/create";

  static String getAvailableQuantityFunc({String? orgType}) {
    return orgType == "ufpo"
        ? UFPO_GET_AVAILABLE_QUANTITY
        : RMG_GET_AVAILABLE_QUANTITY;
  }

  static String getDistrubutionQuantityFunc({String? orgType}) {
    return orgType == "ufpo"
        ? UFPO_GET_DISTRIBUTION_QUANTITY
        : RMG_GET_DISTRIBUTION_QUANTITY;
  }

  static const String UFPO_GET_AVAILABLE_QUANTITY =
      "/representative/ufpo/item-available-quantity";
  static const String RMG_GET_AVAILABLE_QUANTITY =
      "/representative/rmg/item-available-quantity";
  static const String UFPO_GET_DISTRIBUTION_QUANTITY =
      "/representative/ufpo/item-distribution-quantity";
  static const String POST_CREATE_INVENTORY =
      "/representative/ufpo/inventory/create";
  static const String RMG_GET_DISTRIBUTION_QUANTITY =
      "/representative/rmg/item-distribution-quantity";
}
