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
    
    init(viewModel: SelfieBotAnalysisViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        let imageView = UIImageView(image: viewModel.image)
        let selfieBotSaysLabel = UILabel()
        let qouteLabel = UILabel()
        
        imageView.contentMode = .scaleAspectFit
        
        selfieBotSaysLabel.textAlignment = .center
        selfieBotSaysLabel.text = "Selfie bot says"
        
        qouteLabel.textAlignment = .center
        qouteLabel.text = viewModel.qoute
        qouteLabel.numberOfLines = 0
        
        view.backgroundColor = UIColor.white
        
        let analysisView = AnalysisView(options: viewModel.options)
        
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
            
            make.left.right.equalTo(view).inset(50)
            make.top.equalTo(selfieBotSaysLabel.snp.bottom).offset(10)
        }
        
        analysisView.snp.makeConstraints {
            make in
            
            make.top.equalTo(qouteLabel).inset(40)
            make.left.right.equalTo(view).inset(50  )
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}