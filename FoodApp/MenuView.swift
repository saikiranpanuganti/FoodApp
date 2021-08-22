//
//  MenuView.swift
//  FoodApp
//
//  Created by SaiKiran Panuganti on 21/08/21.
//

import UIKit


protocol MenuViewDelegate: AnyObject {
    func itemTapped(item: String)
}


class MenuView: UIView {
    weak var delegate: MenuViewDelegate?
    
    var items: [String] = ["Starters", "Rotis", "Biryani", "Rice", "Desserts", "Starters", "Rotis", "Biryani", "Rice", "Desserts"]
    
    var selectorWidth: NSLayoutConstraint = NSLayoutConstraint()
    var selectorLeftAnchor: NSLayoutConstraint = NSLayoutConstraint()
    private var buttonsArray: [UIButton] = []
    private var currentSelectedButton: UIButton = UIButton()
    
    var topView: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.borderWidth = 0.5
        view.layer.borderColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1).cgColor
        
        return view
    }()
    
    var scrollView: UIScrollView = {
        let scrollView: UIScrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    var mainView: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var stackView: UIStackView = {
        let stackView:UIStackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    var selectorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.red
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setUpUI()
    }
    
    func setUpUI() {
        addSubViews()
        addConstraints()
        scrollView.delegate = self
    }
    
    func addSubViews() {
        self.addSubview(topView)
        topView.addSubview(scrollView)
        scrollView.addSubview(mainView)
        mainView.addSubview(stackView)
        topView.addSubview(selectorView)
        
        
        for (index, item) in items.enumerated() {
            let button = UIButton()
            button.setTitle(item, for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
            button.titleLabel?.textAlignment = .center
            button.addTarget(self, action: #selector(itemTapped(_:)), for: .touchUpInside)
            button.tag = index
            
            let width = widthOfString(text: item, usingFont: UIFont.systemFont(ofSize: 17))
            button.widthAnchor.constraint(equalToConstant: width+10).isActive = true
            
            if index == 0 {
                button.setTitleColor(UIColor.red, for: .normal)
                button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
                
                currentSelectedButton = button
            }
            
            stackView.addArrangedSubview(button)
        }
    }
    
    func addConstraints() {
        topView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: -5).isActive = true
        topView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        topView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        topView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 5).isActive = true
        
        scrollView.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 5).isActive = true
        scrollView.topAnchor.constraint(equalTo: topView.topAnchor, constant: 10).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -10).isActive = true
        scrollView.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: -5).isActive = true
        
        mainView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10).isActive = true
        mainView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        mainView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
        mainView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -10).isActive = true
        
        stackView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 0).isActive = true
        stackView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0).isActive = true
        stackView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: 0).isActive = true
        
        selectorLeftAnchor = selectorView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: -2)
        selectorLeftAnchor.isActive = true
        selectorView.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0).isActive = true
        let width = widthOfString(text: items[0], usingFont: UIFont.boldSystemFont(ofSize: 17))
        selectorWidth = selectorView.widthAnchor.constraint(equalToConstant: width+4)
        selectorWidth.isActive = true
        selectorView.heightAnchor.constraint(equalToConstant: 3.0).isActive = true
    }
    
    func widthOfString(text: String, usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = text.size(withAttributes: fontAttributes)
        return size.width
    }
    
    @objc func itemTapped(_ sender: UIButton) {
        print("item tapped ", items[sender.tag])
        
        currentSelectedButton.setTitleColor(UIColor.black, for: .normal)
        currentSelectedButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        
        sender.setTitleColor(UIColor.red, for: .normal)
        sender.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        
        let width = widthOfString(text: items[sender.tag], usingFont: UIFont.boldSystemFont(ofSize: 17))
        selectorWidth.isActive = false
        selectorWidth.constant = width + 9
        selectorWidth.isActive = true
        
        selectorLeftAnchor.isActive = false
        selectorLeftAnchor.constant = sender.frame.minX - 2
        selectorLeftAnchor.isActive = true
        
        currentSelectedButton = sender
        
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
        
        delegate?.itemTapped(item: items[sender.tag])
    }
}

extension MenuView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         if scrollView.contentOffset.y > 0 || scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
         }
    }
}
