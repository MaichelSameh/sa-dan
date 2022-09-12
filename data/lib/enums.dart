enum SocialAuthMethod { facebook, apple, google }

enum UserType { customer, serviceOwner, admin }

enum SexType { men, women, unisex, none }

enum ProductVariationType {
  color,
  classification,
  colorAndClassification,
  none
}

enum ProductSorting {
  priceLow,
  priceHigh,
  mostPopular,
  mostRecent,
}

enum Stock { inStock, outOffStock }

enum AddressType { home, work, mosque }

enum OrderStatus { orderIsDelivered, orderIsCancelled, orderNotApprovedYet }

enum CartAction { increase, decrease }

enum PaymentMethod { tap, cash }

enum BannerActionType { productPage, categoryPage }
