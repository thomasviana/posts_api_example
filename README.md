# POSTS APP

This is a POSTS APP example implementing asynchronous API calls from [JSONPlaceholder.](https://jsonplaceholder.typicode.com/ "JSONPlaceholder")

To run the app, you just have to clone the project, set up your IOS or Android emulator and run.

#### Proposed architecture

This is a small app and we use the cubit pattern to separate the ui, bussiness logic and data layers as shown in the image.



![cubit](https://user-images.githubusercontent.com/85323846/136705641-47d86b32-8742-40c2-8092-70add89ffd7c.png)



The UI send functions to the cubit, then the cubit goes to the repository and ask for data, the repository implementation goes to the datasource (API Server for this example) and ask for the especific JSON data to convert it then into a Object. This data fetched is then passed back to the cubit to be processed and this cubits emit states to the UI to display the proper information to the user. 

This is a feature driven design, so if you want to implement an autentication feature, you can work on it without touching the other folders. 

I used some third-party libraries like flutter_bloc for sure to implement the cubits, http for networking, and shimmer wich i like to have nice UX while loading data. 

#### Data persistency with Hive

Hive is a third-party library that allows us to have local persistency data with hi eficiency compared to other ways as shown in the next graph.

<img width="798" alt="hive" src="https://user-images.githubusercontent.com/85323846/136939444-1d137cff-9d17-4021-94a4-d11d350d94bb.png">


#### Requirements for this project:

1. ✅ Load the posts from the JSON API and populate the sidebar.
2. ✅ Each Cell/Row height should fit according to the size of the content.
3. ✅ The first 20 posts should have a blue dot indicator.
4. ✅ Remove the blue dot indicator once the related post is read.
5. ✅ Once a post is touched, its related content is shown in the main content area. 
6. ✅ The related content also displays user information.
7. ✅ Add a button in the navigation. It adds the current post to favorites.
8. ✅ Each cell should have the functionality to swipe and delete the post.
9. ✅ Add a button to the footer that removes all posts.
10. ✅ Add a button to navigation that reloads all posts.
11. ✅ Add a segmented control to filter posts (All / Favorites) 
12. ✅ Favorite posts should have a star indicator.

#### Extra requirements:

1. ✅ Cache all posts to handle persistency. 
2. ✅ Show a list of comments related to each post.
3. Add unit testing as you consider it.

