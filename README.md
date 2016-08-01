# Spoiler Alert!
## The REST json API for Watch Party!
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

                  OK

Will send confirmation email to user


## To update user
####PATCH "https://wp-spoileralert.herokuapp.com/auth"

**request**

body:



              {
                email: email,
                password: new_password,
                password_confirmation: new_password,
                current_password: current_password,
                first_name: first,
                last_name: last,
                screen_name: sr,
                bio: bio,
                location: location,
                avatar: img_file,
                remote_avatar_url: img_url
              }


only need avatar file or remote avatar url, not both


only need fields that are being changed


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


## To get posts for an episode (only posts before episode started)
####GET "https://wp-spoileralert.herokuapp.com/:showname/:season#/:episode#/posts"

**request**

no additional info needed

**response**



        {
          posts:
              {
                id:         8907
                username:   "bob"
                thumb_url:  "someamazonthing.com/picture.format"
                timestamp:  "-05:24"
                content:    "this is what the person wrote"
                pops:       5
              }
        }


## To watch user
####POST "https://wp-spoileralert.herokuapp.com/watch/:user_id"

**request**

no additional info needed

**response**

                status: "Success"

                or

                status: "Unable to watch that user"


## To UNwatch user
####DELETE "https://wp-spoileralert.herokuapp.com/watch/:user_id"

**request**

no additional info needed

**response**

                status: "Success"

                or

                status: "Unable to unwatch"


## To search for show by title
####GET 'https://wp-spoileralert.herokuapp.com/search/shows?criteria="thing to search for"'

**request**

no additional info needed

**response**


            {
            shows: [
                  {
                    showname: "Futurama",
                    id: 72
                  }
              ]
            }




## To search for user by screen name or email
####GET 'https://wp-spoileralert.herokuapp.com/search/users?criteria="thing to search for"'

**request**

no additional info needed

**response**

            {
            users: [
                  {
                      username: "boblablah",
                      email: "bob@example.com",
                      id: 1
                  }
              ]
            }


##Is it any good?
[Yes](http://news.ycombinator.com/item?id=3067434)

##A Thanks To...
[TVMAZE-API](http://www.tvmaze.com/api): An api for tv shows and their episodes

.
