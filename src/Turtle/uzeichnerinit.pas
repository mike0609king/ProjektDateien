unit uZeichnerInit;

{$mode delphi}

interface

uses
  Classes, SysUtils, fgl,
  uZeichnerbase, uZeichnerGruenesBlatt, uZeichnerFarben, 
  uZeichnerSchrittlaenge,uZeichnerFarbenUndSchrittlaenge,
  uZeichnerFarbenBlattUndSchritt;

type TErbteZeichnerBase = class of TZeichnerBase;

type TVersandTabelleZeichner = TFPGMap<String, TErbteZeichnerBase>;

{ Aufgabe: Diese Klasse soll den Konstruktor einer Zeichen-Klasse 
  aufrufen, wobei die Konstruktoren den Strings zugeordnet sind. }
type TZeichnerInit = class
  private
    FVersandTabelleZeichner: TVersandTabelleZeichner;
  public
    constructor Create;

    destructor Destroy; override;

    { Aufgabe: Die 'zeichnerArt' spezifiziert den Namen der Zeichenart, 
      welche genutzt wird. Diese Funktion gibt dann die Instanz von 
      dieser Zeichenart zurueck. }
    function initialisiere(zeichnerArt: String; zeichenPara: TZeichenParameter) : TZeichnerBase;

    { Aufgabe: Gibt eine Liste von Zeichenartnamen zurueck. Diese koennen dann als 
      Eingabe in die initialisiere-Methode benutzt werden. }
    function gibZeichnerListe : TStringList;
end;

implementation

constructor TZeichnerInit.Create;
// Der Zeichenparameter wird lediglich dafuer genutzt um den Namen zu extrahieren
var zeichenPara: TZeichenParameter;
begin
  // default
  zeichenPara.winkel := 0;
  zeichenPara.rekursionsTiefe := 0;
  zeichenPara.setzeStartPunkt(0,0,0);

  FVersandTabelleZeichner := TVersandTabelleZeichner.Create;
  FVersandTabelleZeichner.add(
    (TZeichnerBase.Create(zeichenPara)).name,
    TZeichnerBase
    );
  FVersandTabelleZeichner.add(
    (TZeichnerGruenesBlatt.Create(zeichenPara)).name,
    TZeichnerGruenesBlatt
  );
  FVersandTabelleZeichner.add(
    (TZeichnerFarben.Create(zeichenPara)).name,
    TZeichnerFarben
  );
  FVersandTabelleZeichner.add(
    (TZeichnerSchrittlaenge.Create(zeichenPara)).name,
    TZeichnerSchrittlaenge
  );
  FVersandTabelleZeichner.add(
    (TZeichnerFarbenUndSchrittlaenge.Create(zeichenPara)).name,
    TZeichnerFarbenUndSchrittlaenge
  );
  FVersandTabelleZeichner.add(
    (TZeichnerFarbenBlattUndSchritt.Create(zeichenPara)).name,
    TZeichnerFarbenBlattUndSchritt
  );
end;

destructor TZeichnerInit.Destroy;
begin
  FreeAndNil(FVersandTabelleZeichner);
end;

function TZeichnerInit.initialisiere(zeichnerArt: String; zeichenpara: TZeichenParameter) : TZeichnerBase;
var t: TErbteZeichnerBase;
begin
  if FVersandTabelleZeichner.tryGetData(zeichnerArt,t) then result := t.Create(zeichenPara)
  else result := TZeichnerBase.Create(zeichenPara);
end;

function TZeichnerInit.gibZeichnerListe : TStringList;
var i: Cardinal;
begin
  result := TStringList.Create;
  for i := 0 to FVersandTabelleZeichner.Count - 1 do result.add(FVersandTabelleZeichner.keys[i]);
end;

end.

