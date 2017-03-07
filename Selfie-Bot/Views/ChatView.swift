//
//  ChatView.swift
//  Selfie-Bot
//
//  Created by Simeon on 22/2/17.
//  Copyright © 2017 Enabled. All rights reserved.
//

import UIKit
import SnapKit

protocol ChatViewContent {
    
    var view: UIView { get }
    
    func update(_ originalView: UIView, elapsedTime: TimeInterval, duration: TimeInterval)
}

class ChatView: UIView {
    
    private typealias ContentQueueItem = (ChatViewContent, TimeInterval)
    
    private var elapsedTime: TimeInterval = 0.0
    private var chatContent: [ContentQueueItem] = []
    private var displayLink: CADisplayLink!
    
    private let outerContainer = UIView()
    private let contentContainer = UIView()
    private var activeContentView: UIView?
    
    init() {
        super.init(frame: .zero)
        
        displayLink = CADisplayLink(target: self, selector: #selector(displayUpdate(_:)))
        displayLink.isPaused = true
        displayLink.add(to: .current, forMode: .defaultRunLoopMode)
        
        alpha = 0.0
        
        addSubview(outerContainer)
        
        outerContainer.layer.cornerRadius = 6.0
        
        outerContainer.snp.makeConstraints {
            make in
            
            make.edges.equalTo(self)
        }
        
        outerContainer.addSubview(contentContainer)
        
        contentContainer.snp.makeConstraints {
            make in
            
            make.edges.equalTo(outerContainer).inset(12)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Background Color
    
    override var backgroundColor: UIColor? {
        set {
            outerContainer.backgroundColor = newValue
        }
        get {
            return outerContainer.backgroundColor
        }
    }
    
    //MARK: - Presentation
    
    func present(_ content: ChatViewContent, duration: TimeInterval) {
        chatContent.append((content, duration))
        
        if chatContent.count == 1 {
            //Start presenting this content after we fade in
            UIView.animate(withDuration: 0.1, animations: {
                self.alpha = 1.0
            }, completion: { finished in
                self.displayLink.isPaused = false
            })
        }
    }
    
    //MARK: - Display Link
    
    @objc private func displayUpdate(_ sender: CADisplayLink) {
        
        guard chatContent.count > 0 else {
            sender.isPaused = true
            
            UIView.animate(withDuration: 0.1, animations: {
                self.alpha = 0.0
            })
            
            return
        }
        
        let (content, duration) = chatContent[0]
        
        if elapsedTime == 0.0 {
            activeContentView = content.view
            contentContainer.addSubview(activeContentView!)
            
            activeContentView!.snp.makeConstraints {
                make in
                
                make.edges.equalTo(contentContainer)
            }
            
            setNeedsLayout()
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.95, options: [], animations: {
                self.layoutIfNeeded()
            }, completion: nil)
        }
        
        if elapsedTime > duration {
            activeContentView?.removeFromSuperview()
            chatContent.removeFirst()
            elapsedTime = 0.0
            
            return
        }
        
        content.update(activeContentView!, elapsedTime: elapsedTime, duration: duration)
        elapsedTime += sender.duration
    }

}

extension String: ChatViewContent {
    var view: UIView {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 22, weight: UIFontWeightBlack)
        label.attributedText = NSAttributedString(string: self, attributes: [NSForegroundColorAttributeName : UIColor.clear])
        label.text = self
        label.numberOfLines = 0
        label.textColor = .white
        
        return label
    }
    
    func update(_ originalView: UIView, elapsedTime: TimeInterval, duration: TimeInterval) {
        guard let label = originalView as? UILabel else {
            return
        }
        
        //y = -(1 / (x+1)) + 1
        let revealDuration = (-(1/(duration + 1)) + 1) * duration
        
        let count = Double(self.characters.count)
        let visibleCharacterCount = Double(min(elapsedTime / revealDuration, 1.0) * count)
        
        let attribString = NSMutableAttributedString(string: self, attributes: [NSForegroundColorAttributeName : UIColor.clear])
        attribString.setAttributes([NSForegroundColorAttributeName : UIColor.white], range: NSMakeRange(0, Int(floor(visibleCharacterCount))))
        let partialAlpha = visibleCharacterCount - floor(visibleCharacterCount)
        if partialAlpha > 0.0 {
            attribString.setAttributes([NSForegroundColorAttributeName : UIColor(white: 1.0, alpha: CGFloat(partialAlpha))], range: NSMakeRange(Int(floor(visibleCharacterCount)), 1))
        }
        
        label.attributedText = attribString
    }
}
