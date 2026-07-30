# 4.0 CHIPageControl
## Description
A set of beautiful animated page controls written in Swift that can be used as a replacement for the default `UIPageControl`.
## Repository
- https://github.com/ChiliLabs/CHIPageControl

## Example Includes
- Auto-scrolling `UICollectionView`
- Animated `CHIPageControl`
- Infinite loop (last slide → first slide)
- Manual swipe support
- Page indicator synchronization

---
## Installation

1. Initialize CocoaPods (if not already initialized).

   ```bash
   pod init
   ```

2. Open the `Podfile` and add:

   ```ruby
   pod 'CHIPageControl'
   ```

3. Install the pod.

   ```bash
   pod install
   ```

4. Open the `.xcworkspace` file.

5. Build the project (`⌘ + B`).

---

## Storyboard Setup

1. Drag a **UIView** onto the storyboard.
2. Set its custom class to one of the available CHIPageControl classes, for example:

   ```
   CHIPageControlAleppo
   ```

3. Connect the outlet to your ViewController.

---

## Notes

### Attribute Inspector

- Select the **Collection View**.
- Change **Items** from **1** to **0**.
- Enable **Is Paging Enabled**.
- Set **Scroll Direction** to **Horizontal**.

### Size Inspector

- Set **Minimum Spacing** for both:
  - Cell
  - Line
- Value should be **0**.

### Images

- If your collection view displays images, set the **Image View Content Mode** to **Scale To Fill**.