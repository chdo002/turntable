//
//  TurntableView.swift
//  EZY3D
//
//  Created by yr on 2016/11/14.
//  Copyright © 2016年 yw. All rights reserved.
//
import UIKit

protocol TurntableViewDelegate: NSObjectProtocol {
    // 拨轮转动到某个数字
    func turnTalbeDidStopedby(content: String)
}

class TurntableView: UIView {
    
    weak var delegate: TurntableViewDelegate?

    // 转盘
    private(set) var vie : PanView!
    
    // 转盘上的数字
    private(set) var selectNubers: [String]!
    
    // 每个扇区的弧度
    private(set) var selectRange: CGFloat!
    
    let screenW = UIScreen.main.bounds.width

    
    public init(frame: CGRect, target: TurntableViewDelegate,numbers: [String]){
        super.init(frame: frame)

        backgroundColor = UIColor.clear
        
        selectNubers = numbers
        selectRange = 2 * CGFloat.pi / CGFloat(numbers.count)
        delegate = target
        
        vie = PanView(frame: bounds, selectNubers: numbers)
        addSubview(vie)
        clipsToBounds = true
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(pan(ges:)))
        addGestureRecognizer(pan)
    }
    
    // 拖拽事件
    var startAngle : CGFloat = 0 // 初始弧度
    var touchBeginAngle: CGFloat! // 触摸开始时手指的弧度
    var currentAngle   : CGFloat! // 手指移动中时转盘的变形弧度
    var isMoved = false  // 装盘是否被移动过
    
    var startLocaion: CGPoint!
    var startTransForm: CGAffineTransform!
    
    func pan(ges: UIPanGestureRecognizer){
        let state = ges.state
        switch state {
        case .began:
            self.startLocaion   = ges.location(in: self) // 手势开始位置
            self.startTransForm = self.vie.transform
        case .changed:
            
            let anchor = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.5)
            let currentLocation = ges.location(in: self)
            
            let v1 = CGVector(dx: startLocaion.x - anchor.x, dy: startLocaion.y - anchor.y)
            let v2 = CGVector(dx: currentLocation.x - anchor.x, dy: currentLocation.y - anchor.y)
            let angle = atan2(v2.dy, v2.dx) - atan2(v1.dy, v1.dx)
            
            self.vie.transform = self.startTransForm.rotated(by: angle)
            
        default:
            
            let rotaion     = atan2(self.vie.transform.b, self.vie.transform.a)
            let positFlag   = rotaion > 0
            var absRotation = abs(rotaion)
            let reminder    = absRotation.remainder(dividingBy: selectRange)
            
            if reminder > 0.5 {
                absRotation = absRotation - reminder
                absRotation = absRotation + selectRange
            } else if reminder < 0.5 {
                absRotation = absRotation - reminder
            }
            
            absRotation     = positFlag ? absRotation : -absRotation
            
            UIView.animate(withDuration: 0.1, animations: { [weak self] in
                guard self != nil else { return }
                self!.vie.transform = CGAffineTransform(rotationAngle: absRotation)
            }, completion: { [weak self] (_) in
                guard self != nil else { return }
                var index = Int(abs(absRotation / self!.selectRange))
                if positFlag && index != 0 {
                    index = self!.selectNubers.count - index
                }
                self?.delegate?.turnTalbeDidStopedby(content: self!.selectNubers[index])
            })
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
