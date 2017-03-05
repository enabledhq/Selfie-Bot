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
    
    func update(elapsedTime: TimeInterval, duration: TimeInterval)
}

class ChatView: UIView {
    
    private typealias ContentQueueItem = (ChatViewContent, TimeInterval)
    
    private var elapsedTime: TimeInterval = 0.0
    private var chatContent: [ContentQueueItem] = []
    private var displayLink: CADisplayLink!
    private let contentContainer = UIView()
    private var activeContentView: UIView?
    
    init() {
        super.init(frame: .zero)
        
        displayLink = CADisplayLink(target: self, selector: #selector(displayUpdate(_:)))
        displayLink.isPaused = true
        displayLink.add(to: RunLoop.current, forMode: .defaultRunLoopMode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Presentation
    
    func present(_ content: ChatViewContent, duration: TimeInterval) {
        chatContent.append((content, duration))
        
        if chatContent.count == 1 {
            //Start presenting this content immediately
            displayLink.isPaused = false
        }
    }
    
    //MARK: - Display Link
    
    @objc private func displayUpdate(_ sender: CADisplayLink) {
        
        guard chatContent.count > 0 else {
            sender.isPaused = true
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
        }
        
        if elapsedTime > duration {
            activeContentView?.removeFromSuperview()
            chatContent.removeFirst()
            elapsedTime = 0.0
            
            return
        }
        
        content.update(elapsedTime: elapsedTime, duration: duration)
        elapsedTime += sender.duration
    }

}

extension String: ChatViewContent {
    var view: UIView {
        let label = UILabel()
        label.text = self
        
        return label
    }
    
    func update(elapsedTime: TimeInterval, duration: TimeInterval) {
    }
}
