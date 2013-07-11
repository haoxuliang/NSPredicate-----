//
//  HXLRegexVC.m
//  HXLPredicateTest
//
//  Created by LeoHao on 13-5-31.
//  Copyright (c) 2013年 LeoHao. All rights reserved.
//

#import "HXLRegexVC.h"

@interface HXLRegexVC ()

@end

@implementation HXLRegexVC

#pragma mark - Init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"正则表达式";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_textFieldEmail release];
    [_textFieldMobile release];
    [_textFieldPersonID release];
    [_textFieldChinese release];
    [_textFieldUrl release];
    [super dealloc];
}

#pragma mark - <------ Private ------>
-(void)showAlertViewWithMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"验证信息" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

#pragma mark - <------ 备注开始 ------>
/**
 元字符      描述
 \          将下一个字符标记为一个特殊字符、或一个原义字符、或一个向后引用、或一个八进制转义符。例如，“\n”匹配字符“n”。“\\n”匹配一个换行符。序列“\\”匹配“\”而“\(”则匹配“(”。
 
 ^          匹配输入字符串的开始位置。如果设置了RegExp对象的Multiline属性，^也匹配“\n”或“\r”之后的位置。
 
 $          匹配输入字符串的结束位置。如果设置了RegExp对象的Multiline属性，$也匹配“\n”或“\r”之前的位置。
 
 *          匹配前面的子表达式零次或多次。例如，zo*能匹配“z”以及“zoo”。*等价于{0,}。
 
 +          匹配前面的子表达式一次或多次。例如，“zo+”能匹配“zo”以及“zoo”，但不能匹配“z”。+等价于{1,}。
 
 ?          匹配前面的子表达式零次或一次。例如，“do(es)?”可以匹配“does”或“does”中的“do”。?等价于{0,1}。
 
 {n}        n是一个非负整数。匹配确定的n次。例如，“o{2}”不能匹配“Bob”中的“o”，但是能匹配“food”中的两个o。
 
 {n,}       n是一个非负整数。至少匹配n次。例如，“o{2,}”不能匹配“Bob”中的“o”，但能匹配“foooood”中的所有o。“o{1,}”等价于“o+”。“o{0,}”则等价于“o*”。
 
 {n,m}      m和n均为非负整数，其中n<=m。最少匹配n次且最多匹配m次。例如，“o{1,3}”将匹配“fooooood”中的前三个o。“o{0,1}”等价于“o?”。请注意在逗号和两个数之间不能有空格。
 
 ?          当该字符紧跟在任何一个其他限制符（*,+,?，{n}，{n,}，{n,m}）后面时，匹配模式是非贪婪的。非贪婪模式尽可能少的匹配所搜索的字符串，而默认的贪婪模式则尽可能多的匹配所搜索的字符串。例如，对于字符串“oooo”，“o+?”将匹配单个“o”，而“o+”将匹配所有“o”。
 
 .点         匹配除“\n”之外的任何单个字符。要匹配包括“\n”在内的任何字符，请使用像“[\s\S]”的模式。

 (pattern)      匹配pattern并获取这一匹配。所获取的匹配可以从产生的Matches集合得到，在VBScript中使用SubMatches集合，在JScript中则使用$0…$9属性。要匹配圆括号字符，请使用“\(”或“\)”。
 
 (?:pattern)    匹配pattern但不获取匹配结果，也就是说这是一个非获取匹配，不进行存储供以后使用。这在使用或字符“(|)”来组合一个模式的各个部分是很有用。例如“industr(?:y|ies)”就是一个比“industry|industries”更简略的表达式。
 
 (?=pattern)    正向肯定预查，在任何匹配pattern的字符串开始处匹配查找字符串。这是一个非获取匹配，也就是说，该匹配不需要获取供以后使用。例如，“Windows(?=95|98|NT|2000)”能匹配“Windows2000”中的“Windows”，但不能匹配“Windows3.1”中的“Windows”。预查不消耗字符，也就是说，在一个匹配发生后，在最后一次匹配之后立即开始下一次匹配的搜索，而不是从包含预查的字符之后开始。

 (?!pattern)    正向否定预查，在任何不匹配pattern的字符串开始处匹配查找字符串。这是一个非获取匹配，也就是说，该匹配不需要获取供以后使用。例如“Windows(?!95|98|NT|2000)”能匹配“Windows3.1”中的“Windows”，但不能匹配“Windows2000”中的“Windows”。

 (?<=pattern)   反向肯定预查，与正向肯定预查类似，只是方向相反。例如，“(?<=95|98|NT|2000)Windows”能匹配“2000Windows”中的“Windows”，但不能匹配“3.1Windows”中的“Windows”。
 
 (?<!pattern)   反向否定预查，与正向否定预查类似，只是方向相反。例如“(?<!95|98|NT|2000)Windows”能匹配“3.1Windows”中的“Windows”，但不能匹配“2000Windows”中的“Windows”。
 
 x|y            匹配x或y。例如，“z|food”能匹配“z”或“food”。“(z|f)ood”则匹配“zood”或“food”。
 
 [xyz]          字符集合。匹配所包含的任意一个字符。例如，“[abc]”可以匹配“plain”中的“a”。
 
 [^xyz]         负值字符集合。匹配未包含的任意字符。例如，“[^abc]”可以匹配“plain”中的“plin”。
 
 [a-z]          字符范围。匹配指定范围内的任意字符。例如，“[a-z]”可以匹配“a”到“z”范围内的任意小写字母字符。
                注意:只有连字符在字符组内部时,并且出两个字符之间时,才能表示字符的范围; 如果出字符组的开头,则只能表示连字符本身.
 
 [^a-z]         负值字符范围。匹配任何不在指定范围内的任意字符。例如，“[^a-z]”可以匹配任何不在“a”到“z”范围内的任意字符。
 
 \b             匹配一个单词边界，也就是指单词和空格间的位置。例如，“er\b”可以匹配“never”中的“er”，但不能匹配“verb”中的“er”。
 
 \B             匹配非单词边界。“er\B”能匹配“verb”中的“er”，但不能匹配“never”中的“er”。
 
 \cx            匹配由x指明的控制字符。例如，\cM匹配一个Control-M或回车符。x的值必须为A-Z或a-z之一。否则，将c视为一个原义的“c”字符。
 
 \d             匹配一个数字字符。等价于[0-9]。
 
 \D             匹配一个非数字字符。等价于[^0-9]。
 
 \f             匹配一个换页符。等价于\x0c和\cL。
 
 \n             匹配一个换行符。等价于\x0a和\cJ。
 
 \r             匹配一个回车符。等价于\x0d和\cM。
 
 \s             匹配任何空白字符，包括空格、制表符、换页符等等。等价于[ \f\n\r\t\v]。
 
 \S             匹配任何非空白字符。等价于[^ \f\n\r\t\v]。
 
 \t             匹配一个制表符。等价于\x09和\cI。
 
 \v             匹配一个垂直制表符。等价于\x0b和\cK。
 
 \w             匹配包括下划线的任何单词字符。等价于“[A-Za-z0-9_]”。
 
 \W             匹配任何非单词字符。等价于“[^A-Za-z0-9_]”。
 
 \xn            匹配n，其中n为十六进制转义值。十六进制转义值必须为确定的两个数字长。例如，“\x41”匹配“A”。“\x041”则等价于“\x04&1”。正则表达式中可以使用ASCII编码。
 
 \num           匹配num，其中num是一个正整数。对所获取的匹配的引用。例如，“(.)\1”匹配两个连续的相同字符。
 
 \n             标识一个八进制转义值或一个向后引用。如果\n之前至少n个获取的子表达式，则n为向后引用。否则，如果n为八进制数字（0-7），则n为一个八进制转义值。
 
 \nm            标识一个八进制转义值或一个向后引用。如果\nm之前至少有nm个获得子表达式，则nm为向后引用。如果\nm之前至少有n个获取，则n为一个后跟文字m的向后引用。如果前面的条件都不满足，若n和m均为八进制数字（0-7），则\nm将匹配八进制转义值nm。
 
 \nml           如果n为八进制数字（0-7），且m和l均为八进制数字（0-7），则匹配八进制转义值nml。
 
 \un            匹配n，其中n是一个用四个十六进制数字表示的Unicode字符。例如，\u00A9匹配版权符号（&copy;）。
 */

#pragma mark - <------ IBAction ------>

/**
 NSString *englishNameRegex = @"[a-zA-Z]+/[a-zA-Z]+";
 NSString *chineseNameRegex = @"[\u4e00-\u9fa5]+";
 */
- (IBAction)checkEmail:(id)sender {
    _strInput = _textFieldEmail.text;
    _strRegex = @"^[A-Za-z0-9_.+-]+@[A-Za-z0-9-]+[.]([A-Za-z]{2,4})$";
    _predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",_strRegex];
    if ([_predicate evaluateWithObject:_strInput]) {
        [self showAlertViewWithMessage:@"this is an e-mail"];
    }else{
        [self showAlertViewWithMessage:@"this is not an e-mail"];
    }
}

- (IBAction)checkMobileNum:(id)sender {
//    _strRegex = @"^1[0-9]{10}$";//简单方式
    _strRegex = @"^1[3,4,5,6,7,8]{1}[0-9]{9}$";//严格方式
    
    _strInput = _textFieldMobile.text;
    _predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",_strRegex];
    if ([_predicate evaluateWithObject:_strInput]) {
        [self showAlertViewWithMessage:@"this is a mobile"];
    }else{
        [self showAlertViewWithMessage:@"this is not a mobile"];
    }
    
}

- (IBAction)checkPersonID:(id)sender {
    /**
     15位身份证号码各位的含义:
     1-2位省、自治区、直辖市代码；
     3-4位地级市、盟、自治州代码；
     5-6位县、县级市、区代码；
     7-12位出生年月日,比如670401代表1967年4月1日,与18位的第一个区别；
     13-15位为顺序号，其中15位男为单数，女为双数；
     与18位身份证号的第二个区别：没有最后一位的验证码。
     举例：
     130503 670401 001的含义; 13为河北，05为邢台，03为桥西区，出
     生日期为1967年4月1日，顺序号为001。
     */
    _strRegex = @"^([0-9]{8}((0[1-9])|(1[0-2]))(([1,2][0-9])|(3[0,1])|(0[1-9]))[0-9]{3})|([0-9]{6}1[8,9][0-9]{2}((0[1-9])|(1[0-2]))(([1,2][0-9])|(3[0,1])|(0[1-9]))[0-9]{3}([0-9]|[X,x]))$";
    _strInput = _textFieldPersonID.text;
    _predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",_strRegex];
    if ([_predicate evaluateWithObject:_strInput]) {
        [self showAlertViewWithMessage:@"this is a person id"];
    }else{
        [self showAlertViewWithMessage:@"this is not a person id"];
    }
}

- (IBAction)checkChinese:(id)sender {
    _strRegex = @"^[\u4e00-\u9fa5]+$";
    _strInput = _textFieldChinese.text;
    _predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",_strRegex];
    if ([_predicate evaluateWithObject:_strInput]) {
        [self showAlertViewWithMessage:@"this is chinese"];
    }else{
        [self showAlertViewWithMessage:@"this is not chinese"];
    }
}

- (IBAction)checkUrl:(id)sender {
    _strRegex = @"^(http|https|ftp)://[a-zA-Z0-9]+[.][a-zA-Z0-9]+([.][a-zA-Z0-9]+){0,1}(/[a-zA-Z0-9-_.+=?&%]*)*$";
    _strInput = _textFieldUrl.text;
    _predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",_strRegex];
    if ([_predicate evaluateWithObject:_strInput]) {
        [self showAlertViewWithMessage:@"this is url"];
    }else{
        [self showAlertViewWithMessage:@"this is not rul"];
    }
}

-(IBAction)hiddenKeyBoard:(id)sender
{
    [_textFieldEmail resignFirstResponder];
    [_textFieldMobile resignFirstResponder];
    [_textFieldPersonID resignFirstResponder];
    [_textFieldChinese resignFirstResponder];
    [_textFieldUrl resignFirstResponder];
}

#pragma mark - <------ UITextFieldDelegate ------>
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField == _textFieldEmail) {
        [self checkEmail:nil];
    }else if (textField == _textFieldMobile){
        [self checkMobileNum:nil];
    }else if (textField == _textFieldPersonID){
        [self checkPersonID:nil];
    }else if (textField == _textFieldChinese){
        [self checkChinese:nil];
    }else if (textField == _textFieldUrl){
        [self checkUrl:nil];
    }
    return YES;
}



@end
