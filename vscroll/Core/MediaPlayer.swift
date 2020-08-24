import SwiftUI
import Foundation
import AVFoundation
import MediaPlayer
import AVKit

struct NowPlayingData: Codable, Identifiable {
    let id = UUID()
    var artist : String
    var song : String
    var cover : String
}

class MusicPlayer {
static let shared = MusicPlayer()
static var mediatype = ""
static var artist = ""
static var song = ""
static var cover = ""


var player: AVPlayer?
let playerViewController = AVPlayerViewController()

    
    func gettype(completion: @escaping (String) -> Void){
        
          completion(MusicPlayer.mediatype)
     
    }
    
    func getPodCastPlayerNP(completion: @escaping (NowPlayingData) -> ()) {
     // Timer.scheduledTimer(withTimeInterval: 15, repeats: true) { (timer) in
        let songdata = "{\"id\": \"1\",\"song\": \"\(MusicPlayer.song)\",\"artist\": \"\(MusicPlayer.artist)\", \"cover\": \"\(MusicPlayer.cover)\"}"
        let data: Data? = songdata.data(using: .utf8)
        
        let podcast = try! JSONDecoder().decode(NowPlayingData.self, from: data!)
      
                       //print(data!)
                      // let episode = podcast.programs
                      DispatchQueue.main.async{
                          // The array is stored under programs now
                        //print(podcast)
                        completion(podcast)
                      }
       // }
    }

    func startBackgroundMusic(url: String, type:String) {
     
        MusicPlayer.mediatype = String(type)
        
        //let urlString = "http://stream.radiomedia.com.au:8003/stream"
        let urlString = url
        guard let url = URL.init(string: urlString) else { return }

        let playerItem = AVPlayerItem.init(url: url)
        player = AVPlayer.init(playerItem: playerItem)
        
      
        do {

            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.duckOthers, .defaultToSpeaker, .mixWithOthers, .allowAirPlay])
            print("Playback OK")
           // let defaults = UserDefaults.standard
           // defaults.set("1", forKey: defaultsKeys.musicplayer_connected)
            try AVAudioSession.sharedInstance().setActive(true)
            print("Session is Active")
        } catch {
           // let defaults = UserDefaults.standard
          //  defaults.set("0", forKey: defaultsKeys.musicplayer_connected)
            print(error)
        }

         #if targetEnvironment(simulator)

        self.playerViewController.player = player
        self.playerViewController.player?.play()
        print("SIMULATOR")

         #else

        self.setupRemoteTransportControls()
        player?.play()

        #endif
        

    }
    
    
    func startBackgroundMusicTwo() {

        
        let urlString = "http://stream.radiomedia.com.au:8003/stream"
        //let urlString = url
        guard let url = URL.init(string: urlString) else { return }

        let playerItem = AVPlayerItem.init(url: url)
        player = AVPlayer.init(playerItem: playerItem)
        
      
        do {

            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.duckOthers, .defaultToSpeaker, .mixWithOthers, .allowAirPlay])
            print("Playback OK")
           // let defaults = UserDefaults.standard
           // defaults.set("1", forKey: defaultsKeys.musicplayer_connected)
            try AVAudioSession.sharedInstance().setActive(true)
            print("Session is Active")
        } catch {
           // let defaults = UserDefaults.standard
          //  defaults.set("0", forKey: defaultsKeys.musicplayer_connected)
            print(error)
        }

         #if targetEnvironment(simulator)

        self.playerViewController.player = player
        self.playerViewController.player?.play()
        print("SIMULATOR")

         #else

        self.setupRemoteTransportControls()
        player?.play()

        #endif

    }




func setupRemoteTransportControls() {
   // Get the shared MPRemoteCommandCenter
    let commandCenter = MPRemoteCommandCenter.shared()

    // Add handler for Play Command
    commandCenter.playCommand.addTarget { [unowned self] event in
        if self.player?.rate == 0.0 {
            self.player?.play()
            return .success
        }
        return .commandFailed
    }

    // Add handler for Pause Command
    commandCenter.pauseCommand.addTarget { [unowned self] event in
        if self.player?.rate == 1.0 {
            self.player?.pause()
            return .success
        }
        return .commandFailed
    }

   // self.nowplaying(artist: "Anna", song: "test")


}

func nowplaying(with artwork: MPMediaItemArtwork, artist: String, song: String){
  

MPNowPlayingInfoCenter.default().nowPlayingInfo = [
      MPMediaItemPropertyTitle:song,
      MPMediaItemPropertyArtist:artist,
      MPMediaItemPropertyArtwork: artwork,
      MPNowPlayingInfoPropertyIsLiveStream: true
]


   // self.getArtBoard();
}


func setupNowPlayingInfo(with artwork: MPMediaItemArtwork) {
      MPNowPlayingInfoCenter.default().nowPlayingInfo = [
        //   MPMediaItemPropertyTitle: "Some name",
        //   MPMediaItemPropertyArtist: "Some name",
           MPMediaItemPropertyArtwork: artwork,
           //MPMediaItemPropertyPlaybackDuration: CMTimeGetSeconds(currentItem.duration),
           //MPNowPlayingInfoPropertyPlaybackRate: 1,
           //MPNowPlayingInfoPropertyElapsedPlaybackTime: CMTimeGetSeconds(currentItem.currentTime())
       ]
   }



func getData(from url: URL, completion: @escaping (UIImage?) -> Void) {
    URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
        if let data = data {
            completion(UIImage(data:data))
        }
    })
        .resume()
}

func getArtBoard(artist: String, song: String, cover: String) {
   // MusicPlayer.JN = "[{'artist': \(artist), 'song':\(song), 'cover': \(cover)}]"
    MusicPlayer.artist = artist
    MusicPlayer.song = song
    MusicPlayer.cover = cover
    
    
    guard let url = URL(string: cover) else { return }
    getData(from: url) { [weak self] image in
        guard let self = self,
            let downloadedImage = image else {
                return
        }
        let artwork = MPMediaItemArtwork.init(boundsSize: downloadedImage.size, requestHandler: { _ -> UIImage in
            return downloadedImage
        })
        self.nowplaying(with: artwork, artist: artist, song: song)
    }
}



    func stopBackgroundMusic() {
        guard let player = player else { return }
        player.pause()

}
}
