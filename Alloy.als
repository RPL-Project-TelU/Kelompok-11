open util/ordering[Product]

sig Login {
  username: String,
  password: String,
  email: String,
  phoneNumber: String,
  discPage: DiscoveryPage
}

sig DiscoveryPage {
  itemName: String,
  discovery: Discovery
}

sig Discovery {
  isProduct: Product -> lone Product
}

sig Product {
  itemID: String,
  price: Int
}

sig Batu {
  satuanM3: Int
} {
  all p: Product | p in Discovery.isProduct[this] implies p in this
}

sig Besi {
  panjang: Int
} {
  all p: Product | p in Discovery.isProduct[this] implies p in this
}

sig Semen {
  perSak: Int
} {
  all p: Product | p in Discovery.isProduct[this] implies p in this
}

-- Associations
fact LoginAssociations {
  all l: Login, dp: DiscoveryPage | l.discPage = dp
}

fact DiscoveryPageAssociations {
  all dp: DiscoveryPage, d: Discovery | dp.discovery = d
}

fact DiscoveryAssociations {
  all d: Discovery, p: Product | p in d.isProduct
}

-- Operations/Methods
pred checkSession[l: Login] {
  // Implementation of checkSession method
  1.sessionStatus = "active"
}

pred search[dp: DiscoveryPage, itemNameToSearch : String] {
  // Implementation of search method
  some p: Product | p in dp.discovery.isProduct and p.itemName = itemNameToSearch
}

pred productInfo[p: Product] {
  // Implementation of productInfo method
  p in this.isProduct
}

pred getPrice[b: Batu, p: Product] {
  // Implementation of getPrice method for Batu
  p in b.isProduct
  harga batu per meter kubik * volume product
  let volume = p.price / b.satuanM3
  volume > 0;
}

pred getPrice[b: Besi, p: Product] {
  // Implementation of getPrice method for Besi
  p in b.isProduct
  harga besi per meter * panjang product
  let totalPrice = b.panjang * p.price
  totalPrice > 0
}

pred getPrice[s: Semen, p: Product] {
  // Implementation of getPrice method for Semen
  p in b.isProduct
  harga semen per sak * jumlah sak product
  let totalPrice = s.perSak * p.price
  totalPrice > 0
}

run {} for 5 but 4 Product, 3 Batu, 3 Besi, 3 Semen
