//
//  ExhibitionTableViewCell.swift
//  Auctix
//
//  Created by Евгений Башун on 28.10.2021.
//

import UIKit
import SnapKit

protocol _ExhibitionCell {
    var image   : UIImage? { get }
    var name    : String   { get }
    var city    : String   { get }
}

class ExhibitionTableViewCell: UITableViewCell {
    
    private struct Constants {
        static let labelPosition: CGFloat = 20
        static let imageFromLeftRight: CGFloat = 12
        static let imageFromTopBottom: CGFloat = 5
    }
    
    private let container = UIView()
    private let gradient = CAGradientLayer()
    private var netImage = ExhibitionsImageLoader.shared
    private let exhName = UILabel()
    
    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        setupViews()
        setupGradient()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    func configure(with data: _ExhibitionCell) {
        
   
        nameLabel.text       = data.name
        cityLabel.text       = data.city
    
        netImage.image(with: exhName.text!) { [weak self] image in
            self?.mainImageView.image  = image
        }
    }
    
    func calculateTimeDifference(from dateTime1: String) -> String {
        let dateWithTime = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        
        let date = dateFormatter.string(from: dateWithTime) // 2.10.17
        
        let dateString = dateTime1
        let dateA = dateFormatter.date(from: dateString) ?? .init()
        let dateB = dateFormatter.date(from: date) ?? .init()
        
        let components : NSCalendar.Unit = [.second, .minute, .hour, .day, .year]
        let difference = (Calendar.current as NSCalendar).components(components, from: dateB, to: dateA, options: .init())
        
        let dateTimeDifferenceString = "\(difference.day!)"
        
        return dateTimeDifferenceString
        
    }
    
    private func setupViews() {
        addSubview(exhibitionImage)
        exhibitionImage.addSubview(container)
        container.layer.addSublayer(gradient)
        exhibitionImage.addSubview(exhibitionName)
        exhibitionImage.addSubview(exhibitionCity)
        exhibitionImage.addSubview(exhibitionCountry)
        exhibitionImage.addSubview(exhibitionExpirationDate)
    }
    
    private func setupGradient() {
        gradient.colors = [UIColor.darkGrad.cgColor, UIColor.white.withAlphaComponent(0).cgColor]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradient.cornerRadius = layer.cornerRadius
        gradient.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: -1, b: 0, c: 0, d: -5.8, tx: 1, ty: 3.4))
        gradient.bounds = bounds.insetBy(dx: -0.5 * bounds.size.width, dy: -0.5 * bounds.size.height)
        gradient.position = center
    }
    
    private func setupLayout() {
        exhibitionImage.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constraints.imageFromLeftRight)
            make.top.bottom.equalToSuperview().inset(Constraints.imageFromTopBottom)
        }
        exhibitionName.snp.makeConstraints { make in
            make.top.equalTo(exhibitionImage).inset(Constraints.labelPosition)
            make.trailing.equalTo(exhibitionImage).inset(Constraints.labelPosition / 2)
        }
        exhibitionCity.snp.makeConstraints { make in
            make.top.equalTo(exhibitionName).inset(Constraints.labelPosition * 2)
            make.trailing.equalTo(exhibitionName)
        }
        exhibitionCountry.snp.makeConstraints { make in
            make.top.equalTo(exhibitionCity).inset(Constraints.labelPosition)
            make.trailing.equalTo(exhibitionCity)
        }
        exhibitionExpirationDate.snp.makeConstraints { make in
            make.top.equalTo(exhibitionCountry).inset(Constraints.labelPosition)
            make.trailing.equalTo(exhibitionCountry)
        }
    }
}
