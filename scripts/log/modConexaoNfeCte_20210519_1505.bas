Attribute VB_Name = "modConexaoNfeCte"
Option Compare Database

Private Const qryDeleteProcessamento As String = _
        "DELETE * FROM tblProcessamento;"

Private Const qrySelecaoDeCampos As String = _
        "SELECT tblOrigemDestino.Tag FROM tblOrigemDestino WHERE (((tblOrigemDestino.tabela)='strParametro') AND ((Len([Tag]))>0) AND ((tblOrigemDestino.TagOrigem)=1)) ORDER BY tblOrigemDestino.Tag, tblOrigemDestino.tabela;"
       
        
Sub TESTE_CARREGAR()

    carregar_ComprasItens "C:\temp\Coleta\68.365.5010001-05 - Proparts Comércio de Artigos Esportivos e Tecnologia Ltda\35210343283811001202550010087454051410067364-nfeproc.xml"

End Sub


Public Function carregar_ComprasItens(pPathFile As String)
On Error Resume Next

Dim s As New clsConexaoNfeCte

'' CHAVES DE CONTROLE
Dim pPK As String: pPK = DLookup("[Chave]", "[tblDadosConexaoNFeCTe]", "[CaminhoDoArquivo]='" & pPathFile & "'")
Dim pChvAcesso As String: pChvAcesso = DLookup("[ChvAcesso]", "[tblDadosConexaoNFeCTe]", "[CaminhoDoArquivo]='" & pPathFile & "'")

'' CARREGAR ARQUIVO
Dim XDoc As Object: Set XDoc = CreateObject("MSXML2.DOMDocument"): XDoc.async = False: XDoc.validateOnParse = False
XDoc.Load pPathFile

Dim cont As Integer: cont = XDoc.getElementsByTagName("infNFe/det").Length
Dim Item As Variant

Dim pDados As New Collection

Dim idItem As String: idItem = ""

    '' LIMPAR TABELA DE PROCESSAMENTOS
    Application.CurrentDb.Execute qryDeleteProcessamento

    '' IDENTIFICAÇÃO DO ARQUIVO
    pDados.add pPK & "|" & "CaminhoDoArquivo" & "|" & pPathFile

    '' CHAVE DE ACESSO
    pDados.add pPK & "|" & "ChvAcesso_CompraNF" & "|" & pChvAcesso

    '' CABEÇALHO DA COMPRA
    For Each Item In carregarParametros(qrySelecaoDeCampos, "tblCompraNF")
        Select Case UBound(Split((Item), "|"))
            
            '' ITEM DE COMPRA
            Case 1
                regiao = Split((Item), "|")(0)
                campo = Split((Item), "|")(1)
                pDados.add pPK & "|" & campo & "|" & XDoc.SelectNodes(regiao).Item(i).SelectNodes(campo).Item(0).text
            
            '' IMPOSTO
            Case 2
                regiao = Split((Item), "|")(0)
                subRegiao = Split((Item), "|")(1)
                campo = Split((Item), "|")(2)
                pDados.add pPK & "|" & campo & "|" & XDoc.SelectNodes(regiao).Item(i).SelectNodes(subRegiao).Item(0).getElementsByTagName(campo).Item(0).text
            Case Else
        End Select
        
        DoEvents
    
    Next Item


    '' ITENS DA COMPRA
    For i = 0 To cont - 1
        '' ID
        idItem = CStr(XDoc.getElementsByTagName("nfeProc/NFe/infNFe/det").Item(i).Attributes(0).value)
        pDados.add pPK & "_" & idItem & "|" & "Item_CompraNFItem" & "|" & idItem
        pDados.add pPK & "_" & idItem & "|" & "ChvAcesso_CompraNF" & "|" & pChvAcesso

        For Each Item In carregarParametros(qrySelecaoDeCampos, "tblCompraNFItem")
            Select Case UBound(Split((Item), "|"))
                
                '' ITEM DE COMPRA
                Case 1
                    regiao = Split((Item), "|")(0)
                    campo = Split((Item), "|")(1)
                    pDados.add pPK & "_" & idItem & "|" & campo & "|" & XDoc.SelectNodes(regiao).Item(i).SelectNodes(campo).Item(0).text
                
                '' IMPOSTO
                Case 2
                    regiao = Split((Item), "|")(0)
                    subRegiao = Split((Item), "|")(1)
                    campo = Split((Item), "|")(2)
                    pDados.add pPK & "_" & idItem & "|" & campo & "|" & XDoc.SelectNodes(regiao).Item(i).SelectNodes(subRegiao).Item(0).getElementsByTagName(campo).Item(0).text
                Case Else
            End Select
            
            DoEvents
            
        Next Item

        DoEvents

    Next i

    '' CADASTRAR DADOS
    s.cadastroProcessamento pDados
    
    '' LIMPAR COLEÇÃO
    ClearCollection pDados

    '' ATUALIZAR CAMPOS DE RELACIONAMENTOS
    Application.CurrentDb.Execute Replace(qryUpdateProcessamento, "strParametro", "tblCompraNFItem")
    
    '' TRANSFERIR PROCESSADOS
'    s.TransferirDadosProcessados "tblCompraNFItem"

Set XDoc = Nothing

End Function

Function proc_01()
On Error GoTo adm_Err
Dim s As New clsConexaoNfeCte

'' #ANALISE_DE_PROCESSAMENTO

'' #ADMINISTRACAO - RESPONSAVEL POR TRAZER OS DADOS DO SERVIDOR PARA AUXILIO NO PROCESSAMENTO. QUANDO NECESSARIO
'    s.ADM_carregarDadosDoServidor

'' 01.CARREGAR DADOS GERAIS - CONCLUIDO
'    s.carregar_DadosGerais

'' 02.CARREGAR COMPRAS ANTES DE ENVIAR PARA O SERVIDOR
    s.carregar_Compras

'' 03.ENVIAR DADOS PARA SERVIDOR
'    s.enviar_ComprasParaServidor
    
    MsgBox "Fim!", vbOKOnly + vbExclamation, "proc_01"
    

adm_Exit:
    Exit Function

adm_Err:
    MsgBox Error$
    Resume adm_Exit

End Function

