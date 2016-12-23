//
//  ViewController.swift
//  Animatronic-Example
//
//  Created by Artem Novichkov on 23/12/2016.
//  Copyright © 2016 ArtemNovichkov. All rights reserved.
//

import UIKit
import Animatronic

fileprivate extension UIButton {
    
    static func custom(with title: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        return button
    }
}

class ViewController: UIViewController {
    
    let startButton: UIButton = .custom(with: "Start")
    let stopAfterLoopButton: UIButton = .custom(with: "Loop Stop")
    let stopButton: UIButton = .custom(with: "Stop")
    let firstImageSwitch = UISwitch(frame: .zero)
    let lastImageSwitch = UISwitch(frame: .zero)
    var buttonView = UIView(frame: .zero)
    let animatronic = Animatronic()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animatronic.imagesData = Animatronic.imagesData(from: "lines 03")
        view.addSubview(animatronic)
        
        buttonView.backgroundColor = .red
        view.addSubview(buttonView)
        
        startButton.addTarget(self, action: #selector(start), for: .touchUpInside)
        stopAfterLoopButton.addTarget(self, action: #selector(stopAfterLoop), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(stop), for: .touchUpInside)
        
        buttonView.addSubview(startButton)
        buttonView.addSubview(stopAfterLoopButton)
        buttonView.addSubview(stopButton)
        
        firstImageSwitch.addTarget(self, action: #selector(firstImageAction(sender:)), for: .valueChanged)
        lastImageSwitch.addTarget(self, action: #selector(lastImageAction(sender:)), for: .valueChanged)
        buttonView.addSubview(firstImageSwitch)
        buttonView.addSubview(lastImageSwitch)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let height: CGFloat = 128
        let width: CGFloat = view.bounds.width
        buttonView.frame = CGRect(x: 0, y: view.bounds.height - height, width: width, height: height)
        animatronic.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - height)
        startButton.frame = CGRect(x: 0, y: 0, width: width / 3, height: height / 2)
        stopAfterLoopButton.frame = CGRect(x: width / 3, y: 0, width: width / 3, height: height / 2)
        stopButton.frame = CGRect(x: width / 3 * 2, y: 0, width: width / 3, height: height / 2)
        firstImageSwitch.frame = CGRect(x: 0, y: height / 2, width: width / 2, height: height / 2)
        lastImageSwitch.frame = CGRect(x: width / 2, y: height / 2, width: width / 2, height: height / 2)
    }
    
    func start() {
        animatronic.start()
    }
    
    func stopAfterLoop() {
        animatronic.stopAfterLoop {
            print("Finish")
        }
    }
    
    func stop() {
        animatronic.stop()
    }
    
    func firstImageAction(sender: UISwitch) {
        animatronic.keepFirstAnimationImage = sender.isOn
        if sender.isOn {
            animatronic.imagesData = Animatronic.imagesData(from: "lines 03")
        }
    }
    
    func lastImageAction(sender: UISwitch) {
        animatronic.keepLastAnimationImage = sender.isOn
    }
}

