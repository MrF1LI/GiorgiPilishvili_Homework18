//
//  SecondViewController.swift
//  GiorgiPilishvili_Homework18
//
//  Created by GIORGI PILISSHVILI on 19.07.22.
//

import UIKit

class SecondViewController: UIViewController {
    
    enum Shape {
        case redCircle
        case blueCircle
        case purpleTriangle
        case blackTriangle
    }
    
    // MARK: Variables

    @IBOutlet weak var animationChooser: UISegmentedControl!
    @IBOutlet weak var imageView: UIImageView!
    
    var startTime: NSDate? // For imageview press duration
    var shape: Shape?
    var imageViewAnimation: UIView.AnimationOptions = .transitionCrossDissolve
    
    // MARK: Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAnimationChooser()
        configureImageViewFunction()
    }
    
    // MARK: Functions
    
    func configureAnimationChooser() {
        if shape != .blueCircle {
            animationChooser.isHidden = true
        }
    }
    
    func configureImageViewFunction() {
        switch shape {
        case .redCircle:
            addImageViewLongPress()
        case .blueCircle:
            addImageViewLongPress()
        case .purpleTriangle:
            addImageViewSwipe()
        case .blackTriangle:
            addImageViewPinch()
        default:
            addImageViewLongPress()
        }
    }
    
    // MARK: ImageView Long Press

    func addImageViewLongPress() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(imageViewAction))
        longPressGesture.minimumPressDuration = 0
        imageView.addGestureRecognizer(longPressGesture)
    }
    
    @objc func imageViewAction(gesture: UILongPressGestureRecognizer) {
        
        if gesture.state == .began {
            startTime = NSDate()
        } else if gesture.state == .ended {
            
            let duration = NSDate().timeIntervalSince(startTime! as Date)
            
            if shape == .redCircle {
                if duration < 1 {
                    dismiss(animated: true)
                }
            } else {
                if duration > 1 {
                    UIView.transition(with: view, duration: 0.5, options: imageViewAnimation, animations: {
                        self.imageView.isHidden = true
                    })
                }
            }
            
        }
        
    }
    
    // MARK: ImageView Pinch
    
    func addImageViewPinch() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(imageViewPinch))
        imageView.addGestureRecognizer(pinchGesture)
    }
    
    @objc func imageViewPinch(gesture: UIPinchGestureRecognizer) {
        
        if gesture.state == .began || gesture.state == .changed {
            gesture.view?.transform = (gesture.view?.transform.scaledBy(x: gesture.scale, y: gesture.scale))!
            gesture.scale = 1
        } else {
            if imageView.frame.width > view.frame.width {
                self.imageView.transform = CGAffineTransform.identity
                
                let name = "learn.GiorgiPilishvili-Homework18.changeColor"
                NotificationCenter.default.post(name: Notification.Name(name), object: nil, userInfo: nil)
            }
        }
        
    }
    
    // MARK: ImageView Swipe
    
    func addImageViewSwipe() {
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(imageViewSwipe))
        leftSwipeGesture.direction = .left
        
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(imageViewSwipe))
        rightSwipeGesture.direction = .right
        
        let upSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(imageViewSwipe))
        upSwipeGesture.direction = .up
        
        let downSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(imageViewSwipe))
        downSwipeGesture.direction = .down
        
        imageView.addGestureRecognizer(leftSwipeGesture)
        imageView.addGestureRecognizer(rightSwipeGesture)
        imageView.addGestureRecognizer(upSwipeGesture)
        imageView.addGestureRecognizer(downSwipeGesture)
    }
    
    @objc func imageViewSwipe(gesture: UISwipeGestureRecognizer) {
    
        switch gesture.direction {
        case .right:
            increaseX(gesture: gesture)
        case .left:
            decreaseX(gesture: gesture)
        case .up:
            decreaseY(gesture: gesture)
        case .down:
            increaseY(gesture: gesture)
        default:
            decreaseX(gesture: gesture)
        }
        
    }
    
    func increaseX(gesture: UISwipeGestureRecognizer) {
        let width = imageView.frame.width
        let height = imageView.frame.height
        
        let positionX = imageView.frame.origin.x + 50
        let positionY = imageView.frame.origin.y
        
        UIView.animate(withDuration: 1.0, animations: {
            self.imageView.frame = CGRect(x: positionX, y: positionY, width: width, height: height)
        })
    }
    
    func decreaseX(gesture: UISwipeGestureRecognizer) {
        let width = imageView.frame.width
        let height = imageView.frame.height
        
        let positionX = imageView.frame.origin.x - 50
        let positionY = imageView.frame.origin.y
        
        UIView.animate(withDuration: 1.0, animations: {
            self.imageView.frame = CGRect(x: positionX, y: positionY, width: width, height: height)
        })
    }
    
    func increaseY(gesture: UISwipeGestureRecognizer) {
        let width = imageView.frame.width
        let height = imageView.frame.height
        
        let positionX = imageView.frame.origin.x
        let positionY = imageView.frame.origin.y + 50
        
        UIView.animate(withDuration: 1.0, animations: {
            self.imageView.frame = CGRect(x: positionX, y: positionY, width: width, height: height)
        })
    }
    
    func decreaseY(gesture: UISwipeGestureRecognizer) {
        let width = imageView.frame.width
        let height = imageView.frame.height
        
        let positionX = imageView.frame.origin.x
        let positionY = imageView.frame.origin.y - 50
        
        UIView.animate(withDuration: 1.0, animations: {
            self.imageView.frame = CGRect(x: positionX, y: positionY, width: width, height: height)
        })
    }
    
    // Change ImageView hide animation
    
    @IBAction func changeAnimation(_ sender: UISegmentedControl) {
        let animations: [UIView.AnimationOptions] = [
            .transitionCrossDissolve, .transitionCurlUp, .transitionCurlDown
        ]
        self.imageViewAnimation = animations[sender.selectedSegmentIndex]
    }
    
    // Back Button

    @IBAction func backButtonAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
