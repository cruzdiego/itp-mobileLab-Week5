//
//  ControllerViewController.swift
//  itp-mobilelab-week5
//
//  Created by Diego Cruz on 2/28/18.
//  Copyright © 2018 Sebastian Buys. All rights reserved.
//

import UIKit
import SDWebImage

class ControllerViewController: UIViewController {

    //MARK: - Properties
    //MARK: Public
    
    //IBOutlets
    //*** ControllerView ***
    @IBOutlet weak var joystickView: UIView?
    //**********************
    
    //*** PlayerView ***
    @IBOutlet weak var playerImageView: UIImageView?
    @IBOutlet weak var playerNameLabel: UILabel?
    //******************
    
    //MARK: Private
    private enum Segue:String {
        case player = "playerSegue"
        
        var identifier: String {
            return self.rawValue
        }
    }
    
    //MARK: - Public methods
    //MARK: View events
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showPlayerSceneIfNeeded()
    }

    //MARK: Actions
    @IBAction func playerPressed(sender: UIControl) {
        showPlayerScene()
    }
    
    //MARK: - Private methods
    //MARK: Configure
    private func configure() {
        //*** PlayerView ***
        func configurePlayerView() {
            refreshPlayerView()
        }
        //******************
        
        //*** Observers ***
        func configureObservers() {
            let notificationCenter = NotificationCenter.default
            notificationCenter.addObserver(self, selector: #selector(onPlayerHasChanged(_:)), name: PlayerInteractor.Notification.playerHasChanged.name, object: nil)
        }
        //*****************
        
        //
        configurePlayerView()
        configureObservers()
    }
    
    //MARK: UI
    private func refreshPlayerView() {
        playerNameLabel?.text = PlayerInteractor.shared.playerName ?? "No Name"
        playerImageView?.sd_setImage(with: PlayerInteractor.shared.playerImageURL)
    }
    
    //MARK: Observers
    @objc private func onPlayerHasChanged(_ notification:Notification) {
        refreshPlayerView()
    }
    
    //MARK: Util
    private func showPlayerSceneIfNeeded() {
        if PlayerInteractor.shared.playerName == nil {
            showPlayerScene()
        }
    }
    
    private func showPlayerScene() {
        performSegue(withIdentifier: Segue.player.identifier, sender: self)
    }
}
