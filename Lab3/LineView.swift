//
//  LineView.swift
//  Lab3
//
//  Created by Reis Sirdas on 2/15/17.
//  Copyright © 2017 sirdas. All rights reserved.
//

import UIKit

class LineView: UIView {
    
    var theLine: Line? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code

        theLine?.path.lineWidth = (theLine?.thickness)!
        theLine?.color.setStroke()
        theLine?.path.stroke()
        
    }
}

