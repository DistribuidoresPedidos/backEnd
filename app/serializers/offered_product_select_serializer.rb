class OfferedProductSelectSerializer < ActiveModel::Serializer

  def attributes
   data = super
   if scope
     scope.split(",").each do |field|
       if field == 'price'
         data[:price] = object.price
       elsif field == 'product_id'
         data[:product_id] = object.product_id
       elsif field == 'distributor_id'
         data[:distributor_id] = object.distributor_id
       end
     end
   end
   data
 end

end
