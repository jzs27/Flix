# Project 2 - Flix
Flix is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **17** hours spent in total

## User Stories

The following **required** functionality is complete:

- User sees an app icon on the home screen and a styled launch screen.
- User can view a list of movies currently playing in theaters from The Movie Database.
- Poster images are loaded using the UIImageView category in the AFNetworking library.
- User sees a loading state while waiting for the movies API.
- User can pull to refresh the movie list.
- User sees an error message when there's a networking error.
- User can tap a tab bar button to view a grid layout of Movie Posters using a CollectionView.

The following **optional** features are implemented:

- User can tap a poster in the collection view to see a detail screen of that movie
- User can search for a movie in the table view and the collection view. 
- User can view the large movie poster by tapping on a button.
- For the large poster, load the low resolution image first and then switch to the high resolution image when complete.
- Customize the selection effect of the cell.
- Customize the navigation bar.
- Customize the UI.
- Run your app on a real device.

The following **additional** features are implemented:
- User can tap on poster in detail view and see an enlarged version. 
- User can view month and year of movie in the detail view. 
- User can tap of backdrop in detail view and watch the trailer of the movie. 
- User can view the genres of the movie in the detail view. 

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. One is able to connect so many different part of the movie API to the app (eg. ratings, popularity, similar movies).
2. One is able to implement animations to move from one part of the app to another. 

## Video Walkthrough

Here's a walkthrough of implemented user stories:

![ezgif com-gif-maker (8)](https://user-images.githubusercontent.com/71947227/123494906-1fa4fc80-d5e7-11eb-9d7d-7a9c892f89e2.gif)
![ezgif com-gif-maker (9)](https://user-images.githubusercontent.com/71947227/123494808-c046ec80-d5e6-11eb-8aa7-0698f7ac8820.gif)
![ezgif com-gif-maker (10)](https://user-images.githubusercontent.com/71947227/123494810-c210b000-d5e6-11eb-93d0-60a6eabf628b.gif)
![ezgif com-gif-maker (11)](https://user-images.githubusercontent.com/71947227/123494921-2df31880-d5e7-11eb-949e-1f74fe62b29a.gif)
GIF created with [Kap](https://getkap.co/).

## Notes

Describe any challenges encountered while building the app.

I mistakenly wasted a lot of time remaking view controllers since I did not realize you could link multiples view controllers to the same one. 

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library

## License

    Copyright [yyyy] [name of copyright owner]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
