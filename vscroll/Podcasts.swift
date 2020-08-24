//
//  Podcasts.swift
//  vscroll
//
//  Created by Russell Harrower on 18/8/20.
//  Copyright © 2020 Russell Harrower. All rights reserved.
//

import SwiftUI

struct Podcasts: View {
    
     let post: Program
    
    
    @State var podcast: [PodProgram] = []
    
    var body: some View {
      
     
            List(podcast) {podcast in
                 Button(action: {
                    MusicPlayer.shared.startBackgroundMusic(url:"https://\(podcast.enclosureurl)", type: "podcast")
                    MusicPlayer.shared.getArtBoard(artist: self.post.title, song: podcast.title, cover:self.post.icon)
                   
                   }) {
                        Text(podcast.title)
                }
                    
            }
            .onAppear{
                //Send data to dataA
               
            //RUN CODE TO Fetch podcast episodes.
                
                print("podcast")
                PodApi().getPodcast(podurl: self.post.url){ (podcast) in
                    self.podcast = podcast
                }
            }
            .navigationBarTitle(Text(post.title), displayMode: .inline)
            .navigationBarHidden(false)
            .navigationBarBackButtonHidden(false)
           
      
        
        
    
    }
        
}

