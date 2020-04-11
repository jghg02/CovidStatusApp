//
//  CovidProtocolAPI.swift
//  COVIDStatus
//
//  Created by Josue Hernandez Gonzalez on 11-04-20.
//  Copyright © 2020 Josue Hernandez Gonzalez. All rights reserved.
//

import Combine

enum APIError: Error {
    case internalError
    case serverError
    case parsingError
}

protocol CovidAPIProvider {
    func fetchDataFromServer(completion: @escaping((Result<CovidTotal, APIError>) -> Void))
    // MARK: Combine
    func fetchDataFromServer() -> AnyPublisher<CovidTotal, APIError>
}
