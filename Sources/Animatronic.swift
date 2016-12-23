//
//  Animatronic.swift
//  Animatronic
//
//  Created by Artem Novichkov on 23/12/2016.
//  Copyright © 2016 Rosberry. All rights reserved.
//

import UIKit
import QuartzCore

typealias StopHandler = (() -> Void)

class Animatronic: UIImageView {
    
    /// The array of `UIImage`s converted to `Data`
    var imagesData: [Data]? {
        didSet { reset() }
    }
    /// if YES, the Animatronic will display a first image after settings new images data
    var keepLastAnimationImage = false
    
    /// if YES, the Animatronic will display a firslast image after end of animation
    var keepFirstAnimationImage = false
    
    /// Duration per frame in images data
    var animationFrameDuration: TimeInterval
    
    private var displayLink: CADisplayLink?
    private var currentFrameIndex: Int = 0
    private var timeSinceLastAnimationFrame: TimeInterval = 0
    private var needStopRepeatingAnimation = false
    private var stopHandler: StopHandler?
    
    //MARK: - Lifecycle
    
    /// Initializes and returns a newly allocated Animatronic object with the specified duration per frame.
    ///
    /// - Parameter duration: Duration per frame in images data. Default duration is 1 / 60.
    init(duration: TimeInterval = 1 / 60) {
        animationFrameDuration = duration
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        invalidateTimerIfNeeded()
    }
    
    //MARK: - Public
    
    /// Starts animation. If the Animatronic are animating, it will stop previous animation.
    func start() {
        stop()
        update()
        startScreenUpdate()
    }
    
    /// Stops current animation.
    ///
    /// - Parameter forced: if YES, animation will stop immediately. Otherwise, animation will finish after last frame.
    func stop(forced: Bool = true) {
        if forced {
            resetToInitialStateIfNeeded()
            invalidateTimerIfNeeded()
        }
        else {
            needStopRepeatingAnimation = true
        }
    }
    
    /// Stops current animation after last frame with handler.
    ///
    /// - Parameter handler: Closure form handling end of animation
    func stopAfterLoop(with handler: @escaping StopHandler) {
        guard displayLink != nil else {
            handler()
            return
        }
        stopHandler = handler
        stop(forced: false)
    }
    
    /// Resets state of the Animatronic
    func reset() {
        invalidateTimerIfNeeded()
        currentFrameIndex = 0
        if keepFirstAnimationImage {
            update()
        }
        else {
            image = nil
        }
    }
    
    //MARK: - Private
    
    private func startScreenUpdate() {
        displayLink = CADisplayLink(target: self, selector: .update)
        if #available(iOS 10, *) {
            displayLink!.preferredFramesPerSecond = 50
        }
        displayLink!.add(to: RunLoop.main, forMode: .commonModes)
    }
    
    @objc fileprivate func updateFrame(displayLink: CADisplayLink)  {
        timeSinceLastAnimationFrame += displayLink.duration
        guard timeSinceLastAnimationFrame >= animationFrameDuration else {
            return
        }
        let nextIndex = currentFrameIndex + 1
        currentFrameIndex = nextIndex >= imagesData!.count ? 0 : nextIndex
        if currentFrameIndex == 0 && needStopRepeatingAnimation {
            stop()
            stopHandler?()
        }
        else {
            update()
        }
    }
    
    private func update() {
        if let imagesData = imagesData {
            image = UIImage(data: imagesData[currentFrameIndex])
        }
    }
    
    private func resetToInitialStateIfNeeded() {
        if !keepLastAnimationImage {
            currentFrameIndex = 0
            image = nil
        }
        needStopRepeatingAnimation = false
    }
    
    private func invalidateTimerIfNeeded() {
        if let displayLink = displayLink {
            displayLink.remove(from: RunLoop.main, forMode: .commonModes)
            self.displayLink = nil
        }
    }
}

fileprivate extension Selector {
    static let update = #selector(Animatronic.updateFrame(displayLink:))
}
