//
//  FileManager+DocumentsDirectory.swift
//  BucketList
//
//  Created by Lippmann, Erik on 21.02.23.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
