#import <Foundation/Foundation.h>

@interface FileHelper : NSObject

+ (FileHelper*)shareIntance;

+ (NSString*)getDocumentPath;

- (BOOL)fileExistsAtPath:(NSString*)filePath;

- (BOOL)createDirectory:(NSString*)dir attribute:(NSDictionary*)attr;

- (BOOL)createFileAtPath:(NSString*)path content:(NSData*)contentData;

//- (void)ansyWriteToFile:(id)obj

//
//+ (BOOL)setSkipBackupAttribute:(NSString *)path;
//
//+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;

//根据文件名加载Plist，默认位置bundle
- (NSDictionary*)loadDictInfoPlistName:(NSString*)plistName;

- (NSDictionary*)loadDictInfoPlistPath:(NSString *)filePath;

#pragma mark -- usercache相关
- (void)setObjectToUserCache:(id)data forKey:(NSString*)key;

- (id)getObjectFromUserCacheForKey:(NSString*)key;

- (void)removeObjectFromUserCacheForKey:(NSString*)key;

@end
