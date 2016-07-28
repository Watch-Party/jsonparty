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


## To get posts for an episode
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
                timestamp:  "Time in EST"
                content:    "this is what the person wrote"
                pops:       5
              }
        }




## To get show options based on show name
####GET "https://wp-spoileralert.herokuapp.com/:showname/new"

**request**

no additional info needed

**response**

body:

          {
          options: [
              {
                tvrage_id: 17156,
                title: "Kashimashi : Girl Meets Girl",
                summary: "<p>Hazumu Osaragi is a normal, albeit effeminate high school boy who is seriously injured when an alien spaceship crash lands on him, only to be restored to health as a girl. A common theme throughout the series is the same-sex relationships that Hazumu finds himself in with two of his best female friends.</p>",
                cover_img_url: "http://tvmazecdn.com/uploads/images/original_untouched/57/144330.jpg"
              },
              {
                tvrage_id: 58,
                title: "New Girl",
                summary: "<p><strong><em>"New Girl"</em></strong> is a single-camera ensemble comedy starring Zooey Deschanel as Jess, an offbeat girl who - after a bad breakup - moves in with three single guys and essentially sets a bomb off in their lives.</p>",
                cover_img_url: "http://tvmazecdn.com/uploads/images/original_untouched/0/455.jpg"
              },
              {
                tvrage_id: 567,
                title: "Gossip Girl",
                summary: "<p>Six years after the first <strong><em>"Gossip Girl"</em></strong> blast rocked the Upper East Side and viewers at home, <em>Gossip Girl</em> returns for an unforgettable final season. Season six opens with the Upper East Siders working together to find one of their own. Serena has gone off the grid, beyond even the reach of <em>Gossip Girl</em>. Her friends fear for the worst and hope for the best, but even they can't imagine where they will ultimately find her. <br /><br /> Meanwhile, Blair has offered Chuck her heart, but is her love enough to help him win back his empire? Lonely Boy Danhas written a new book that promises to make even more trouble than the first, and this time he has no desire to remain anonymous. Nate is determined to finally reveal the true identity of <em>Gossip Girl</em>, thereby making a name for The Spectator and himself. Lily and Rufus turn on one another when Rufus makes a surprising new ally who threatens Lily and her family. Always ready with a scheme, Ivy is prepared to stir up trouble. <br /><br /> Anywhere else it would be too much drama to handle, but this is the Upper East Side. And when Bart Bass, Jack Bass and Georgina Sparks show up to raise hell, it's a fight to the spectacular series finale. Who comes out on top? That's one secret I'll never tell… xoxo, <em>Gossip Girl</em>. </p>",
                cover_img_url: "http://tvmazecdn.com/uploads/images/original_untouched/4/11753.jpg"
              }
          ]}


## To confirm the show you want to add
####POST "https://wp-spoileralert.herokuapp.com/:tvrage_id#/confirm"

**request**

no additional info needed

**response**

                status: "Show Added!"

                or

                status: "Unable to add show"


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



## To pop a post
####PATCH "https://wp-spoileralert.herokuapp.com/posts/:post_id/pop"

**request**

no additional info needed

**response**

                status: "Post Popped"




## To search for user or show by title or email
####GET 'https://wp-spoileralert.herokuapp.com/search?criteria="thing to search for"'

**request**

no additional info needed

**response**

            {
            results: [
                  {
                      username: "boblablah",
                      email: "bob@example.com",
                      type: "User",
                      id: 1
                  }
              ]
            }


or


            {
            results: [
                  {
                    showname: "futurama",
                    type: "Show",
                    id: 72
                  }
              ]
            }

or a combination of both


##Is it any good?
[Yes](http://news.ycombinator.com/item?id=3067434)

##A Thanks To...
[TVMAZE-API](http://www.tvmaze.com/api): An api for tv shows and their episodes

.
