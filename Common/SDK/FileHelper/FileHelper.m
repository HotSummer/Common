#import "FileHelper.h"
#import <sys/xattr.h>

#define USER_CACHE_PLISTNAME        @"userPlist.plist"

static FileHelper *shareFileObj = nil;

@interface FileHelper ()

- (NSString *)getUserCacheFilePath;

@end

@implementation FileHelper

+ (FileHelper*)shareIntance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareFileObj = [[FileHelper alloc] init];//_ALLOC_OBJ_(FileHelper);
    });
    
    return shareFileObj;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        NSString *filePath = [self getUserCacheFilePath];
        
        [self createFileAtPath:filePath content:nil];
    }
    return self;
}

- (BOOL)fileExistsAtPath:(NSString*)filePath
{
     return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

+ (NSString*)getDocumentPath
{
    NSArray *arrPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [arrPath objectAtIndex:0];
    return documentsDirectory;
}

- (BOOL)createDirectory:(NSString*)dir attribute:(NSDictionary*)attr
{
    NSFileManager *fileMangaer = [NSFileManager defaultManager];
    
    BOOL result = [fileMangaer createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:attr error:nil];
    
    return result;
}

- (BOOL)createFileAtPath:(NSString*)path content:(NSData*)contentData
{
    NSFileManager *fileMangaer = [NSFileManager defaultManager];
    BOOL flag       = NO;
    BOOL isExisted  = [fileMangaer fileExistsAtPath:path isDirectory:&flag];
    
    BOOL result     = YES;
    if(!isExisted)
    {
        result = [fileMangaer createFileAtPath:path contents:contentData attributes:nil];
    }
    return result;
}

//+ (BOOL) setSkipBackupAttribute:(NSString *)path
//{
//    NSString * strVersion = [[UIDevice currentDevice] systemVersion];
//    float fVersion = 0.0;
//    
//    if (strVersion.length > 0) {
//        fVersion = [strVersion floatValue];
//    }
//    
//    BOOL result = NO;
//    
//    NSURL * url = [NSURL fileURLWithPath:path];
//    
//    if (fVersion >= 5.1f) {
//        result = [self addSkipBackupAttributeToItemAtURL_iOS5_1:url];
//    }
//    
//    if ((fVersion > 5.0f) && (fVersion < 5.1f)) {
//        result = [self addSkipBackupAttributeToItemAtURL:url];
//    }
//    
//    return result;
//}
//
//+ (BOOL)addSkipBackupAttributeToItemAtURL_iOS5_1:(NSURL *)URL
//{
//    BOOL success = NO;
//    
//    if ([[NSFileManager defaultManager] fileExistsAtPath:[URL path]]) {
//        NSError *error = nil;
//        success = [URL setResourceValue:[NSNumber numberWithBool:YES]
//                                 forKey:NSURLIsExcludedFromBackupKey error:&error];
//        
//        if (!success) {
//            NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
//        }
//    }
//    
//    return success;
//}

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    int result = NO;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[URL path]]) {
        const char *filePath = [[URL path] fileSystemRepresentation];
        
        const char  *attrName = "com.apple.MobileBackup";
        u_int8_t    attrValue = 1;
        
        result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
    }
    
    return result;
}

#pragma mark -- plist
- (NSDictionary*)loadDictInfoPlistName:(NSString*)plistName
{
    NSString *filtPath = [[NSBundle mainBundle] pathForResource:plistName ofType:([plistName rangeOfString:@"plist"].location == NSNotFound) ? @"plist" : nil];
    
    return [self loadDictInfoPlistPath:filtPath];
}

- (NSDictionary*)loadDictInfoPlistPath:(NSString *)filePath
{
    return [NSDictionary dictionaryWithContentsOfFile:filePath];
}


+ (float) fileSizeWithPath:(NSString *)path
{
    NSDictionary * fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    
    unsigned long long length = [fileAttributes fileSize];
    
    return length/1024.0;
}

#pragma mark -- usercache相关
- (NSString *)getUserCacheFilePath
{
    NSString *filePath  = [[[self class] getDocumentPath] stringByAppendingPathComponent:USER_CACHE_PLISTNAME];
    BOOL flag           = NO;
    BOOL isExisted      = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&flag];
    if(isExisted)
    {
        [self createFileAtPath:filePath content:nil];
    }
    return filePath;
}

- (void)setObjectToUserCache:(id)data forKey:(NSString*)key
{
    NSString *filePath       = [self getUserCacheFilePath];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithContentsOfFile:filePath]];
    if(data)
    {
        [dic setObject:data forKey:key];
        [self saveDataToUserCache:dic];
    }
}

- (void)saveDataToUserCache:(NSDictionary*)dict
{
    NSString *filePath = [self getUserCacheFilePath];
    [dict writeToFile:filePath atomically:YES];
}

- (id)getObjectFromUserCacheForKey:(NSString*)key
{
    NSString *filePath  = [self getUserCacheFilePath];
    NSDictionary *dic   = [NSDictionary dictionaryWithContentsOfFile:filePath];
    id val = [dic objectForKey:key];
    return val;
}

- (void)removeObjectFromUserCacheForKey:(NSString*)key
{
    NSString *filePath       = [self getUserCacheFilePath];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithContentsOfFile:filePath]];
    if(dic)
    {
        [dic removeObjectForKey:key];
        
        [self saveDataToUserCache:dic];
    }
}

@end
