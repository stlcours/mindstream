unit l3SimpleDataContainer;


{$Include l3Define.inc}

interface

uses
  l3SimpleObject
  ;

type
 _l3DataContainer_Parent_ = Tl3SimpleObject;
 {$Include l3DataContainer.imp.pas}
 Tl3SimpleDataContainer = {abstract} class(_l3DataContainer_)
 end;//Tl3SimpleDataContainer

implementation

{$Include l3DataContainer.imp.pas}

end.