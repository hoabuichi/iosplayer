//
//  BaseVC.swift
//  ONEdu
//
//  Created by Tran Dat on 30/05/2022.
//

import UIKit
import RxCocoa
import RxSwift

protocol BasePresenter {
    associatedtype View
    var view: View? { get set }
    var isAttached: Bool { get }

    func onAttach(view: View)
    func onDetach(view: View)
}

/// Default implementation for the `isAttached()` method just checks if the `view` is non nil.
extension BasePresenter {
    var isAttached: Bool { return view != nil }
}

class BaseVC<M, V, P: BasePresenter>: UIViewController {
    var disposeBag = DisposeBag()
    typealias View = V
    var viewModel: M? = nil
    private(set) var presenter: P!
    //MARK: - Initializers
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override public init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
    }
    deinit {
//        presenter.onDetach(view: self as! P.View)
    }
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultConfig()
        presenter = createPresenter()
    }
    func defaultConfig() {
        self.view.backgroundColor = .bkg
    }
    override func viewWillAppear(_ animated: Bool) {
        guard let view = self as? P.View else {
            preconditionFailure("MVP ViewController must implement the view protocol `\(View.self)`!")
        }
        super.viewWillAppear(animated)
        if (!presenter.isAttached) {
            presenter.onAttach(view: view)
        }
    }
    //MARK: - MVP
    /// Override and return a presenter in a subclass.
    func createPresenter() -> P {
        preconditionFailure("MVP method `createPresenter()` must be override in a subclass and do not call `super.createPresenter()`!")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}
protocol BaseModel {}
protocol BaseView {}
/*
 class VC: BaseVC<Model, View, Presenter>, View {
     ...
     override func createPresenter() -> Presenter {
         return Presenter()
     }
     ...
 }
 */
/*
class TestPresenter: BasePresenter {
    typealias View = <#type#>
    weak var view: View?
}
*/
