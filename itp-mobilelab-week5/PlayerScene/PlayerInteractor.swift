//
//  PlayerInteractor.swift
//  itp-mobilelab-week5
//
//  Created by Diego Cruz on 2/28/18.
//  Copyright © 2018 Sebastian Buys. All rights reserved.
//

import UIKit

class PlayerInteractor {
    //MARK: - Properties
    //MARK: Public
    public static let shared = PlayerInteractor()
    public var playerName: String? {
        get {
            return DefaultKey.playerName.value
        }
        set {
            DefaultKey.playerName.set(newValue)
        }
    }
    public var playerImageURLString: String? {
        get {
            return DefaultKey.playerImageURLString.value
        }
        set {
            DefaultKey.playerImageURLString.set(newValue)
        }
    }
    public var playerImageURL: URL? {
        guard let urlString = self.playerImageURLString else {
            return nil
        }
        
        return URL(string:urlString)
    }
    
    //MARK: Private
    private enum DefaultKey:String {
        case playerName = "playerName"
        case playerImageURLString = "playerImageURLString"
        
        var key: String {
            return self.rawValue
        }
        var value: String? {
            return userDefaults.string(forKey: self.key)
        }
        func set(_ newValue:String?) {
            userDefaults.set(newValue, forKey: self.key)
        }
    }
    private class var userDefaults: UserDefaults {
        return UserDefaults.standard
    }
    
    //MARK: - Public methods
    //MARK: Util
    public func updatePlayerImageURL(completion: @escaping (_ :URL?)->()) {
        DogImageInteractor.getRandomImageURLString { (urlString) in
            self.playerImageURLString = urlString
            self.sendPlayerImageToServer()
            completion(self.playerImageURL)
        }
    }
    
    //MARK: - Private methods
    //MARK: Server
    private func sendPlayerImageToServer() {
        guard   let playerName = playerName,
                let playerImageURLString = playerImageURLString else {
            return
        }
        
        let message = "\(playerName), profile_image:\(playerImageURLString)"
        ServerInteractor.shared.send(message: message)
    }
}
