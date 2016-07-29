
desc 'Add network to existing shows'
task update_network: :environment do
  Show.find_each do |show|
    if show.confirmed == true

      resp = HTTParty.get "http://api.tvmaze.com/shows/#{show.tvrage_id}"

      show.network = resp["network"]["name"]

      if show.save
        puts "#{show.network} added to #{show.title}"
      else
        puts "Could not update #{show.title}"
      end
      
    end
  end
end
