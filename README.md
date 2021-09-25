# Internet Chuck Norris Database iOS App

This repository contains the source code for the ICNDb App, which intereacts with the [Internet Chuck Norris Database API](http://www.icndb.com/api/). This SwiftUI application is written in `Swift 5` and able to run on any iPhone on iOS 13.0 or greater. As such, this project requires at least `Xcode11`. 

### Installation

1. Download the project files and unzip.
2. Open the `.xcodeproj` with Xcode.
3. Go to `Targets > ICNDb > Signing & Capabilities`, select your team & add a new unique bundle identifier (e.g. `com.[your-team].ICNDb`). For personal use it is recommended to leave the "Automatically manage signing" box checked - to let Xcode manage Provisioning Profiles, App IDs & Certificates for you.
4. Build and run the app, installing it on your device / simulator.
5. If you're using a personal team + Xcode managed signing, you may need to go to `Settings > General > VPN & Device Management`\* and manually approve/trust the developer on your physical device.



\*The exact path in Settings App for trusting developer depends on iOS version, it could appear as `Settings > General > Profiles Management/Profiles & Device Management`.