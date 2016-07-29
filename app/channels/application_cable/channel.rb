module ApplicationCable
  class Channel < ActionCable::Channel::Base
    # def login
    #   credentials = @message
    #   auth_flow = Users::AuthFlow.new(credentials)
    # 
    #   if auth_flow.auth_valid?
    #     user = User.find_by(email: @message['email'])
    #     @token = Tokens::GenerateFlow.new(user).generate!
    #     trigger_success status: :success, key: @token.key, user: JSON.parse(user.to_json(
    #       only: [:id, :email]
    #     ))
    #   else
    #     trigger_success status: :error
    #   end
    # end
    #
    # before_action
    #
    # def set_message_and_token
    #   @key = message['key']
    #   @message = message['message']
    # end
    #
    # def authorize!
    #   if @key.present?
    #     @token = Token.where(key: @key).first
    #     if @token
    #       @user = @token.user
    #     end
    #   end
    #
    #   if !@user
    #     trigger_failure({
    #       error: true,
    #       message: "you must pass a token or this token does not exists"
    #       })
    #       head(403)
    #   end
    # end
  end
end
