unit PhoneInfo;

interface

uses
  System.SysUtils
  ,System.Classes
  ,Androidapi.JNI.Embarcadero
  ,Androidapi.JNI.GraphicsContentViewText
  ,Androidapi.helpers
  ,Androidapi.JNIBridge
  ,DeviceInfo
  ,DeviceStatus
  ;


type TOnGetDeviceInfo = procedure (const Info: TInfo) of object;
type TOnGetDevicePhoneNumber = procedure (const Number:string) of object;
type TOnGetBatteryPercentEvent = procedure(Sender: TObject; const Percent: Integer) of object;

type
  TPhoneInfo = class(TComponent)
  private

   FDeviceInfo:TDeviceInfo;
   FDeviceStatus:TDeviceStatus;
   FOnGetDeviceInfo:TOnGetDeviceInfo;
   FOnGetDevicePhoneNumber:TOnGetDevicePhoneNumber;
   FOnGetBatteryPercentEvent:TOnGetBatteryPercentEvent;

  protected

    function DoGetDeviceInfo():TInfo;
    function DoGetDevicePhoneNumber:string;
    function DoGetBatteryPercent():Integer;

  public

    constructor Create(AOwner: TComponent); overload;
    constructor Create(); overload;
    destructor Destroy; override;

    function GetDeviceInfo():TInfo;
    function GetDevicePhoneNumber:string;
    function GetBatteryPercent():Integer;

  published

     property OnGetDeviceInfo : TOnGetDeviceInfo read FOnGetDeviceInfo write FOnGetDeviceInfo;
     property OnGetDevicePhoneNumber : TOnGetDevicePhoneNumber read FOnGetDevicePhoneNumber write FOnGetDevicePhoneNumber;
     property OnGetDeviceBatteryPercent : TOnGetBatteryPercentEvent read FOnGetBatteryPercentEvent write FOnGetBatteryPercentEvent;

  end;

procedure Register;

implementation


procedure Register;
begin
  RegisterComponents('PhoneInfo', [TPhoneInfo]);
end;

{ TPhoneInfo }

constructor TPhoneInfo.Create(AOwner: TComponent);
begin

  if not (Assigned(FDeviceInfo)) then
    FDeviceInfo:=TDeviceInfo.Create;

  if not (Assigned(FDeviceStatus)) then
    FDeviceStatus:=TDeviceStatus.Create;

end;

constructor TPhoneInfo.Create;
begin

  if not (Assigned(FDeviceInfo)) then
    FDeviceInfo:=TDeviceInfo.Create;

  if not (Assigned(FDeviceStatus)) then
    FDeviceStatus:=TDeviceStatus.Create;

end;

destructor TPhoneInfo.Destroy;
begin

  inherited;
end;

function TPhoneInfo.DoGetDevicePhoneNumber: string;
begin

   if not(Assigned(FDeviceInfo)) then
    FDeviceInfo:=TDeviceInfo.Create;

   Result := FDeviceInfo.GetDeviceInfo.PhoneNumber;

end;

function TPhoneInfo.DoGetBatteryPercent: Integer;
begin

  if not (Assigned(FDeviceStatus)) then
   FDeviceStatus:=TDeviceStatus.Create;

   Result:=FDeviceStatus.GetBatteryLevel;

end;

function TPhoneInfo.DoGetDeviceInfo: TInfo;
begin

 if not(Assigned(FDeviceInfo)) then
    FDeviceInfo:=TDeviceInfo.Create;

 Result:=FDeviceInfo.GetDeviceInfo;

end;

function TPhoneInfo.GetBatteryPercent: Integer;
begin

  Result:=DoGetBatteryPercent;

  if Assigned(FOnGetBatteryPercentEvent) then
    FOnGetBatteryPercentEvent(self, Result);

end;

function TPhoneInfo.GetDeviceInfo: TInfo;
begin

  Result:=DoGetDeviceInfo();

  if Assigned(FOnGetDeviceInfo) then
    FOnGetDeviceInfo(Result);

end;

function TPhoneInfo.GetDevicePhoneNumber: string;
begin

  Result:=DoGetDevicePhoneNumber;
  if Assigned(FOnGetDevicePhoneNumber) then
    FOnGetDevicePhoneNumber(Result);

end;

end.
