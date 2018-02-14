
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var testableLabel: SwipableLabel!
    
    var testWords = ["안녕하세요", "반갑습니다", "뭐하시나요?", "이건 정말정말 긴 텍스트 입니다 정말인가요?"]
    
    @IBAction func isItHappened(_ sender: Any) {
        print("It is happened")
    }
    
    @IBAction func happenedInLabel(_ sender: UISwipeGestureRecognizer) {
        print("asjnaksnajksnkajs")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        testableLabel.delegate = self
//        testableLabel.offset = 100
//        testableLabel.adjustsFontSizeToFitWidth = true
        Toast.makeText(self, position: .bottom)
    }
    
    
//    let recog: UISwipeGestureRecognizer = {
//        let rec = UISwipeGestureRecognizer()
//        rec.direction = .left
//        rec.addTarget(self, action: #selector(park))
//        return rec
//    }()
//    
//    @objc func park(_ sender: UISwipeGestureRecognizer) {
//        print("sender is \(sender)")
//    }
}

extension ViewController: SwipablePickerLabelDelegate {
    func numberOfItems(in label: SwipableLabel) -> Int {
        return testWords.count
    }
    
    func swipableLabel(_ label: SwipableLabel, textForItem at: Int) -> String {
        return testWords[at]
    }
}



