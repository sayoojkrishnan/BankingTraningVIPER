//
//  DepositListInteractorTests.swift
//  BankingTrainingVIPERTests
//
//  Created by Sayooj Krishnan  on 09/08/21.
//
import Combine
import XCTest
@testable import BankingTrainingVIPER

class DepositListInteractorTests: XCTestCase {
    
    var service : MockDepositListsService!
    var sut : DepositListInteractor!
    var presenter :  MockDepositListPresenter!
    override func setUpWithError() throws {
        _ =  DepositsModule.build(withEnv: .mock)
        service = MockDepositListsService()
        sut = DepositListInteractor(service: service)
        presenter = MockDepositListPresenter()
        sut.presenter = presenter
    }
    
    override func tearDownWithError() throws {
        sut = nil
        presenter = nil
    }
    
    func test_WhenDepositListRequested_ShouldGetDataAndUpdateState() {
        
        sut.initialFetch()
        XCTAssertEqual(presenter.spinnerState, .loading)
        let exp  = self.expectation(description: "depositList expectation")
        let res = XCTWaiter().wait(for: [exp], timeout: 0.5)
        
        guard  res == .timedOut else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(presenter.updatedDeposit.count, 15)
        XCTAssertEqual(presenter.spinnerState, .success)
        XCTAssertTrue(presenter.totalUpdated)
        XCTAssertEqual(presenter.transactions, "From 15 transactions")
        
    }
    
    func test_WhenDepositPaginateRequested_ShouldGetNextSetupDataAndUpdateState() {
      
        sut.paginate()
        XCTAssertEqual(presenter.paginationState, .loading)
        let exp  = self.expectation(description: "depositList expectation")
        let res = XCTWaiter().wait(for: [exp], timeout: 0.5)
        
        guard  res == .timedOut else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(presenter.updatedDeposit.count, 15)
        XCTAssertEqual(presenter.paginationState, .success)
    }
    
    func test_WhenDepositPage2Requested_ShouldGetNextSetupDataAndUpdateState() {
      
        sut.paginate()
        sut.paginate()
        XCTAssertEqual(presenter.paginationState, .loading)
        let exp  = self.expectation(description: "depositList expectation")
        let res = XCTWaiter().wait(for: [exp], timeout: 0.5)
        
        guard  res == .timedOut else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(presenter.updatedDeposit.count, 30)
        XCTAssertEqual(presenter.paginationState, .success)
    }
    
    func test_WhenDepositListRequestFailes_ShoulddUpdateState() {
        
        service.shouldFail = true
        sut.initialFetch()
        XCTAssertEqual(presenter.spinnerState, .loading)
        let exp  = self.expectation(description: "depositList expectation")
        let res = XCTWaiter().wait(for: [exp], timeout: 0.5)
        
        guard  res == .timedOut else {
            XCTFail()
            return
        }
        let e = DepositError.failedToLoad.desciprtion
        XCTAssertEqual(presenter.spinnerState, .failed(e))
        XCTAssertNil(presenter.updatedDeposit)
        XCTAssertFalse(presenter.totalUpdated)
        XCTAssertNil(presenter.transactions)
    }
}

final class MockDepositListPresenter : DepositListInteractorPresenterProtocol , DepositListPresenterProtocol {
    
    var view: DepositListViewControllerProtocol!
    
    var interactor: DepositListInteractorProtocol!
    
    var router: DepositListRouterProtocol!
    
    func navigateToDeposit() {
        
    }
    
    func present() {
        
    }
    
    func paginate() {
        
    }
    
    
    
    var updatedDeposit : [DepositViewModel]!
    func updateDeposit(deposits: [DepositViewModel]) {
        updatedDeposit = deposits
    }
    
    var spinnerState : DepositListViewState!
    func updateSpinner(forState state: DepositListViewState) {
        spinnerState = state
    }
    
    var paginationState : DepositListViewState!
    func updatePaginationUI(forState state: DepositListViewState) {
        paginationState = state
    }
    
    var totalUpdated : Bool = false
    var transactions :String!
    func updateBottomBanner(total: String, transactions: String) {
        self.totalUpdated = true
        self.transactions = transactions
    }
    
    
    var warmingMessage : String!
    func showWarning(message: String) {
        warmingMessage = message
    }
    
    
}



final class MockDepositListsService : DepositsListServiceProtocol {
    
    var mockType: MockType? = .localJSON("deposits_list")
    
    var shouldFail : Bool = false
    func fetchDeposits(pageSize : Int, offset : Int) -> AnyPublisher<[DepositModel], DepositError> {
        
        let items = JSONDecoder.decoded(fromBundledJSONFile: "deposits_list", type: [DepositModel].self) ?? []
        
        var updated = items.map { dp -> DepositModel in
            var up = dp
            up.id = UUID().uuidString
            return up
        }
        updated.shuffle()
        let count = updated.count
        let required = max(count-pageSize, 0)
        
        updated.removeFirst(required)
        
        return Future<[DepositModel],DepositError>{promise in
            if self.shouldFail {
                promise(.failure(DepositError.failedToLoad))
                return
            }
            promise(.success(updated))
        }.eraseToAnyPublisher()
    }
    
}



extension JSONDecoder {
    
    static func decoded<T>(fromBundledJSONFile fileName : String , type : T.Type) -> T? where T : Decodable {
        
        guard let url =  Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("Failed to get Bundle path for resource \(fileName)")
            return nil
        }
        
        guard let data =  try? Data(contentsOf: url) else {
            print("Failed to read data from \(url)")
            return nil
        }
        
        guard let decoded = try? JSONDecoder().decode(T.self, from: data)  else {
            print("Failed to decode given data using \(T.self)")
            return nil
        }
        
        return decoded
    }
}
