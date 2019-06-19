class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      resp.write (@@cart.size > 0 ? @@cart.each {|item|resp.write "#{item}\n"} :"Your cart is empty")
    elsif req.path.match(/add/)
      input_item = req.params["item"]
      resp.write add_to_cart(input_item)
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

  def add_to_cart(input_item)
    @@items.each do |item|
      if input_item == item
        @@cart << item
        return "added #{item}"
      else
        return "We don't have that item"
      end
    end
  end

end
