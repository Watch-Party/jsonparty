#no longer needed
desc 'Get real info for the test show'
task update_fake_show: :environment do
  Show.find_each do |show|
    if show.confirmed == true

      resp = HTTParty.get "http://api.tvmaze.com/shows/#{show.tvrage_id}"

      show.network = resp["network"]["name"]
      show.cover_img_url = resp["image"]["original"]
      show.summary = resp["summary"]

      if show.save
        puts "#{show.title} updated"
      else
        puts "Could not update #{show.title}"
      end

    end
  end
end
