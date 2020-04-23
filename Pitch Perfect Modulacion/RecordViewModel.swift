//
//  RecordViewModel.swift
//  Pitch Perfect Modulacion
//
//  Created by Laxman Nyamagouda on 4/22/20.
//  Copyright © 2020 Laxman Nyamagouda. All rights reserved.
//

import Foundation

class RecordViewModel {
    
    func recordAudioURL() -> NSURL {
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]

        let url : NSString = pathArray.joined(separator: "/") as NSString
        let urlStr : NSString = url.addingPercentEscapes(using: String.Encoding.utf8.rawValue)! as NSString
        let searchURL : NSURL = NSURL(string: urlStr as String)!
        return searchURL
    }
}
