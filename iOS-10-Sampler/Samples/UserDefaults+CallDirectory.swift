//
//  UserDefaults+CallDirectory.swift
//  iOS-10-Sampler
//
//  Created by Masayoshi Ukida on 2016/10/06.
//  Copyright © 2016年 Shuichi Tsutsumi. All rights reserved.
//

import Foundation

extension UserDefaults {
    static func callDirectoryShared() -> UserDefaults {
        return UserDefaults(suiteName: "group.com.shu223.iOS-10-Sampler.CallDirectory")!
    }
    
    func callDirectoryBlocks() -> [String]? {
        guard let blocks = array(forKey: "Blocks") as? [String] else {
            return nil
        }
        return blocks
    }
    
    func setCallDirectoryBlocks(blocks: [String]) {
        set(blocks, forKey: "Blocks")
    }
    
    func callDirectoryLabels() -> [String: String]? {
        guard let labels = dictionary(forKey: "Labels") as? [String: String] else {
            return nil
        }
        return labels
    }
    
    func setCallDirectoryLabels(labels: [String: String]) {
        set(labels, forKey: "Labels")
    }
}
