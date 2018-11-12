//
//  ViewController.swift
//  Lab3
//
//  Created by Reis Sirdas on 2/15/17. Used Tray View and Animation code from https://guides.codepath.com/ios/Moving-and-Transforming-Views-with-Gestures
//  Copyright © 2017 sirdas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var canvas: CanvasView!
    @IBOutlet weak var tray: UIView!
    var trayOriginalCenter: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    @IBOutlet weak var redValue: UILabel!
    @IBOutlet weak var greenValue: UILabel!
    @IBOutlet weak var blueValue: UILabel!
    @IBOutlet weak var mysteryButton: UIButton!
    var red: CGFloat = 1
    var green: CGFloat = 1
    var blue: CGFloat = 1
    
    override func viewDidLoad() {
        trayDownOffset = 160
        trayUp = tray.center
        trayDown = CGPoint(x: tray.center.x ,y: tray.center.y + trayDownOffset)
        tray.center = trayDown
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didClear(_ sender: Any) {
        for v in canvas.subviews {
            v.removeFromSuperview()
        }
    }

    @IBAction func didUndo(_ sender: Any) {
        canvas.subviews.last?.removeFromSuperview()
    }
    
    @IBAction func didSlide(_ sender: UISlider) {
        canvas.thickness = CGFloat(sender.value)
    }

    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        //print("translation \(translation)")
        if sender.state == UIGestureRecognizerState.began {
            trayOriginalCenter = tray.center
            
        } else if sender.state == UIGestureRecognizerState.changed {
            tray.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            
        } else if sender.state == UIGestureRecognizerState.ended {
            let velocity = sender.velocity(in: view)
            if velocity.y > 0 {
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.tray.center = self.trayDown
                }, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.tray.center = self.trayUp
                })
            }
            
        }
    }

    @IBAction func pressedRed(_ sender: Any) {
        canvas.color = UIColor.red
    }
    
    @IBAction func pressedBlue(_ sender: Any) {
        canvas.color = UIColor.blue
    }
    
    @IBAction func pressedYellow(_ sender: Any) {
        canvas.color = UIColor.yellow
    }
    
    @IBAction func pressedGreen(_ sender: Any) {
        canvas.color = UIColor.green
    }
    
    @IBAction func pressedBrown(_ sender: Any) {
        canvas.color = UIColor.brown
    }

    @IBAction func pressedBlack(_ sender: Any) {
        canvas.color = UIColor.black
    }
    
    @IBAction func pressedMystery(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.tray.center = self.trayUp
        })
        canvas.color = mysteryButton.backgroundColor!
    }
    
    @IBAction func changeRed(_ sender: UISlider) {
        red = CGFloat(Int(sender.value)) / 255
        redValue.text =  "\(Int(sender.value))"
        mysteryButton.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        canvas.color = mysteryButton.backgroundColor!
    }

    @IBAction func changeGreen(_ sender: UISlider) {
        green = CGFloat(Int(sender.value)) / 255
        greenValue.text =  "\(Int(sender.value))"
        mysteryButton.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        canvas.color = mysteryButton.backgroundColor!
    }
    
    @IBAction func changeBlue(_ sender: UISlider) {
        blue = CGFloat(Int(sender.value)) / 255
        blueValue.text =  "\(Int(sender.value))"
        mysteryButton.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        canvas.color = mysteryButton.backgroundColor!
    }
}

