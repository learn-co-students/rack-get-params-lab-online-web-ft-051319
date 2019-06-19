class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = [] #Create a new class array called @@cart to hold any items in your cart

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end

    elsif req.path.match(/search/) #Create a new route called /search that takes in a GET param with the q item
      search_term = req.params["q"] #GET param with the q item
      resp.write handle_search(search_term)

    elsif  req.path.match(/cart/) #Create a new route called /cart to show the items in your cart
      if @@cart.empty?
        resp.write "Your cart is empty"
      else
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end

    elsif req.path.match(/add/) #Create a new route called /add that takes in a GET param with the key item
      add_term = req.params["item"] #GET param with the key item
      if @@items.include?(add_term) #checking if add_term is available in list of @@items
        @@cart << add_term #adding the item to our cart
        resp.write "added #{add_term}"
      else
        resp.write "We don't have that item"
      end

    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
