//
//  AudioManager.swift
//  MC3-FitMotion
//
//  Created by Vebrillia Santoso on 23/07/24.
//

import AVFoundation

class AudioManager: ObservableObject{
    private var effectPlayer: AVAudioPlayer?

    static let shared = AudioManager()

    @Published var sfxVolume: Double = 50 {
        didSet{
            updateSFXVolume()
        }
    }
    private func updateSFXVolume(){
        effectPlayer?.volume = Float(sfxVolume / 100.0)
    }

    func playSoundEffect(named effectName: String){
        guard let audio = Bundle.main.url(forResource: effectName, withExtension: "mp3") else {
            print("Sound effect file not found")
            return
        }
        do{
            effectPlayer = try AVAudioPlayer(contentsOf: audio)
            effectPlayer?.volume = Float(sfxVolume / 100.0)
            effectPlayer?.play()
        }catch{
            print("Could not load sound effect: \(error)")
        }
    }
}
