//
//  OCCodingObjectWrapper.swift
//  AutoCodable
//
//  Created by lucky.li on 2018/8/16.
//  Copyright © 2018 cico. All rights reserved.
//

import Foundation

public struct OCCodingObjectWrapper<T>: Codable {
    public var value: T
    private var data: Data = Data.init()
    
    public init(value: T) {
        self.value = value
    }
}

public extension OCCodingObjectWrapper {
    public enum CodingKeys: String, CodingKey {
        case data
    }
}

public extension OCCodingObjectWrapper {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(Data.self, forKey: .data)
        
        self.value = NSKeyedUnarchiver.unarchiveObject(with: self.data) as! T
    }
    
    public func encode(to encoder: Encoder) throws {
        let data = NSKeyedArchiver.archivedData(withRootObject: value)
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
    }
}
