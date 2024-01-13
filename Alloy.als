sig Login {
  username: String,
  password: String,
  email: String,
  phoneNumber: String,
  discPage: DiscoveryPage
}

sig DiscoveryPage {
 itemName: String,
 discovery: Discovery,
 sessionStatus: String
}

sig Discovery {
 listProduct: some Product
}

sig Product {
 itemID: String,
 price: Int
}

sig Batu extends Product {
 satuanM3: Int
}

sig Besi extends Product{
 panjang: Int
}

sig Semen extends Product {
 perSak: Int
}

pred checkSession[l: Login] {
 // Implementation of the checkSession method
 l.discPage.sessionStatus = "active"
}

pred search[dp: DiscoveryPage, itemNameToSearch: String] {
 // Implementation of the search method
 some p: Product | p in dp.discovery.listProduct and dp.itemName = itemNameToSearch
}

pred productInfo[p: Product] {
 // Implementation of the productInfo method
 p in Discovery.listProduct
}

pred getPriceBatu[b: Batu, p: Product] {
 // Implementation of the getPrice method for Batu
 p in Discovery.listProduct =>
    let totalPrice = mul[b.satuanM3, p.price] |
      totalPrice > 0
}

pred getPriceBesi[b: Besi, p: Product] {
 // Implementation of the getPrice method for Besi
 p in Discovery.listProduct =>
    let totalPrice = mul[b.panjang,p.price] |
      totalPrice > 0
}

pred getPriceSemen[s: Semen, p: Product] {
 // Implementation of the getPrice method for Semen
 p in Discovery.listProduct =>
    let totalPrice = mul[s.perSak,p.price] |
      totalPrice > 0
}

pred show {
 all l: Login, dp: DiscoveryPage |
    checkSession[l] and search[dp, dp.itemName]
}

fact {
 one login: Login, dp: DiscoveryPage |
    login.discPage = dp and
    dp.sessionStatus = "active"
}

assert AssertionCheckSessionActive {
 all l: Login, dp: DiscoveryPage |
   checkSession[l] and search[dp, dp.itemName]
}

run show for 5 but 4 Product, 3 Batu, 3 Besi, 3 Semen

check AssertionCheckSessionActive


