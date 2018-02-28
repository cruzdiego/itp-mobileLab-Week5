//
//  ServerInteractor.swift
//  itp-mobilelab-week5
//
//  Created by Diego Cruz on 2/28/18.
//  Copyright © 2018 Sebastian Buys. All rights reserved.
//

import UIKit
import Starscream

class ServerInteractor {
    //MARK: - Properties
    //MARK: Public
    public static let shared = ServerInteractor()
    
    //MARK: Private
    private let serverURLString = "ws://websockets.mobilelabclass.com:1024/"
    private lazy var serverURL: URL? = URL(string: serverURLString)
    //
    private lazy var serverSocket:WebSocket? = {
        guard let url = serverURL else {
            return nil
        }
        
        return WebSocket(url: url)
    }()
    
    //MARK: - Public methods
    //MARK: Util
    public func send(message:String) {
        serverSocket?.write(string: message)
    }
}
