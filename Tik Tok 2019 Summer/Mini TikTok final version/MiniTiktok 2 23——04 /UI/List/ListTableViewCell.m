//
//  ListTableViewCell.m
//  MiniTiktok
//
//  Created by Alan Young on 2019/7/20.
//  Copyright © 2019 Alan Young. All rights reserved.
//

#import "ListTableViewCell.h"

static NSCache *gloabImageCache;

@interface ListTableViewCell ()

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
//@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) UIImageView *playPauseIcon;
@property (nonatomic, strong) UILabel *myTitleLabel;
@property (nonatomic, strong) LikeButton *loveButton;
@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic, strong) NSURLSessionTask *imageDownloadTask;
//@property (nonatomic, assign) BOOL pausedByUser;
@property (nonatomic, strong) AVAsset *asset;

@end

@implementation ListTableViewCell 

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.iconImageView];
        
//        [self.contentView addGestureRecognizer:self.tapGesture];
        
        // DEMO 3-3 视频循环播放
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoDidFinishedPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        
        // Demo 3-4 AVPlayerLayer 创建并显示
        [self.contentView.layer addSublayer:self.playerLayer];
        [self.contentView addSubview:self.myTitleLabel];
        
        //创建喜欢&评论按钮
        [self.contentView addSubview:self.loveButton];
        [self.contentView addSubview:self.commentButton];
        [self.contentView addSubview:self.playPauseIcon];
    }
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)configWithModel:(ItemModel *)item forIndexPath:(nonnull NSIndexPath *)indexPath {
    
    [self.myTitleLabel setText:item.title];
    _myTitleLabel.alpha = 1;
    CABasicAnimation *titleAnimation = [[CABasicAnimation alloc] init];
    titleAnimation.keyPath = @"frame.size.width";
    titleAnimation.fromValue = @(0);
    titleAnimation.toValue = @(100);
    
    self.iconImageView.image = [UIImage imageNamed:@"img_video_loading_max"];
    self.iconImageView.hidden = NO;
    [self setPlayPauseIconVisible:NO animated:NO];
    
    if (item.coverURL.length > 0) {
        // Demo 2-2 NSCache
        //NScache 和字典差不多 key value存储格式
        [self.imageDownloadTask cancel];
        
        UIImage *cachedImage = [[self imageCache] objectForKey:item.coverURL];
        if (cachedImage) {
            self.iconImageView.image = cachedImage;
            NSLog(@"缓存照片！");
        }
        else
        {
            // Demo 2-1 加载网络图片
            [self.imageDownloadTask cancel];
            NSURLSession *sharedSession = [NSURLSession sharedSession];
            self.imageDownloadTask = [sharedSession dataTaskWithURL:[NSURL URLWithString:item.coverURL] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                UIImage *responseImage = [UIImage imageWithData:data];
                if (responseImage)
                {
                    [[self imageCache] setObject:responseImage forKey:item.coverURL cost:(responseImage.size.width * responseImage.size.height * 8)];
                }
                NSLog(@"下载照片！");
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.iconImageView.image = [UIImage imageWithData:data];
                });
            }];
            [self.imageDownloadTask resume];
        }
        
    }
    
    // Demo 3-1 创建 Asset，并获取相关的 视频信息
    NSURL *videoURL = [NSURL URLWithString:item.videoURL];
    self.asset = [AVURLAsset assetWithURL:videoURL];
    [self.asset loadValuesAsynchronouslyForKeys:@[@"dutarion"] completionHandler:^{
        AVKeyValueStatus durationStatus = [self.asset statusOfValueForKey:@"dutarion" error:nil];
        
        switch (durationStatus)
        {
            case AVKeyValueStatusLoaded:
                NSLog(@"duration: %f",CMTimeGetSeconds([self.asset duration]));
                break;
                
            default:
                break;
        }
    }];
    
    // Demo 3-2 创建 playerItem，并监听视频加载进度
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:self.asset];
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:0 context:nil];
    
    // Demo 3-2 播放视频
    //    AVPlayer *player = [[AVPlayer alloc] initWithPlayerItem:playerItem];//开销很大！！！
    [self.player replaceCurrentItemWithPlayerItem:playerItem];
    [self.player setRate:1.0];
    
}

- (void)didEndDisplayModel:(ItemModel *)item forIndexPath:(NSIndexPath *)indexPath {
    [ImageDownloader cancelDownloadingFromURLString:item.coverURL forTaskTag:[self tagForIndexPath:indexPath]];
    [self.player pause];
}

- (NSString *)tagForIndexPath:(NSIndexPath *)indexPath {
    return [NSString stringWithFormat:@"%ld-%ld", indexPath.section, indexPath.row];
}

#pragma mark - Layout
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.iconImageView.frame = self.contentView.bounds;
    self.playPauseIcon.center = self.contentView.center;
    
    // 3-4 layout player layer
    self.playerLayer.frame = self.contentView.bounds;
//    self.pausedByUser = NO;
}

#pragma mark - Getters
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.clipsToBounds = YES;
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _iconImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (AVPlayer *)player {
    if (!_player) {
        // Demo 3-2 播放视频 并播放
        self.player = [[AVPlayer alloc] init];
        
        // Demo 3-2 播放开始时，封面消失
        [self.player addObserver:self forKeyPath:@"timeControlStatus" options:0 context:nil];
        
        // Demo 3-3 播放进度监听
        [_player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(0.5, 30) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
            NSLog(@"AVPlayer play progress %f",CMTimeGetSeconds(time));
        }];
    }
    return _player;
}

- (AVPlayerLayer *)playerLayer {
    if (!_playerLayer) {
        // Demo 3-4 AVPlayerLayer 创建并显示
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;//撑满整个屏幕
        
    }
    return _playerLayer;
}

//- (UITapGestureRecognizer *)tapGesture {
//    if (!_tapGesture) {
//        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTapped:)];
//    }
//    return _tapGesture;
//}

- (UIImageView *)playPauseIcon {
    if (!_playPauseIcon) {
        _playPauseIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pauseAndPlay"]];
        CGFloat lenth = CGRectGetWidth(UIScreen.mainScreen.bounds) / 5;
        CGFloat leftDis = CGRectGetWidth(UIScreen.mainScreen.bounds) / 2 - lenth / 2;
        CGFloat topDis = CGRectGetHeight(UIScreen.mainScreen.bounds) / 2 - lenth / 2;
        
        [_playPauseIcon setFrame:CGRectMake(leftDis, topDis, lenth, lenth)];
        [self setPlayPauseIconVisible:NO animated:NO];
    }
    return _playPauseIcon;
}

- (UILabel *)myTitleLabel
{
    if (!_myTitleLabel) {
        _myTitleLabel = [[UILabel alloc] init];
        CGFloat topDis = CGRectGetHeight(UIScreen.mainScreen.bounds) * 8 / 10;
        CGFloat leftDis = 20;
        [_myTitleLabel setFrame:CGRectMake(leftDis, topDis, 200, 30)];
        _myTitleLabel.backgroundColor = [UIColor clearColor];
        _myTitleLabel.textColor = [UIColor whiteColor];
        [_myTitleLabel setFont:[UIFont systemFontOfSize:30]];
    }
    return _myTitleLabel;
}

- (LikeButton *)loveButton
{
    if (!_loveButton) {
        CGFloat lenth = 40;
        CGFloat rightMargin = 8;
        CGFloat topDis = CGRectGetHeight(UIScreen.mainScreen.bounds) * 5 / 9;
        CGFloat leftDis = CGRectGetWidth(UIScreen.mainScreen.bounds) - lenth - rightMargin;
        _loveButton = [LikeButton buttonWithType:UIButtonTypeCustom];
        _loveButton.contentMode = UIViewContentModeScaleToFill;
        _loveButton.frame = CGRectMake(leftDis, topDis, lenth, lenth);
        _loveButton.backgroundColor = [UIColor clearColor];
        _loveButton.alpha = 0.7;
        
        [_loveButton setImage:[UIImage imageNamed:@"dislike"] forState:UIControlStateNormal];
        [_loveButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateSelected];
        
        [_loveButton addTarget:self action:@selector(loveButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loveButton;
}

- (UIButton *)commentButton
{
    if (!_commentButton) {
        _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _commentButton.contentMode = UIViewContentModeScaleToFill;
        _commentButton.frame = CGRectMake(self.loveButton.frame.origin.x, self.loveButton.frame.origin.y + 65, CGRectGetWidth(_loveButton.frame), CGRectGetHeight(_loveButton.frame));
        _commentButton.backgroundColor = [UIColor clearColor];
        _commentButton.alpha = 0.7;
        
        [_commentButton setImage:[UIImage imageNamed:@"commentButton"] forState:UIControlStateNormal];
        
        [_commentButton addTarget:self action:@selector(commentButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentButton;
}

#pragma mark - Player status
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    // DEMO 3-2 创建 playerItem，并监听视频加载进度
    if ([keyPath isEqualToString:@"loadedTimeRanges"])
    {
        NSLog(@"New loadedTimeRanges %@",self.player.currentItem.loadedTimeRanges);
    }
    
    // DEMO 3-2 播放开始时，封面消失
    else if ([keyPath isEqualToString:@"timeControlStatus"])
    {
        switch (self.player.timeControlStatus)
        {
            case AVPlayerTimeControlStatusPlaying:
                self.iconImageView.hidden = YES;
                break;
                
            default:
                break;
        }
    }
}

- (void)playVideo {
//    if (!self.pausedByUser) {
        [self.player play];
//        self.pausedByUser = !self.pausedByUser;
//    }
}

- (void)pauseVideo {
//    if (!self.pausedByUser) {
        [self.player pause];
//        self.pausedByUser = !self.pausedByUser;
//    }
}

#pragma mark - Events
- (void)cellTapped:(UITapGestureRecognizer *)tapGesture {
    if (self.player.rate) {
        [self setPlayPauseIconVisible:YES animated:YES];
//        [self.player pause];
        [self pauseVideo];
    }
    else
    {
        [self setPlayPauseIconVisible:NO animated:YES];
//        [self.player play];
        [self playVideo];
    }
}

- (void)setPlayPauseIconVisible:(BOOL)visible animated:(BOOL)animated {
//    self.pausedByUser = visible;
    void (^animation)(void) = ^{
        self.playPauseIcon.alpha = visible ? 0.6 : 0;
        self.playPauseIcon.transform = visible ? CGAffineTransformIdentity : CGAffineTransformMakeScale(1.5, 1.5);
    };
    
    if (animated) {
        [UIView animateWithDuration:0.2 animations:animation];
    } else {
        animation();
    }
}

- (void)videoDidFinishedPlaying:(NSNotification *)noti {
    // DEMO 3-3 视频循环播放
    AVPlayerItem *item = noti.object;
    if (item == self.player.currentItem)
    {
        [self.player seekToTime:kCMTimeZero];
        [self.player play];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    NSTimeInterval delaytime = 0.4;//自己根据需要调整
    switch (touch.tapCount)
    {
        case 1:
            [self performSelector:@selector(cellTapped:) withObject:nil afterDelay:delaytime];
            break;
        default:
            [NSObject cancelPreviousPerformRequestsWithTarget:self];
            [[YPDouYinLikeAnimation shareInstance] createAnimationWithTouch:touches withEvent:event];
            NSLog(@"2 click");
            break;
//        default:
//            break;
    }
}

#pragma mark - image cache
- (NSCache *)imageCache
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // Demo 2-2 NSCache
        gloabImageCache = [[NSCache alloc] init];
        [gloabImageCache setCountLimit:100];
        [gloabImageCache setTotalCostLimit:50 * 1024 * 1024];
        
    });
    return gloabImageCache;
}

#pragma mark - button actions

- (void) loveButtonClick
{
    _loveButton.selected = !_loveButton.selected;
}

- (void) commentButtonClick
{
    
}

@end
