//
//  CloudStorageService.swift
//  Config Validator
//
//  Created by Ross Butler on 5/31/18.
//

import Foundation

protocol ContentDeliveryNetworkService {
    
    /// Invalidates cache for items at specified paths
    func invalidateCache(distributionId: String, for paths: [String])
    
    /// Makes content a the specified location public readable
    func makePublic(url: URL) -> Bool
    
    /// Uploads file at the specified location on disk to the specified remote location
    func upload(fileURL: URL, uploadURL: URL) -> Bool
    
}
