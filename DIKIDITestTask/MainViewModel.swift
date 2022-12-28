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
    @Published var data: DataModel?
    
    @Published var link: String?
    
    
    func downloadingData() { // completion: @escaping (Result<Void, Error>) -> Void
        NetworkManager.shared.fetchData(urlString: "https://api-beauty.test.dikidi.ru/home/info?") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    guard let data = data as? DataModel? else { print("error"); return }
                    self.data = data
                    print(self.data)
                    self.link = data?.data?.blocks?.catalog?[0].image?.origin
                case .failure(let error):
                    print(error)
                }
            }
            
        }
    }
}
