//
//  ViewController.swift
//  CatProgressButtonExample
//
//  Created by K-cat on 16/7/9.
//  Copyright © 2016年 K-cat. All rights reserved.
//

import UIKit
import CatProgressButton

let blueColor = UIColor(red: 0.0000000000, green: 0.4568864703, blue: 0.7001402974, alpha: 1.0000000000)
let greenColor = UIColor(red: 0.1503065315, green: 0.7194610834, blue: 0.1177300118, alpha: 1.0000000000)

class ViewController: UIViewController {

    var progressButton: MyProgressButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressButton = MyProgressButton(frame: CGRectMake(0, 0, 150, 40))
        progressButton.center = self.view.center
        progressButton.title = "Download"
        progressButton.layer.cornerRadius = 20
        progressButton.progressColor = blueColor
        progressButton.titleColor = blueColor
        progressButton.layer.borderColor = blueColor.CGColor
        progressButton.layer.borderWidth = 1
        progressButton.layer.masksToBounds = true
        progressButton.progressAnimationDuration = 0.3
        self.view.addSubview(progressButton)
        
        progressButton.buttonOnClickHandler = {(button) in
            switch self.progressButton.buttonState {
            case .Download:
                self.halfProgress()
            case .Use:
                self.progressButton.buttonState = .Inuse
            default:
                break
            }
        }
        
        progressButton.progressValueChangeHandler = {(progressValue) in
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func maxProgress() {
        progressButton.buttonState = .Use
        progressButton.progressValue = 1
    }
    
    func halfProgress() {
        progressButton.buttonState = .Downloading
        progressButton.progressValue = 0.5
        self.performSelector(#selector(maxProgress), withObject: nil, afterDelay: 0.5)
    }
    
    func clearProgress() {
        progressButton.progressValue = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

enum ProgressButtonState {
    case Download
    case Downloading
    case Use
    case Inuse
}

class MyProgressButton: CatProgressButton {
    var buttonState: ProgressButtonState = .Download {
        didSet {
            switch buttonState {
            case .Download:
                self.title = "Download"
            case .Downloading:
                self.title = "Downloading"
            case .Use:
                self.title = "Use"
                self.progressColor = blueColor
                self.layer.borderColor = blueColor.CGColor
            case .Inuse:
                self.title = "Inuse"
                self.progressColor = greenColor
                self.layer.borderColor = greenColor.CGColor
            }
        }
    }
}

