//
//  ReuseIdentifying.swift
//  appStroeSearch
//
//  Created by siyeon park on 2023/05/13.
//

protocol ReuseIdentifying: AnyObject {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifying {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
