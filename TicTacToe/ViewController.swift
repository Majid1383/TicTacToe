//
//  ViewController.swift
//  TicTacToe
//
//  Created by AbdulMajid Shaikh on 10/11/24.
//

import UIKit
import SwiftyGif


class ViewController: UIViewController {
  
    @IBOutlet weak var lblPlayerX: UILabel!
    @IBOutlet weak var lblPlayerO: UILabel!
    @IBOutlet weak var btnPlayAgain: UIButton!
    @IBOutlet weak var imgAnimation: UIImageView!
    @IBOutlet weak var lblStatus: UILabel!
    
    var activePlayer = 1  // x is active
    var gameState : [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    let winningCombinations = [[0, 1, 2],
                               [3, 4, 5],
                               [6, 7, 8],
                               [0, 3, 6],
                               [1, 4, 7],
                               [2, 5, 8],
                               [0, 4, 8],
                               [2, 4, 6]]
    
    var gameIsActive = true
    var totalWinsForX : Int = 0
    var totalWinsForO : Int = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        btnPlayAgain.isHidden = true
        btnPlayAgain.layer.cornerRadius = 5
        btnPlayAgain.layer.masksToBounds = true
    }
    
    
    @IBAction func actionBtnClicked(_ sender: AnyObject) {
        guard let index = sender.tag else { return }
        
        
        if (gameState[index - 1] == 0) && gameIsActive {
            gameState[index - 1] = activePlayer
            
            if (activePlayer == 1){
                print("BUtton is getting tapped,", index)
                sender.setImage(UIImage(named: "tictactoeX"), for: UIControl.State())
                activePlayer = 2 //2nd player is active now which is, 0
            }else {
                sender.setImage(UIImage(named: "tictactoeO"), for: UIControl.State())
                activePlayer = 1 // 1st player is active now which is X
            }
            
        }
        
        for combination in winningCombinations {
            if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]] {
                
                if gameState[combination[0]] == 1 {
                    totalWinsForX += 1
                    lblPlayerX.text = "Player X win's \(totalWinsForX) times!"
                    lblStatus.text = "Player X Won!😅"
                    startAnimation()
                    disableButtons()
                    
                }else {
                    totalWinsForO += 1
                    lblPlayerO.text = "Player O win's \(totalWinsForO) times!"
                    lblStatus.text = "Player O Won!😅"
                    startAnimation()
                    disableButtons()
                    
                }
                
                btnPlayAgain.isHidden = false
                
            }
        }
        
        gameIsActive = false
        
        for i in gameState {
            if i == 0 {
                gameIsActive = true
                break
            }
        }
        
        if gameIsActive == false {
            lblStatus.text = "Match is DRAW😅"
            disableButtons()
            lblStatus.isHidden = false
            btnPlayAgain.isHidden = false
        }
 
    }
  
    
    @IBAction func btnPlayAgainClicked(_ sender: UIButton) {
        enableButtons()
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        gameIsActive = true
        activePlayer = 1
        lblStatus.text = ""
        
        btnPlayAgain.isHidden = true
        
        for i in 1...9 {
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(UIImage(named: ""), for: UIControl.State())
        }
    }
    
    
    func enableButtons(){
        for i in 1...9 {
            let button = view.viewWithTag(i) as! UIButton
            button.isEnabled = true
        }
    }
    
    func disableButtons(){
        for i in 1...9 {
            let button = view.viewWithTag(i) as! UIButton
            button.isEnabled = false
        }
    }
    
    
    func startAnimation(){
       
        do {
            let gif = try! UIImage(gifName: "success.gif", levelOfIntegrity:0.5 )
            self.imgAnimation.setGifImage(gif, loopCount: 1)
            
        }catch {
            print("DEBUG: code went into Catch block!")
        }
    }
     
}

