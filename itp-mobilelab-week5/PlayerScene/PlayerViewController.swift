//
//  PlayerViewController.swift
//  itp-mobilelab-week5
//
//  Created by Diego Cruz on 2/28/18.
//  Copyright © 2018 Sebastian Buys. All rights reserved.
//

import UIKit
import SDWebImage

class PlayerViewController: UIViewController {
    //MARK: - Properties
    //MARK: Public
    
    //*** IBOutlets ***
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var playerImageView: UIImageView?
    @IBOutlet weak var playerImageViewLoadingView: UIView?
    @IBOutlet weak var playerNameTextField: UITextField?
    //*****************
    
    //MARK: Private
    private let oldPlayerName:String? = PlayerInteractor.shared.playerName
    
    //MARK: - Public methods
    //MARK: View events
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playerNameTextField?.becomeFirstResponder()
    }
    
    //MARK: - Private methods
    //MARK: Configure
    private func configure() {
        //*** TitleLabel ***
        func configureTitleLabel() {
            if let _ = PlayerInteractor.shared.playerName {
                titleLabel?.text = "Edit Player"
            } else {
                titleLabel?.text = "New Player"
            }
        }
        //******************

        //*** PlayerNameTextField ***
        func configurePlayerNameTextField() {
            playerNameTextField?.text = PlayerInteractor.shared.playerName
        }
        //***************************
        
        //*** PlayerImageView ***
        func configurePlayerImageView() {
            guard let playerImageURL = PlayerInteractor.shared.playerImageURL else {
                updatePlayerImageIfNeeded()
                return
            }
            
            playerImageView?.sd_setImage(with: playerImageURL)
        }
        //************************
        
        //
        configureTitleLabel()
        configurePlayerNameTextField()
        configurePlayerImageView()
    }
    
    //MARK: Util
    private func updatePlayerImageIfNeeded() {
        //*** Should Update ***
        func shouldUpdate() -> Bool{
            return PlayerInteractor.shared.playerImageURL == nil
        }
        //*********************
        
        //*** Update PlayerName ***
        func updatePlayerImage() {
            playerImageViewLoadingView?.isHidden = false
            PlayerInteractor.shared.updatePlayerImageURL {[weak self] (url) in
                self?.playerImageViewLoadingView?.isHidden = true
                self?.playerImageView?.sd_setImage(with: url)
            }
        }
        //*************************
        
        //
        if shouldUpdate() {
            updatePlayerImage()
        }
    }
    
    private func updatePlayerNameIfNeeded() {
        //*** Should Update ***
        func shouldUpdate() -> Bool{
            return playerNameTextField?.text != nil && oldPlayerName != playerNameTextField?.text
        }
        //*********************
        
        //*** Update PlayerName ***
        func updatePlayerName() {
            PlayerInteractor.shared.playerName = playerNameTextField?.text
        }
        //*************************
        
        //
        if shouldUpdate() {
            updatePlayerName()
        }
    }
}

//MARK: - Delegate methods
//MARK: UITextFieldDelegate
extension PlayerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        updatePlayerNameIfNeeded()
        textField.resignFirstResponder()
        presentingViewController?.dismiss(animated: true, completion: nil)
        return false
    }
}
