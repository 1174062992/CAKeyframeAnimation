//
//  CAKeyFAnimationViewController.m
//  CAKeyframeAnimation
//
//  Created by xunli on 2018/3/9.
//  Copyright © 2018年 caoji. All rights reserved.
//

#import "CAKeyFAnimationViewController.h"

@interface CAKeyFAnimationViewController ()<CAAnimationDelegate>
/**
 *图片视图
 */
@property(nonatomic,strong)UIImageView* addCartImg;
/**
 *添加购物车按钮
 */
@property(nonatomic,strong)UIButton* ShoppingCartButton;
/**
 *购物车按钮
 */
@property(nonatomic,strong)UIButton* CartButton;
/**
 *加入购物车的计数器
 */
@property(nonatomic,strong)UILabel* LabelNumber;
@property(nonatomic,assign)NSInteger number;
@end

@implementation CAKeyFAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    self.number =0;
    [self reloadData];
    //标题
    self.title=@"购物车";
}
/**
 *创建动画view
 */
-(void)reloadData{
    self.addCartImg =[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4, self.view.frame.size.height-100, 30, 30)];
    self.addCartImg.hidden =true;
    [self.view addSubview:self.addCartImg];
    self.addCartImg.image =[UIImage imageNamed:@"123.jpg"];
    //添加购物车
    self.ShoppingCartButton =[[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-45, self.view.frame.size.width-100, 45)];
    [self.ShoppingCartButton setTitle:@"添加购物车" forState:0];
    [self.ShoppingCartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.ShoppingCartButton.backgroundColor =[UIColor redColor];
    [self.ShoppingCartButton addTarget:self action:@selector(clickAddShopCartBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.ShoppingCartButton];
    //购物车
    self.CartButton =[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-100, self.view.frame.size.height-45, 100, 45)];
    [self.CartButton setImage:[UIImage imageNamed:@"购物车.png"] forState:UIControlStateNormal];
    [self.CartButton setImage:[UIImage imageNamed:@"购物车.png"] forState:UIControlStateSelected];
    self.CartButton.imageView.contentMode =  UIViewContentModeScaleAspectFit;
    self.CartButton.backgroundColor =[UIColor orangeColor];
    [self.CartButton addTarget:self action:@selector(clickAddShopCartBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.CartButton];
    //购物车数量
    self.LabelNumber =[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-40, self.view.frame.size.height-45, 40, 30)];
    self.LabelNumber.textColor =[UIColor whiteColor];
    self.LabelNumber.textAlignment =NSTextAlignmentCenter;
    self.LabelNumber.font =[UIFont systemFontOfSize:16];
    self.LabelNumber.text =[NSString stringWithFormat:@"%ld",(long)self.number];
    [self.view addSubview:self.LabelNumber];
}
/**
 *具体动画的实现
 */
-(void)clickAddShopCartBtn:(id)sender{
    self.number++;
    self.LabelNumber.text =[NSString stringWithFormat:@"%ld",(long)self.number];
    self.addCartImg.hidden =NO;
    //闯将动画对象
    CAKeyframeAnimation* keyframeAnimation =[CAKeyframeAnimation animationWithKeyPath:@"position"];
    //创建一个CGPathRef对象===动画路线、
    CGMutablePathRef path =CGPathCreateMutable();
    //设置开始位置
    CGPathMoveToPoint(path, NULL, self.addCartImg.layer.position.x-40, self.addCartImg.layer.position.y-40);//移动到起始点
    //沿着路径添加四曲线点移动
    CGPathAddQuadCurveToPoint(path, NULL, 100, 100, self.view.frame.size.width-30, self.view.frame.size.height-35);
    keyframeAnimation.path =path;
    keyframeAnimation.delegate =self;
    CGPathRelease(path);
    keyframeAnimation.duration =0.7;
    [self.addCartImg.layer addAnimation:keyframeAnimation forKey:@"KCKeyframeAnimation_Position"];
    //旋转动画
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 0.1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 5;
    
    //    为addCartImg添加旋转动画
    [self.addCartImg.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
