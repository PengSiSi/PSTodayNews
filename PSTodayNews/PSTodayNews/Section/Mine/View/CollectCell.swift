//
//  CollectCell.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/25.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class CollectCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        for control in self.subviews{
            
            if control.isMember(of: NSClassFromString("UITableViewCellEditControl")!) {
                for v in control.subviews{
                    if(v.isKind(of: UIImageView.self)){
                        let img = v as! UIImageView
                        if(self.isSelected){
                            img.image = UIImage(named: "air_download_option_press_20x20_")
                        }else{
                            img.image = UIImage(named: "air_download_option_20x20_")
                        }
                    }
                }
            }
        }
        super.layoutSubviews()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        
        for control in self.subviews{
            
            if control.isMember(of: NSClassFromString("UITableViewCellEditControl")!) {
                for v in control.subviews{
                    if(v.isKind(of: UIImageView.self)){
                        let img = v as! UIImageView
                        if(self.isSelected){
                            img.image = UIImage(named: "air_download_option_press_20x20_")
                        }else{
                            img.image = UIImage(named: "air_download_option_20x20_")
                        }
                    }
                }
            }
        }
    }
}

