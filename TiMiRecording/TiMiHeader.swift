//
//  TiMiHeader.swift
//  TiMiRecording
//
//  Created by 潘元荣(外包) on 16/9/1.
//  Copyright © 2016年 潘元荣(外包). All rights reserved.
//

import Foundation
import UIKit

let KWidth  = UIScreen.mainScreen().bounds.size.width
let KHeight  = UIScreen.mainScreen().bounds.size.height
let KSkyColor = UIColor(red: 248/255.0, green: 197/255/0, blue: 0, alpha: 1.0)
let KOrangeColor = UIColor(red: 253 / 255.0, green: 165/255.0, blue: 65/255.0, alpha: 1.0)
let KHeightScale  = KHeight / 670
let KWidthScale =  KWidth / 375
let KAccoutTitleMarginToAmount = 20 * KWidthScale
let KAccountDetailTypeImageViewHeight = 25 * KHeightScale
let KAccountDetailTipsImgaeViewHeight = 35 * KHeightScale
let KMiddleViewAddButtonHeight : CGFloat = 80
let KLittleFont  = 10 * KHeightScale
let KTitleFont = 14 * KHeightScale
let KMiddleFont = 12 * KHeightScale
let KBigFont = 18 * KHeightScale
let KKeyBoardHeight : CGFloat = 286.0 * KHeightScale
let KAccountItemHeight =  (KWidth)/5
let KAccountItemWidthMargin = 20 * KWidthScale
let KAccountChartViewHeight = 110 * KHeightScale
let KAccountItemNum : Int = 5
let KAccountItemNumTrue : Int = 3
let KAccountCommontTable = "commonAccountTable"
let KNotificationCurrentTime  = "CurrentTimeNotification"
let KNotificationAddAccountDetail = "AddAccountDetailNotification"
let KNotificationCellAnimationEnd = "AccountDetailCellAnimationEnd"
let KNotificationCellRefreshMonthBalance = "AccountDetailCellRefreshMonthBalance"
let KNotificationEndLoadFMDBData = "AccountFMDBDataEndLoad"