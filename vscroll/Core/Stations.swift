import SwiftUI

// Add this top level struct to
// decode properly

// PODCASTS
struct Post: Codable {
    var programs: [Program]
}

struct Program: Codable, Identifiable {
    let id = UUID()
    var title : String
    var url : String
    var icon : String
}


// STATION
struct Sdata: Codable {
    var data: [Station]
}

struct Station: Codable, Identifiable {
    let id = UUID()
    var name : String
    var imageurl : String
    var listenlive : String

}




class Api {
    
    func getShows(station:String,completion: @escaping ([Program]) -> ()) {
        guard let url = URL(string: "https://api.drn1.com.au/api-access/programs/\(station)") else { return }
          
          URLSession.shared.dataTask(with: url) { (data, _, _) in
              // Based on the updated structs, you would no
              // longer be decoding an array
              let post = try! JSONDecoder().decode(Post.self, from: data!)
              DispatchQueue.main.async{
                  // The array is stored under programs now
                  completion(post.programs)
              }
              
          }
      .resume()
      }
    
    
    
    
//TO DO THIS TOMORROW
    func getStations(completion: @escaping ([Station]) -> ()) {
        guard let url = URL(string: "https://api.drn1.com.au/station/allstations") else { return }
       
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            // Based on the updated structs, you would no
            // longer be decoding an array
            let station = try! JSONDecoder().decode(Sdata.self, from: data!)
            DispatchQueue.main.async{
                // The array is stored under station now
                completion(station.data)
            }
            
        }
    .resume()
    }
    
    
 
}


