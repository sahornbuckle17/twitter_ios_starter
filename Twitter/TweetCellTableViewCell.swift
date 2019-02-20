//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Sia on 2/10/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    var favorited : Bool = false
    var tweetId: Int = -1
    
    
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let tobeFavorited = !favorited
        if(tobeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setfavorite(isfavorited: true)
            }, failure: { (error) in
                print ("Favorite did not succed: \(error)")
            })
        }else{
            TwitterAPICaller.client? .unfavoriteTweet(tweetId: tweetId, success: {
                self.setfavorite(isfavorited: false)
            }, failure: { (error) in
                print("Unfavorited did not succeed: \(error)")
            })
        }
        
    }
    
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: { 
            self.setRetweeted(isRetweeted: true)
        }, failure: { (error) in
            print("Error retweeting: \(error)")
        })
    }
    func setRetweeted( isRetweeted:Bool){
        if(isRetweeted){
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for:UIControl.State.normal)
            retweetButton.isEnabled = false
        }else{
            retweetButton.setImage(UIImage(named: "retweet-icon"), for:UIControl.State.normal)
            retweetButton.isEnabled = true
            
        }
    }
    
    
    func setfavorite( isfavorited:Bool){
        favorited = isfavorited
        if(favorited){
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else{
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
