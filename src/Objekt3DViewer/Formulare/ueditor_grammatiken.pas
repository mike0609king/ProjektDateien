unit uEditor_Grammatiken;
{$mode delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,uTurtlemanager, ComCtrls, Menus,uTurtle,fgl;

type
  TIntegerList = TFPGList<Integer>;

type

  { TForm10 }

  TForm10 = class(TForm)
    BT_entfernen: TButton;
    BT_bearbeiten: TButton;
    BT_Fertig: TButton;
    BT_sichtbarkeit: TButton;
    BT_Alle: TButton;
    BT_alle_unmarkieren: TButton;
    BT_unsichtbar_machen: TButton;
    BT_kopieren: TButton;
    BT_parameterisierung: TButton;
    ED_abstand: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ListView1: TListView;
    UpDown1: TUpDown;
    procedure BT_AlleClick(Sender: TObject);
    procedure BT_bearbeitenClick(Sender: TObject);
    procedure BT_entfernenClick(Sender: TObject);
    procedure BT_FertigClick(Sender: TObject);
    procedure BT_kopierenClick(Sender: TObject);
    procedure BT_parameterisierungClick(Sender: TObject);
    procedure BT_sichtbarkeitClick(Sender: TObject);
    procedure BT_unsichtbar_machenClick(Sender: TObject);
    procedure BT_alle_unmarkierenClick(Sender: TObject);
    procedure ED_abstandChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
  private
    turtlemanager:TTurtlemanager;
    function gib_markierte_nr():TIntegerList;
    procedure markiere_liste_nr(liste:TIntegerList);
  public
    procedure BT_updateClick(mode:CARDINAL=0); //mode 1 wenn die markierungen bleiben sollen
  end;

var
  EditorForm: TForm10;

implementation
uses uForm,uParameter_Form,uParameterisierung_Form;

{$R *.lfm}

{ TForm10 }
procedure TForm10.FormCreate(Sender: TObject);
begin
  //CheckListBox1:=TCheckListBox.Create();

end;
procedure TForm10.UpDown1Click(Sender: TObject; Button: TUDBtnType);
VAR i:REAL;
begin
   //an ED_abstand anbinden
   if button = btNext then
   begin
        i:=strtofloat(ED_abstand.Text)+1;
        ED_abstand.Text:=floattostr(i);
   end
   else
   begin
        i:=strtofloat(ED_abstand.Text)-1;
        ED_abstand.Text:=floattostr(i);
   end;
end;

procedure TForm10.BT_updateClick(mode:CARDINAL=0);
VAR summe:INT64;i,anzahl:CARDINAL;str,name,sichtbarkeit,Winkel,Rek_tiefe,Zeichenart:string; turtle:TTurtle; Item1: TListItem; liste:TIntegerList;str_max:string;
begin
  if mode=1 then liste:=gib_markierte_nr();
  ListView1.clear;
  ED_abstand.Text:=floattostr(Hauptform.abstand_x);
  anzahl:=(HauptForm.o.turtleListe.Count);
  if not (anzahl=0) then
  begin
    //abstand
    summe:=0;
    for i:=0 to anzahl-1 do
        begin
             Item1 := ListView1.Items.Add;
             Item1.Caption := '';
             turtle:=HauptForm.o.turtleListe[i];
             str:='Turtel'+inttostr(i);
             name:=turtle.name;
             str_max:=inttostr(length(turtle.zuZeichnenderString));
             if turtle.visible then
               begin
                 sichtbarkeit:='Sichtbar';
                 summe:=summe+strtoint(str_max);
               end
             else sichtbarkeit:='Unsichtbar';
             Winkel:=floattostr(turtle.winkel);
             Rek_tiefe:=inttostr(turtle.rekursionsTiefe);
             Zeichenart:=turtle.zeichnerName;  //
             Item1.SubItems.Add(str);
             Item1.SubItems.Add(name);
             Item1.SubItems.Add(sichtbarkeit);
             Item1.SubItems.Add(Winkel);
             Item1.SubItems.Add(Rek_tiefe);
             Item1.SubItems.Add(Zeichenart);
             Item1.SubItems.Add(str_max);
             //Aktuelle anzhal von Spalten 5
        end;
    //for i:=0 to 7 do ListView1.columns[1].Autosize:=True;
    label3.caption:=inttostr(summe);
    if mode=1 then markiere_liste_nr(liste);
  end;
end;

procedure TForm10.BT_alle_unmarkierenClick(Sender: TObject);
VAR i:CARDINAL;
begin
  if not (ListView1.Items.Count=0) then
  begin
       for i := 0 to ListView1.Items.Count-1 do ListView1.Items[i].Checked := False;
  end;
end;

procedure TForm10.ED_abstandChange(Sender: TObject);
VAR x_abstand:REAL; anzahl:CARDINAL;
    str:String;
begin
   anzahl:=hauptform.o.turtleListe.Count;
   if not (anzahl=0) then
   begin
     str:=ED_abstand.Text;
     if not (str='') then
     begin
        x_abstand:= strtofloat(ED_abstand.Text);
        Hauptform.abstand_aendern(x_abstand);
     end;
   end;
end;

procedure TForm10.BT_AlleClick(Sender: TObject);
VAR i:CARDINAL;
begin
  if not (ListView1.Items.Count=0) then
  begin
       for i := 0 to ListView1.Items.Count-1 do ListView1.Items[i].Checked := True;
  end;
end;

procedure TForm10.BT_bearbeitenClick(Sender: TObject);
begin
    //Parameterform aufrufen
    Parameter_Form.Show;
    Parameter_Form.BT_resetClick(self);
end;

procedure TForm10.BT_entfernenClick(Sender: TObject);
VAR i,a,anzahl:CARDINAL;
begin
   anzahl:= ListView1.Items.Count;
   if not (anzahl=0) then
   begin
     turtlemanager:=Hauptform.o.copy();
     a:=0;
     for i := 0 to ListView1.Items.Count -1 do
         begin
              if ListView1.Items[i].Checked then
              begin
                   turtlemanager.setzeSichtbarkeit(i-a,true);
                   turtlemanager.entferneTurtleAn(i-a) ;
                   inc(a)
              end;
         end;
     Hauptform.push_neue_instanz(turtlemanager);
     BT_updateClick();
   end;
end;
procedure TForm10.BT_FertigClick(Sender: TObject);
begin
   Visible:=False;
   Hauptform.zeichnen;
end;

procedure TForm10.BT_kopierenClick(Sender: TObject);
VAR turtle:Tturtle;  i,anzahl:CARDINAL; liste:TIntegerlist; x_abstand:Real;
begin
   anzahl:= ListView1.Items.Count;
   if not (anzahl=0) then
   begin
     liste:=gib_markierte_nr();
     turtlemanager:=Hauptform.o.copy();
     for i := 0 to anzahl-1 do
         begin
              if ListView1.Items[i].Checked then
              begin
                   turtle:=hauptform.o.turtleListe[i].copy();
                   turtlemanager.addTurtle(turtle);
              end;
         end;
     Hauptform.push_neue_instanz(turtlemanager);
     x_abstand:= strtofloat(ED_abstand.Text);
     Hauptform.abstand_aendern(x_abstand);
     BT_updateClick();
     markiere_liste_nr(liste);
   end;
end;

procedure TForm10.BT_parameterisierungClick(Sender: TObject);
VAR nr:CARDINAL;hl:TIntegerList;
begin
  //Es muss immer genau eine Turtle ausgewählt sein.
  //n muss übergeben werden.
   hl:=gib_markierte_nr();
   if hl.Count=1 then
   begin
        //überprüfen ob es in der Turtle parameter gibt
        nr:=hl[0];
        if not (Hauptform.o.turtleliste[nr].gibParameter.Count=0) then
        begin
          Parameterisierung_Form.show;
          Parameterisierung_Form.update_ed(nr);
        end
        else Showmessage('Die ausgewählte Grammatik unterstützt keine Parameterisierung!');
   end
   else Showmessage('Wenn die Parameterisierung bearbeitet werden soll darf nur genau eine Turtle ausgewählt sein!');
end;

procedure TForm10.BT_sichtbarkeitClick(Sender: TObject);
VAR i,anzahl:CARDINAL;
begin
   anzahl:=ListView1.Items.Count;
   if not (anzahl=0) then
   begin
     turtlemanager:=Hauptform.o.copy();
     for i := 0 to anzahl-1 do
         begin
              if ListView1.Items[i].Checked then
              begin
                   turtlemanager.setzeSichtbarkeit(i,true)
              end;
         end;
     Hauptform.push_neue_instanz(turtlemanager);
     BT_updateClick(1) ;
   end;
end;

procedure TForm10.BT_unsichtbar_machenClick(Sender: TObject);
VAR i,anzahl:CARDINAL;
begin
   anzahl:=ListView1.Items.Count;
   if not (anzahl=0) then
   begin
     turtlemanager:=Hauptform.o.copy();
     for i := 0 to anzahl-1 do
         begin
              if ListView1.Items[i].Checked then
              begin
                   turtlemanager.setzeSichtbarkeit(i,false)
              end;
         end;
     Hauptform.push_neue_instanz(turtlemanager);
     BT_updateClick(1) ;
   end;
end;

procedure TForm10.markiere_liste_nr(liste:TIntegerList);
VAR i,h,anzahl:CARDINAL;
begin
   anzahl:=ListView1.Items.Count;
   if not (anzahl=0) then
   begin
   for i:=0 to anzahl-1 do
       begin
            for h:=0 to liste.Count-1 do
            begin
                 if liste[h]=i then ListView1.Items[i].Checked := True;
          end;
       end;
   end;
end;

function TForm10.gib_markierte_nr():TIntegerList;
VAR hl:TIntegerList;i,anzahl:CARDINAL;
begin
   hl:=TIntegerList.Create();
   anzahl:=ListView1.Items.Count;
   if not (anzahl=0) then
   begin
   for i := 0 to anzahl -1 do
       begin
         if ListView1.Items[i].Checked then
           begin
                hl.add(i);
           end;
       end;
   result:=hl;
   end;
  end;
end.

