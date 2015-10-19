//
//  ViewController.swift
//  GestureDemo
//
//  Created by aven on 10/19/15.
//  Copyright (c) 2015 aven. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK pan/drag
    var helloLabel: UILabel!
    var panGestureRecognizer: UIPanGestureRecognizer!
    //MARK swipe
    var swipeRecognier: UISwipeGestureRecognizer!
    
    //MARK rotation
    var rotateLabel: UILabel!
    var rotationRecognizer: UIRotationGestureRecognizer!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let labelFrame = CGRect(x: 0, y: 0, width: 150, height: 150)
        helloLabel = UILabel(frame: labelFrame)
        helloLabel.userInteractionEnabled = true
        helloLabel.text = "Hello Pan Gesture"
        helloLabel.frame = labelFrame
        helloLabel.backgroundColor = UIColor.blackColor()
        helloLabel.textColor = UIColor.whiteColor()
        helloLabel.textAlignment = .Center
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGestures:")
        
        //swipe
        swipeRecognier = UISwipeGestureRecognizer(target: self, action: "handleSwipes:")
        
        //rotation
        rotateLabel = UILabel(frame: CGRect(x: 200, y: 200, width: 200, height: 200))
        rotateLabel.font = UIFont.systemFontOfSize(16)
        rotateLabel.text = "Rotation label"
        rotateLabel.sizeToFit()

        rotationRecognizer = UIRotationGestureRecognizer(target: self, action: "handleRotation:")
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(helloLabel)
        panGestureRecognizer.minimumNumberOfTouches = 1
        panGestureRecognizer.maximumNumberOfTouches = 1
        helloLabel.addGestureRecognizer(panGestureRecognizer)
        
        //swipe
        swipeRecognier.direction = .Left
        swipeRecognier.numberOfTouchesRequired = 1
        view.addGestureRecognizer(swipeRecognier)
        
        //rotation
        rotateLabel.center = view.center
        view.addSubview(rotateLabel)
        view.addGestureRecognizer(rotationRecognizer)
    }
    
    func handlePanGestures(sender: UIPanGestureRecognizer) {
        if sender.state != .Ended && sender.state != .Failed {
            sender.view?.center = sender.locationInView(sender.view?.superview)
        }
    }

    func handleSwipes(sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case UISwipeGestureRecognizerDirection.Down:
            println("Swipe Down")
            break
        case UISwipeGestureRecognizerDirection.Left:
            println("Swipe Left")
            break
        case UISwipeGestureRecognizerDirection.Up:
            println("Swipe Up")
            break
        case UISwipeGestureRecognizerDirection.Right:
            println("Swipe Right")
            break
        default:
            
            break
        }
    }
    
    var rotationAngleinRadians: CGFloat = 0
    
    func handleRotation(sender: UIRotationGestureRecognizer) {
        rotateLabel.transform = CGAffineTransformMakeRotation(sender.rotation+rotationAngleinRadians)
        if sender.state == .Ended {
            rotationAngleinRadians += sender.rotation
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

