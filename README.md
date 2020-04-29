# Stackoverflow
Stack Overflow is the iOS app for searching [Stack Overflow](https://stackoverflow.com/) questions and viewing answers

|         | Features  |
----------|-----------------
:zero: | Questions search with full info and answers screen
:one: | Plist configurable search methods with live search option
:two: | Observable event based streams 
:three: | Answers filtering based on votes, activity and date posted
:four: | live search throttling and much more...

## Installation

```sh
git clone https://github.com/innocentmggl/stackoverflow.git
cd stackoverflow
pod install
open stackoverflow.xcworkspace/
```

#### Live search:

  - To enable live search open property list file and and select ```LiveSearchEnabled``` to `YES`
  - Configure the ```MinimumSearchcharacters``` character to trigger search, currently set to a minimum 3 characters
  - Set desired throttle in ```AppConfigurations.swift``` class
