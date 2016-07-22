
desc 'Remove all unconfirmed shows front db'
task remove_unconfirmed: :environment do
   Show.find_each do |show|
     unless show.confirmed
       puts "#{show.title} removed"
       show.destroy
     end
   end
end
