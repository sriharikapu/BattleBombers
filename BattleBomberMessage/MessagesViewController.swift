//
//  MessagesViewController.swift
//  BattleBomberMessage
//
//  Created by Franky Aguilar on 2/14/19.
//  Copyright © 2019 Franky Aguilar. All rights reserved.
//

import UIKit
import Messages
import Celer
import QRCode
import SpriteKit

class MessagesViewController: MSMessagesAppViewController, BrianProtocol {
    

    @IBOutlet weak var ibo_qrCode:UIImageView?
    @IBOutlet weak var ibo_publicKey:UILabel?

    var ibo_explosion:UIImageView?
    var gameScene:GameScene?
    @IBOutlet var ibo_spriteView:SKView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.iba_createWallet()
//        if let scene = SKScene(fileNamed: "GameScene") {
//            // Set the scale mode to scale to fit the window
//            print("SCENE")
//            self.gameScene = scene as! GameScene
//            self.gameScene?.view = self.ibo
//        }

    }
    
    func didChangeState() {
        print("Changed")
    }
    
    @IBAction func iba_createWallet() {
        do {
            if EtherWallet.account.hasAccount == false {
                try EtherWallet.account.generateAccount(password: "")
            }
            
            let qrCode = QRCode(EtherWallet.account.address!)
            self.ibo_publicKey?.text = EtherWallet.account.address!
            ibo_qrCode?.image = qrCode!.image
            
        } catch {
            print(error)
        }
    }
    
    @IBAction func iba_plantBomb(sender:UIButton){
        sender.setImage(UIImage(named: "plot_plant.png"), for: .normal)
    
    }
    
    @IBAction func iba_submitMove() {
        self.gameScene?.saveGameStates()
        
        let layout = MSMessageTemplateLayout()
        layout.image = UIImage(named: "bomb.png")
        
        let message = MSMessage()
        message.url = URL(string: "WOW")
        message.layout = layout
        
        self.activeConversation!.insert(message) { error in
            if let error = error {
                print(error)
            }
        }
        
        self.dismiss()
    }
    // MARK: - Conversation Handling
    
    override func willBecomeActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the inactive to active state.
        // This will happen when the extension is about to present UI.
        
        // Use this method to configure the extension and restore previously stored state.
    }
    
    override func didResignActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the active to inactive state.
        // This will happen when the user dissmises the extension, changes to a different
        // conversation or quits Messages.
        
        // Use this method to release shared resources, save user data, invalidate timers,
        // and store enough state information to restore your extension to its current state
        // in case it is terminated later.
    }
   
    override func didReceive(_ message: MSMessage, conversation: MSConversation) {
        // Called when a message arrives that was generated by another instance of this
        // extension on a remote device.
        
        // Use this method to trigger UI updates in response to the message.
    }
    
    override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user taps the send button.
    }
    
    override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user deletes the message without sending it.
    
        // Use this to clean up state related to the deleted message.
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called before the extension transitions to a new presentation style.
    
        // Use this method to prepare for the change in presentation style.
    }
    
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called after the extension transitions to a new presentation style.
    
        // Use this method to finalize any behaviors associated with the change in presentation style.
    }

}
