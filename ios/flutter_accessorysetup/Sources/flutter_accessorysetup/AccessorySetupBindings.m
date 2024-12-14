#include <stdint.h>
#import <AccessorySetupKit/AccessorySetupKit.h>
#import "AccessorySetupBindings.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import <UIKit/UIImage.h>

#if !__has_feature(objc_arc)
#error "This file must be compiled with ARC enabled"
#endif

id objc_retain(id);
id objc_retainBlock(id);

typedef void  (^_ListenerTrampoline)(void * arg0, id arg1);
_ListenerTrampoline _FFIAccessorySetupKit_wrapListenerBlock_wjovn7(_ListenerTrampoline block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, objc_retain(arg1));
  };
}

typedef void  (^_ListenerTrampoline1)(void * arg0, id arg1, id arg2);
_ListenerTrampoline1 _FFIAccessorySetupKit_wrapListenerBlock_ao4xm9(_ListenerTrampoline1 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, objc_retain(arg1), objc_retain(arg2));
  };
}

Protocol* _FFIAccessorySetupKit_FFIAccessorySessionDelegate() { return @protocol(FFIAccessorySessionDelegate); }

typedef void  (^_ListenerTrampoline2)(id arg0, id arg1);
_ListenerTrampoline2 _FFIAccessorySetupKit_wrapListenerBlock_wjvic9(_ListenerTrampoline2 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1) {
    objc_retainBlock(block);
    block(objc_retain(arg0), objc_retain(arg1));
  };
}
