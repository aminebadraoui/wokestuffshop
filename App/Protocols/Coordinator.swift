import UIKit
import RxSwift

protocol Coordinator {
    
    var rootViewController: UIViewController {get set}
    
    var childCoordinators: [Coordinator] { get set }
 
}
