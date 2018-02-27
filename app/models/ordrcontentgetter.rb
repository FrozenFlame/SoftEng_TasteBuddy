class Ordrcontentgetter

    def initialize(oC)
        @orderContents = oC
    end
    def total_price
        total = 0
        @orderContents.each do |item|
            @prods = Product.where(:prodCode.nin => [item[0],nil])
            @prods.each do |p|
                total = p.price * item[1]
            end
        end         
        return total
    end
    def self.total_price(oC)
        total = 0
        @orderContents = oC
        @orderContents.each do |item|
            @prods = Product.where(:prodCode => item[0])
            @prods.each do |p|
                total += p.price * item[1]
            end
        end         
        puts "[Ordrcontentgetter] total price: %f" % [total]
        return total
    end

    def self.get_names(oC)
        names = []
        @orderContents = oC
        @orderContents.each do |item|
            @prods = Product.where(:prodCode => item[0])
            @prods.each do |p|
                names.push("[%dx]" % [item[1].to_i] +p.prodName)  
            end
        end
        return names.join(", ")
    end

    def self.get_name(oC)
        
    end
end