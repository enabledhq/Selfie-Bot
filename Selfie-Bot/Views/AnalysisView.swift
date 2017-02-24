//
// Created by John Smith on 23/2/17.
// Copyright (c) 2017 Enabled. All rights reserved.
//

import Foundation
import SnapKit

class AnalysisView: UIView {


    var confidenceBars = [ConfidenceBar]()
    
    init(options: [String : Double]) {
        super.init(frame: CGRect())
        
        backgroundColor = UIColor.white
        
        //Format confidence bars
        var previousBar: UIView?
        options.enumerated().forEach {
            option in
            
            let confidenceBar = ConfidenceBar(CGFloat(option.element.value))
            let confidenceLabel = UILabel()
            
            confidenceLabel.text = option.element.key


            self.addSubview(confidenceLabel)
            self.addSubview(confidenceBar)
            
            confidenceLabel.snp.makeConstraints {
                make in
                
                make.height.equalTo(30)
                if let previousBar = previousBar {
                    make.top.equalTo(previousBar.snp.bottom).offset(10)
                } else {
                    make.top.equalTo(self)
                }
                
                make.left.equalTo(self).inset(10)
            }
            
            confidenceBar.snp.makeConstraints {
                make in
                
                make.left.right.equalTo(self).inset(10)
                make.top.equalTo(confidenceLabel.snp.bottom).offset(2.5)
                make.height.equalTo(30)
            }
            previousBar = confidenceBar
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
