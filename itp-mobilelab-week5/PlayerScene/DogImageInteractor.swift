//
//  DogImageInteractor.swift
//  itp-mobilelab-week5
//
//  Created by Diego Cruz on 2/28/18.
//  Copyright © 2018 Sebastian Buys. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DogImageInteractor {
    //MARK: - Properties
    //MARK: Private
    private class var apiURLString: String {
        return "https://dog.ceo/api/breeds/image/random"
    }
    
    //MARK: - Public methods
    public class func getRandomImageURLString(completion: @escaping (_ : String?)->()) {
        Alamofire.request(apiURLString).responseJSON { (response) in
            guard let responseValue = response.result.value else {
                completion(nil)
                return
            }
            
            let json = JSON(responseValue)
            completion(json["message"].string)
        }
    }
}
