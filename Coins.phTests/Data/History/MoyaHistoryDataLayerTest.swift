//
//  MoyaHistoryDataLayerTest.swift
//  Coins.phTests
//
//  Created by Дайняк Александр Николаевич on 01.05.2021.
//

import XCTest
import Moya
import RxBlocking
import RxCocoa
import RxSwift
import Network
import Data
@testable import Coins_ph

class MoyaHistoryDataLayerTest: XCTestCase {
    
    private var histoiesJsonData: Data!
    private var disposeBag: DisposeBag!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        histoiesJsonData = loadDataInJSONFile(fileName: "histories")!
        disposeBag = DisposeBag()
        
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testSuccessfullResponseHistoryProvider() {
        let provider = MoyaProvider<HistoryTarget>(
            endpointClosure: { self.mockEndpointForAPI(api: $0, response: .networkResponse(200, self.histoiesJsonData)) },
            stubClosure: { _ in .immediate }
        )
        
        let HistorysState = provider.rx.request(.getHistory)
            .performMapping(
                valueType: HistoriesDto.self,
                errorType: ApiErrorModel.self
            )
            .map { $0.asDomain() }
        
        // Act + Assert
        XCTAssertEqual(try HistorysState.toBlocking().first()?.count, 3)
    }
    
    func testNetworkErrorFromHistoryTarget() {
        
        let expectedError = NSError(domain: "expectedError", code: -1, userInfo: nil)
        
        let provider = MoyaProvider<HistoryTarget>(endpointClosure: { self.mockEndpointForAPI(api: $0, response: .networkError(expectedError)) },
                                                   stubClosure: { _ in .immediate })
        
        let HistorysState = provider.rx.request(.getHistory)
            .performMapping(
                valueType: HistoriesDto.self,
                errorType: ApiErrorModel.self
            )
            .map { $0.asDomain() }
        
        // Act + Assert
        XCTAssertThrowsError(try HistorysState.toBlocking().first())
    }
    
    
    func testResponseErrorFromHistoryTarget() {
        let statusCode = 404
        let provider = MoyaProvider<HistoryTarget>(endpointClosure: {
                                                    self.mockEndpointForAPI(api: $0, response: .networkResponse(statusCode, Data())) },
                                                   stubClosure: { _ in .immediate })
        let HistorysState = provider.rx.request(.getHistory)
            .performMapping(
                valueType: HistoriesDto.self,
                errorType: ApiErrorModel.self
            )
            .map { $0.asDomain() }
        
        XCTAssertThrowsError(try HistorysState.toBlocking().first(), "Expected 404 error statusCode") { (error) in
            XCTAssertEqual((error as! Moya.MoyaError).response?.statusCode, statusCode)
        }
    }
    
    func mockEndpointForAPI(api: TargetType, response: EndpointSampleResponse) -> Endpoint {
        return Endpoint(url: api.baseURL.absoluteString,
                        sampleResponseClosure: { response },
                        method: api.method,
                        task: api.task,
                        httpHeaderFields: api.headers)
    }
    
    func loadDataInJSONFile(fileName: String) -> Data? {
        let bundle = Bundle(for: type(of: self))
        guard let filePath = bundle.path(forResource: fileName, ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else {
            return nil
        }
        return data
    }
}

