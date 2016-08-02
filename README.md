# Spoiler Alert!
## The REST json API and websocket server for [Watch Party](https://watch-party.firebaseapp.com)!
"Your Shows, Your Friends, On Your Time"


## To update user
####PATCH or PUT "https://wp-spoileralert.herokuapp.com/auth"

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


only need avatar file OR remote avatar url, not both

only need fields that are being changed


**response**



            {
              "id":5,
              "email":"something@example.com",
              "created_at":"2016-07-18T21:35:19.926Z",
              "updated_at":"2016-07-18T21:35:19.930Z",
              "bio":nil,
              "screen_name":"preteenwithapredatorhead",
              "location":nil,
              "first_name":"Brad",
              "last_name":"Neely",
              "avatar": avatar url stuff
            }

## To get user info
####GET "https://wp-spoileralert.herokuapp.com/users/:user_id"

**request**

no additional info needed

**response**



        {
          user: {
              id: 1,
              username: "boblablah",
              email: "bob@example.com",
              first_name: "Robert",
              last_name: "LaBlah",
              bio: "A jaunty man from France",
              location: "France, duh",
              avatar: avatar url stuff,
              avatar_thumb: avatar url stuff,
              total_posts: 56,
              watching: [ ],
              watched_by: [ ]
          }
        }



## To get posts for an episode (only posts before episode start time)
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
note: user_id is of the user being watched

**request**

no additional info needed

**response**

                status: "Success"

                or

                status: "Unable to watch that user"


## To UNwatch user
####DELETE "https://wp-spoileralert.herokuapp.com/watch/:user_id"
note: user_id is of the user being unwatched

**request**

no additional info needed

**response**

                status: "Success"

                or

                status: "Unable to unwatch"


## To get recent and popular show data
####GET 'https://wp-spoileralert.herokuapp.com/search/init'

**request**

no additional info needed

**response**


            {
              recent: [
                {
                  id: 24,
                  title: "Stranger Things",
                  img_url: img url stuff,
                  show_added_on: "July 30 2016 - 04:06PM EST"
                },
                {
                  id: 26,
                  title: "Preacher",
                  img_url: img url stuff,
                  show_added_on: "July 30 2016 - 04:49PM EST"
                }
              ],
              popular: [
                {
                  id: 2,
                  title: "Game of Thrones",
                  img_url: img url stuff
                },
                {
                  id: 26,
                  title: "Preacher",
                  img_url: img url stuff
                },
                {
                id: 3,
                  title: "Doctor Who",
                  img_url: img url stuff
                }
              ]
            }


## To search for shows by title
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




## To search for users by screen name or email
####GET 'https://wp-spoileralert.herokuapp.com/search/users?criteria="thing to search for"'

**request**

no additional info needed

**response**

            {
            users: [
                  {
                      screen_name: "boblablah",
                      email: "bob@example.com",
                      id: 1
                  }
              ]
            }

## To get basic show info
####GET 'https://wp-spoileralert.herokuapp.com/:showname/info'

**request**

no additional info needed

**response**

            {
              show: {
                id: 2,
                title: "Game of Thrones",
                img_url: img url stuff,
                description: "<p>Based on the bestselling book series <em>A Song of Ice and Fire</em> by George R.R. Martin, this sprawling new HBO drama is set in a world where summers span decades and winters can last a lifetime. From the scheming south and the savage eastern lands, to the frozen north and ancient Wall that protects the realm from the mysterious darkness beyond, the powerful families of the Seven Kingdoms are locked in a battle for the Iron Throne. This is a story of duplicity and treachery, nobility and honor, conquest and triumph. In the <em>"Game of Thrones"</em>, you either win or you die.</p>",
                network: "HBO",
                upcoming_title: "TBA",
                upcoming_date: "TBA",
                recent_id: 354,
                recent_title: "The Winds of Winter",
                recent_date: "June 26, 2016 - 09:00PM EST",
                seasons: [ ... ]
            }


## To get info for recently aired shows
####GET 'https://wp-spoileralert.herokuapp.com/recent'

**request**

no additional info needed

**response**

            {
            recent_shows: [
                  {
                      title: "Doctor Who",
                      seasons: [ ... ]
                  }
              ]
            }


## To get basic episode info
####GET 'https://wp-spoileralert.herokuapp.com/episodes/:episode_id'

**request**

no additional info needed

**response**

            {
              showname:        "Game of Thrones",
              season_number:    1,
              episode_number:  "3"
            }


## To get upcoming episode info
####GET 'https://wp-spoileralert.herokuapp.com/upcoming'

**request**

no additional info needed

**response**

            {
              upcoming: [
                  {
                    id: 4246,
                    show: "The Bachelorette",
                    season: 12,
                    episode_number: "11",
                    episode_title: "Week 9",
                    air_date: "2016-08-02T00:00:00.000Z"
                  },
                  {
                    id: 4247,
                    show: "The Bachelorette",
                    season: 12,
                    episode_number: "12",
                    episode_title: "After the Final Rose",
                    air_date: "2016-08-02T02:00:00.000Z"
                  }
              ]
            }



##Is it any good?
[Yes](http://news.ycombinator.com/item?id=3067434)

##A Thanks To...
[TVMAZE-API](http://www.tvmaze.com/api): An api for tv shows and their episodes

.
