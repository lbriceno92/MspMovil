//
//  StringExtension.swift
//  MobileSupervision
//

import Foundation
extension String {
    
    var length: Int {
        get {
            return self.characters.count;
        }
    }
    
    func indexOf(_ target: String) -> Int {
        let range = self.range(of: target)
        if let range = range {
            return self.characters.distance(from: self.startIndex, to: range.lowerBound);
        } else {
            return -1
        }
    }
    
    func indexOf(_ target: String, startIndex: Int) -> Int {
        let startRange = self.characters.index(self.startIndex, offsetBy: startIndex)
        
        let range = self.range(of: target, options: NSString.CompareOptions.literal, range: Range<String.Index>(startRange..<self.endIndex))
        
        if let range = range {
            return self.characters.distance(from: self.startIndex, to: range.lowerBound)
        } else {
            return -1
        }
    }
    
    func componentsSeperatedByStrings(_ ss: [String]) -> [String] {
        let unshifted = ss
            .flatMap { s in range(of: s) }
            .flatMap { r in [r.lowerBound, r.upperBound] }
        let inds  = [startIndex] + unshifted + [endIndex];
        return stride(from: inds.startIndex, to: inds.endIndex, by: 2)
            .map { i in (inds[i], inds[i+1]) }
            .flatMap { (s, e) in s == e ? nil : self[s..<e] }
    }
    
    func lastIndexOf(_ target: String) -> Int {
        var index = -1
        var stepIndex = self.indexOf(target)
        while stepIndex > -1 {
            index = stepIndex
            if stepIndex + target.length < self.length {
                stepIndex = indexOf(target, startIndex: stepIndex + target.length)
            } else {
                stepIndex = -1
            }
        }
        return index
    }
    
    func substringWithRange(_ range:Range<Int>) -> String {
        let start = self.characters.index(self.startIndex, offsetBy: range.lowerBound);
        let end = self.characters.index(self.startIndex, offsetBy: range.upperBound);
        return self.substring(with: start..<end)
    }
    
}
