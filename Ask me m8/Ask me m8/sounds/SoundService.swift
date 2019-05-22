//
//  SoundService.swift
//  Ask me m8
//
//  Created by Aleksander  on 22/05/2019.
//

import Foundation
import  AVFoundation

class SoundService {
    
    static var audioPlayer:AVAudioPlayer?
    
    enum SoundObjects {
        
        case shake
        
    }
    
    static func playSound(_ effect:SoundObjects) {
        
        var soundName = ""
        
        switch effect {
       
        case .shake:
            soundName = "ballShake"
            
        }
        
        let bundlePath = Bundle.main.path(forResource: soundName, ofType: "wav")
        
        guard bundlePath != nil else {
            
            print("Couldn't find sound file named \(soundName) in the bundle")
            return

            
        }
        
        let soundUrl = URL(fileURLWithPath: bundlePath!)
        do {
            
            audioPlayer = try AVAudioPlayer(contentsOf: soundUrl)
            audioPlayer?.play()
            
        }
        catch {
            
            print("Couldn't create the audio player object for sound file \(soundName)")
            
        }
        
    }
    
}
