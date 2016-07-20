# Spoiler Alert!
## The json API for Watch Party!
"Your Shows, Your Friends, On Your Time"

## To log in
####POST "https://wp-spoileralert.herokuapp.com/auth/sign_in"

**request**

body:



            {
             email: email,
             password: password
            }



**response**

body:



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
            "last_name":"Neely",
            "avatar": avatar url stuff
          }

header:



          {
            "access-token":["their-code"],
            "token-type":["Bearer"],
            "client"=>["client-code"],
            "expiry"=>["epoc-till-expire"],
            "uid"=>["something@example.com"]
          }




## To sign up
####POST "https://wp-spoileralert.herokuapp.com/auth"

**request**

body:



              {
                email: email,
                password: password,
                password_confirmation: password,
                first_name: first,
                last_name: last,
                screen_name: sr
              }




**response**

body:


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
            "last_name":"Neely",
            "avatar": avatar url stuff
          }



header:



          {
            "access-token":["their-code"],
            "token-type":["Bearer"],
            "client"=>["client-code"],
            "expiry"=>["epoc-till-expire"],
            "uid"=>["something@example.com"]
          }


## To update user
####PATCH "https://wp-spoileralert.herokuapp.com/auth"

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
          "last_name":"Neely",
          "avatar": avatar url stuff
        }


## To get posts for an episode
####GET "https://wp-spoileralert.herokuapp.com/:showname/:season#/:episode#/posts"

**request**

no additional info needed

**response**



        {
          posts:
              {
                username:   "bob"
                thumb_url:  "someamazonthing.com/picture.format"
                timestamp:  "Time in EST"
                content:    "this is what the person wrote"
              }
        }


## To make a posts for an episode
####POST "https://wp-spoileralert.herokuapp.com/:showname/:season#/:episode#/posts"

**request**

body:



        content: "This is what I want to post"


**response**

ok
