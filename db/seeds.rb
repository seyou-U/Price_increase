require 'csv'

file_path = 'lib/Price_increase_list_products.csv'
products_date = CSV.read(file_path)

Genre.create(id: 1, name: "食料品(即席麺)")
Genre.create(id: 2, name: "食料品(小麦・パン)")
Genre.create(id: 3, name: "食料品(食用油)")
Genre.create(id: 4, name: "食料品(冷食、レトルト食品)")
Genre.create(id: 5, name: "食料品(加工肉)")
Genre.create(id: 6, name: "食料品(調味料)")
Genre.create(id: 7, name: "食料品(乳製品)")
Genre.create(id: 8, name: "食料品(飲料)")
Genre.create(id: 9, name: "飲食・コンビニ")
Genre.create(id: 10, name: "日用品")

products_date.each do |product|
  Product.create(
    name: product[0],
    high_price: product[1],
    explanation: product[2],
    quote: product[4],
    genre_id: product[5],
    image: File.open("#{Rails.root}/#{product[3]}"))
end

User.create!(username: 'Test', email: 'example@example.com', password: 'foobar')
