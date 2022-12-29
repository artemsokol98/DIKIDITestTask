//
//  MainViewModel.swift
//  DIKIDITestTask
//
//  Created by Артем Соколовский on 27.12.2022.
//

import Foundation

protocol MainViewModelProtocol {
    
}

final class MainViewModel: ObservableObject {
    
    @Published var catalog: [Catalog]?
    @Published var vip: [Vip]?
    @Published var imageTitle: String?
    @Published var imageExamples: String?
    @Published var categories: [String]?

    func downloadingData() { // completion: @escaping (Result<Void, Error>) -> Void
        NetworkManager.shared.fetchData(urlString: "https://api-beauty.test.dikidi.ru/home/info?") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    guard let data = data as? DataModel? else { print("error"); return }
                    
                    self.catalog = data?.data?.blocks?.catalog
                    self.vip = data?.data?.blocks?.vip
                    self.imageTitle = data?.data?.image
                    self.imageExamples = data?.data?.blocks?.examples
                    self.categories = data?.data?.blocks?.vip?[0].categories
                case .failure(let error):
                    print(error)
                }
            }
            
        }
    }
}
