//
//  DetailTableViewCell.swift
//  appStoreSearch
//
//  Created by siyeon park on 2023/07/10.
//

import UIKit

final class DetailTableViewCell: UITableViewCell, ReuseIdentifying {

    private let topView: UIView = UIView()
    private let iconImg: UIImageView = UIImageView()
    private let titleLabel: UILabel =  UILabel()
    private let corpNameLabel: UILabel = UILabel()
    private let userRatingCountLabel: UILabel = UILabel()
    private let downloadButton: UIButton = UIButton()

    private let bottomView: UIView = UIView()
    private let screenShotFirstImage: UIImageView = UIImageView()
    private let screenShotSecondImage: UIImageView = UIImageView()
    private let screenShotThirdImage: UIImageView = UIImageView()

    private let stackView: UIStackView = {
        let stackView = UIStackView()

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        return stackView
    }()

    private let screenShotStackView: UIStackView = {
        let screenShotStackView = UIStackView()

        screenShotStackView.translatesAutoresizingMaskIntoConstraints = false
        screenShotStackView.axis = .horizontal
        screenShotStackView.alignment = .fill
        screenShotStackView.distribution = .fillEqually
        screenShotStackView.spacing = 10
        return screenShotStackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraint()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

    // MARK: - Internal Methods

extension DetailTableViewCell {
    func setupUI() {
        iconImg.layer.cornerRadius = 10
        iconImg.layer.masksToBounds = true

        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        corpNameLabel.font = .systemFont(ofSize: 14)
        corpNameLabel.textColor = .lightGray

        downloadButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        downloadButton.setTitleColor(.blue, for: .normal)
        downloadButton.setTitle("받기", for: .normal)
        downloadButton.backgroundColor = .systemGray6
        downloadButton.layer.cornerRadius = 17
        downloadButton.layer.masksToBounds = true

        contentView.addSubview(topView)
        contentView.addSubview(bottomView)

        topView.addSubview(iconImg)
        topView.addSubview(stackView)
        topView.addSubview(downloadButton)

        bottomView.addSubview(screenShotStackView)
        bottomView.addSubview(screenShotFirstImage)
        bottomView.addSubview(screenShotSecondImage)
        bottomView.addSubview(screenShotThirdImage)

        screenShotFirstImage.layer.cornerRadius = 10
        screenShotFirstImage.layer.masksToBounds = true

        screenShotSecondImage.layer.cornerRadius = 10
        screenShotSecondImage.layer.masksToBounds = true

        screenShotThirdImage.layer.cornerRadius = 10
        screenShotThirdImage.layer.masksToBounds = true
    }

    func setupConstraint() {
        topView.translatesAutoresizingMaskIntoConstraints = false
        iconImg.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        corpNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userRatingCountLabel.translatesAutoresizingMaskIntoConstraints = false
        downloadButton.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        screenShotStackView.translatesAutoresizingMaskIntoConstraints = false
        screenShotFirstImage.translatesAutoresizingMaskIntoConstraints = false
        screenShotSecondImage.translatesAutoresizingMaskIntoConstraints = false
        screenShotThirdImage.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        corpNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        [titleLabel, corpNameLabel, userRatingCountLabel].forEach {
            self.stackView.addArrangedSubview($0)
        }

        [screenShotFirstImage, screenShotSecondImage, screenShotThirdImage].forEach {
            self.screenShotStackView.addArrangedSubview($0)
        }

        NSLayoutConstraint.activate([
            topView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            topView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            topView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            topView.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: 0),
            iconImg.widthAnchor.constraint(equalToConstant: 60),
            iconImg.heightAnchor.constraint(equalToConstant: 60),
            iconImg.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 15),
            iconImg.topAnchor.constraint(equalTo: topView.topAnchor, constant: 15),
            iconImg.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -15),
            stackView.leadingAnchor.constraint(equalTo: iconImg.trailingAnchor, constant: 10),
            stackView.centerYAnchor.constraint(equalTo: iconImg.centerYAnchor),
            downloadButton.widthAnchor.constraint(equalToConstant: 60),
            downloadButton.heightAnchor.constraint(equalToConstant: 20),
            downloadButton.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 2),
            downloadButton.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -5),
            downloadButton.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            bottomView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            bottomView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0),
            bottomView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            screenShotStackView.heightAnchor.constraint(equalToConstant: 120),
            screenShotStackView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 10),
            screenShotStackView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -10),
            screenShotStackView.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 10),
            screenShotStackView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -10)
        ])
    }

    func setupItem(_ item: SearchItemResult) {
        ImageManager.shared.loadImage(
            with: item.artworkUrl60,
            into: iconImg,
            placeholder: UIImage(named: "placeholderImage")
        )

        titleLabel.text = item.trackName
        corpNameLabel.text = item.artistName
        let getStringValue = round(item.averageUserRating)
        userRatingCountLabel.text = (String(getStringValue)).trimmingCharacters(in: ["0","."])
        downloadButton.isHidden = true

        let screenshotImageViews = [screenShotFirstImage, screenShotSecondImage, screenShotThirdImage]
        for (index, imageView) in screenshotImageViews.enumerated() {
            if index < item.screenshotUrls.count {
                ImageManager.shared.loadImage(with: item.screenshotUrls[index], into: imageView, placeholder: UIImage(named: "placeholderImage"))
            } else {
                imageView.image = UIImage(named: "placeholderImage")
            }
        }
    }
}
