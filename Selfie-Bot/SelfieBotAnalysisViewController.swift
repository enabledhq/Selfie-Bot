//
//  SelfieBotCardViewController.swift
//  Selfie-Bot
//
//  Created by John Smith on 24/2/17.
//  Copyright © 2017 Enabled. All rights reserved.
//

import Foundation
import UIKit

class SelfieBotAnalysisViewController: ViewController {
    private let viewModel: SelfieBotAnalysisViewModel
    private let analysisView: AnalysisView
    
    init(viewModel: SelfieBotAnalysisViewModel) {
        self.viewModel = viewModel
        analysisView = AnalysisView(options: viewModel.options)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        let imageView = UIImageView(image: viewModel.image)
        let selfieBotSaysLabel = UILabel()
        let qouteLabel = UILabel()
        let textColor = UIColor(colorLiteralRed: 140 / 255, green: 140 / 255, blue: 140 / 255, alpha: 1)
        
        //Drop Shadow
        imageView.layer.shadowOffset = CGSize(width: -1.0, height: -1.0)
        imageView.layer.shadowOpacity = 0.5
        
        imageView.contentMode = .scaleAspectFit
        
        selfieBotSaysLabel.textAlignment = .center
        selfieBotSaysLabel.text = "Selfie bot says"
        selfieBotSaysLabel.textColor = textColor
        
        
        qouteLabel.textAlignment = .center
        qouteLabel.text = viewModel.qoute
        qouteLabel.numberOfLines = 0
        qouteLabel.font = UIFont.init(name: "ChalkboardSE-Light", size: 17)
        qouteLabel.textColor = textColor
        
        view.backgroundColor = UIColor.white
        

        view.addSubview(imageView)
        view.addSubview(selfieBotSaysLabel)
        view.addSubview(qouteLabel)
        view.addSubview(analysisView)
        
        imageView.snp.makeConstraints {
            make in
            
            make.height.equalTo(200)
            make.top.equalTo(view).inset(50)
            make.centerX.equalTo(view)
        }
        
        selfieBotSaysLabel.snp.makeConstraints {
            make in
            
            make.left.right.equalTo(view).inset(50)
            make.top.equalTo(imageView.snp.bottom).offset(20)
        }
        
        qouteLabel.snp.makeConstraints {
            make in
            
            make.left.right.equalTo(view).inset(70)
            make.top.equalTo(selfieBotSaysLabel.snp.bottom).offset(10)
        }
        
        analysisView.snp.makeConstraints {
            make in
            
            make.top.equalTo(qouteLabel).inset(40)
            make.left.right.equalTo(view).inset(50  )
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        analysisView.animateConfidenceBars()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
