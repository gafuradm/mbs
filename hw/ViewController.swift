import UIKit
import SnapKit
class ViewController: UIViewController {
    var arr = ["Бесспорно", "Предрешено", "Никаких сомнений", "Определённо да", "Можешь быть уверен в этом", "Мне кажется — «да»", "Вероятнее всего", "Хорошие перспективы", "Знаки говорят — «да»", "Да", "Пока не ясно, попробуй снова", "Спроси позже", "Лучше не рассказывать", "Сейчас нельзя предсказать", "Сконцентрируйся и спроси опять", "Даже не думай", "Мой ответ — «нет»", "По моим данным — «нет»", "Перспективы не очень хорошие", "Весьма сомнительно"]
    var randomElement: String?
    let viewBall: UIView = {
        let width: CGFloat = 300
        let view = UIView()
        view.snp.makeConstraints{
            $0.size.equalTo(width)
        }
        view.layer.cornerRadius = width / 2
        view.backgroundColor = .darkGray
        return view
    }()
    let ball: UIView = {
        let width: CGFloat = 150
        let view = UIView()
        view.snp.makeConstraints{
            $0.size.equalTo(width)
        }
        view.layer.cornerRadius = width / 2
        view.backgroundColor = .black
        return view
    }()
    let ballLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    let myLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello World"
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.textAlignment = .center
        return label
    }()
    let btn: UIButton = {
        let button = UIButton()
        button.setTitle("Make Prediction", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.configuration = .filled()
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(viewBall)
        view.addSubview(ball)
        view.addSubview(ballLabel)
        view.addSubview(myLabel)
        view.addSubview(btn)
        makeConstraints()
        addAnimation()
    }
}
extension ViewController {
    @objc func tap() {
        if btn.title(for: .normal) == "Make Prediction" {
            btn.setTitle("Reset", for: .normal)
        } else {
            btn.setTitle("Make Prediction", for: .normal)
        }
        let shuffledArr = arr.shuffled()
        randomElement = shuffledArr.randomElement()
        if let randomElement = randomElement {
            UIView.transition(with: ball, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                self.ball.isHidden = true
            }, completion: { _ in
                self.ballLabel.text = randomElement
                UIView.transition(with: self.ball, duration: 0.5, options: .transitionFlipFromRight, animations: {
                    self.ball.isHidden = false
                }, completion: nil)
            })
        }
    }
}
private extension ViewController {
    func makeConstraints() {
        viewBall.snp.makeConstraints{
            $0.centerY.equalToSuperview().offset(0)
            $0.centerX.equalToSuperview().offset(0)
        }
        ball.snp.makeConstraints{
            $0.centerY.equalToSuperview().offset(-50)
            $0.centerX.equalToSuperview().offset(0)
        }
        ballLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview().offset(0)
            $0.centerY.equalToSuperview().offset(-75)
        }
        myLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(125)
        }
        btn.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(300)
        }
    }
    func addAnimation() {
        UIView.transition(with: ball, duration: 1, options: .transitionFlipFromLeft, animations: {
            self.ball.isHidden = true
        }, completion: { _ in
            self.ballLabel.text = "8"
            UIView.transition(with: self.ball, duration: 1, options: .transitionFlipFromRight, animations: {
                self.ball.isHidden = false
            }, completion: nil)
        })
        UIView.transition(with: myLabel, duration: 5, options: .transitionCrossDissolve, animations: {
            self.myLabel.attributedText = NSAttributedString.init(string: "The magic 8 ball")
        }, completion: nil)
        UIView.animate(withDuration: 3, delay: 0) {
            self.view.layoutIfNeeded()
            self.myLabel.layoutIfNeeded()
        }
    }
}
