# githubuser

A technical assessment given to me with 6 hours of time and I did complete it in 4 hours.

## Definition: 
Write an application that can load users & handle selection from [GitHub Users API](https://docs.github.com/en/rest/reference/users#list-users).

The application contains two tabs. 

1. First Tab: Users 
2. Second Tab: Bookmarked Users 

Features to be implemented: 
1. List of Users from the above API 
2. Show user login name and the circular image from avatar_url 
3. Load more with the help of pagination 
4. Pull-to-refresh to refresh the page 
5. User should be bookmarked/unbookmarked from the list item 
6. Display the bookmarked users in Second Tab (No API call /pagination required here) 
7. From the second Tab, We can deselect the user.(Users selection/deselection should reflect properly in both listings)
8. In both the tabs, add a feature to search the users based on their name case-insensitively. (Search should happen for data already loaded. No network call needed for it). Search should be throttled for 300 milliseconds to avoid frequent processing while the user is typing.
9. Bookmarked users should be accessible in offline mode or across the app instances 

NICE TO HAVE: 
- Use of MVVM or more granular architecture.
- Use of DI concepts for better modularity & testability of the code
- Use of Reactive Programming
- Unit testing of any 1 feature

Download the app [here](https://drive.google.com/file/d/1g2xB9RRjRX2uclGaWyi-wJ1dinSOnWFT/view?usp=sharing).
