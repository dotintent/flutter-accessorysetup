#import <Foundation/Foundation.h>
#import <AccessorySetupKit/AccessorySetupKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FFIAccessorySessionDelegate;

@interface FFIAccessorySession : NSObject

@property (nonatomic, readonly, copy) NSArray<NSString *> *logs;
@property (nonatomic, readonly, copy) NSArray<ASAccessory *> *accessories;

- (instancetype)init;

- (void)setDelegate:(id<FFIAccessorySessionDelegate>)delegate;

- (void)activate;
- (void)invalidate;
- (void)showPicker;
- (void)showPickerForItems:(NSArray<ASPickerDisplayItem *> *)items;
- (void)renameAccessory:(ASAccessory *)accessory options:(ASAccessoryRenameOptions)options;
- (void)removeAccessory:(ASAccessory *)accessory;
- (void)finishAuthorizationForAccessory:(ASAccessory *)accessory
                              settings:(ASAccessorySettings *)settings;
- (void)failAuthorizationForAccessory:(ASAccessory *)accessory;

@end

@protocol FFIAccessorySessionDelegate <NSObject>

- (void)handleEvent:(ASAccessoryEvent *)event;
- (void)didShowPickerWithError:(nullable NSError *)error;
- (void)didRenameAccessory:(ASAccessory *)accessory withError:(nullable NSError *)error;
- (void)didRemoveAccessory:(ASAccessory *)accessory withError:(nullable NSError *)error;
- (void)didFinishAuthorizationForAccessory:(ASAccessory *)accessory withError:(nullable NSError *)error;
- (void)didFailAuthorizationForAccessory:(ASAccessory *)accessory withError:(nullable NSError *)error;

@end

NS_ASSUME_NONNULL_END