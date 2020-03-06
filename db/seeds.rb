Company.create(id: 1, name: "Super Cleanerz")
Company.create(id: 2, name: "Keep it Kleen Karpet Kleeners")
Company.create(id: 3, name: "ShingSparkleSprakle Floor Care")

Admin.create(username: "iClean", email: "cleancleanclean@clean.com", password: "superclean", company_id: 1)
Admin.create(username: "KingofKleen", email: "admin@carpetsrus.com", password: "password", company_id: 2)
Admin.create(username: "SparkleMan", email: "floorguy@cleaner.com", password: "12345678", company_id: 3)


Employee.create(id: 1, username: "AwesomeJanitor", email: "cleaningrocks@clean.com", password: "iluvtoclean", company_id: 1)
Employee.create(id: 2, username: "carpetking", email: "carpetcleaner@carpetsrus.com", password: "freshFiberz", company_id: 2)
Employee.create(id: 3, username: "ShinyFloorzz", email: "floormaster@cleaner.com", password: "sparkleSparkle", company_id: 3)

Product.create(name: "Orange Blossom", price: "10.99", quantity: "6", company_id: 1)
Product.create(name: "Perox-a-Peel", price: "11.50", quantity: "3", company_id: 1)
Product.create(name: "Spray Away", price: "13.00", quantity: "4", company_id: 1)
Product.create(name: "Creme Cote", price: "15.99", quantity: "1", company_id: 1)
Product.create(name: "Paneless", price: "14.00", quantity: "3", company_id: 1)

Product.create(name: "MaxPack", price: "32.00", quantity: "4", company_id: 2)
Product.create(name: "pHiber Guard TLC", price: "29.99", quantity: "2", company_id: 2)
Product.create(name: "Formula 'O'", price: "34.99", quantity: "3", company_id: 2)
Product.create(name: "pHiber Guard Rinse", price: "24.99", quantity: "6", company_id: 2)
Product.create(name: "Formula 'D'", price: "31.00", quantity: "1", company_id: 2)

Product.create(name: "Orange Blossom", price: "10.99", quantity: "10", company_id: 3)
Product.create(name: "Creme Cote", price: "15.99", quantity: "12", company_id: 3)
Product.create(name: "Pex-o-mite", price: "34.99", quantity: "8", company_id: 3)
Product.create(name: "Defiant", price: "31.99", quantity: "16", company_id: 3)
Product.create(name: "Rock Candy", price: "31.99", quantity: "8", company_id: 3)
Product.create(name: "Black 13\" Pad", price: "4.99", quantity: "20", company_id: 3)
Product.create(name: "Blue 13\" Pad", price: "4.99", quantity: "20", company_id: 3)
