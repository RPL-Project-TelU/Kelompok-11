// Signatures
sig Node{
	left : Node,
	right : Node,
	data : Login
}

sig DiscoveryPage {
	itemName: String,
	Discovery : Discovery
}

sig Product {
	itemID: String,
	price : Int
}

sig Batu extends Product {
	satuanM3 : Int
}

sig Besi extends Product {
	satuanPanjang : Int
}

sig Semen extends Product {
	perSak : Int
}

sig Discovery {
	lsProduct: seq Product
}

sig Login {
	username : String,
	password : String,
	email : String,
	phoneNumber : String,
	DiscPage : one DiscoveryPage
}

pred ShowAll {}

run ShowAll for 5
