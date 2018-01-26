//
//  YDLineChart.h
//  JHChartDemo
//
//  Created by sky on 2018/1/23.
//  Copyright © 2018年 JH. All rights reserved.
//

#import "YDChart.h"
#import <UIKit/UIKit.h>

/**
 *  Line chart type, has been abandoned
 */
typedef  NS_ENUM(NSInteger,JHLineChartTypeYD){

    JHChartLineEveryValueForEveryXYD=0, /*        Default         */
    JHChartLineValueNotForEveryXYD
};



/**
 *  Distribution type of line graph
 */
typedef NS_ENUM(NSInteger,JHLineChartQuadrantTypeYD){

    /**
     *  The line chart is distributed in the first quadrant.
     */
    JHLineChartQuadrantTypeFirstQuardrantYD,

    /**
     *  The line chart is distributed in the first two quadrant
     */
    JHLineChartQuadrantTypeFirstAndSecondQuardrantYD,

    /**
     *  The line chart is distributed in the first four quadrant
     */
    JHLineChartQuadrantTypeFirstAndFouthQuardrantYD,

    /**
     *  The line graph is distributed in the whole quadrant
     */
    JHLineChartQuadrantTypeAllQuardrantYD


};



@interface YDLineChart : YDChart

/**
 *  X axis scale data of a broken line graph, the proposed use of NSNumber or the number of strings
 */
@property (nonatomic, strong) NSArray * xLineDataArr;


/**
 *  Y axis scale data of a broken line graph, the proposed use of NSNumber or the number of strings
 */
@property (nonatomic, strong) NSArray * yLineDataArr;


/**
 *  An array of values that are about to be drawn.
 */
@property (nonatomic, strong) NSArray * valueArr;


/**
 *  The type of broken line graph has been abandoned.
 */
@property (assign , nonatomic) JHLineChartTypeYD  lineType ;


/**
 *  The quadrant of the specified line chart
 */
@property (assign, nonatomic) JHLineChartQuadrantTypeYD  lineChartQuadrantType;


/**
 *  Line width (the value of non drawn path width, only refers to the X, Y axis scale line width)
 */
@property (assign, nonatomic) CGFloat lineWidth;


/**
 *  To draw the line color of the target
 */
@property (nonatomic, strong) NSArray * valueLineColorArr;




/**
 *  Color for each value draw point
 */
@property (nonatomic, strong) NSArray * pointColorArr;


/**
 *  Y, X axis scale numerical color
 */
@property (nonatomic, strong) UIColor * xAndYNumberColor;


/**
 *  Draw dotted line color
 */
@property (nonatomic, strong) NSArray * positionLineColorArr;



/**
 *  Draw the text color of the information.
 */
@property (nonatomic, strong) NSArray * pointNumberColorArr;



/**
 *  Value path is required to draw points
 */
@property (assign,  nonatomic) BOOL hasPoint;

@property (assign, nonatomic) CGPoint currentLoc; //长按时当前定位位置
@property (assign, nonatomic) CGPoint screenLoc; //相对于屏幕位置
@property (assign,nonatomic)BOOL isLongPress;//是不是长按状态

/**
 *  Draw path line width
 */
@property (nonatomic, assign) CGFloat animationPathWidth;


/**
 *  Drawing path is the curve, the default NO
 */
@property (nonatomic, assign) BOOL pathCurve;


@property (assign, nonatomic) CGFloat pointGap;//点之间的距离
@property (assign , nonatomic)  CGFloat  perXLen ;
@property (assign , nonatomic)  NSInteger MaxX   ;
/**
 *  Whether to fill the contents of the drawing path, the default NO
 */
@property (nonatomic, assign) BOOL contentFill;

@property (nonatomic, strong) NSArray * allDicArray;


/**
 *  Draw path fill color, default is grey
 */
@property (nonatomic, strong) NSArray * contentFillColorArr;


/*!
 * whether this chart shows the pointDescription or not.Default is YES
 */
@property (nonatomic , assign)BOOL showPointDescription;

/**
 *  whether this chart shows the Y line or not.Default is YES
 */
@property (nonatomic,assign) BOOL showYLine ;


/**
 *  whether this chart shows the Y level lines or not.Default is NO
 */
@property (nonatomic,assign) BOOL showYLevelLine;

/**
 *  whether this chart shows leading lines for value point or not,default is YES
 */
@property (nonatomic,assign) BOOL showValueLeadingLine;


/**
 *  fontsize of value point.Default 8.0;
 */
@property (nonatomic,assign) CGFloat valueFontSize;

/*!
 * whether chart shows XLineDescription vertical or not。Default is NO；
 */
@property (nonatomic , assign)BOOL showXDescVertical;

/*!
 * if showXDescVertical is YES,this property will control xDescription width.Default is 20.0
 */
@property (nonatomic , assign)CGFloat xDescMaxWidth;

/*!
 * if showXDescVertical is YES,this property will control xDescription angle;
 */
@property (nonatomic , assign)CGFloat xDescriptionAngle;

/*!
 * if showDoubleYLevelLine is true ,this chart will show two y levelLine.Default is NO;
 */
@property (nonatomic , assign)BOOL showDoubleYLevelLine;

/*!
 * if showDoubleYLevelLine is true ,this chart will display others vlaues from this Array;
 */
@property (nonatomic , strong)NSArray * valueBaseRightYLineArray;

/*!
 * it will draw path start will point valueArray[drawPathFromXIndex];Default 0;Action:this property only take effect when chart type in JHLineChartQuadrantTypeFirstQuardrant and
 JHLineChartQuadrantTypeFirstAndFouthQuardrant;
 */
@property (nonatomic , assign)NSInteger drawPathFromXIndex;
/**
 *  Custom initialization method
 *
 *  @param frame         frame
 *  @param lineChartType Abandoned
 *
 */
-(instancetype)initWithFrame:(CGRect)frame
            andLineChartType:(JHLineChartTypeYD)lineChartType;




@end
