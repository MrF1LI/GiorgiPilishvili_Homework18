//
//  TriangleView.swift
//  GiorgiPilishvili_Homework18
//
//  Created by GIORGI PILISSHVILI on 19.07.22.
//

import Foundation
import UIKit

class TriangleView : UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {

        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        context.addLine(to: CGPoint(x: (rect.maxX / 2.0), y: rect.minY))
        context.closePath()

        context.setFillColor(self.tintColor?.cgColor ?? UIColor.systemPink.cgColor)
        context.fillPath()
    }
    
}
