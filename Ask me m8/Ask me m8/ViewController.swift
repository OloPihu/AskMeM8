//
//  ViewController.swift
//  Ask me m8
//
//  Created by Aleksander  on 21/05/2019.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ballImageView: UIImageView!
    @IBOutlet weak var buttonView: UIButton!
    
    var random8BallIndex: Int = 0
    
    let ballArray = ["ball1","ball2","ball3","ball4","ball5"]
    let image = UIImage(named: "ball") as UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ballImageView.image = image
        
        placeholderText()
        
        textField.delegate = self
        
        titleLabel.text = "Ask me m8"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont(name:"BradleyHandITCTT-Bold", size: 40)
        
        buttonView.setTitle("Ask" , for: .normal)
        buttonView.setTitleColor( .white , for: .normal)
        buttonView.titleLabel?.font = UIFont(name:"BradleyHandITCTT-Bold", size: 40)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.text == "Type question..." {
            
            textField.text = ""
            textField.textColor = UIColor.black
            textField.font = UIFont(name:"BradleyHandITCTT-Bold", size: 20)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            
            placeholderText()
        }
    }
    
    func textField (_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text == "\n" {
            textField.resignFirstResponder()
            
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillChange(notification: Notification) {
        
        guard ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil else {
            return
        }
        
        if notification.name == UIResponder.keyboardWillShowNotification ||
            notification.name == UIResponder.keyboardWillChangeFrameNotification {
            
            view.frame.origin.y = -150
            
        } else {
            
            view.frame.origin.y = 0
            
        }
        
    }
    
    func updateBallImage() {
        
        random8BallIndex = Int(arc4random_uniform(5))
        
        print("ball answered: \(random8BallIndex)")
        
        ballImageView.image = UIImage(named: ballArray[random8BallIndex])
        
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        
        askingQuestion()
        
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        askingQuestion()
        
    }
    
    func placeholderText() {
        
        textField.text = "Type question..."
        textField.textColor = UIColor.lightGray
        textField.font = UIFont(name:"BradleyHandITCTT-Bold", size: 20)
        
    }
    
    // TODO: ustawic inne image na ""
    func askingQuestion() {
        
        if textField.text == "Type question..." {
            
            ballImageView.image = UIImage(named: "noQuestionBall")
            
            print("ask me")
            
        } else if textField.text != "Type question..." {
            
            textField.resignFirstResponder()
            updateBallImage()
            placeholderText()
            SoundService.playSound(.shake)
        }
        
    }
    
}


