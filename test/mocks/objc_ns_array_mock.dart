import 'package:objective_c/objective_c.dart' as objc;

class NSArrayMock implements objc.NSArray {
  // @override
  // objc.NSObject autorelease() {
  //   // TODO: implement autorelease
  //   throw UnimplementedError();
  // }

  // @override
  // objc.ObjCObjectBase class2() {
  //   // TODO: implement class2
  //   throw UnimplementedError();
  // }

  // @override
  // bool conformsToProtocol_1(objc.Protocol aProtocol) {
  //   // TODO: implement conformsToProtocol_1
  //   throw UnimplementedError();
  // }

  // @override
  // objc.ObjCObjectBase copy() {
  //   // TODO: implement copy
  //   throw UnimplementedError();
  // }

  // @override
  // // TODO: implement count
  // int get count => throw UnimplementedError();

  // @override
  // int countByEnumeratingWithState_objects_count_(Pointer<objc.NSFastEnumerationState> state, Pointer<Pointer> buffer, int len) {
  //   // TODO: implement countByEnumeratingWithState_objects_count_
  //   throw UnimplementedError();
  // }

  // @override
  // void dealloc() {
  //   // TODO: implement dealloc
  // }

  // @override
  // // TODO: implement debugDescription1
  // objc.NSString get debugDescription1 => throw UnimplementedError();

  // @override
  // // TODO: implement description1
  // objc.NSString get description1 => throw UnimplementedError();

  // @override
  // void doesNotRecognizeSelector_(Pointer aSelector) {
  //   // TODO: implement doesNotRecognizeSelector_
  // }

  // @override
  // void encodeWithCoder_(objc.NSCoder coder) {
  //   // TODO: implement encodeWithCoder_
  // }

  // @override
  // void forwardInvocation_(objc.NSInvocation anInvocation) {
  //   // TODO: implement forwardInvocation_
  // }

  // @override
  // objc.ObjCObjectBase forwardingTargetForSelector_(Pointer aSelector) {
  //   // TODO: implement forwardingTargetForSelector_
  //   throw UnimplementedError();
  // }

  // @override
  // // TODO: implement hash1
  // int get hash1 => throw UnimplementedError();

  // @override
  // objc.NSArray init() {
  //   // TODO: implement init
  //   throw UnimplementedError();
  // }

  // @override
  // objc.NSArray initWithArray_(objc.NSArray array) {
  //   // TODO: implement initWithArray_
  //   throw UnimplementedError();
  // }

  // @override
  // objc.NSArray initWithArray_copyItems_(objc.NSArray array, bool flag) {
  //   // TODO: implement initWithArray_copyItems_
  //   throw UnimplementedError();
  // }

  // @override
  // objc.NSArray? initWithCoder_(objc.NSCoder coder) {
  //   // TODO: implement initWithCoder_
  //   throw UnimplementedError();
  // }

  // @override
  // objc.NSArray initWithObjects_(objc.ObjCObjectBase firstObj) {
  //   // TODO: implement initWithObjects_
  //   throw UnimplementedError();
  // }

  // @override
  // objc.NSArray initWithObjects_count_(Pointer<Pointer> objects, int cnt) {
  //   // TODO: implement initWithObjects_count_
  //   throw UnimplementedError();
  // }

  // @override
  // bool isEqual_(objc.ObjCObjectBase object) {
  //   // TODO: implement isEqual_
  //   throw UnimplementedError();
  // }

  // @override
  // bool isKindOfClass_(objc.ObjCObjectBase aClass) {
  //   // TODO: implement isKindOfClass_
  //   throw UnimplementedError();
  // }

  // @override
  // bool isMemberOfClass_(objc.ObjCObjectBase aClass) {
  //   // TODO: implement isMemberOfClass_
  //   throw UnimplementedError();
  // }

  // @override
  // bool isProxy() {
  //   // TODO: implement isProxy
  //   throw UnimplementedError();
  // }

  // @override
  // Pointer<NativeFunction<Void Function()>> methodForSelector_(Pointer aSelector) {
  //   // TODO: implement methodForSelector_
  //   throw UnimplementedError();
  // }

  // @override
  // objc.NSMethodSignature methodSignatureForSelector_(Pointer aSelector) {
  //   // TODO: implement methodSignatureForSelector_
  //   throw UnimplementedError();
  // }

  // @override
  // objc.ObjCObjectBase mutableCopy() {
  //   // TODO: implement mutableCopy
  //   throw UnimplementedError();
  // }

  // @override
  // objc.ObjCObjectBase objectAtIndex_(int index) {
  //   // TODO: implement objectAtIndex_
  //   throw UnimplementedError();
  // }

  // @override
  // objc.ObjCObjectBase performSelector_(Pointer aSelector) {
  //   // TODO: implement performSelector_
  //   throw UnimplementedError();
  // }

  // @override
  // objc.ObjCObjectBase performSelector_withObject_(Pointer aSelector, objc.ObjCObjectBase object) {
  //   // TODO: implement performSelector_withObject_
  //   throw UnimplementedError();
  // }

  // @override
  // objc.ObjCObjectBase performSelector_withObject_withObject_(Pointer aSelector, objc.ObjCObjectBase object1, objc.ObjCObjectBase object2) {
  //   // TODO: implement performSelector_withObject_withObject_
  //   throw UnimplementedError();
  // }

  // @override
  // // TODO: implement ref
  // get ref => throw UnimplementedError();

  // @override
  // void release() {
  //   // TODO: implement release
  // }

  // @override
  // bool respondsToSelector_(Pointer aSelector) {
  //   // TODO: implement respondsToSelector_
  //   throw UnimplementedError();
  // }

  // @override
  // objc.NSObject retain() {
  //   // TODO: implement retain
  //   throw UnimplementedError();
  // }

  // @override
  // int retainCount() {
  //   // TODO: implement retainCount
  //   throw UnimplementedError();
  // }

  // @override
  // objc.NSObject self() {
  //   // TODO: implement self
  //   throw UnimplementedError();
  // }

  // @override
  // // TODO: implement superclass1
  // objc.ObjCObjectBase get superclass1 => throw UnimplementedError();

  @override
  dynamic noSuchMethod(Invocation invocation) {
    throw UnimplementedError(invocation.memberName.toString().split('"')[1]);
  }
}
