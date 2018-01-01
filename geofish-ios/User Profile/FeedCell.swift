//
//  PostCell.swift
//  geofish-ios
//
//  Created by Ilyas on 19.12.17.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell{
    
    var feedController: UserProfileVC?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 2
        label.text = "Sample text"
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.rgb(155, green: 155, blue: 155)
        label.numberOfLines = 1
        label.text = "1 час назад"
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.red
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let postTextView: UITextView = {
        let postTextView = UITextView()
        postTextView.font = UIFont.systemFont(ofSize: 14)
        postTextView.isScrollEnabled = false
        postTextView.text = "gegwrgwewrghf kjerhgjerhg erg ekrjt erbk tejrltel krt lekr"
        return postTextView
    }()
    
    let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.red
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.black
        label.text = "1213"
        return label
    }()
    
    let commentsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.black
        label.text = "1241"
        return label
    }()
    
    let likeButton = FeedCell.buttonForTitle("", imageName: "like-inactive")
    let commentButton: UIButton = FeedCell.buttonForTitle("", imageName: "comment")
    let optionDotsButon: UIButton = FeedCell.buttonForTitle("", imageName: "postOption")
    
    
    
    static func buttonForTitle(_ title: String, imageName: String) -> UIButton{
        let button = UIButton()
        button.setTitle(title, for: UIControlState())
        button.setTitleColor(UIColor(red: 143, green: 150, blue: 163, alpha: 1) , for: UIControlState.normal)
        button.setImage(UIImage(named: imageName), for: UIControlState.normal)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        return button
    }
    
    func setupView(){
        backgroundColor = UIColor.white
        
        addSubview(nameLabel)
        addSubview(dateLabel)
        addSubview(profileImageView)
        
        addSubview(postTextView)
        addSubview(postImageView)
        addSubview(likesLabel)
        addSubview(commentsLabel)
        
        addSubview(optionDotsButon)
        addSubview(likeButton)
        addSubview(commentButton)
        
        addConstraintsWithFormat("H:|-15-[v0(40)]-13-[v1]-[v2]-13-|", views: profileImageView, nameLabel, optionDotsButon)
        addConstraintsWithFormat("H:[v0]-13-[v1]", views: profileImageView, dateLabel)
        addConstraintsWithFormat("V:|-15-[v0(40)]-13-[v1]-12-[v2(100)]-16-[v3]-15-|", views: profileImageView, postTextView, postImageView, likeButton)
        addConstraintsWithFormat("V:|-20-[v0]-2-[v1]", views: nameLabel, dateLabel)
        
        addConstraintsWithFormat("V:|-24-[v0]", views: optionDotsButon)
        
        addConstraintsWithFormat("V:[v0]-16-[v1]", views: postImageView, commentButton)
        addConstraintsWithFormat("V:[v0]-16-[v1]", views: postImageView, likesLabel)
        
        addConstraintsWithFormat("H:|-16-[v0]-24-|", views: postTextView)
        addConstraintsWithFormat("H:|[v0]|", views: postImageView)
        
        addConstraintsWithFormat("H:|-15-[v0]-6-[v1]-40-[v2]-6-[v3]",aligin: .alignAllBottom, views: likeButton, likesLabel, commentButton, commentsLabel)
//        addConstraintsWithFormat("H:|24-[v0]", views: optionDotsButon)

    }
    
    
}


