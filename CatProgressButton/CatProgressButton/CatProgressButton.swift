//
//  CatProgressButton.swift
//  CatProgressButton
//
//  Created by K-cat on 16/7/8.
//  Copyright © 2016年 K-cat. All rights reserved.
//

import UIKit

public class CatProgressButton: UIControl {
    
    private var progressView: UIView = UIView()
    private var progressTitleLabel: UILabel = UILabel()
    private var titleLabel: UILabel = UILabel()
    private var touchView: UIView = UIView()
    
    /// Text for button's title
    public var title: String? {
        didSet {
            progressTitleLabel.text = title
            titleLabel.text = title
        }
    }
    
    /// Text color for button's title on the progress
    public var progressTitleColor: UIColor = UIColor.whiteColor() {
        didSet {
            progressTitleLabel.textColor = progressTitleColor
        }
    }
    
    /// Text color for button's title
    public var titleColor: UIColor = UIColor.blackColor() {
        didSet {
            titleLabel.textColor = titleColor
        }
    }
    
    /// Color for progress's background
    public var progressColor: UIColor = UIColor.blackColor() {
        didSet {
            progressView.backgroundColor = progressColor
        }
    }
    
    /// Color for button's background
    override public var backgroundColor: UIColor? {
        didSet {
            super.backgroundColor = backgroundColor
        }
    }
    
    public override var frame: CGRect {
        didSet {
//            super.frame = frame
            refreshLayout()
        }
    }
    
    /// Default duration for progress's move animation
    public var progressAnimationDuration: NSTimeInterval = 0.3
    
    /// The value of current progress
    public var progressValue: Double = 0 {
        didSet {
            refreshLayout()
            if progressValueChangeHandler != nil {
                progressValueChangeHandler!(progressValue: progressValue)
            }
        }
    }
    
    /// The handler will execute when progress value changed
    public var progressValueChangeHandler: ((progressValue: Double) -> Void)?
    
    /// The handler will execute when button clicked
    public var buttonOnClickHandler: ((progressButton: CatProgressButton) -> Void)?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initBaseLayout()
    }
    
    private func initBaseLayout() {
        titleLabel.frame = self.bounds
        titleLabel.textAlignment = .Center
        titleLabel.textColor = titleColor
        self.addSubview(titleLabel)
        
        progressView.frame = CGRectMake(0, 0, 0, CGRectGetHeight(self.bounds))
        progressView.backgroundColor = progressColor
        progressView.clipsToBounds = true
        self.addSubview(progressView)
        
        progressTitleLabel.frame = self.bounds
        progressTitleLabel.textAlignment = .Center
        progressTitleLabel.textColor = progressTitleColor
        progressView.addSubview(progressTitleLabel)
        
        touchView.frame = self.bounds
        touchView.backgroundColor = UIColor.clearColor()
        touchView.userInteractionEnabled = true
        self.addSubview(touchView)
        
        let touchGesture = UITapGestureRecognizer(target: self, action: #selector(buttonOnClick))
        touchView.addGestureRecognizer(touchGesture)
    }
    
    private func refreshLayout() {
        if progressValue <= 0 {
            UIView.animateWithDuration(progressAnimationDuration) {
                self.progressView.frame = CGRectMake(0, 0, 0, CGRectGetHeight(self.bounds))
            }
        } else if progressValue >= 1 {
            UIView.animateWithDuration(progressAnimationDuration) {
                self.progressView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))
            }
        } else {
            UIView.animateWithDuration(progressAnimationDuration) {
                self.progressView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds)*CGFloat(self.progressValue), CGRectGetHeight(self.bounds))
            }
        }
    }
    
    @objc private func buttonOnClick() {
        if buttonOnClickHandler != nil {
            buttonOnClickHandler!(progressButton: self)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
