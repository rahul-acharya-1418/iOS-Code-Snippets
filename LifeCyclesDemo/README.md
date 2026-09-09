#  Lifecycle's

---

##### Resources
- [Application Life Cycle](https://manasaprema04.medium.com/application-life-cycle-in-ios-f7365d8c1636)
- [ViewController Life Cycle](https://medium.com/@knoo/viewcontroller-life-cycle-in-ios-29f7da4acfc7)
- [UIView  Life Cycle](https://nirajpaul2.medium.com/uiview-lifecycle-12435f8de492)

---

## App Lifecycle

### First Time App Run

```text
AppDelegate: willFinishLaunchingWithOptions
        ↓
AppDelegate: didFinishLaunchingWithOptions
        ↓
SceneDelegate: willConnectTo
        ↓
SceneDelegate: sceneWillEnterForeground
        ↓
SceneDelegate: sceneDidBecomeActive
```

### Shutter Down

```text
sceneWillResignActive
```

### Shutter Up

```text
sceneDidBecomeActive
```

### Enter Background / Change App

```text
sceneWillResignActive
        ↓
sceneDidEnterBackground
```

### Enter App Again

```text
sceneWillEnterForeground
        ↓
sceneDidBecomeActive
```

### App Kill

```text
sceneWillResignActive
        ↓
sceneDidEnterBackground
        ↓
sceneDidDisconnect
```

---

## UIViewController Life Cycle

### First Time ViewController Open
```text
AppDelegate:  application(_:willFinishLaunchingWithOptions:)
    ↓
AppDelegate:  application(_:didFinishLaunchingWithOptions:)
    ↓
SceneDelegate:  scene(_:willConnectTo:options:)
    ↓
SceneDelegate:  sceneWillEnterForeground(_:)
    ↓
loadView()
    ↓
viewDidLoad()
    ↓
viewWillAppear()
    ↓
viewIsAppearing()
    ↓
viewWillLayoutSubviews()
    ↓
viewDidLayoutSubviews()
    ↓
SceneDelegate:  sceneDidBecomeActive(_:)
```
### Navigate to Next ViewController

```text
CurrentVC: viewWillLayoutSubviews()
    ↓
CurrentVC: viewDidLayoutSubviews()
    ↓
NextVC: loadView()
    ↓
NextVC: viewDidLoad()
    ↓
CurrentVC: viewWillDisappear()
    ↓
NextVC: viewWillAppear()
    ↓
NextVC: viewIsAppearing()
    ↓
NextVC: viewWillLayoutSubviews()
    ↓
NextVC: viewDidLayoutSubviews()
    ↓
CurrentVC: viewWillLayoutSubviews()
    ↓
CurrentVC: viewDidLayoutSubviews()
    ↓
CurrentVC: viewDidDisappear()
```

### Come Back to Previous ViewController

```text
NextVC: viewWillDisappear()
    ↓
CurrentVC: viewWillAppear()
    ↓
CurrentVC: viewIsAppearing()
    ↓
NextVC: viewDidDisappear()
    ↓
NextVC: deinit
```

### APP kill
```text
SceneDelegate:  sceneWillResignActive(_:)
    ↓
SceneDelegate:  sceneDidEnterBackground(_:)
    ↓
SceneDelegate:  sceneDidDisconnect(_:)
    ↓
CurrentVC:  viewWillDisappear(_:)
    ↓
CurrentVC:  viewDidDisappear(_:)
    ↓
CurrentVC:  deinit
```

---


## UIView Life Cycle

### First Time When Controller Opens
```text
init(coder:)
    ↓
willMove(toSuperview:)
    ↓
didMoveToSuperview()
    ↓
didMoveToWindow()
    ↓
layoutSubviews()
    ↓
draw(_:)
```
### View Layout Changes

```text
layoutSubviews()
    ↓
draw(_:)   // only when the view needs to be redrawn
```

### View Added to Superview

```text
willMove(toSuperview:)
    ↓
didMoveToSuperview()
```

### View Added to Window

```text
didMoveToWindow()
```

### View Removed from Superview

```text
willMove(toSuperview: nil)
    ↓
didMoveToSuperview()
```

### View Removed from Window

```text
willMove(toWindow: nil)
    ↓
didMoveToWindow()
```

### Remove View Completely

```text
willMove(toSuperview: nil)
    ↓
didMoveToSuperview()
    ↓
willMove(toWindow: nil)
    ↓
didMoveToWindow()
    ↓
removeFromSuperview()
```

### Main Methods

|Method|Purpose|
|---|---|
|`init(coder:)`|Creates the view from Storyboard/XIB|
|`willMove(toSuperview:)`|Called before the view is added/removed from a superview|
|`didMoveToSuperview()`|Called after the superview changes|
|`didMoveToWindow()`|Called after the view is added/removed from a window|
|`layoutSubviews()`|Lays out the view's subviews|
|`draw(_:)`|Draws the view's custom content|
|`removeFromSuperview()`|Removes the view from its superview|

### Easy Order to Remember

```text
CREATE
  ↓
init(coder:)
  ↓
ADD TO SUPERVIEW
  ↓
willMove(toSuperview:)
  ↓
didMoveToSuperview()
  ↓
ADD TO WINDOW
  ↓
didMoveToWindow()
  ↓
LAYOUT
  ↓
layoutSubviews()
  ↓
DRAW
  ↓
draw(_:)
```
