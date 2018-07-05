//
//  UITableViewCellRepresentable.h
//  WeatherApp
//
//  Created by Javier Azuara on 2018/06/30.
//  Copyright © 2018年 Javier Azuara. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol UITableViewCellRepresentable

@required
- (CGFloat)rowHeight;
- (UITableViewCell *)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
