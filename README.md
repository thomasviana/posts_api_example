# POSTS APP

This is a POSTS APP example implementing asynchronous API calls from [JSONPlaceholder.](https://jsonplaceholder.typicode.com/ "JSONPlaceholder")

To run the app, you just have to clone the project, set up your IOS or Android emulator and run.

#### Proposed architecture

This is a small app and we use the cubit pattern to separate the ui, bussiness logic and data layers as shown in the image.



![cubit](https://user-images.githubusercontent.com/85323846/136705641-47d86b32-8742-40c2-8092-70add89ffd7c.png)



The UI send functions to the cubit, then the cubit goes to the repository and ask for data, the repository implementation goes to the datasource (API Server for this example) and ask for the especific JSON data to convert it then into a Object. This data fetched is then passed back to the cubit to be processed and this cubits emit states to the UI to display the proper information to the user. 

This is a feature driven design, so if you want to implement an autentication feature, you can work on it without touching the other folders. 

I used some third-party libraries like flutter_bloc for sure to implement the cubits, http for networking, and shimmer wich i like to have nice UX while loading data. 
