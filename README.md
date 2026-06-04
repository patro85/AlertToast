# AlertToast-SwiftUI

### Present Apple-like alert & toast in SwiftUI

> **Maintained fork.** This is an actively maintained fork of [elai950/AlertToast](https://github.com/elai950/AlertToast), which is no longer receiving updates. It keeps the original API while adding visionOS support, a native Liquid Glass background on iOS/macOS 26, and community bug fixes. See the [Releases](https://github.com/patro85/AlertToast/releases) page for the changelog.

<p align="center">
   <img src="https://github.com/patro85/AlertToast/blob/master/Assets/GithubCoverNew.png" width="480"/>
</p>

## 🌄 Example

<p align="center">
    <img src="https://github.com/patro85/AlertToast/blob/master/Assets/onboarding.png" style="display: block; margin: auto;"/>
</p>

<p align="center">
    <img src="https://github.com/patro85/AlertToast/blob/master/Assets/ToastExample.gif" style="display: block; margin: auto;" width="180"/>
</p>

## 🔭 Overview

Currently in SwiftUI, the only way to inform the user about some process that finished, for example, is by using `Alert`. Sometimes you just want to display a message telling the user that something completed or that their message was sent. Apple doesn't provide any method other than using `Alert`, even though they use various types of pop-ups themselves. This results in poor UX, as the user must tap "OK" or "Dismiss" for every piece of information they should be notified about.

`AlertToast` is an open-source library to use with SwiftUI. It lets you present popups that don't need any user action to dismiss or to validate. Some great usage examples: `Message Sent`, `Poor Network Connection`, `Profile Updated`, `Logged In/Out`, `Favorited`, `Loading`, and so on.

<img src="https://img.shields.io/badge/BUILD-1.5.1-green?style=for-the-badge" />&nbsp;&nbsp;&nbsp;<img src="https://img.shields.io/badge/PLATFORM-IOS%20|%20MACOS%20|%20VISIONOS-lightgray?style=for-the-badge" />&nbsp;&nbsp;&nbsp;<img src="https://img.shields.io/badge/LICENSE-MIT-lightgray?style=for-the-badge" />&nbsp;&nbsp;&nbsp;<img src="https://img.shields.io/badge/MADE WITH-SWIFTUI-orange?style=for-the-badge" />

* Built with pure SwiftUI.
* 3 display modes: `Alert` (pop at the center), `HUD` (drop from the top), and `Banner` (pop/slide from the bottom).
* Alert types: `Complete`, `Error`, `SystemImage`, `Image`, `Loading`, and `Regular` (text only).
* iOS, macOS, and **visionOS** support.
* Native **Liquid Glass** background on iOS/macOS 26+ (on by default, with an opt-out).
* Long titles and subtitles wrap instead of being truncated.
* Supports Light & Dark Mode.
* Works with **any** kind of view builder.
* Localization support.
* Font & background customization.

#### If you like the project, don't forget to `put a star 🌟`.

## Navigation

- [Installation](#-installation)
    - [Swift Package Manager](#swift-package-manager)
    - [CocoaPods](#cocoapods)
    - [Manually](#manually)
- [Requirements](#-requirements)
- [Usage](#-usage)
    - [Usage example with a regular alert](#usage-example-with-a-regular-alert)
    - [Complete modifier example](#complete-modifier-example)
    - [Styling & Liquid Glass](#styling--liquid-glass)
    - [Alert Toast parameters](#alert-toast-parameters)
- [Article](#-article)
- [Contributing](#-contributing)
- [Credits](#-credits)
- [License](#-license)

## 💻 Installation

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code, integrated with the Swift build system.

In Xcode, go to **File → Add Package Dependencies…**, paste the repository URL, and choose a version rule (e.g. *Up to Next Major* from `1.5.1`):

```
https://github.com/patro85/AlertToast.git
```

Or add it directly to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/patro85/AlertToast.git", from: "1.5.1")
]
```

------

### CocoaPods

This fork is not published to the CocoaPods trunk. Reference it directly from Git in your `Podfile`:

```ruby
pod 'AlertToast', :git => 'https://github.com/patro85/AlertToast.git', :tag => '1.5.1'
```

------

### Manually

If you prefer not to use a dependency manager, you can integrate `AlertToast` into your project manually. Put the `Sources/AlertToast` folder in your Xcode project. Make sure to enable `Copy items if needed` and `Create groups`.

## 🧳 Requirements

- iOS 14.0+ · macOS 11.0+ · visionOS 1.0+
- Swift 5.9+ (the package declares `swift-tools-version:5.9`)
- Xcode 15.0+ to build

> **Liquid Glass:** the optional Liquid Glass background uses the `glassEffect` API, which requires the iOS 26 / macOS 26 SDK (Xcode 26+) to compile. It activates automatically at runtime only on iOS/macOS 26 and later, and can be turned off — see [Styling & Liquid Glass](#styling--liquid-glass).

## 🛠 Usage

First, add `import AlertToast` to every Swift file where you want to use `AlertToast`.

Then use the `.toast` view modifier:

**Parameters:**

- `isPresenting`: (MUST) a `Binding<Bool>` to show or dismiss the alert.
- `duration`: default is 2, set 0 to disable auto-dismiss.
- `tapToDismiss`: default is `true`, set `false` to disable.
- `alert`: (MUST) expects an `AlertToast`.

#### Usage example with a regular alert

```swift
import AlertToast
import SwiftUI

struct ContentView: View {

    @State private var showToast = false

    var body: some View {
        VStack {
            Button("Show Toast") {
                showToast.toggle()
            }
        }
        .toast(isPresenting: $showToast) {

            // `.alert` is the default displayMode
            AlertToast(type: .regular, title: "Message Sent!")

            // Choose .hud to drop the alert from the top of the screen
            // AlertToast(displayMode: .hud, type: .regular, title: "Message Sent!")

            // Choose .banner to slide/pop the alert from the bottom of the screen
            // AlertToast(displayMode: .banner(.slide), type: .regular, title: "Message Sent!")
        }
    }
}
```

#### Complete modifier example

```swift
.toast(isPresenting: $showAlert, duration: 2, tapToDismiss: true, alert: {
   // AlertToast goes here
}, onTap: {
   // onTap is called whether `tapToDismiss` is true or false.
   // If tapToDismiss is true, onTap is called and then the alert is dismissed.
}, completion: {
   // Completion block called after dismiss
})
```

#### Styling & Liquid Glass

Customize appearance by passing an `AlertStyle` via `.style(...)`:

```swift
.toast(isPresenting: $showToast) {
    AlertToast(type: .complete(.green),
               title: "Saved",
               subTitle: "Your changes are stored.",
               style: .style(backgroundColor: .gray,
                             titleColor: .white,
                             subTitleColor: .white,
                             useGlassEffect: false)) // keep the classic background on iOS/macOS 26+
}
```

On iOS 26 / macOS 26 and later, the toast background uses the native Liquid Glass material **by default**. To keep the classic solid-color / blur background, pass `useGlassEffect: false` in the style. On earlier OS versions the flag has no effect (the classic background is always used).

### Alert Toast parameters

```swift
AlertToast(displayMode: DisplayMode = .alert,
           type: AlertType,
           title: Optional(String),
           subTitle: Optional(String),
           style: Optional(AlertStyle))

// Available appearance customizations:
.style(backgroundColor: Color?,
       titleColor: Color?,
       subTitleColor: Color?,
       titleFont: Font?,
       subTitleFont: Font?,
       activityIndicatorColor: Color?,
       useGlassEffect: Bool?)
```

#### Available display modes:
- **Alert:** pop at the center of the screen.
- **HUD:** drop from the top of the screen.
- **Banner:** pop/slide from the bottom of the screen.
- **Custom:** present any view of your own at the center of the screen (see [Custom view](#custom-view)).

#### Available alert types:
- **Regular:** text only (title and subtitle).
- **Complete:** animated checkmark.
- **Error:** animated xmark.
- **System Image:** named image from `SFSymbols`.
- **Image:** named image from Assets.
- **Loading:** activity indicator (spinner).

#### Alert dialog view modifier (with default settings):
```swift
.toast(isPresenting: Binding<Bool>, duration: Double = 2, tapToDismiss: true, alert: () -> AlertToast, onTap: () -> (), completion: () -> ())
```

#### Simple text alert:
```swift
AlertToast(type: .regular, title: Optional(String), subTitle: Optional(String))
```

#### Complete / Error alert:
```swift
AlertToast(type: .complete(Color) /* or */ .error(Color), title: Optional(String), subTitle: Optional(String))
```

#### System image alert:
```swift
AlertToast(type: .systemImage(String, Color), title: Optional(String), subTitle: Optional(String))
```

#### Image alert:
```swift
AlertToast(type: .image(String, Color), title: Optional(String), subTitle: Optional(String))
```

#### Loading alert:
```swift
// When using loading, duration won't auto-dismiss and tapToDismiss is set to false.
AlertToast(type: .loading, title: Optional(String), subTitle: Optional(String))
```

#### Custom view:
Present any view you like using the `customView` initializer. It is shown centered like `.alert` and respects `duration` / `tapToDismiss`.

```swift
.toast(isPresenting: $showToast) {
    AlertToast {
        HStack {
            ProgressView()
            Text("Uploading…")
                .font(.headline)
        }
    }
}
```

You can add many `.toast` modifiers on a single view.

#### Right-to-left (RTL) layouts
Layout, text alignment, and `SystemImage` icons mirror automatically in RTL locales, and the universal `.complete` / `.error` marks are intentionally kept unmirrored (per Apple's guidance for universally recognized symbols).

The one thing the library can't decide for you is a custom `.image(_:)` asset: if your asset is directional (e.g. a reply or forward arrow) and should flip in RTL, set its **Direction → "Mirrors"** in the asset catalog, or apply `.flipsForRightToLeftLayoutDirection(true)`. Non-directional assets need nothing.

## 📖 Article

The original author wrote an article with more usage examples:

[Medium — How to toast an alert in SwiftUI](https://elaizuberman.medium.com/presenting-apples-music-alerts-in-swiftui-7f5c32cebed6)

## 👨‍💻 Contributing

All issue reports, feature requests, pull requests, and GitHub stars are welcomed and much appreciated.

## 🙏 Credits

- Original library created by **Elai Zuberman** ([@elai950](https://github.com/elai950)) — [elai950/AlertToast](https://github.com/elai950/AlertToast).
- This fork is maintained by [@patro85](https://github.com/patro85).
- Community contributions incorporated into this fork:
    - visionOS support — [@derwaldgeist](https://github.com/derwaldgeist)
    - Liquid Glass background — [@lfuelling](https://github.com/lfuelling)
    - Subtitle wrapping fix — [@arslankaleem7229](https://github.com/arslankaleem7229)

## 📃 License

`AlertToast` is available under the MIT license. See the [LICENSE](https://github.com/patro85/AlertToast/blob/master/LICENSE.md) file for more info.

---

- [Jump Up](#alerttoast-swiftui)
