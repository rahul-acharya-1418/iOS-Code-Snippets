//
//  ViewController.swift
//  PageControlDemo
//
//  Created by Rahul Acharya on 30/07/26.
//

import UIKit
import CHIPageControl

class ViewController: UIViewController {
        
    // MARK: - Outlets

    /// Animated page indicator.
    @IBOutlet weak var pgcontrol: CHIPageControlAleppo!
    
    /// Horizontal slider.
    @IBOutlet weak var collectionView: UICollectionView!
    

    // MARK: - Properties

    /// Timer responsible for automatic page changes.
    private var timer: Timer?

    /// Stores the currently visible page.
    ///
    /// This value is updated:
    /// - Automatically by the timer
    /// - Manually when the user swipes
    private var currentIndex = 0

    private let totalItems = 3
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfig()
    }

    /// Prevent Timer from continuing after ViewController is released.
    deinit {
        timer?.invalidate()
    }
}


// MARK: - Initial Configuration

extension ViewController {

    /// Entry point for all setup.
    ///
    /// Keeping configuration separated makes
    /// viewDidLoad() small and easy to read.
    func setupConfig() {
        collectionViewConfig()
        pgcontrolConfig()
        startAutoScroll()
    }

    /// Configure CHIPageControl appearance.
    func pgcontrolConfig() {

        /// Total number of pages.
        pgcontrol.numberOfPages = totalItems

        /// Dot radius.
        pgcontrol.radius = 10

        /// Color of inactive dots.
        pgcontrol.tintColor = .white

        /// Color of active dot.
        pgcontrol.currentPageTintColor = .tintColor

        /// Space between dots.
        pgcontrol.padding = 6
    }

    /// Configure CollectionView.
    func collectionViewConfig() {

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(
            UINib(nibName: "CollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "CollectionViewCell"
        )
    }
}


// MARK: - Auto Scroll

extension ViewController {

    /// Starts automatic scrolling.
    ///
    /// Every 3 seconds:
    ///
    /// Slide 1
    ///      ↓
    /// Slide 2
    ///      ↓
    /// Slide 3
    ///      ↓
    /// Slide 1
    ///
    /// Existing timer is always removed before creating a new one
    /// to prevent multiple timers running simultaneously.
    func startAutoScroll() {

        timer?.invalidate()

        timer = Timer.scheduledTimer(withTimeInterval: 3,
                                     repeats: true) { [weak self] _ in

            self?.moveToNextSlide()
        }
    }

    /// Moves CollectionView to next page.
    ///
    /// currentIndex progression:
    ///
    /// 0 → 1 → 2 → 0 → 1 → 2 ...
    ///
    /// When the last page is reached,
    /// index resets back to zero.
    func moveToNextSlide() {

        currentIndex += 1

        if currentIndex >= totalItems {
            currentIndex = 0
        }

        let indexPath = IndexPath(item: currentIndex,
                                  section: 0)

        collectionView.scrollToItem(
            at: indexPath,
            at: .centeredHorizontally,
            animated: true
        )
    }
}

// MARK: - CollectionView

extension ViewController: UICollectionViewDelegate,
                          UICollectionViewDataSource,
                          UICollectionViewDelegateFlowLayout {

    /// Total slides.
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return totalItems
    }

    /// Creates each slide.
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CollectionViewCell",
            for: indexPath
        ) as? CollectionViewCell else {

            return UICollectionViewCell()
        }

        return cell
    }

    /// Every cell occupies the entire CollectionView.
    ///
    /// This creates the paging effect.
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath)
    -> CGSize {

        return CGSize(
            width: collectionView.bounds.width,
            height: collectionView.bounds.height
        )
    }

    /// Remove all outer spacing.
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int)
    -> UIEdgeInsets {

        .zero
    }

    /// Remove horizontal spacing between pages.
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int)
    -> CGFloat {

        0
    }

    /// Remove vertical spacing.
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int)
    -> CGFloat {

        0
    }
}

// MARK: - PageControl Animation

extension ViewController {

    /// Called continuously while CollectionView is scrolling.
    ///
    /// Instead of changing pages only when scrolling ends,
    /// CHIPageControl uses a "progress" value.
    ///
    /// Example:
    ///
    /// Page 0 ----25%----50%----75%----100%---- Page 1
    ///
    /// progress:
    /// 0.0 → 0.25 → 0.50 → 0.75 → 1.0
    ///
    /// This is what creates CHIPageControl's smooth animation.
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let progress = scrollView.contentOffset.x / scrollView.frame.width
        pgcontrol.progress = progress
    }
}

// MARK: - Synchronize Current Page

extension ViewController {

    /// User finished dragging manually.
    ///
    /// Update currentIndex so the timer
    /// continues from the correct page.
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        currentIndex = Int(
            scrollView.contentOffset.x / scrollView.frame.width
        )
    }

    /// Auto-scroll animation completed.
    ///
    /// Keep currentIndex synchronized with
    /// the page currently displayed.
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {

        currentIndex = Int(
            scrollView.contentOffset.x / scrollView.frame.width
        )
    }
}
