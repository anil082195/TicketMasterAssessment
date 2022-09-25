//
//  EventCollectionViewCell.swift
//  TicketMasterAssessment
//
//  Created by Anil Persaud on 9/23/22.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    
    private let imageCache = NSCache<NSString, UIImage>()
    
    var eventModel: EventModel? {
        didSet {
            lblEventName.text = eventModel?.name
            lblType.text = eventModel?.type.capitalized
            lblStartDate.text = convertDateFormat(inputDate: (eventModel?.dates.start.localDate)!)
            loadImageView(eventImageUrl: (eventModel?.images[0].url)!)
        }
    }
    
    private let eventImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let lblEventName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.papyrusFontWithSize(size: 15.0)
        return label
    }()
    
    private let lblType: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.papyrusFontWithSize(size: 13.0)
        return label
    }()
    
    private let lblStartDate: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.papyrusFontWithSize(size: 13.0)
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 0
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.colorFromHex("#D6E8EE")
        stackView.addArrangedSubview(lblEventName)
        stackView.addArrangedSubview(lblType)
        stackView.addArrangedSubview(lblStartDate)
        contentView.addSubview(eventImageView)
        contentView.addSubview(stackView)
        
        eventImageView.translatesAutoresizingMaskIntoConstraints = false
            // Layout constraints for `collectionView`
            NSLayoutConstraint.activate([
                eventImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                eventImageView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor),
                eventImageView.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor),
                eventImageView.heightAnchor.constraint(equalToConstant: 150)
            ])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
            // Layout constraints for `stackview`
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: eventImageView.bottomAnchor, constant: 0),
                stackView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor),
                stackView.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor),
                stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

extension EventCollectionViewCell {
    private func loadImageView(eventImageUrl: String) {
        DispatchQueue.global().async {
            if let cachedImage = self.imageCache.object(forKey: eventImageUrl as NSString) {
                DispatchQueue.main.async {
                    self.eventImageView.image = cachedImage
                }
            } else {
                guard let url = URL(string: eventImageUrl) else { return }
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.imageCache.setObject(image, forKey: eventImageUrl as NSString)
                            self.eventImageView.image = image
                        }
                    }
                }
            }
        }
    }
    
    private func convertDateFormat(inputDate: String) -> String {

         let olDateFormatter = DateFormatter()
         olDateFormatter.dateFormat = "yyyy-MM-dd"

         let oldDate = olDateFormatter.date(from: inputDate)

         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "MMM dd yyyy"

         return convertDateFormatter.string(from: oldDate!)
    }

}
