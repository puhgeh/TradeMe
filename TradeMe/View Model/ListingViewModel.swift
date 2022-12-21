//
//  ListingViewModel.swift
//  TradeMe
//
//  Created by Axel on 12/21/22.
//

import Foundation
import Combine

class ListingViewModel: ObservableObject {
    @Published var listings: [Listing] = []
    
    static let shared = ListingViewModel()
    private let service = ListingService.shared
    private var cancellables = Set<AnyCancellable>()
    private var request: AnyCancellable? = nil
    
    
    init() {
        load()
    }
    
    func load() {
        request = try? service.latest(stub: true)
            .map(\.value)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("failed: \(error.localizedDescription)")
                case .finished:
                    print(completion)
                }
            }, receiveValue: { [weak self] latest in
                self?.listings = latest.list
            })
        
        request?.store(in: &cancellables)
    }
    
    deinit {
        cancellables.removeAll()
    }
}
