# FriendBase

Created using SwiftUI, FriendBase enables users to easily view others within their organization with just the tap of a few buttons. The app fetches data through a network call to update the information that was already stored in Core Data and then neatly displays the information to users.

## App Preview

## FriendBase's Purpose
This app can help bring together people that work at an organization by allowing users to see everyone that is involved. The organization just needs to provide a link with data for each person in JSON format and anytime the information in that link updates, all users will automatically see those updates reflected on the next app launch. This approach allows organizations to only share as much information as they feel necessary for each of its members while also maintaining synchronization with their own databases.

#### An Example
Suppose there is a company with around 200 employees. It will be difficult for employees within the company to know who else works there and how to contact them if the company doesn't have a proper service in place exclusive to employees. In such situations, this app is a perfect solution as it could prevent users outside the company from accessing key employee information while also giving employees the opportunity to discover everyone else that works there.

## Technical Info
- Data fetched asynchronously through a URLSession and decoded into native swift types
- The cached Core Data information is then updated to reflect any changes
- Information is shown through a generic FilteredList View that I created
- Users are searchable by filtering the Core Data using NSPredicates
- Users are sortable by filtering the Core Data using SortDescriptors

## Up and Coming Features
- [ ] Adapting the app so that it can work with multiple organizations based on a login or invite system
- [ ] Implementing more powerful sort features that can help find people with similar profiles or interests.
- [ ] Allowing users to chat with those in their organization directly through the app

## App Idea Origin
I origininally created this app to complete the challenge for Day 60/61 in Paul Hudson's free online 100DaysOfSwiftUI course. However, I later decided to take this project further as I acquired more SwiftUI skills and realized the potential it can have.

### Important Note
No coding solutions were provided for this app so the entire implementation was on my own besides a few tips given by the challenge guidelines. The challenge required me to create an app that fetches data from a [Sample API Call](https://www.hackingwithswift.com/samples/friendface.json), if possible, to update the information stored in CoreData, which is then displayed through the UI. Full challenge guidelines can be found at [Day 60](https://www.hackingwithswift.com/guide/ios-swiftui/5/3/challenge) and [Day 61](https://www.hackingwithswift.com/100/swiftui/61).
