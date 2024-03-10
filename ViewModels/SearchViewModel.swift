//
//  SearchViewModel.swift
//  appStoreSearch
//
//  Created by siyeon park on 2023/06/14.
//

import UIKit

class SearchViewModel {
    private let service = NetworkingManager.shared

    func searchItems(term: String, completionHandler: @escaping([SearchItemResult]) -> Void) {
        service.searchItunesAPI(term: term) { response in
            completionHandler(response)
        } failure: { error in
            print(error)
        }
    }

    var dataList: [String] = ["요기요1", "요기요2", "요기요3", "요기요4", "요기요5"]
    var recommendList: [RecommendModel.RecommendData] = []

    func setListData() {
        for _ in 0...16 {
            recommendList.append(RecommendModel.RecommendData(title: "전략적 팀 전투: 리그 오브 레전드 전략 게임", description: "모집하고 명령만 내리면 되는 오토 배틀게임"))
        }
    }
}
