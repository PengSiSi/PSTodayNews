//
//  AddCategoryViewController.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/24.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit
import SwiftyJSON
import ObjectMapper

let ChannelViewCellIdentifier = "ChannelViewCellIdentifier"
let ChannelViewHeaderIdentifier = "ChannelViewHeaderIdentifier"

let itemWidth: CGFloat = (k_ScreenWidth - 100) * 0.25

class AddCategoryViewController: BaseViewController {

    // 我的频道
    var myTopics: [VideoTopTitle] = [VideoTopTitle]()
    // 推荐频道
    var recommendTopics: [AddCategoryModel] = [AddCategoryModel]()

    // 频道的回调
    var switchCallBack: ((_ selectArr: [String], _ recommendArr: [String]) -> ())?
    
    var headerArr = [["我的频道","点击进入频道"],["频道推荐","点击添加频道"]]
    var selectedArr = ["推荐","河北","财经","娱乐","体育","社会","NBA","视频","汽车","图片","科技","军事","国际","数码","星座","电影","时尚","文化","游戏","教育","动漫","政务","纪录片","房产","佛学","股票","理财"]
    var recommendArr: [String]? = [String]()
    
    var isEdit: Bool = false // 是否是编辑状态
    var collectionView: UICollectionView?
    var indexPath: IndexPath?
    var targetIndexPath: IndexPath?
    
    lazy var dragingItem: ChannelCell = {
        
        let cell = ChannelCell(frame: CGRect(x: 0, y: 0, width: itemWidth, height: itemWidth * 0.5))
        cell.isHidden = true
        return cell
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        topView()
        setupUI()
    }
}

// MARK: - 数据请求

extension AddCategoryViewController {
    
    func initialize() {
        
    }
    
    func loadData() {
        let url = "http://is.snssdk.com/article/category/get_extra/v1/?version_code=6.1.2&app_name=news_article&vid=6AB8DE8F-DADF-4C93-A6EE-C81B88F94F44&device_id=14958264372&channel=App%20Store&resolution=1242*2208&aid=13&ab_version=127190,126061,128695,129540,127680,122834,130106,126065,123725,128454,129627,126072,129993,125503,125174,130167,127335,129538,126057,128478,129518,122948,130200,128166,130015,130094,114338,125071,127758&ab_feature=z1&ab_group=z1&openudid=f147bc351dc77e5f2da6b37337f44f513c0a3cf5&live_sdk_version=1.6.5&idfv=6AB8DE8F-DADF-4C93-A6EE-C81B88F94F44&ac=WIFI&os_version=10.3.1&ssmix=a&device_platform=iphone&iid=36424536574&ab_client=a1,f2,f7,e1&device_type=iPhone%206S%20Plus&idfa=36137365-CB03-4CE2-AFB2-8261BE190622&version=3715800923%7C12%7C1495522218"
//        let params = ["device_id": device_id,
//                      "aid": 13,
//                      "iid": IID] as [String : Any]
        HTTPTool.shareInstance.requestData(.GET, URLString: url, parameters: nil, success: { (response) in
            print(response)
            // 字典数组转化为模型数组
            let dataArray = response["data"] as! [String: AnyObject]
            let data = dataArray["data"]
            self.recommendTopics = Mapper <AddCategoryModel>().mapArray(JSONArray: data as! [[String : Any]])! // 注意在这里转数组
            self.handleData()
        }) { (error) in
            print(error)
        }
    }
    
    func handleData() {
        for model in recommendTopics {
            let model = model 
            recommendArr?.append("+ \(model.name!)")
        }
        collectionView?.reloadData()
    }
}

// MARK: - 设置界面

extension AddCategoryViewController {
    
    func setupUI() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 0.5)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        layout.headerReferenceSize = CGSize(width: k_ScreenWidth, height: 40)
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 40, width: k_ScreenWidth, height: k_ScreenHeight - 40), collectionViewLayout: layout)
        collectionView?.backgroundColor = UIColor.white
        collectionView?.delegate = self
        collectionView?.dataSource = self
        view.addSubview(collectionView!)
        collectionView?.register(ChannelCell.self, forCellWithReuseIdentifier: ChannelViewCellIdentifier)
        collectionView?.register(ChannelHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ChannelViewHeaderIdentifier)
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressGesture(_:)))
        collectionView?.isUserInteractionEnabled  = true
        (collectionView?.addGestureRecognizer(longPress))
    }
    
    func topView() {
        
        let backview = UIView(frame: CGRect(x: 0, y: 20, width: k_ScreenWidth, height: 20))
        view.addSubview(backview)
        let button = UIButton(frame: CGRect(x: 10, y: 0, width: 40, height: 20))
        backview.addSubview(button)
        button.setImage(UIImage(named: "add_channels_close_20x20_"), for: .normal)
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
    }
    
    // dismiss
    func back() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - 代理

extension AddCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? selectedArr.count : (recommendArr?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChannelViewCellIdentifier, for: indexPath) as! ChannelCell
        cell.text = indexPath.section == 0 ? selectedArr[indexPath.row] : recommendArr?[indexPath.row]
        if indexPath.section == 0 {
            cell.backgroundColor = UIColor.groupTableViewBackground
            cell.edite = !self.isEdit
        } else {
            // section = 1都要隐藏
            cell.edite = false
            cell.imageView.isHidden = true
            cell.layer.borderWidth = 0.5
            cell.layer.cornerRadius = 3
            cell.backgroundColor = UIColor.white
            cell.layer.borderColor = UIColor.lightGray.cgColor
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ChannelViewHeaderIdentifier, for: indexPath) as! ChannelHeaderView
        // 注意if...else都要写
        if indexPath.section == 1 {
            header.button.isHidden = true
        } else {
            header.button.isHidden = false
        }
        header.text = headerArr[indexPath.section][0]
        header.subTitle = headerArr[indexPath.section][1]
        
        header.clickCallBack = { [weak self] in
            self?.isEdit = !(self?.isEdit)!
            collectionView.reloadData()
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let cell = collectionView.cellForItem(at: indexPath) as! ChannelCell
//        cell.label.textColor = UIColor.red
        if indexPath.section > 0 {
            
            // 更新数据
            let obj = recommendArr?[indexPath.item]
            // 移除
            recommendArr?.remove(at: indexPath.item)
            // 添加
            selectedArr.append(obj!)
            // 移动
            collectionView.moveItem(at: indexPath, to: NSIndexPath(item: selectedArr.count - 1, section: 0) as IndexPath)
        } else {
            // 编辑
            if isEdit {
                // 第一个不能移除
                if indexPath.item == 0 {
                    return
                }
                // 更新数据
                let obj = selectedArr[indexPath.item]
                // 移除
                selectedArr.remove(at: indexPath.item)
                //添加
                recommendArr?.insert(obj, at: 0)
                collectionView.moveItem(at: indexPath, to: NSIndexPath(item: 0, section: 1) as IndexPath)
            }
        }
        // block回调
        if self.switchCallBack != nil {
            self.switchCallBack!(selectedArr, recommendArr!)
        }
    }
}

// MARK: - Private Method

extension AddCategoryViewController {
    
    //MARK: - 长按动作
    func longPressGesture(_ tap: UILongPressGestureRecognizer) {
        
        if !isEdit{
            isEdit = !isEdit
            collectionView?.reloadData()
            return
        }
        let point = tap.location(in: collectionView)
        
        switch tap.state {
        case UIGestureRecognizerState.began:
            dragBegan(point: point)
        case UIGestureRecognizerState.changed:
            drageChanged(point: point)
        case UIGestureRecognizerState.ended:
            drageEnded(point: point)
        case UIGestureRecognizerState.cancelled:
            drageEnded(point: point)
        default: break
        }
    }
    
    //MARK: - 长按开始
    private func dragBegan(point: CGPoint) {
        
        indexPath = collectionView?.indexPathForItem(at: point)
        if indexPath == nil || (indexPath?.section)! > 0 || indexPath?.item == 0
        {return}
        
        let item = collectionView?.cellForItem(at: indexPath!) as? ChannelCell
        item?.isHidden = true
        dragingItem.isHidden = false
        dragingItem.frame = (item?.frame)!
        dragingItem.text = item!.text
        dragingItem.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
    }
    //MARK: - 长按过程
    private func drageChanged(point: CGPoint) {
        if indexPath == nil || (indexPath?.section)! > 0 || indexPath?.item == 0 {return}
        dragingItem.center = point
        targetIndexPath = collectionView?.indexPathForItem(at: point)
        if targetIndexPath == nil || (targetIndexPath?.section)! > 0 || indexPath == targetIndexPath || targetIndexPath?.item == 0 {return}
        // 更新数据
        let obj = selectedArr[indexPath!.item]
        selectedArr.remove(at: indexPath!.row)
        selectedArr.insert(obj, at: targetIndexPath!.item)
        //交换位置
        collectionView?.moveItem(at: indexPath!, to: targetIndexPath!)
        indexPath = targetIndexPath
    }
    
    //MARK: - 长按结束
    private func drageEnded(point: CGPoint) {
        
        if indexPath == nil || (indexPath?.section)! > 0 || indexPath?.item == 0 {return}
        let endCell = collectionView?.cellForItem(at: indexPath!)
        
        UIView.animate(withDuration: 0.25, animations: {
            
            self.dragingItem.transform = CGAffineTransform.identity
            self.dragingItem.center = (endCell?.center)!
            
        }, completion: {
            
            (finish) -> () in
            
            endCell?.isHidden = false
            self.dragingItem.isHidden = true
            self.indexPath = nil
            
        })
        
    }
}
