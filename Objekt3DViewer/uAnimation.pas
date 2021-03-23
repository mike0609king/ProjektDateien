unit uAnimation;
 //Testbereich
{$MODE Delphi}

{Bisher noch eine riesengroße Baustelle. Wer darf wen bewegen????
 Bsp. Bewegt sich die Kamera im EigenKOS durch die programmierte Animation oder
 ausschließlich interaktiv durch die Steuerung des Anwenders?! Beides gleichzeitig
 ist schlecht möglich!!!!,}
interface

procedure ozeichnen;

implementation

uses uTurtle, uGrammatik, uBeleuchtung, uZeichnerInit, uTurtleManager, uZeichnerBase,uForm,
sysUtils,Classes; // testing
(*
VAR o: TTurtleManager;
    turtle,turtle1: TTurtle;
    gram: TGrammatik;
    zeichenPara: TZeichenParameter;
    zeichnerInit: TZeichnerInit;
    manager: TTurtleManager;
    para: TStringList;*)

procedure ozeichnen;
begin
   //LichtAn(FALSE);
   Hauptform.o.zeichnen;
end;

begin
  (*
    //befindet sich jetzt in uForm.standardturtel

    o := TTurtleManager.Create;
    zeichnerInit := TZeichnerInit.Create;

    // So wird die Grammatik erstellt
    gram := TGrammatik.Create;                          // initialisieren der Grammatik-Klass
    gram.axiom := 'F';                                  // axiom einstellen
    gram.addRegel('F','F&[+F&&FB]&&F[-^^/^-FB]F',18);   // 18%ige Chance fuer diese Einsetzung
    gram.addRegel('F','B',2.01);                        // 2.01%ige Chance fuer diese Einsetzung
    gram.addRegel('F','F&[+F&&F]&&F[-^^/^-F]F',79.99);  // 79.99%ige Chance fuer diese Einsetzung
    //gram.addRegel('F','F&[+F&&FB]&&F[-^^/^-FB]F');      // 100%ige Chance fuer diese Einsetzung
    gram.addRegel('G', 'GGF--[]');                      // 100%ige Chance fuer diese Einsetzung

    // einistellen vom winkel und der rekursionsTiefe
    zeichenPara.winkel := 47.5;
    zeichenPara.rekursionsTiefe := 5;

    // erster Baum (index 0)
    // zeichenPara.setzeStartPunkt(0,0,0);
    turtle := TTurtle.Create(gram, TZeichnerBase.Create(zeichenPara));
    o.addTurtle(turtle);
    //o.setzeSichtbarkeit(0,false);  // setzten der Sichtbarkeit der Turtle

    // zweiter Baum (index 1)
    zeichenPara.setzeStartPunkt(2,0,0);
    turtle := TTurtle.Create(gram, zeichnerInit.initialisiere('ZeichnerGruenesBlatt',zeichenPara));
    o.addTurtle(turtle);
    //o.setzeSichtbarkeit(1,false);  // setzten der Sichtbarkeit der Turtle

    // dritter Baum (index 2)
    zeichenPara.setzeStartPunkt(-2,0,0);
    turtle := TTurtle.Create(gram, zeichnerInit.initialisiere(
        zeichnerInit.gibZeichnerListe[0],zeichenPara));
    o.addTurtle(turtle);
    //o.setzeSichtbarkeit(2,false);  // setzten der Sichtbarkeit der Turtle

    // beides das gleiche (entfernt beide die Turtle an index 2)
    // o.entferneTurtle(turtle);
    // o.entferneTurtleAn(2);

    // modifizieren der rekursions Tiefe und Winkel der Turtle an index 0
    o.gibTurtle(0, turtle);
    turtle.rekursionsTiefe := 6;
    turtle.winkel := 15;

    // aendern der maximalenStringLaenge, damit die turtle mit Rekursionstiefe
    // 6 gezeichnet werden kann
    turtle.maximaleStringLaenge := turtle.maximaleStringLaenge*2;

    turtle.setzeZeichnerName(zeichnerInit.gibZeichnerListe[1]);
    turtle.speichern(GetCurrentDir+'\test.json');

    // laden und modifizieren der hochgeladenen Turtle
    turtle := TTurtle.Create(GetCurrentDir+'\test.json');
    turtle.rekursionsTiefe := 5;
    turtle.setzeStartPunkt(2,0,2);
    o.addTurtle(turtle);
  o := TTurtleManager.Create;
  zeichnerInit := TZeichnerInit.Create;

  numTurt := 0;

  // Standardsymbole im Programm
  {
  gram := TGrammatik.Create;
  zeichenPara.winkel := 47.5;
  zeichenPara.rekursionsTiefe := 4;
  gram.axiom := 'F';
  gram.addRegel('F','F&[+F&&FF]&&F[-^^/^-FF]F');
  plaziereTurtle('ZeichnerBase');

  gram := TGrammatik.Create;
  zeichenPara.winkel := 22.5;
  zeichenPara.rekursionsTiefe := 6;
  gram.axiom := 'X';
  gram.addRegel('X','F+[[-X]&&-X]-F[-F//X]+X');
  gram.addRegel('F','FF');
  plaziereTurtle('ZeichnerBase');
  }

  // Stochastische L-Systeme
  {
  gram := TGrammatik.Create;
  zeichenPara.winkel := 22.5;
  zeichenPara.rekursionsTiefe := 6;
  gram.axiom := 'X';
  gram.addRegel('X','F+[[-X]&&-X]-F[-F/X]+X',50);
  gram.addRegel('X','X&[X][^F]',25);
  gram.addRegel('X','F+[&F][-F]&&F[F][^F^]F',25);
  gram.addRegel('F','F[+F]F[-^F]F[&F]',50);
  gram.addRegel('F','FF',50);
  plaziereTurtle('ZeichnerBase');
  plaziereTurtle('ZeichnerBase');
  plaziereTurtle('ZeichnerBase');
  plaziereTurtle('ZeichnerBase');
  plaziereTurtle('ZeichnerBase');
  }
  
  // Baum mit gruenen Blaettern
  {
  zeichenPara.winkel := 47.5;
  zeichenPara.rekursionsTiefe := 5;
  gram := TGrammatik.Create;
  gram.axiom := 'F';
  gram.addRegel('F','F&[+F&&FB]&&F[-^^/^-FB]F');      
  plaziereTurtle('ZeichnerGruenesBlatt');
  }

  // Noch einer!
  {
  zeichenPara.winkel := 47.5;
  zeichenPara.rekursionsTiefe := 5;
  gram := TGrammatik.Create;
  gram.axiom := 'F';
  gram.addRegel('F','F&[+F&&FB]&&F[-^^/^-FB]F');      
  plaziereTurtle('ZeichnerGruenesBlatt');

  inc(numTurt);

  gram := TGrammatik.Create;
  gram.axiom := 'F';
  gram.addRegel('F','F&[+F&&FB]&&F[-^^/^-FB]F',18);   
  gram.addRegel('F','B',2.01);                        
  gram.addRegel('F','F&[+F&&F]&&F[-^^/^-F]F',79.99);  
  plaziereTurtle('ZeichnerGruenesBlatt');
  plaziereTurtle('ZeichnerGruenesBlatt');
  }

  // Parametrisierung von Farben - Beispiel (1)
  {
  zeichenPara.winkel := 47.5;
  zeichenPara.rekursionsTiefe := 3;
  gram := TGrammatik.Create;
  gram.axiom := 'F(1)&[+F(2)&&F(3)F(4)]&&F(5)[-^^/^-F(0)F(7)]F(8)';
  gram.addRegel('F(c)','F(c)&[+F(c)&&F(c)F(c)]&&F(c)[-^^/^-F(c)F(c)]F(c)');
  plaziereTurtle('ZeichnerFarben');
  }

  // Parametrisierung von Farben - Beispiel (2)
  {
  zeichenPara.winkel := 47.5;
  zeichenPara.rekursionsTiefe := 3;
  gram := TGrammatik.Create;
  gram.axiom := 'F(1;2)&[+F(2;13)&&F(3;10)F(4;7)]&&F(5;9)[-^^/^-F(0;3)F(7;13)]F(8;1)';
  gram.addRegel('F(c)','F(c)&[+F(c)&&F(c)F(c)]&&F(c)[-^^/^-F(c)F(c)]F(c)');
  gram.addRegel('F(c;d)','F(d;c)&[+F(d;c)&&F(c;c)F(d;c)]&&F(c;d)[-^^/^-F(c;d)F(d;c)]F(c;d)',40);
  gram.addRegel('F(c;d)','F(c;d)&[+F(c;d)&&F(c;d)F(d;c)]&&F(c;d)[-^^/^-F(d;c)F(c;d)]F(d;c)',40);
  gram.addRegel('F(c;d)','F(c;d)&[+F(c;d)&&F(c;d)F(c)]&&F(c;d)[-^^/^-F(d;c)F(d)]F(d;c)',20);
  plaziereTurtle('ZeichnerFarben');
  plaziereTurtle('ZeichnerFarben');
  plaziereTurtle('ZeichnerFarben');
  plaziereTurtle('ZeichnerFarben');
  }

  // Schrittlaenge und Farben
  {
  zeichenPara.winkel := 47.5;
  zeichenPara.rekursionsTiefe := 4;
  gram := TGrammatik.Create;
  gram.axiom := 'F(1;20)&[+F(2)&&F(3)F(4)]&&F(5)[-^^/^-F(13)F(7)]F(8)';
  gram.addRegel('F(c)','F(c)&[+F(c)&&F(c)F(c)]&&F(c)[-^^/^-F(c)F(c)]F(c)');      
  gram.addRegel('F(c;l)','F(c;l)&[+F(c;l)&&F(c;l)F(c;l)]&&F(c;l)[-^^/^-F(c;l)F(c;l)]F(c;l)');      
  plaziereTurtle('ZeichnerFarbenUndSchrittlaenge')
  }

  // Beispiel 1
  {
  gram := TGrammatik.Create;
  zeichenPara.winkel := 22.5;
  zeichenPara.rekursionsTiefe := 3;
  gram.axiom := 'F(1;5)&[+F(1;5)&&F(1;5)F(1;5)B(5)]&&F(1;5)[-^^/^-F(1;5)F(1;5)B(5)]F(1;5)';
  gram.addRegel('F(c;d)','F(c;d)&[+F(c;d)&&F(c;d)F(c;d)B(d)]&&F(c;d)[-^^/^-F(c;d)F(c;d)B(d)]F(c;d)',25);
  gram.addRegel('F(c;d)','F(c;d)&[+F(c;d)&&F(c;d)F(c;d)]&&F(c;d)[-^^/^-F(c;d)F(c;d)]F(c;d)',75);
  plaziereTurtle('ZeichnerFarbenBlattUndSchritt');
  }

  // Beispiel 2
  {
  gram := TGrammatik.Create;
  zeichenPara.winkel := 47.5;
  zeichenPara.rekursionsTiefe := 7;
  gram.axiom := 'X(1;10)';
  gram.addRegel('X(c;d)','F(c)+[[-X(c;d)]&&-X(c;d)B(d)]-F(c)[-F(c)//X(c;d)B(d)]+X(c;d)');
  gram.addRegel('F(c)','F(c)F(c)');
  plaziereTurtle('ZeichnerFarbenBlattUndSchritt');
  }

  // Beispiel 3
  
  gram := TGrammatik.Create;
  zeichenPara.winkel := 22.5;
  zeichenPara.rekursionsTiefe := 6;
  gram.axiom := 'X(1;10)';
  gram.addRegel('X(c;d)','F(c)+[[-X(c;d)]&&-X(c;d)B(d)]-F(c)[-F(c)//X(c;d)B(d)]+X(c;d)');
  gram.addRegel('F(c)','F(c)F(c)');
  plaziereTurtle('ZeichnerFarbenBlattUndSchritt');      *)
  
end.
