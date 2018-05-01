//
//  StorageType.swift
//  Amaca
//
//  Created by Luis Ezcurdia on 5/1/18.
//

import Foundation

public enum StorageType {
    case cache
    case permanent

    public var searchPathDirectory: FileManager.SearchPathDirectory {
        switch self {
        case .cache: return .cachesDirectory
        case .permanent: return .documentDirectory
        }
    }

   public var folder: URL {
        let path = NSSearchPathForDirectoriesInDomains(searchPathDirectory, .userDomainMask, true).first!
        let subfolder = "org.ezcurdia.Amaca.storage"
        return URL(fileURLWithPath: path).appendingPathComponent(subfolder)
    }

    public func clearStorage() {
        try? FileManager.default.removeItem(at: folder)
    }

    public func ensureExists() {
        let fileManager = FileManager.default
        var isDir: ObjCBool = false
        if fileManager.fileExists(atPath: folder.path, isDirectory: &isDir) {
            if isDir.boolValue { return }
            try? fileManager.removeItem(at: folder)
        }
        try? fileManager.createDirectory(at: folder, withIntermediateDirectories: false, attributes: nil)
    }
}
