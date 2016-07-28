module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect(data)
      self.current_user = find_verified_user(data)
    end

    protected
      def find_verified_user(data)
        if current_user = User.find(params["data"][1]["user_id"])
          current_user
        else
          reject_unauthorized_connection
        end
      end
  end
end
