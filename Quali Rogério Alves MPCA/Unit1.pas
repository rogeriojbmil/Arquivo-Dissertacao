unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, ExtCtrls, Buttons, DdeMan;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Button3: TButton;
    Edit2: TEdit;
    Button4: TButton;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    SBarra1: TScrollBar;
    SBarra2: TScrollBar;
    Grid1: TStringGrid;
    Panel5: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    BitBtn1: TBitBtn;
    Panel6: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    Panel7: TPanel;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    Panel8: TPanel;
    RadioButton7: TRadioButton;
    RadioButton8: TRadioButton;
    RadioButton9: TRadioButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    BitBtn2: TBitBtn;
    Button5: TButton;
    Button6: TButton;
    DdeClientConv1: TDdeClientConv;
    edicion: TMemo;
    RadioButton10: TRadioButton;
    RadioButton11: TRadioButton;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    CheckBox10: TCheckBox;
    Button7: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure SBarra1Change(Sender: TObject);
    procedure SBarra2Change(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Grid1TopLeftChanged(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Button7Click(Sender: TObject);


  private
    { Private declarations }
    NCol, NRow,NColTotal,NRowTotal,tab,cod127: Integer;
    Bcol: array [0..30] of boolean;
    Brow: array [0..200] of boolean;
    LenCol,Ccol: array [1..30] of integer;
    procedure LeerRejilla;
    procedure EscribirRejilla;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
   if StrToInt(Edit1.Text)<30 then
    begin
      Edit1.Text:= IntToStr(StrToInt(Edit1.Text)+1);
      NColTotal:= StrToInt(Edit1.Text);
      if NColTotal>2 then
         SBarra1.Max:= NColTotal-2;
      Grid1.ColCount:= Grid1.ColCount+1;
    end;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
   if StrToInt(Edit1.Text)>1 then
    begin
      Edit1.Text:= IntToStr(StrToInt(Edit1.Text)-1);
      NColTotal:= StrToInt(Edit1.Text);
      if NColTotal>2 then
         SBarra1.Max:= NColTotal-2;
      Grid1.ColCount:= Grid1.ColCount-1;
      if (Grid1.LeftCol>=(NColTotal-3)) and (Grid1.LeftCol>0) then
         Grid1.LeftCol:= Grid1.LeftCol-1;

    end;

end;

procedure TForm1.Button4Click(Sender: TObject);
begin
   if StrToInt(Edit2.Text)<200 then
    begin
      Edit2.Text:= IntToStr(StrToInt(Edit2.Text)+1);
      NRowTotal:= StrToInt(Edit2.Text);
      if NRowTotal>3 then
        SBarra2.Max:= NRowTotal-3
      else
        SBarra2.Max := 1;
      Grid1.RowCount:= Grid1.RowCount+1;
    end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
   if StrToInt(Edit2.Text)>1 then
    begin
      Edit2.Text:= IntToStr(StrToInt(Edit2.Text)-1);
      NRowTotal:= StrToInt(Edit2.Text);
      if NRowTotal>3 then
        SBarra2.Max:= NRowTotal-3;
      Grid1.RowCount:= Grid1.RowCount-1;
      if (Grid1.TopRow>=(NRowTotal-4)) and (Grid1.TopRow>0) then
         Grid1.TopRow:= Grid1.TopRow-1;

    end;

end;

procedure TForm1.FormCreate(Sender: TObject);
var
   i: integer;
begin
     tab:= 1;
     cod127:= 0;
     NColTotal:= 3;
     NRowTotal:= 4;
     NCol:= 1;
     NRow:= 1;
     for i:=1 to 30 do
       Ccol[i]:= 0;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
     Application.Terminate;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var
  i,j: Integer;
  maclatex: TStringList;
  cadena: string;
  function Adjust(s: String; Max,Align: integer): String;
  var x: String;
      i: integer;
  begin
    if Align<0 then begin {Left}
      x:=s;
      for i:=1 to Max-Length(s) do x:=x+' ';
    end else
    if Align>0 then begin {Right}
      for i:=1 to Max-Length(s) do x:=x+' ';
      x:=x+s;
    end else begin {Center}
      for i:=1 to (Max-Length(s)) div 2 do x:=x+' ';
      x:=x+s;
      Max:=Max-Length(x);
      for i:=1 to Max do x:=x+' ';
    end;
    Result:=x;
  end;
begin
     LeerRejilla;
     maclatex:= TStringList.Create;

     if tab=1 then
         cadena:='\begin{tabular}{'
     else
         cadena:='\begin{array}{';

//
     if bcol[0]=true then
       cadena:=cadena + '|';
     for j:= 1 to NColTotal do
       begin
          case Ccol[j] of
           -1:
              cadena:= cadena + 'l';
            0:
              cadena:= cadena + 'c';
            1:
              cadena:= cadena + 'r';
          end;
          if bcol[j]=true then
            cadena:=cadena + '|';
       end;
     cadena:= cadena+ '}' ;
     maclatex.Add(cadena);

     if brow[0]=true then
       begin
         cadena:='\hline';
         maclatex.Add(cadena);
       end;

     {Compute the maximal dimensions of columns}
     for i:=1 to NColTotal do begin
       if (cod127=0) then LenCol[i]:=0 else LenCol[i]:=1;
       for j:=1 to NRowTotal do begin
         if Length(Grid1.Cells[i-1,j-1])>LenCol[i] then begin
           LenCol[i]:=Length(Grid1.Cells[i-1,j-1]);
         end;
       end;
     end;

     cadena:='';
     for i:=1 to NRowTotal do
       begin
         for j:=1 to NColTotal-1 do
           begin
              if (cod127=0) then
                cadena:= cadena + #32 + Adjust(Grid1.Cells[j-1,i-1],LenCol[j],CCol[j]) + ' &'
              else
                begin
                  if Grid1.Cells[j-1,i-1]='' then
                    cadena:= cadena + #32 + Adjust(#127,LenCol[j],CCol[j]) + ' &'
                  else
                    cadena:= cadena + #32 + Adjust(Grid1.Cells[j-1,i-1],LenCol[j],CCol[j]) + ' &';
                end;
           end;
         if cod127=0 then
             cadena:= cadena + #32 + Adjust(Grid1.Cells[NColTotal-1,i-1],LenCol[NColTotal],CCol[NColTotal]) + ' \\'
         else
           begin
              if Grid1.Cells[NColTotal-1,i-1]='' then
                 cadena:= cadena + #32 + Adjust(#127,LenCol[NColTotal-1],CCol[NColTotal]) + ' \\'
              else
                 cadena:= cadena + #32 + Adjust(Grid1.Cells[NColTotal-1,i-1],LenCol[NColTotal],CCol[NColTotal]) + ' \\';
           end;
         maclatex.Add(cadena);
         if brow[i]=true then
          begin
           cadena:='\hline';
           maclatex.Add(cadena);
          end;
         cadena:= '';
       end;
//
     if tab=1 then
         cadena:= '\end{tabular}'
     else
         cadena:='\end{array}';

      maclatex.Add(cadena);
     // edicion:= TMemo.Create;
      edicion.Clear;
      for i:=0 to maclatex.Count-1 do
         edicion.Lines.Add(maclatex[i]);
      edicion.SelectAll;
      edicion.CopyToClipboard;
      cadena:='[CMD("Paste")]';

  DdeClientConv1.SetLink('WinEdt','DDEServer');
  if DdeClientConv1.OpenLink then begin
    if not DdeClientConv1.ExecuteMacro(PChar(@cadena[1]), false) then begin
      if not DdeClientConv1.ExecuteMacro(PChar(@cadena[1]), false) then begin
        MessageDlg('Cannot Send a Macro to WinEdt.'+#13+#10+
          'Please paste the table manually...',
          mtWarning, [mbOK], 0);
      end;
    end;
    DdeClientConv1.CloseLink;
  end else begin
    MessageDlg('Cannot Open DDE Link to WinEdt.',
      mtWarning, [mbOK], 0);
  end;

end;

procedure TForm1.SBarra1Change(Sender: TObject);
begin
     LeerRejilla;
     NCol:= SBarra1.Position;
     Grid1.LeftCol:=NCol-1;
     Label7.Caption:=IntToStr(NCol);
     Label8.Caption:=IntToStr(NCol+1);
     Label9.Caption:=IntToStr(NCol+2);
     EscribirRejilla;

end;

procedure TForm1.SBarra2Change(Sender: TObject);
begin
     LeerRejilla;
     NRow:= SBarra2.Position;
     Grid1.TopRow:=NRow-1;
     Label3.Caption:=IntToStr(NRow);
     Label4.Caption:=IntToStr(NRow+1);
     Label5.Caption:=IntToStr(NRow+2);
     Label6.Caption:=IntToStr(NRow+3);
     EscribirRejilla;

end;

procedure TForm1.LeerRejilla;
begin
    brow[NRow-1]:= CheckBox5.Checked;
    brow[NRow]:= CheckBox6.Checked;
    brow[NRow+1]:= CheckBox7.Checked;
    brow[NRow+2]:= CheckBox8.Checked;
    brow[NRow+3]:= CheckBox9.Checked;
    bcol[NCol-1]:= CheckBox1.Checked;
    bcol[NCol]:= CheckBox2.Checked;
    bcol[NCol+1]:= CheckBox3.Checked;
    bcol[NCol+2]:= CheckBox4.Checked;
    if RadioButton1.Checked=True then
        Ccol[NCol]:= -1;
    if RadioButton2.Checked=True then
        Ccol[NCol]:= 0;
    if RadioButton3.Checked=True then
        Ccol[NCol]:= 1;
    if RadioButton4.Checked=True then
        Ccol[NCol+1]:= -1;
    if RadioButton5.Checked=True then
        Ccol[NCol+1]:= 0;
    if RadioButton6.Checked=True then
        Ccol[NCol+1]:= 1;
    if RadioButton7.Checked=True then
        Ccol[NCol+2]:= -1;
    if RadioButton8.Checked=True then
        Ccol[NCol+2]:= 0;
    if RadioButton9.Checked=True then
        Ccol[NCol+2]:= 1;

    if RadioButton10.Checked=True then
        tab:=1
    else
        tab:=2;
    if CheckBox10.Checked=True then
        cod127:=1
    else
        cod127:=0;
end;


procedure TForm1.EscribirRejilla;
begin
    CheckBox5.Checked:=brow[NRow-1];
    CheckBox6.Checked:=brow[NRow];
    CheckBox7.Checked:=brow[NRow+1];
    CheckBox8.Checked:=brow[NRow+2];
    CheckBox9.Checked:=brow[NRow+3];
    CheckBox1.Checked:=bcol[NCol-1];
    CheckBox2.Checked:=bcol[NCol];
    CheckBox3.Checked:=bcol[NCol+1];
    CheckBox4.Checked:=bcol[NCol+2];
    case Ccol[NCol] of
      -1:
          RadioButton1.Checked:=True;
       0:
          RadioButton2.Checked:=True;
       1:
          RadioButton3.Checked:=True;
    end;
    case Ccol[NCol+1] of
      -1:
          RadioButton4.Checked:=True;
       0:
          RadioButton5.Checked:=True;
       1:
          RadioButton6.Checked:=True;
    end;
    case Ccol[NCol+2] of
      -1:
          RadioButton7.Checked:=True;
       0:
          RadioButton8.Checked:=True;
       1:
          RadioButton9.Checked:=True;
    end;
end;



procedure TForm1.Button6Click(Sender: TObject);
var
  i: Integer;
begin
 if Button6.Caption='All' then
  begin
    for i:=0 to 30 do
      bcol[i]:= True;
    Button6.Caption:= 'None';
  end
 else
  begin
    for i:=0 to 30 do
      bcol[i]:= False;
    Button6.Caption:= 'All';
  end;
 EscribirRejilla;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  i: integer;
begin
 if Button5.Caption='All' then
  begin
    for i:=0 to 200 do
      brow[i]:= True;
    Button5.Caption:= 'None';
  end
 else
  begin
    for i:=0 to 200 do
      brow[i]:= False;
    Button5.Caption:= 'All';
  end;
 EscribirRejilla;

end;


procedure TForm1.Grid1TopLeftChanged(Sender: TObject);
begin
   if (Grid1.TopRow=(NRowTotal-3)) then
      Grid1.TopRow:= NRowTotal-3;
   SBarra1.Position:= Grid1.LeftCol+1;
   SBarra2.Position:= Grid1.TopRow+1;
end;

procedure TForm1.Edit2Exit(Sender: TObject);
var
  i: Integer;
begin
   if (StrToInt(Edit2.Text)<200) and (StrToInt(Edit2.Text)>1) then
    begin
      i:= StrToInt(Edit2.Text)-NRowTotal;
      NRowTotal:= StrToInt(Edit2.Text);
      if NRowTotal>3 then
        SBarra2.Max:= NRowTotal-3;
      Grid1.RowCount:= Grid1.RowCount+i;
      if (Grid1.TopRow>=(NRowTotal-4)) and (Grid1.TopRow>0) then
         Grid1.TopRow:= Grid1.TopRow-1;
    end
   else
    Edit2.Text:= IntToStr(NRowTotal);


end;

procedure TForm1.Edit1Exit(Sender: TObject);
var
   i: integer;
begin
   if StrToInt(Edit1.Text)<30 then
    begin
      i:= StrToInt(Edit1.Text) - NColTotal;
      NColTotal:= StrToInt(Edit1.Text);
      if NColTotal>2 then
         SBarra1.Max:= NColTotal-2;
      Grid1.ColCount:= Grid1.ColCount+i;
      if (Grid1.LeftCol>=(NColTotal-3)) and (Grid1.LeftCol>0) then
         Grid1.LeftCol:= Grid1.LeftCol-1;
    end
   else
     Edit1.Text:= IntToStr(NColTotal);


end;

procedure TForm1.Button7Click(Sender: TObject);
var
i,j: integer;
begin
     for i:=1 to NRowTotal do
       begin
         for j:=1 to NColTotal do
           begin
                Grid1.Cells[j-1,i-1]:= '';
           end;
       end;
end;

end.
