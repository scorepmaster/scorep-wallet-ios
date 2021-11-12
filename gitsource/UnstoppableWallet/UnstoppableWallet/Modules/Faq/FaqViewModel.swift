import Foundation
import RxSwift
import RxCocoa

class FaqViewModel {
    private let disposeBag = DisposeBag()

    private let service: FaqService

    private var itemsRelay = BehaviorRelay<[FaqService.Item]>(value: [])
    private var loadingRelay = BehaviorRelay<Bool>(value: true)
    private var errorRelay = BehaviorRelay<Error?>(value: nil)

    init(service: FaqService) {
        self.service = service

        service.faqObservable
                .subscribe(onNext: { [weak self] dataStatus in
                    self?.handle(dataStatus: dataStatus)
                })
                .disposed(by: disposeBag)
    }

    private func handle(dataStatus: DataStatus<[FaqService.Item]>) {
        if case .loading = dataStatus {
            loadingRelay.accept(true)
        } else {
            loadingRelay.accept(false)
        }

        if case .completed(let items) = dataStatus {
            itemsRelay.accept(items)
        } else {
            itemsRelay.accept([])
        }

        if case .failed(let error) = dataStatus {
            errorRelay.accept(error.convertedError)
        } else {
            errorRelay.accept(nil)
        }
    }

}

extension FaqViewModel {

    var itemsDriver: Driver<[FaqService.Item]> {
        itemsRelay.asDriver()
    }

    var loadingDriver: Driver<Bool> {
        loadingRelay.asDriver()
    }

    var errorDriver: Driver<Error?> {
        errorRelay.asDriver()
    }

}
