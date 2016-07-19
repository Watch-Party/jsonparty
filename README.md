# json-party
## The json API for Watch Party!
"Your Shows, Your Friends, On Your Time"

## To log in
####POST "https://json-party.herokuapp.com/users/sign_in.json"

**request**

body:



            user: {
                  email: email,
                  password: password
                  }



**response**



          {
            "id":5,
            "email":"something@example.com",
            "created_at":"2016-07-18T21:35:19.926Z",
            "updated_at":"2016-07-18T21:35:19.930Z",
            "avatar_url":nil,
            "bio":nil,
            "screen_name":"preteenwithapredatorhead",
            "location":nil,
            "first_name":"Brad",
            "last_name":"Neely"
          }




## To sign up
####POST "https://json-party.herokuapp.com/users.json"

**request**

body:



          user: {
                email: email,
                password: password,
                password_confirmation: password,
                first_name: first,
                last_name: last,
                screen_name: sr
                }



**response**



          {
            "id":5,
            "email":"something@example.com",
            "created_at":"2016-07-18T21:35:19.926Z",
            "updated_at":"2016-07-18T21:35:19.930Z",
            "avatar_url":nil,
            "bio":nil,
            "screen_name":"preteenwithapredatorhead",
            "location":nil,
            "first_name":"Brad",
            "last_name":"Neely"
          }

## To update user
####PATCH "https://json-party.herokuapp.com/users.json"

**request**

body:



        user: {
              email: email,
              password: new_password,
              password_confirmation: new_password,
              current_password: current_password,
              first_name: first,
              last_name: last,
              screen_name: sr,
              bio: bio,
              location: location,
              avatar: img_file
              }


email and current_password are required, everything else optional


**response**



        {
          "id":5,
          "email":"something@example.com",
          "created_at":"2016-07-18T21:35:19.926Z",
          "updated_at":"2016-07-18T21:35:19.930Z",
          "avatar_url":nil,
          "bio":nil,
          "screen_name":"preteenwithapredatorhead",
          "location":nil,
          "first_name":"Brad",
          "last_name":"Neely"
        }
