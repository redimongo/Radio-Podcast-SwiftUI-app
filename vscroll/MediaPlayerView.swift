//
//  MediaPlayerView.swift
//  vscroll
//
//  Created by Russell Harrower on 21/8/20.
//  Copyright © 2020 Russell Harrower. All rights reserved.
//

import SwiftUI
import RemoteImage

struct MediaPlayerView: View {
    @State private var uuid = UIDevice.current.identifierForVendor?.uuidString
    @State private var playingtye = ""
   //@State var NowPlayingInfo: [NowPlayingData] = []
    @State private var artist = ""
    @State private var song = ""
    @State private var cover = "https://storage.googleapis.com/ad-system/campaigns/ssad01771688PeterZapfella.png"
    @State private var refreshrate = 2.0
    
    
    
    @State private var playing = ""
    var body: some View {
       GeometryReader { geo in
                  if geo.size.height == 250 {
                 
                    VStack{
                       // Text(String(uuid!))
                        //Text(playingtye)
                    
                        RemoteImage(type: .url(URL(string: self.cover)!), errorView: { error in
                              Text(error.localizedDescription)
                           }, imageView: { image in
                             image
                            .resizable()
                            //.offset(x: 0, y: 20)
                            .renderingMode(.original)
                            //.clipShape(Circle())
                            .shadow(radius: 0)
                            //.overlay(Circle().stroke(Color.green, lineWidth: 5))
                            .overlay(
                             Rectangle()
                             .fill(Color.black)
                             .opacity(0.8)
                                .overlay(
                                   VStack
                                    {
                                       Text(self.artist)
                                        .font(.system(size: 24))
                                        .foregroundColor(Color.white)
                                        .fontWeight(.medium)
                                        .multilineTextAlignment(.leading)
                                        .frame(width: geo.size.width * 1.0)
                             
                                    Text(self.song)
                                        .font(.system(size: 18))
                                        .foregroundColor(Color.white)
                                        .fontWeight(.light)
                                        .multilineTextAlignment(.leading)
                                        .frame(width: geo.size.width * 1.0)
                                }
                                , alignment: .leading)
                             
                            .frame(width:geo.size.width * 1.0, height: 80)
                            , alignment: .bottomTrailing)
                            .aspectRatio(contentMode: .fill)
                            .frame(width:geo.size.width, height: 160)
                        }, loadingView: {
                            Text("Loading ...")
                        })
                            //.padding(EdgeInsets(top: geo.size.height * 0.0, leading: 10, bottom: 10, trailing: 10))
                            .frame(width: geo.size.width * 1.0, height: 160)
                       
                        /*Text(self.artist)
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                            .multilineTextAlignment(.center)
                            .frame(width: geo.size.width * 1.0)
                       
                        Text(self.song)
                            .font(.system(size: 12))
                            .fontWeight(.light)
                            .multilineTextAlignment(.leading)
                            .frame(width: geo.size.width * 1.0)
                        */
                        
                    }
                } else {
                  // START LARGE MEDIA PLAYER
                    
                    
                    VStack{
                       // Text(String(uuid!))
                        //Text(playingtye)
                    
                        RemoteImage(type: .url(URL(string: self.cover)!), errorView: { error in
                              Text(error.localizedDescription)
                           }, imageView: { image in
                             image
                            .resizable()
                            //.offset(x: 0, y: 20)
                            .renderingMode(.original)
                            //.clipShape(Circle())
                            .shadow(radius: 0)
                            //.overlay(Circle().stroke(Color.green, lineWidth: 5))
                            .overlay(
                             Rectangle()
                             .fill(Color.black)
                             .opacity(0.8)
                                .overlay(
                                   VStack
                                    {
                                       Text(self.artist)
                                        .font(.system(size: 24))
                                        .foregroundColor(Color.white)
                                        .fontWeight(.medium)
                                        .multilineTextAlignment(.leading)
                                        .frame(width: geo.size.width * 1.0)
                             
                                    Text(self.song)
                                        .font(.system(size: 18))
                                        .foregroundColor(Color.white)
                                        .fontWeight(.light)
                                        .multilineTextAlignment(.leading)
                                        .frame(width: geo.size.width * 1.0)
                                }
                                , alignment: .leading)
                             
                            .frame(width:geo.size.width * 1.0, height: 80)
                            , alignment: .bottomTrailing)
                            .aspectRatio(contentMode: .fill)
                            .frame(width:geo.size.width, height: 250)
                        }, loadingView: {
                            Text("Loading ...")
                        })
                            //.padding(EdgeInsets(top: geo.size.height * 0.0, leading: 10, bottom: 10, trailing: 10))
                            .frame(width: geo.size.width * 1.0, height: 250)
                    }
                    //
                    
                    }
                }
            
          //  Text(playing)
        
            .onAppear{
             //   self.refreshrate = 2.0
               
                    MusicPlayer().gettype { type in
                          self.playingtye = type
                    }
                
                if(self.playingtye == "radio"){
                        self.artist = "Station Name"
                        self.song = "SONG Playing"
                        self.cover = "https://storage.googleapis.com/ad-system/campaigns/ssad01771688PeterZapfella.png"
                }else if(self.playingtye == "podcast")
                {
                     MusicPlayer().getPodCastPlayerNP{ (podcast) in
                      self.artist = podcast.artist
                      self.song = podcast.song
                      self.cover = podcast.cover
                     //  print(podcast.song)
                      //  self.NowPlayingInfo = podcast
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
                }
                else
                {
                    self.playing = "no"
                }
        }
          
    }
}

struct smallMediaPlayerView: View {
    @State var showingDetail = false
    var body: some View {
        VStack{
           
            Button(action: {
                self.showingDetail.toggle()
            }) {
            Color.red
                Text("SMALL MEDIA PLAYER")
            }
            .sheet(isPresented: self.$showingDetail) {
                    MediaPlayerView()
            }
        }
        .frame(maxHeight: .infinity) // <- this
        
    }
}

struct MediaPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        MediaPlayerView()
    }
}
