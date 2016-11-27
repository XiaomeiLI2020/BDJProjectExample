//
//  BDJPostExpressPack.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/24.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJPostExpressPack.h"
#import "BDJPostFrame.h"
#import "BDJPostRenderItem.h"
#import "BDJPicturePostRenderItem.h"

@implementation BDJPostExpressPack

- (id)onMeasureFrameWithItem:(__kindof XFRenderItem *)renderItem index:(NSUInteger)index
{
    BDJPostFrame *postFrame = [[BDJPostFrame alloc] init];
    BDJPostRenderItem *postRenderItem = renderItem;
    CGFloat cellContentWidth = ScreenSize.width - R_Size_PostCellMargin * 4;
    
    // 初始化固定的高度
    CGFloat cellTopH = R_Height_PostCellClip; // cell被裁剪的高度
    CGFloat cellHeaderH =  R_Size_PostCellMargin + R_Height_PostCellHeader + R_Size_PostCellMargin; // 头部高
    CGFloat cellBottomH = R_Size_PostCellMargin + R_Height_PostCellBottomBar; // 底部高
    // 开始计算cell高度
    CGFloat textMaxY = cellHeaderH;
    CGFloat textH = [postRenderItem.text boundingRectWithSize:CGSizeMake(cellContentWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
    textMaxY += textH;
    
    // 如果为短图
    if (postRenderItem.type == BDJPostRenderItemTypePicture ||
        postRenderItem.type == BDJPostRenderItemTypePictureGIF ||
        postRenderItem.type == BDJPostRenderItemTypePictureLong) {
        // 如果是长图，固定它的高度
        if(postRenderItem.type == BDJPostRenderItemTypePictureLong) {
            postFrame.pictureF = CGRectMake(R_Size_PostCellMargin, textMaxY + R_Size_PostCellMargin, cellContentWidth, R_Height_PostPictureBreak);
        } else {
            // 缩放它的比例
            BDJPicturePostRenderItem *item = renderItem;
            // 获得等比例图高
            CGFloat PictureH = cellContentWidth * item.height / item.width;
            
            // 计算图片的Frame
            postFrame.pictureF = CGRectMake(R_Size_PostCellMargin, textMaxY + R_Size_PostCellMargin, cellContentWidth, PictureH);
        }
        postFrame.cellHeight = cellTopH + CGRectGetMaxY(postFrame.pictureF) + cellBottomH;
        return postFrame;
    }
    
    postFrame.cellHeight = cellTopH + textMaxY + cellBottomH;
    return postFrame;
}
@end
