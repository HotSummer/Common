//
//  NSDate+DateHelper.m
//  DateHelper
//
//  Created by rang on 13-1-7.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "NSDate+TPCategory.h"

#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]

@implementation NSDate (TPCategory)
/**
 *  获取在中国时区的当前时间
 *
 *  @return 中国时区的当前时间
 */
+ (NSDate *)getCurrentTimeInChinaTimeZone {
    NSDate *date;
    NSTimeZone *zone;
    NSInteger interval;
    NSDate *localeDate;
    
    date = [NSDate date];
    zone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    interval = [zone secondsFromGMTForDate:date];
    localeDate = [date dateByAddingTimeInterval:interval];
    
    return localeDate;
}

/**
 *  获取所有时区的标准名称的集合
 *
 *  @return 所有时区的标准名称的集合
 */
+ (NSArray *)getAllTimeZoneNames {
    return [NSTimeZone knownTimeZoneNames];
}

/**
 *  获取所有时区的简称的集合
 *
 *  @return 所有时区的简称的集合
 */
+ (NSDictionary *)getAllTimeZoneAbbreviation {
    return [NSTimeZone abbreviationDictionary];
}

//获取今天是星期几
-(NSInteger)dayOfWeek{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *offsetComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
													 fromDate:self];
    NSInteger y=[offsetComponents year];
    NSInteger m=[offsetComponents month];
    NSInteger d=[offsetComponents day];
    static int t[] = {0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4};
    y -= m < 3;
    
    NSInteger result=(y + y/4 - y/100 + y/400 + t[m-1] + d) % 7;
    if (result==0) {
        result=7;
    }
    return result;
}
//获取每月有多少天
-(NSInteger)monthOfDay{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *offsetComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
													 fromDate:self];
    NSInteger y=[offsetComponents year];
    NSInteger m=[offsetComponents month];
    if (m==2) {
        if (y%4==0&&(y%100!=0||y%400==0)) {
            return 29;
        }
        return 28;
    }
    if (m==4||m==6||m==9||m==11) {
        return 30;  
    }
    return 31;
}
//本周开始时间
-(NSDate*)beginningOfWeek{
    NSInteger weekday=[self dayOfWeek];
    return  [self dateByAddingDays:(weekday-1)*-1];
}
//本周结束时间
- (NSDate *)endOfWeek{
    NSInteger weekday=[self dayOfWeek];
    if (weekday==7) {
        return self;
    }
    return [self dateByAddingDays:7-weekday];
}
//日期添加几天
-(NSDate*)dateByAddingDays:(NSInteger)days{
    NSDateComponents *c = [[NSDateComponents alloc] init];
	c.day = days;
    
    NSDate *resultDate=[[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0];
    [c release];
    
    return resultDate;
	//return [[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0];
    /***
    NSTimeInterval interval = 24 * 60 * 60;//表示一天
    return  [self dateByAddingTimeInterval:day*interval];
     ***/
}
//日期格式化
- (NSString *)stringWithFormat:(NSString *)format {
	NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
	[outputFormatter setDateFormat:format];
	NSString *timestamp_str = [outputFormatter stringFromDate:self];
	[outputFormatter release];
	return timestamp_str;
}
//字符串转换成时间
+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format {
	NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
	[inputFormatter setDateFormat:format];
	NSDate *date = [inputFormatter dateFromString:string];
	[inputFormatter release];
	return date;
}

-(NSDate*)dateWithFormater:(NSString*)format{
    NSString *string = [self stringWithFormat:format];
    
	return [NSDate dateFromString:string withFormat:format];
}

+ (NSString*)timeStringFromInterval:(NSTimeInterval)timeInterval
{
    long hours  = (long)timeInterval / 60l;
    long mins   = ((long)timeInterval / 60l) % 60l;
    long secs   = (long)timeInterval % 60l;
    long hunds  = (long)(timeInterval * 100.0) % 100l;
    
    NSString *timeStr = [NSString stringWithFormat:@"%02ld:%02ld:%02ld.%02ld", hours, mins, secs, hunds];
    
    return timeStr;
}

//时间转换成字符串
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format {
	return [date stringWithFormat:format];
}
//日期转化成民国时间
-(NSString*)dateToTW:(NSString *)string{
    NSString *str=[self stringWithFormat:string];
    int y=[[str substringWithRange:NSMakeRange(0, 4)] intValue];
    return [NSString stringWithFormat:@"%d%@",y-1911,[str stringByReplacingCharactersInRange:NSMakeRange(0, 4) withString:@""]];
}
- (TKDateInformation) dateInformationWithTimeZone:(NSTimeZone*)tz{
	
	
	TKDateInformation info;
	
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	[gregorian setTimeZone:tz];
	NSDateComponents *comp = [gregorian components:(NSMonthCalendarUnit | NSMinuteCalendarUnit | NSYearCalendarUnit |
													NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSSecondCalendarUnit)
										  fromDate:self];
	info.day = (int)[comp day];
	info.month = (int)[comp month];
	info.year = (int)[comp year];
	
	info.hour = (int)[comp hour];
	info.minute = (int)[comp minute];
	info.second = (int)[comp second];
	
	info.weekday = (int)[comp weekday];
	
	
	return info;
	
}
- (TKDateInformation) dateInformation{
	
	TKDateInformation info;
	
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comp = [gregorian components:(NSMonthCalendarUnit | NSMinuteCalendarUnit | NSYearCalendarUnit |
													NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSSecondCalendarUnit)
										  fromDate:self];
	info.day = (int)[comp day];
	info.month = (int)[comp month];
	info.year = (int)[comp year];
	
	info.hour = (int)[comp hour];
	info.minute = (int)[comp minute];
	info.second = (int)[comp second];
	
	info.weekday = (int)[comp weekday];
	
    
	return info;
}
+ (NSDate*) dateFromDateInformation:(TKDateInformation)info timeZone:(NSTimeZone*)tz{
	
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	[gregorian setTimeZone:tz];
	NSDateComponents *comp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit) fromDate:[NSDate date]];
	
	[comp setDay:info.day];
	[comp setMonth:info.month];
	[comp setYear:info.year];
	[comp setHour:info.hour];
	[comp setMinute:info.minute];
	[comp setSecond:info.second];
	[comp setTimeZone:tz];
	
	return [gregorian dateFromComponents:comp];
}
+ (NSDate*) dateFromDateInformation:(TKDateInformation)info{
	
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit) fromDate:[NSDate date]];
	
	[comp setDay:info.day];
	[comp setMonth:info.month];
	[comp setYear:info.year];
	[comp setHour:info.hour];
	[comp setMinute:info.minute];
	[comp setSecond:info.second];
	//[comp setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	
	return [gregorian dateFromComponents:comp];
}

+ (NSString*) dateInformationDescriptionWithInformation:(TKDateInformation)info{
	return [NSString stringWithFormat:@"%d %d %d %d:%d:%d",info.month,info.day,info.year,info.hour,info.minute,info.second];
}
-(BOOL)compareToDate:(NSDate*)date{
    if ([self compare:date]==NSOrderedDescending) {
        return YES;
    }
    return NO;
}

#pragma mark Comparing Dates

- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}

- (BOOL) isToday
{
    return [self isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL) isTomorrow
{
    return [self isEqualToDateIgnoringTime:[NSDate dateTomorrow]];
}

- (BOOL) isYesterday
{
    return [self isEqualToDateIgnoringTime:[NSDate dateYesterday]];
}

// This hard codes the assumption that a week is 7 days
- (BOOL) isSameWeekAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
    
    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
    if (components1.weekday != components2.weekday) return NO;
    
    // Must have a time interval under 1 week. Thanks @aclark
    return (abs([self timeIntervalSinceDate:aDate]) < D_WEEK);
}

- (BOOL) isThisWeek
{
    return [self isSameWeekAsDate:[NSDate date]];
}

- (BOOL) isNextWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self isSameWeekAsDate:newDate];
}

- (BOOL) isLastWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self isSameWeekAsDate:newDate];
}

// Thanks, mspasov
- (BOOL) isSameMonthAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:aDate];
    return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}

- (BOOL) isThisMonth
{
    return [self isSameMonthAsDate:[NSDate date]];
}

- (BOOL) isSameYearAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:aDate];
    return (components1.year == components2.year);
}

- (BOOL) isThisYear
{
    // Thanks, baspellis
    return [self isSameYearAsDate:[NSDate date]];
}

- (BOOL) isNextYear
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:[NSDate date]];
    
    return (components1.year == (components2.year + 1));
}

- (BOOL) isLastYear
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:[NSDate date]];
    
    return (components1.year == (components2.year - 1));
}

- (BOOL) isEarlierThanDate: (NSDate *) aDate
{
    return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL) isLaterThanDate: (NSDate *) aDate
{
    return ([self compare:aDate] == NSOrderedDescending);
}

// Thanks, markrickert
- (BOOL) isInFuture
{
    return ([self isLaterThanDate:[NSDate date]]);
}

// Thanks, markrickert
- (BOOL) isInPast
{
    return ([self isEarlierThanDate:[NSDate date]]);
}

+ (NSDate *) dateWithDaysFromNow: (NSInteger) days
{
    // Thanks, Jim Morrison
    return [[NSDate date] dateByAddingDays:days];
}

+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days
{
    // Thanks, Jim Morrison
    return [[NSDate date] dateBySubtractingDays:days];
}

+ (NSDate *) dateTomorrow
{
    return [NSDate dateWithDaysFromNow:1];
}

+ (NSDate *) dateYesterday
{
    return [NSDate dateWithDaysBeforeNow:1];
}

- (NSDate *) dateBySubtractingDays: (NSInteger) dDays
{
    return [self dateByAddingDays: (dDays * -1)];
}


@end
