unit u_principal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnDiretorio: TButton;
    btnListar: TButton;
    chkSub: TCheckBox;
    Label1: TLabel;
    edtDiretorio: TEdit;
    Label2: TLabel;
    listList: TListBox;
    memLista: TMemo;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    procedure btnDiretorioClick(Sender: TObject);
    procedure btnListarClick(Sender: TObject);
  private

    procedure ListarArquivos(Diretorio: string; Sub:Boolean);
    function TemAtributo(Attr, Val: Integer): Boolean;

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.btnListarClick(Sender: TObject);
begin
      memLista.Lines.Clear;
      ListarArquivos(edtDiretorio.Text, chkSub.Checked);
end;

procedure TForm1.btnDiretorioClick(Sender: TObject);
begin
     SelectDirectoryDialog1.Execute;
     edtDiretorio.Text:=SelectDirectoryDialog1.FileName;

end;

procedure TForm1.ListarArquivos(Diretorio: string; Sub: Boolean);

    var

  F: TSearchRec;

  Ret: Integer;

  TempNome: string;

begin

  Ret := FindFirst(Diretorio+'/*.pgn', faAnyFile, F);

  try

    while Ret = 0 do

    begin

      if TemAtributo(F.Attr, faDirectory) then

      begin

        if (F.Name <> '.') And (F.Name <> '..') then

          if Sub = True then

          begin

            TempNome := Diretorio+'\' + F.Name;

            ListarArquivos(TempNome, True);

          end;

      end

      else

      begin

        memLista.Lines.Add(Diretorio+'\'+F.Name);
        listList.AddItem(F.Name, TObject (Diretorio+'\'));

      end;

        Ret := FindNext(F);

    end;

  finally

  begin

    FindClose(F);

  end;

  end;
end;

function TForm1.TemAtributo(Attr, Val: Integer): Boolean;
begin
    Result := Attr and Val = Val;
end;

end.

