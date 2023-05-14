abstract class states{}
class initialstate extends states{}
class counterchange extends states{}


class signuploadingstate extends states{}
class signupsuccessstate extends states{}
class signuperrorstate extends states{
  final String error ;
  signuperrorstate(this.error);
}

class loginloadingstate extends states{}
class loginsuccessstate extends states{}
class loginerrorstate extends states{}

class createuserloadingstate extends states{}
class createusersuccessstate extends states{}
class createusererrorstate extends states{}


class getuserloadingstate extends states{}
class getusersuccessstate extends states{}
class getusererrorstate extends states{}

class updateloadingstate extends states{}
class updatesuccessstate extends states{}
class updateerrorstate extends states{}

class paymentauthloadingstate extends states{}
class paymentauthsuccessstate extends states{}
class paymentautherrorstate extends states{}

class getOrderloadingstate extends states{}
class getOrdersuccessstate extends states{}
class getOrdererrorstate extends states{}

class getpaymentloadingstate extends states{}
class getpaymentsuccessstate extends states{}
class getpaymenterrorstate extends states{}

class getrefcodeloadingstate extends states{}
class getrefcodesuccessstate extends states{}
class getrefcodeerrorstate extends states{}

class StartTimerState extends states{}
class StopTimerState extends states{}


class LoadingSendMessageState extends states {}

class SuccessSendMessageState extends states {}

class ErrorSendMessageState extends states {}

class LoadingGetMessageState extends states {}

class SuccessGetMessageState extends states {}

class ErrorGetMessageState extends states {}

class LoadingGetUsersState extends states {}
class SuccessGetUsersState extends states {}
class ErrorGetUsersState extends states {}


class LoadingSaveDataState extends states {}
class SuccessSaveDataState extends states {}
class ErrorSaveDataState extends states {}

class LoadingGetDataState extends states {}
class SuccessGetDataState extends states {}
class ErrorGetDataState extends states {}

class ChangeRate extends states{}

class LoadingGetPublicDataState extends states{}
class SuccessGetPublicDataState extends states{}
class ErrorGetPublicDataState extends states{}