//
//  DepositListInteractor.swift
//  BankingTrainingVIPER
//
//  Created by Sayooj Krishnan  on 04/08/21.
//
import Combine
import Foundation
final class DepositListInteractor : DepositListInteractorProtocol {
   
    typealias PaginationState = DepositViewState
    typealias DepositReponse = Subscribers.Completion<DepositError>
    
    enum DepositViewState {
        case loading
        case failed
        case success
    }
    
    private var paginateAttemptCount = 0
    
    var totalDeposits : String {
        return "$" + String(format: "%.2f", total)
    }
    
    var numberOfTransaction : String {
        return "From \(deposits.count) transaction" + "\(deposits.count > 1 ? "s":"")"
    }
    
    var deposits : [DepositViewModel] = []
    
    let depositService : DepositsListServiceProtocol
    init(service depositService: DepositsListServiceProtocol = DepositListsService()) {
        self.depositService = depositService
    }
    
    private var offset : Int = 0
    private var pageSize : Int = 15
    private var hasMoreData : Bool = true
    private var bag = Set<AnyCancellable>()
    private var total : Double = 0
    
    
    func fetchDeposits() {
        initialFetch()
    }
    
    weak var presenter: DepositListInteractorPresenterProtocol!
    
    
    private func getDeposits(
        pageSize: Int,
        offset: Int ,
        stateCallBack : @escaping (DepositReponse)->Void,
        depositsCallBack : @escaping ([DepositViewModel])->Void
    ) {
        depositService.fetchDeposits(pageSize: pageSize, offset: offset)
            .receive(on: RunLoop.main)
            .sink { stateCallBack($0)}
                receiveValue: {  deposits in
                    depositsCallBack(deposits.map({DepositViewModel(deposit: $0)}))
                }.store(in: &bag)
    }
    
    
    func initialFetch() {
        presenter.updateSpinner(forState: .loading)
        getDeposits(pageSize: pageSize, offset: offset) {[weak self] res in
            switch res {
            case .failure(let error) :
                self?.presenter.updateSpinner(forState: .failed(error.desciprtion))
            case .finished :
                self?.presenter.updateSpinner(forState: .success)
            }
        } depositsCallBack: { [weak self] deposits in
            self?.appendDeposits(deposits: deposits)
        }
    }
    
    enum PaginationError : Error {
        case noMoreData
    }
    
    func paginate()   {
        
        if !hasMoreData {
            if paginateAttemptCount >= 2 {
                presenter.showWarning(message: "No more transaction available!")
                paginateAttemptCount = 0
            }
            paginateAttemptCount+=1
            return
        }
        
        presenter.updatePaginationUI(forState: .loading)
        getDeposits(pageSize: pageSize, offset: offset) { [weak self] res  in
            switch res {
            case .failure(let error) :
                self?.presenter.updatePaginationUI(forState: .failed(error.desciprtion))
            case .finished :
                self?.presenter.updatePaginationUI(forState: .success)
            }
        } depositsCallBack: { [weak self] deposits in
            self?.appendDeposits(deposits: deposits)
        }
        
    }
    
    
    
    private func appendDeposits(deposits : [DepositViewModel]) {
        if deposits.count < 1  {
            hasMoreData = false
        }
        offset+=deposits.count
        // self?.deposits = unsortedDeposits.sorted(by: {$0.addedDate > $1.addedDate})
        // Expecting the server to return deposits in sorted order
        self.deposits.append(contentsOf: deposits)
        total += deposits.reduce(0, { prev, model in return prev + model.amount })
        self.presenter.updateDeposit(deposits: self.deposits)
        self.presenter.updateBottomBanner(total: totalDeposits, transactions: numberOfTransaction)
    }
    
}
