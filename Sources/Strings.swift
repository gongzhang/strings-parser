//
//  Strings.swift
//
//
//  Created by Gong Zhang on 2024/4/26.
//

import Foundation

public enum Strings {
    
    public static func parse(_ strings: String) -> [Entry] {
        var entries: [Entry] = []
        strings.enumerateLines { line, stop in
            if let entry = Entry(parse: line) {
                entries.append(entry)
            }
        }
        return entries
    }
    
    public struct Entry {
        private static let linePattern = try! Regex(#"^\s*"(.+)"\s*=\s*"(.+)"\s*;\s*(//\s*(.*)\s*)?$"#)
        
        public var key: String
        public var escapedTranslation: String
        public var comment: String?
        
        public var string: String {
            if let comment {
                return "\"\(key)\" = \"\(escapedTranslation)\"; // \(comment)"
            } else {
                return "\"\(key)\" = \"\(escapedTranslation)\";"
            }
        }
        
        public init(key: String, escapedTranslation: String, comment: String?) {
            self.key = key
            self.escapedTranslation = escapedTranslation
            self.comment = comment
        }
        
        public init?(parse line: String) {
            guard let match = line.wholeMatch(of: Self.linePattern) else {
                // empty line or comments
                return nil
            }
            guard let keyRange = match[1].range,
                  let valueRange = match[2].range else {
                assertionFailure()
                return nil
            }
            
            self.key = String(line[keyRange])
            self.escapedTranslation = String(line[valueRange])
            if let commentRange = match[4].range, !commentRange.isEmpty {
                self.comment = String(line[commentRange])
            }
        }
        
    }
    
}
