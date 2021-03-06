program Matrix3x3;

{$MODE Delphi}

uses
  Forms, Interfaces,
  uform in 'Formulare\uform.pas' {Hauptform},
  uEditor_Grammatiken in 'Formulare\uEditor_Grammatiken.pas' {EditorForm},
  ugrammatiken in 'Formulare\ugrammatiken.pas' {uGrammatiken},
  uparameter_Form in  'Formulare\uparameter_Form.pas' {Parameter_Form},
  uoptionen_form in 'Formulare\uoptionen_form .pas' {Optionen_Form},
  uParameterisierung_Form in 'Formulare\uParameterisierung_Form.pas' {Parameterisierung_Form},
  (*  AMatrix in 'Formulare\AMatrix.pas' {FormAMatrix},
  MMatrix in 'Formulare\MMatrix.pas' {FormMMatrix},
  Rotation in 'Formulare\Rotation.pas' {FormRot},
  Umrechnung in 'Formulare\Umrechnung.pas' {FormKart2Kugel},
  Umrechnung2 in 'Formulare\Umrechnung2.pas' {FormKugel2Kart},
  Streckung in 'Formulare\Streckung.pas' {FormStreck},
  Verschiebung in 'Formulare\Verschiebung.pas' {FormVer},
  Scherung in 'Formulare\Scherung.pas' {FormScher},      *)
  uMatrizen in '..\Graphik\uMatrizen.pas',
  uKamObjektiv in '..\Graphik\uKamObjektiv.pas',
  uRenderer in '..\Graphik\uRenderer.pas',
  uBeleuchtung in '..\Graphik\uBeleuchtung.pas',
  uAnimation in 'uAnimation.pas',
  uturtle in 'uObjekt.pas',
  uscaledpi in 'uscaledpi.pas';

//uOctree in '..\Octree\uOctree.pas';

{$R *.res}

begin
  Application.Scaled:=False;
  Application.Initialize;
  Application.CreateForm(TForm1, HauptForm);
  Application.CreateForm(TForm10, EditorForm);
  Application.CreateForm(TuGrammatiken, aGrammatiken);
  Application.CreateForm(TParameter_Form, Parameter_Form);
  Application.CreateForm(TTOptionen, Optionen_Form);
  Application.CreateForm(TParameterisierung_Form,Parameterisierung_Form);
  (*Application.CreateForm(TForm3, FormMMatrix);
  Application.CreateForm(TForm2, FormAMatrix);
  Application.CreateForm(TForm4, FormRot);
  Application.CreateForm(TForm5, FormKart2Kugel);
  Application.CreateForm(TForm6, FormKugel2Kart);
  Application.CreateForm(TForm7, FormStreck);
  Application.CreateForm(TForm8, FormVer);
  Application.CreateForm(TForm9, FormScher);     *)
  //HighDPI(192);
  Application.Run;
end.
