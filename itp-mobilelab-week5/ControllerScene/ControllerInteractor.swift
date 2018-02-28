//
//  ControllerInteractor.swift
//  itp-mobilelab-week5
//
//  Created by Diego Cruz on 2/28/18.
//  Copyright © 2018 Sebastian Buys. All rights reserved.
//

import UIKit
import Starscream

class ControllerInteractor {
    //MARK: - Properties
    public static let shared = ControllerInteractor()
    public enum Direction: String {
        case up = "0"
        case down = "1"
        case left = "2"
        case right = "3"
        case none = "9999"
        
        var value: String {
            return self.rawValue
        }
    }
    public var direction:Direction = .none {
        didSet {
            didSetDirection()
        }
    }
    
    //MARK: Private
    private var serverMessage: String? {
        guard   let playerName = PlayerInteractor.shared.playerName,
                direction != .none else {
                return nil
        }
        
        return "\(playerName), \(direction.value)"
    }
    //
    private var timer: Timer?
    
    //MARK: - Private methods
    //MARK: didSet
    private func didSetDirection() {
        resetTimer()
    }
    
    //MARK: Timer
    private func resetTimer() {
        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(handleTimer(_:)), userInfo: nil, repeats: true)
    }
    
    @objc private func handleTimer(_ timer:Timer) {
        sendDirection()
    }
    
    //Util
    private func sendDirection() {
        guard let message = serverMessage else {
            return
        }
        
        ServerInteractor.shared.send(message: message)
    }
}
