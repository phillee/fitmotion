//
//  RequestManager.swift
//  Couples
//
//  Created by Винниченко Дмитрий on 31.10.16.
//  Copyright © 2016 Philip Lee. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage


class RequestManager {
    
    /* Singletone */
    static let defaultManager = RequestManager()
    
    /* Requests API */
    private let getAllProgramsAPI = "http://fitmotion.co/app/couples-workouts"
    
    
    /* Get all video programs */
    func getAllPrograms(programs: @escaping (Array<AnyObject>) -> ()) {
        
        Alamofire.request(self.getAllProgramsAPI).responseJSON { response in
            
            let responseData = response.result.value as? NSDictionary
            let responseDictData: NSDictionary = responseData?.object(forKey: "data") as! NSDictionary
            
            /* Parse programs */
            if let responseArrayPrograms: NSArray = responseDictData.object(forKey: "programs") as? NSArray {

                var allPrograms = [Program]()
                
                for dictionary in responseArrayPrograms {
                    
                    let program = Program.init(dictionary as! NSDictionary)
                    allPrograms.append(program)
                }
                
                programs(allPrograms)
            }
        }
    }
    
    
    /* Get image with URL */
    func getImageWithURL(imageURL: String ,resultImage: @escaping (Image) -> ()) {
        
        Alamofire.request(imageURL).responseImage { response in
            
            if let image = response.result.value {

                resultImage(image)
            }
        }
    }
}
