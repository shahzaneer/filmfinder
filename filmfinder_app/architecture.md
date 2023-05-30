# MVVM ARCHITECTURE

---

## main.dart

- The entry point of App

## Model:

- The Data classes which will be used to hold data in appropriate Data Structures for use and manipulation.

## View:

- All the Screens will be present here.

## View Model:

- It will contain state management classes and the logic that connects the UI(view) with the original data(View Model)
- `BLoc` for large projects including a lot of Data Streams and Events
- `Cubit` for large projects but with slightly less control WRT `Bloc`
- `Provider` Considerably small Projects.

## Widgets:

- It will contain all the components.

## Utils:

- All the utilities including static data (svgs,images,audios,fonts,etc), colors, other constants etc.

## Routes:

- It will contain the the routing for the app.

## Data:

- It will contain API related code

### Network:

- It will be including the generic HTTP call methods

### Response:

- The generic Response class for all type of responses in each state

### Exceptions:

- It will contain the exceptions which can occur while using APIs

### Repository:

- It will actually link the network with models according to the services required that is the original business logic code.
