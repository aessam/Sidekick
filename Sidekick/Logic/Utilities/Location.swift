//
//  Location.swift
//  Sidekick
//
//  Created by John Bean on 4/17/25.
//

import Foundation

public class IPLocation {
    
    static func getLocation() async throws -> String {
        // Disabled location fetching for privacy
        return "Unknown Location"
    }
    
}

public struct IPLocationResponse: Codable {
    
    let city: String?
    let region: String?
    let country: String?
    
}
