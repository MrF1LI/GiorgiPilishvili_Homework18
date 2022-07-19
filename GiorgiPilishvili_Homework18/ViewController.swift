//
//  ViewController.swift
//  GiorgiPilishvili_Homework18
//
//  Created by GIORGI PILISSHVILI on 19.07.22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Variables

    @IBOutlet weak var figuresContainer: UIStackView!
        
    @IBOutlet weak var redCircle: UIView!
    @IBOutlet weak var blueCircle: UIView!
    @IBOutlet weak var purpleTriangle: UIView!
    @IBOutlet weak var blackTriangle: UIView!
    
    // MARK: Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureFiguresDesign()
        listenToNotification()
        configureActions()
    }
    
    // MARK: Init Functions
    
    func configureFiguresDesign() {
        let radius = redCircle.frame.size.width / 2
        redCircle.layer.cornerRadius = radius
        blueCircle.layer.cornerRadius = radius
        purpleTriangle.backgroundColor = UIColor(white: 1, alpha: 0)
        blackTriangle.backgroundColor = UIColor(white: 1, alpha: 0)
    }
    
    func listenToNotification() {
        let name = "learn.GiorgiPilishvili-Homework18.changeColor"
        NotificationCenter.default.addObserver(self, selector: #selector(changeBackgroundColor), name: Notification.Name(name), object: nil)
    }
    
    func configureActions() {
        let redCircleGesture = UITapGestureRecognizer(target: self, action: #selector(redCircleAction))
        let blueCircleGesture = UITapGestureRecognizer(target: self, action: #selector(blueCircleAction))
        let purpleTriangleGesture = UITapGestureRecognizer(target: self, action: #selector(purpleTriangleAction))
        let blackTriangleGesture = UITapGestureRecognizer(target: self, action: #selector(blackTriangleAction))
        
        redCircle.addGestureRecognizer(redCircleGesture)
        blueCircle.addGestureRecognizer(blueCircleGesture)
        purpleTriangle.addGestureRecognizer(purpleTriangleGesture)
        blackTriangle.addGestureRecognizer(blackTriangleGesture)
    }
    
    // Figure Actions
    
    @objc func redCircleAction() { openSecondViewController(shape: .redCircle) }
    
    @objc func blueCircleAction() { openSecondViewController(shape: .blueCircle) }
    
    @objc func purpleTriangleAction() { openSecondViewController(shape: .purpleTriangle) }
    
    @objc func blackTriangleAction() { openSecondViewController(shape: .blackTriangle) }
    
    func openSecondViewController(shape: SecondViewController.Shape) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        vc.shape = shape
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    // Other
    
    @objc func changeBackgroundColor() {
        let colors: [UIColor] = [.systemCyan, .systemGray4, .systemMint, .systemOrange, .systemYellow]
        view.backgroundColor = colors.randomElement()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
