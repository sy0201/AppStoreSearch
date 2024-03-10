//
//  Array+Extension.swift
//  appStroeSearch
//
//  Created by siyeon park on 2023/05/13.
//

extension Array {
    // Array의 index value를 가져올때 safe하게 가져올 수 있도록 하기위한 subscript
    // 참고 : http://minsone.github.io/programming/check-index-of-array-in-swift
    subscript (safe index: Int) -> Element? {
        // iOS 9 or later
        return indices ~= index ? self[index] : nil
        // iOS 8 or earlier
        // return startIndex <= index && index < endIndex ? self[index] : nil
        // return 0 <= index && index < self.count ? self[index] : nil
    }
}
