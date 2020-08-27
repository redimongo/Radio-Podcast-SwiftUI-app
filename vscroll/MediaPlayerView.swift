//
//  MediaPlayerView.swift
//  vscroll
//
//  Created by Russell Harrower on 21/8/20.
//  Copyright © 2020 Russell Harrower. All rights reserved.
//

import SwiftUI
import Kingfisher
import KingfisherSwiftUI

struct MediaPlayerView: SwiftUI.View {
    
    @State private var uuid = UIDevice.current.identifierForVendor?.uuidString
    @State private var selection = 1
    @State private var playingtye = ""
   //@State var NowPlayingInfo: [NowPlayingData] = []
    @State private var artist = ""
    @State private var song = ""
    @State private var cover = ""
    @State private var advertlink = ""
    @State private var refreshrate = 2.0
    @State var showingDetail = false
   // private let options: KingfisherOptionsInfo = [.processor(ResizingImageProcessor(referenceSize: .init(width:UIScreen.main.bounds.width - 20,height:UIScreen.main.bounds.height / 3)))]
    
    @State private var playing = ""
    var body: some SwiftUI.View {
        
       GeometryReader { geo in
        Group {
            if self.cover.isEmpty {
            Text("Loading")
        }
        else{
        if geo.size.height == 270 {
                 
                                      
            
                    VStack{
                     
                    
                        KFImage(URL(string: self.cover)!, options: [.processor(ResizingImageProcessor(referenceSize: .init(width: geo.size.width,height:300)))])
                            .resizable()
                            
                            .renderingMode(.original)
                            .offset(x: 0, y: 0)
                            //.clipShape(Circle())
                            .shadow(radius: 0)
                            //.overlay(Circle().stroke(Color.green, lineWidth: 5))
                            .overlay(
                             Rectangle()
                             .fill(Color.black)
                             .frame(width:geo.size.width)
                             .opacity(0.8)
                                .overlay(
                                    HStack(alignment:.center){
                                        VStack(alignment: .leading){
                                                if UIDevice.current.userInterfaceIdiom == .pad{
                                                    self.selection == 0 ? Image(systemName: "play.circle").resizable().scaledToFit().frame(width: geo.size.width * 0.05) : Image(systemName: "pause.circle").resizable().scaledToFit().frame(width: geo.size.width * 0.05)
                                                }
                                                else
                                                {
                                                    self.selection == 0 ? Image(systemName: "play.circle").resizable().scaledToFit().frame(width: geo.size.width * 0.1) : Image(systemName: "pause.circle").resizable().scaledToFit().frame(width: geo.size.width * 0.1)
                                                }
                                            }
                                               .foregroundColor(Color.white)
                                               .frame(width: 40)
                                                                   
                                             .onTapGesture {
                                               self.selection == 1 ?
                                                MusicPlayer.shared.player?.pause()
                                               :
                                                MusicPlayer.shared.player?.play()
                                                                       
                                                if(self.selection == 1) {
                                                   self.selection = 0
                                                 }
                                                 else{
                                                    self.selection = 1
                                                 }
                                            }.frame(width: 40)
                                       
                                            VStack(alignment: .trailing)
                                            {
                                             
                                               Text(self.artist)
                                                .font(.system(size: 24))
                                                .foregroundColor(Color.white)
                                                .fontWeight(.medium)
                                                .multilineTextAlignment(.leading)
                                                .frame(width: geo.size.width * 1)
                                     
                                            Text(self.song)
                                                .font(.system(size: 18))
                                                .foregroundColor(Color.white)
                                                .fontWeight(.light)
                                                .fixedSize(horizontal: false, vertical: true)
                                                .multilineTextAlignment(.leading)
                                                .frame(width: geo.size.width * 1)
                                                
                                               
                                              
                                            }.frame(width: geo.size.width * 0.85)
                                            
                                            
                                    }.frame(width: geo.size.width)
                                    
                                , alignment: .trailing)
                             
                            .frame(width:geo.size.width, height: 80)
                            , alignment: .bottomTrailing)
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 250)
                            
                        
                       
                      
                        
                    }
                } else {
                  // START LARGE MEDIA PLAYER
                    
                    
                    VStack{
                       // Text(String(uuid!))
                        //Text(playingtye)
                    
                        KFImage(URL(string: self.cover)!)
                            .resizable()
                            .renderingMode(.original)
                            .shadow(radius: 0)
                            .aspectRatio(contentMode: .fill)
                            .frame(width:geo.size.width, height: 250)
                        
                            .onTapGesture {
                                                           if(self.advertlink != "")
                                                           {
                                                               if let url = URL(string: self.advertlink) {
                                                                   UIApplication.shared.open(url)
                                                               }
                                                           }
                                                           else{
                                                           
                                                           }
                                                       }
                            //.padding(EdgeInsets(top: geo.size.height * 0.0, leading: 10, bottom: 10, trailing: 10))
                            .frame(width: geo.size.width * 1.0, height: geo.size.width * 1.0)
                      
                        
                         Text(self.artist)
                                   .font(.system(size: 24))
                                   //.foregroundColor(Color.white)
                                   .fontWeight(.medium)
                                   .multilineTextAlignment(.leading)
                                   .frame(width: geo.size.width * 1.0)
                        
                               Text(self.song)
                                   .font(.system(size: 18))
                                   //.foregroundColor(Color.white)
                                   .fontWeight(.light)
                                   .multilineTextAlignment(.leading)
                                   .frame(width: geo.size.width * 1.0)
                        
                        
                        VStack{
                            self.selection == 0 ? Image(systemName: "play.circle").resizable().scaledToFit().frame(width: geo.size.width * 0.2) : Image(systemName: "pause.circle").resizable().scaledToFit().frame(width: geo.size.width * 0.2)
                           
                        }
                            
                        .onTapGesture {
                           self.selection == 1 ?
                                MusicPlayer.shared.player?.pause()
                            :
                                 MusicPlayer.shared.player?.play()
                                
                            if(self.selection == 1) {
                                  self.selection = 0
                            }
                            else{
                                  self.selection = 1
                            }
                        }
                    }
                    //
                    
                    }
                }
        }
            }
          //  Text(playing)
        
            .onAppear{
             //   self.refreshrate = 2.0
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
                    MusicPlayer().gettype { type in
                          self.playingtye = type
                    }
                
                
                if(self.playingtye == "radio"){
                    AdStichrApi().getSong(station: AdStichrApi.station){ (AdStichrNP) in
                   //     self.cover = AdStichrNP.imageurl ?? ""
                        if(self.cover != AdStichrNP.imageurl)
                        {
                            self.cover = AdStichrNP.imageurl!
                            self.advertlink = AdStichrNP.url ?? ""
                        }
                        if(self.song != AdStichrNP.title && self.artist != AdStichrNP.artist)
                        {
                            self.artist = AdStichrNP.artist
                            self.song = AdStichrNP.title
                            
                             MusicPlayer.shared.getArtBoard(artist: self.song, song: self.artist, cover: self.cover)
                                                      
                        }
                       // print(AdStichrNP)
                    }
                    
                    
                      //  self.artist = "Station Name"
                      //  self.song = "SONG Playing"
                      //  self.cover = "https://storage.googleapis.com/ad-system/campaigns/ssad01771688PeterZapfella.png"
                }else if(self.playingtye == "podcast")
                {
                     MusicPlayer().getPodCastPlayerNP{ (podcast) in
                        if(self.cover != podcast.cover)
                        {
                            self.artist = podcast.artist
                            self.song = podcast.song
                            self.cover = podcast.cover
                        }
                    }
                  
               
                }
                else{
                    MusicPlayer().gettype { type in
                          self.playingtye = type
                    }
                }
                
                if(MusicPlayer.shared.player!.rate != 0)
                {
                    self.playing = "yes"
                    self.selection = 1
                }
                else
                {
                    self.playing = "no"
                    self.selection = 0
                }
                }
                
        }
          
    }
}

struct MediaPlayerView_Previews: SwiftUI.PreviewProvider {
    static var previews: some SwiftUI.View {
        MediaPlayerView()
    }
}
