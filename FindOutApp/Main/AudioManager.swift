//
//  AudioManager.swift
//  FindOutApp
//
//  Created by cmStudent on 2024/10/31.
//

import AVFoundation
import SwiftUI

class AudioManager: ObservableObject {
    static let shared = AudioManager()
    private var audioPlayer: AVAudioPlayer?
    
    @Published var isMusicOn: Bool = true // 控制音乐开关
    @Published var volume: Float = 0.5 // 默认音量

    private init() {}

    // 播放背景音乐
    func playBackgroundMusic(for level: Int) {
        guard isMusicOn else { return }
        
        let musicFile = level == 1 ? "bgm1" : "bgm2"
        
        if let url = Bundle.main.url(forResource: musicFile, withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.numberOfLoops = -1 // 无限循环
                audioPlayer?.volume = volume
                audioPlayer?.play()
            } catch {
                print("无法播放音乐：\(error)")
            }
        }
    }
    
    // 停止音乐播放
    func stopMusic() {
        audioPlayer?.stop()
    }

    // 更新音量
    func updateVolume(to newVolume: Float) {
        volume = newVolume
        audioPlayer?.volume = volume
    }
}

