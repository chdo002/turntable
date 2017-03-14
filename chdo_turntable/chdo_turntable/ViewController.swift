//
//  ViewController.swift
//  chdo_turntable
//
//  Created by chdo on 2017/3/8.
//  Copyright © 2017年 yw. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TurntableViewDelegate {

    
    var selectWindow: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray

        var numbes = [String]()
        for i in 1...8 {
            numbes.append("\(i)")
        }
        
        let tableRect = CGRect(x: 5, y: 120, width: self.view.frame.width * 0.7, height: self.view.frame.width * 0.7)
        turntable = TurntableView(frame: tableRect, target: self, numbers: numbes)
        self.view.addSubview(turntable)
        
        let point = UIImageView(image: #imageLiteral(resourceName: "pointer"))
        self.view.addSubview(point)
        
        point.snp.makeConstraints { (mk) in
            mk.centerY.equalTo(self.turntable)
            mk.left.equalTo(self.turntable.snp.right).offset(20)
        }
        
        selectWindow = UILabel()
        selectWindow.textAlignment = .center
        self.view.addSubview(selectWindow)
        selectWindow.snp.makeConstraints { (mk) in
            mk.bottom.equalTo(point.snp.top).offset(-4)
            mk.centerX.equalTo(point)
        }
    }
    
    
    
    var turntable: TurntableView!
    func turnTalbeDidStopedby(content: String) {
        selectWindow.text = content
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        turntable.vie.font = UIFont.systemFont(ofSize: 10)
    }

}

