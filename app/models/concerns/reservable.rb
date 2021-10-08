module Reservable
    
    module Class_methods

        def highest_ratio_res_to_listings
            instances = self.all
            sorted_instances = instances.sort {|a,b| a.instance_eval{res_to_listings} <=> b.instance_eval{res_to_listings}}
            sorted_instances.last
        end 
    
        def most_res
            instances = self.all
            sorted_instances = instances.sort {|a,b| a.instance_eval{reservations} <=> b.instance_eval{reservations}}
            sorted_instances.last
        end

    end

    
    module Instance_methods

        private
        
        def res_to_listings
            if reservations > 0
                reservations / listings.count  
            else
                return 0
            end 
        end 

        def reservations
            count = 0
            listings.each {|listing| count += listing.reservations.count}
            count.to_f
        end 
        
    end 

end 