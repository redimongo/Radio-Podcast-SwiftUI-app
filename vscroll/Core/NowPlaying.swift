//
//  NowPlaying.swift
//  vscroll
//
//  Created by Russell Harrower on 25/8/20.
//  Copyright © 2020 Radio Media PTY LTD. All rights reserved.
//
import UIKit
import SwiftUI

// Add this top level struct to
// decode properly

// NowPlaying Radio Station Script

struct Nowplayng: Decodable{
    let data: [Data]
}

struct Data: Decodable{
    let track: Trackinfo
}
struct Trackinfo: Decodable {
    let title: String
    let artist: String
    let imageurl: String?
    let type: String?
    let url: String?
}



class AdStichrApi {
static var station = "DRN1"
    
    
    
    //Func to update Now playing info
   
   // Func to print data
   func getSong(station:String,completion: @escaping (Trackinfo) -> ()) {
  
    let stationurl = station
   
    
    
    guard let urls = URL(string: "https://api.drn1.com.au:9000/nowplaying/\(stationurl)?uuid=\(MusicPlayer.uuid!)") else { return }
              
              
              URLSession.shared.dataTask(with: urls) { ( data, _, _) in
             
            
               // Based on the updated structs, you would no
                  // longer be decoding an array
                if(data != nil){
                 
               let podcast = try! JSONDecoder().decode(Nowplayng.self, from: data!)
                   //print(data!)
                  // let episode = podcast.programs
                  DispatchQueue.main.async{
                      // The array is stored under programs now
                   
                    completion(podcast.data.first!.track)
                    //updateNotification()
                  }
                }
              }
       .resume()
    
   }
    
    
    func PlayAudio(){
          DispatchQueue.main.async{
            MusicPlayer().startBackgroundMusic(url: "http://stream.radiomedia.com.au:8003/stream",type: "radio")
          }
    }
    
}
