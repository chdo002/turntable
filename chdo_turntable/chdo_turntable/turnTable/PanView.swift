//
//  PanView.swift
//  EZY3D
//
//  Created by yr on 2016/11/14.
//  Copyright © 2016年 yw. All rights reserved.
//

import UIKit

class PanView: UIView {
    
    var font: UIFont = UIFont.systemFont(ofSize: 15) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    
    var textColor = UIColor.black {
        didSet {
            print("set")
        }
    }

    private(set) var labels = [UILabel?]()
    private(set) var selectNumbers: [String]!
    private(set) var selectedNumber = 0
    
    init(frame: CGRect,selectNubers:[String]) {
        super.init(frame: frame)
        
        selectNumbers = selectNubers
        backgroundColor = UIColor.clear
        loadSubView()
                
        let img = UIImageView(image: #imageLiteral(resourceName: "wheel"))
        img.frame = self.bounds
        img.contentMode = .scaleAspectFill
        addSubview(img)
    }
    
    
    let screenW = UIScreen.main.bounds.width
    
    func loadSubView() {
        // 圆盘半径
        let radius = self.frame.width / 2 * 0.8
        
        // 圆心
        let centerPoint = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        
        // 布局
        let textSize = "12".size(attributes: [NSFontAttributeName: font])
        for (i, v) in selectNumbers.enumerated() {
            
            let angle = (CGFloat.pi * 2 / CGFloat(selectNumbers.count)) * CGFloat(i)
            let x = cos(angle) * radius + centerPoint.x
            let y = sin(angle) * radius + centerPoint.y
            let labelX = x - textSize.width / 2
            let labelY = y - textSize.height / 2
            
            let labelRect = CGRect(x: labelX, y: labelY, width: textSize.width, height: textSize.height)
            
            let label = UILabel(frame: labelRect)
                label.text = v
                    
            label.textColor = textColor
            label.backgroundColor = UIColor.green
            label.transform = CGAffineTransform(rotationAngle: angle)
            self.addSubview(label)
            labels.append(label)
        }
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}


