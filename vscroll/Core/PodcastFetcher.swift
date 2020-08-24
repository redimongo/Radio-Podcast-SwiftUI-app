//
//  PodcastFetcher.swift
//  vscroll
//
//  Created by Russell Harrower on 21/8/20.
//  Copyright © 2020 Russell Harrower. All rights reserved.
//

import SwiftUI

// Add this top level struct to
// decode properly

// PODCASTS
struct PodPost: Codable {
    var programs: [PodEpisode]
}

struct PodEpisode: Codable {
    var episode : [PodProgram]
}

struct PodProgram: Codable, Identifiable {
    let id = UUID()
    var title : String
    var enclosureurl : String
    var summary : String
}






class PodApi {
   // Func to print data
   func getPodcast(podurl:String,completion: @escaping ([PodProgram]) -> ()) {
     
    
    
       
    let podurl = podurl
    
        guard let url = URL(string: "https://api.drn1.com.au/api-access/programs/\(podurl)") else { return }
           
           URLSession.shared.dataTask(with: url) { ( data, _, _) in
          
         
            // Based on the updated structs, you would no
               // longer be decoding an array
              
            let podcast = try! JSONDecoder().decode(PodPost.self, from: data!)
                //print(data!)
               // let episode = podcast.programs
               DispatchQueue.main.async{
                   // The array is stored under programs now
                
                completion(podcast.programs.first!.episode)
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
