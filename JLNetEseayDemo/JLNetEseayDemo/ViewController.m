//
//  ViewController.m
//  JLNetEseayDemo
//
//  Created by xiaomama on 2017/3/16.
//  Copyright © 2017年 lm. All rights reserved.
//

#import "ViewController.h"
#import "TopLineViewController.h"
#import "HotViewController.h"
#import "VideoViewController.h"
#import "ScoietyViewController.h"
#import "ReaderViewController.h"
#import "ScienceViewController.h"

#define JLScreenW [UIScreen mainScreen].bounds.size.width
#define JLScreenH [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) UIScrollView *titleScrollView;
@property (nonatomic, strong) NSMutableArray *titlesButton;
@property (nonatomic, weak) UIButton *selectButton;
@property (weak, nonatomic) UICollectionView *collectionView;


@end

@implementation ViewController

static NSString *const ID = @"cell";


#pragma mark - 懒加载
- (NSMutableArray *)titlesButton
{
    if (!_titlesButton) {
        _titlesButton = [NSMutableArray array];
    }
    return _titlesButton;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.添加子控制器
    [self setupAllChildViewController];
    // 2.添加滚动条
    [self setupTitleScrollView];
    // 3.添加标题按钮
    [self setupAllButtonTitle];
    
    // 4.添加底部的CollectionView
    [self setUpCollectionView];
    
}


#pragma mark - 添加所有的子控制器
- (void)setupAllChildViewController
{
    // 头条
    TopLineViewController *topLineVc = [[TopLineViewController alloc] init];
    topLineVc.title = @"头条";
    [self addChildViewController:topLineVc];
    
    // 热点
    HotViewController *hotVc = [[HotViewController alloc] init];
    hotVc.title = @"热点";
    [self addChildViewController:hotVc];
    
    // 视频
    VideoViewController *videoVc = [[VideoViewController alloc] init];
    videoVc.title = @"视频";
    [self addChildViewController:videoVc];
    
    // 社会
    ScoietyViewController *scoietyVc = [[ScoietyViewController alloc] init];
    scoietyVc.title = @"社会";
    [self addChildViewController:scoietyVc];
    
    // 订阅
    ReaderViewController *readerVc = [[ReaderViewController alloc] init];
    readerVc.title = @"订阅";
    [self addChildViewController:readerVc];
    
    // 科技
    ScienceViewController *scienceVc = [[ScienceViewController alloc] init];
    scienceVc.title = @"科技";
    [self addChildViewController:scienceVc];
}

#pragma mark - 添加标题滚动视图
- (void)setupTitleScrollView
{
    // 创建ScrollView
    CGFloat y = 64;
    CGFloat h = 44;
    CGFloat w = JLScreenW;
    UIScrollView *titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, y, w, h)];
    titleScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:titleScrollView];
    _titleScrollView = titleScrollView;
    
    // 导航控制器中添加的scrollView默认添加了额外滚动区域64，当scrollView高度小于64时，上面添加的控件显示不出来，一定要将automaticallyAdjustsScrollViewInsets属性设为NO
    self.automaticallyAdjustsScrollViewInsets=NO;
}

#pragma mark - 设置添加所有标题
- (void)setupAllButtonTitle
{
    NSUInteger count = self.childViewControllers.count;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = 100;
    CGFloat btnH = 44;

    for (NSUInteger i = 0; i < count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btnX = i * btnW;
        // 设置尺寸
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        btn.tag = i;
        
        UIViewController *vc = self.childViewControllers[i];
        
        // 设置标题颜色
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        // 设置内容
        [btn setTitle:vc.title forState:UIControlStateNormal];
    
        // 监听标题按钮点击
        [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        // 默认选中第0个标题
        if (i == 0) {
            [self titleClick:btn];
        }
        
        [_titleScrollView addSubview:btn];

        [self.titlesButton addObject:btn];
    }
    
    // 设置标题滚动视图范围
    _titleScrollView.contentSize = CGSizeMake(count * btnW, 0);

}

#pragma mark - 点击标题就会调用
- (void)titleClick:(UIButton *)button
{
    NSInteger i = button.tag;
    
    // 分析:需要做什么事情,看效果
    // 1.标题变成红色
    [self selectTitleButton:button];
    
    CGFloat offsetX = JLScreenW * i;
    
    self.collectionView.contentOffset = CGPointMake(offsetX, 0);
}

#pragma mark - 选中标题按钮
- (void)selectTitleButton:(UIButton *)titleButton
{
    // 设置标题颜色
    
    [_selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    
    // 设置标题居中
    [self setupTitleCenter:titleButton];
    
    // 标题放大
    _selectButton.transform = CGAffineTransformIdentity;
    titleButton.transform = CGAffineTransformMakeScale(1.3, 1.3);
    
    _selectButton = titleButton;
}

#pragma mark - 设置标题居中
- (void)setupTitleCenter:(UIButton *)titleButton
{
    // 本质:修改标题滚动视图的偏移量
    CGFloat offsetX = titleButton.center.x - JLScreenW * 0.5;
    
    // 处理最小偏移量
    if (offsetX < 0) {
        offsetX = 0;
    }
    
    // 处理最大偏移量
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - JLScreenW;
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    
    // 设置偏移量
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

- (void)setUpCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置cell尺寸
    flowLayout.itemSize = CGSizeMake(JLScreenW, JLScreenH - 64-44);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor blueColor];
    collectionView.frame = CGRectMake(0, 64+44, self.view.frame.size.width, JLScreenH - 64-44);
    collectionView.pagingEnabled = YES;
    _collectionView = collectionView;
    [self.view addSubview:collectionView];
    
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.childViewControllers.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIViewController *vc = self.childViewControllers[indexPath.item];
      vc.view.frame = cell.bounds;
    [cell.contentView addSubview:vc.view];
  
    return cell;
}

#pragma mark - collectionView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x / self.view.bounds.size.width;
    UIButton *selectedBtn = self.titlesButton[index];
    
     [self selectTitleButton:selectedBtn];

}

@end
