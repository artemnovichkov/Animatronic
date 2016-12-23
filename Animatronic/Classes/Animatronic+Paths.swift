//
//  Animatronic+Paths.swift
//  Animatronic
//
//  Created by Artem Novichkov on 23/12/2016.
//  Copyright © 2016 Rosberry. All rights reserved.
//

import Foundation

public enum ResourcesType {
    
    case png
    case jpg
    case custom(type:String)
    
    var type: String {
        switch self {
        case .png: return "png"
        case .jpg: return "jpg"
        case let .custom(type: type): return type
        }
    }
}

public extension Animatronic {
    
    /// Returns the array of `UIImage`'s data.
    ///
    /// - Parameters:
    ///   - directory: the path to image's folder in Bundle.
    ///   - type: the enum for image extension. Default falue is png.
    /// - Returns: the array of `UIImage`'s data
    static func imagesData(from directory: String, type: ResourcesType = .png) -> [Data] {
        let imagePaths = Bundle.main.paths(forResourcesOfType: type.type, inDirectory: directory)
        return imagePaths.map { try! Data(contentsOf: URL(fileURLWithPath: $0)) }
    }
}
