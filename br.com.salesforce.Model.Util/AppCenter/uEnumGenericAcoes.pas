unit uEnumGenericAcoes;
    //EXPLICAR AQUI A REAL UTILIDADE DESSA CLASSE / UNIT
    //AQUI TRABALHA CENTRALIZANDO OP��ES PARA M�TODOS QUE UTIZAM ALGUMA FORMA DE CASE OF..
    //COMO SE FOSSE UMA ESP�CIE DE HUB...

interface

type

  //VEIO DO PROJETO ORIGINAL... AQUI USADO APENAS NA MODEL.... NO M�TODO DE SALVAR...
  TActionRotulo = (tactionIndefinido, tactionIncluir, tactionAlterar, tactionExcluir);

  //UTILIZADOS ESPECIFICAMENTE PARA O M�TODO QUE REORDENA CARACTERISTICAS DE BTNS E EDITS NAS VIEWS..
  TBtnActions   = (NovoAct, SalvaAct, AlteraAct, ExcluiAct, CancelaAct);

implementation

end.
