//
//  YDLineY.h
//  JHChartDemo
//
//  Created by sky on 2018/1/24.
//  Copyright © 2018年 JH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>

#define weakSelf(weakSelf)  __weak typeof(self) weakself = self;
#define XORYLINEMAXSIZE CGSizeMake(CGFLOAT_MAX,30)

/**
 *  Line chart type, has been abandoned
 */
typedef  NS_ENUM(NSInteger,JHLineChartTypeYDY){
    
    JHChartLineEveryValueForEveryXYDY=0, /*        Default         */
    JHChartLineValueNotForEveryXYDY
};



/**
 *  Distribution type of line graph
 */
typedef NS_ENUM(NSInteger,JHLineChartQuadrantTypeYDY){
    
    /**
     *  The line chart is distributed in the first quadrant.
     */
    JHLineChartQuadrantTypeFirstQuardrantYDY,
    
    /**
     *  The line chart is distributed in the first two quadrant
     */
    JHLineChartQuadrantTypeFirstAndSecondQuardrantYDY,
    
    /**
     *  The line chart is distributed in the first four quadrant
     */
    JHLineChartQuadrantTypeFirstAndFouthQuardrantYDY,
    
    /**
     *  The line graph is distributed in the whole quadrant
     */
    JHLineChartQuadrantTypeAllQuardrantYDY
    
    
};



@interface YDLineY : UIView

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
@property (assign , nonatomic) JHLineChartTypeYDY  lineType ;


/**
 *  The quadrant of the specified line chart
 */
@property (assign, nonatomic) JHLineChartQuadrantTypeYDY  lineChartQuadrantType;


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



/**
 *  Draw path line width
 */
@property (nonatomic, assign) CGFloat animationPathWidth;


/**
 *  Drawing path is the curve, the default NO
 */
@property (nonatomic, assign) BOOL pathCurve;





/**
 *  Whether to fill the contents of the drawing path, the default NO
 */
@property (nonatomic, assign) BOOL contentFill;




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




/**
 *  The margin value of the content view chart view
 *  图表的边界值
 */
@property (nonatomic, assign) UIEdgeInsets contentInsets;


/**
 *  The origin of the chart is different from the meaning of the origin of the chart.
 As a pie chart and graph center ring. The line graph represents the origin.
 *  图表的原点值（如果需要）
 */
@property (assign, nonatomic)  CGPoint chartOrigin;


/**
 *  Name of chart. The name is generally not displayed, just reserved fields
 *  图表名称
 */
@property (copy, nonatomic) NSString * chartTitle;


/**
 *  The fontsize of Y line text.Default id 8;
 */
@property (nonatomic,assign) CGFloat yDescTextFontSize;

/*!
 * if animationDuration <= 0,this chart will display without animation.Default is 2.0;
 */
@property (nonatomic , assign)NSTimeInterval animationDuration;

/**
 *  The fontsize of X line text.Default id 8;
 */
@property (nonatomic,assign) CGFloat xDescTextFontSize;


/**
 *  X, Y axis line color
 */
@property (nonatomic, strong) UIColor * xAndYLineColor;


/**
 *  Start drawing chart.
 */
- (void)showAnimation;

/**
 *  Clear current chart when refresh
 */
- (void)clear;



-(instancetype)initWithFrame:(CGRect)frame
            andLineChartType:(JHLineChartTypeYDY)lineChartType;

/**
 *  Draw a line according to the conditions
 *  @param start：Draw Starting Point
 *  @param end：Draw Ending Point
 *  @param isDotted：Is the dotted line
 *  @param color：Line color
 */
- (void)drawLineWithContext:(CGContextRef )context
               andStarPoint:(CGPoint )start
                andEndPoint:(CGPoint)end
            andIsDottedLine:(BOOL)isDotted
                   andColor:(UIColor *)color;


/**
 *  Draw a piece of text at a point
 *  @param point：Draw position
 *  @param color：TextColor
 *  @param fontSize：Text font size
 */
- (void)drawText:(NSString *)text
      andContext:(CGContextRef )context
         atPoint:(CGPoint )point
       WithColor:(UIColor *)color
     andFontSize:(CGFloat)fontSize;



/**
 *  Similar to the above method
 *
 */
- (void)drawText:(NSString *)text
         context:(CGContextRef )context
         atPoint:(CGRect )rect
       WithColor:(UIColor *)color
            font:(UIFont*)font;



/**
 *  Determine the width of a certain segment of text in the default font.
 */
- (CGFloat)getTextWithWhenDrawWithText:(NSString *)text;



/**
 *  Draw a rectangle at a point
 *  p:Draw position
 *
 */
- (void)drawQuartWithColor:(UIColor *)color
             andBeginPoint:(CGPoint)p
                andContext:(CGContextRef)contex;


/**
 *  Draw a circle at a point
 *  @param redius：Circle redius
 *  @param p:Draw position
 *
 */
- (void)drawPointWithRedius:(CGFloat)redius
                   andColor:(UIColor *)color
                   andPoint:(CGPoint)p
                 andContext:(CGContextRef)contex;


/**
 *  According to the relevant conditions to determine the width of the text
 *  @param maxSize：Maximum range of text
 *  @param textFont：Text font
 *  @param aimString:Text that needs to be measured
 */
- (CGSize)sizeOfStringWithMaxSize:(CGSize)maxSize
                         textFont:(CGFloat)fontSize
                        aimString:(NSString *)aimString;



@end
