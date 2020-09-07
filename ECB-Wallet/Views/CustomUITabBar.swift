//
//  CustomUITabBar.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/20/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit
@IBDesignable
class CustomUITabBar: UITabBar {

    private var shapeLayer: CALayer?

    override func draw(_ rect: CGRect) {
        self.addShape()
    }

    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.fillColor = #colorLiteral(red: 0.9529411765, green: 0.9647058824, blue: 1, alpha: 1)
        shapeLayer.lineWidth = 0.5
        shapeLayer.shadowOffset = CGSize(width:0, height:0)
        shapeLayer.shadowRadius = 10
        shapeLayer.shadowColor = UIColor.gray.cgColor
        shapeLayer.shadowOpacity = 0.3

        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
    }

    func createPath() -> CGPath {
        let height: CGFloat = 60
        let h = self.frame.height/2
                let path = UIBezierPath()
                let centerWidth = self.frame.width / 2

                path.move(to: CGPoint(x: 0, y: 0)) // start top left
                
                path.addLine(to: CGPoint(x: (centerWidth - height * 1), y: 0)) // the beginning of the trough

                // first curve down
        //        path.addCurve(to: CGPoint(x: centerWidth, y: -30),
        //                      controlPoint1: CGPoint(x: (centerWidth - 30), y: 0), controlPoint2: CGPoint(x: centerWidth - 30, y: -30))
                path.addCurve(to: CGPoint(x: centerWidth, y: h),
                controlPoint1: CGPoint(x: (centerWidth - 30), y: 0), controlPoint2: CGPoint(x: centerWidth - 30, y: h))
                // second curve up
        //        path.addCurve(to: CGPoint(x: (centerWidth + height * 2), y: 0),
        //                      controlPoint1: CGPoint(x: centerWidth + 30, y: -30), controlPoint2: CGPoint(x: (centerWidth + 30), y: 0))
                path.addCurve(to: CGPoint(x: (centerWidth + height * 1), y: 0),
                controlPoint1: CGPoint(x: centerWidth + 30, y: h), controlPoint2: CGPoint(x: (centerWidth + 30), y: 0))

                // complete the rect
                path.addLine(to: CGPoint(x: self.frame.width, y: 0))
                path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
                path.addLine(to: CGPoint(x: 0, y: self.frame.height))
                path.close()

                return path.cgPath
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !clipsToBounds && !isHidden && alpha > 0 else { return nil }
        for member in subviews.reversed() {
            let subPoint = member.convert(point, from: self)
            guard let result = member.hitTest(subPoint, with: event) else { continue }
            return result
        }
        return nil
    }

}
