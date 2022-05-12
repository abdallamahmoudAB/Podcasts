//
//  CMTime.swift
//  Podcasts
//
//  Created by abdalla mahmoud on 10/05/2022.
//

import AVKit

extension CMTime {
    
    func toDisplayString() -> String {
        if CMTimeGetSeconds(self).isNaN {
            return "--:--"
        }
        let totalSeconds = Int(CMTimeGetSeconds(self))
        let seconds = totalSeconds % 60
        let minutes = totalSeconds / 60
        let timeFormatString = String(format: "%02d:%02d",minutes, seconds)
        return timeFormatString
    }
}
