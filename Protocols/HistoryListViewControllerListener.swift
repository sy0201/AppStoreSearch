//
//  SendDataDelegate.swift
//  appStoreSearch
//
//  Created by siyeon park on 2023/08/04.
//

import Foundation

// 대리자가 할수있는 함수를 작성
protocol HistoryListViewControllerListener: AnyObject {
    func pushToDetail(searchKeyword: String)
}
