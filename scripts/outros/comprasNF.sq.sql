SELECT tblCompraNF.BaseCalcICMS_CompraNF
	,tblCompraNF.CFOP_CompraNF
	,tblCompraNF.ChvAcesso_CompraNF
	,tblCompraNF.CNPJ_CPF_CompraNF
	,tblCompraNF.DTEmi_CompraNF
	,tblCompraNF.DTEntd_CompraNF
	,tblCompraNF.Fil_CompraNF
	,tblCompraNF.HoraEntd_CompraNF
	,tblCompraNF.ID_Forn_CompraNF
	,tblCompraNF.ID_NatOp_CompraNF
	,tblCompraNF.ModeloDoc_CompraNF
	,tblCompraNF.NomeCompleto_CompraNF
	,tblCompraNF.NumNF_CompraNF
	,tblCompraNF.NumPed_CompraNF
	,tblCompraNF.Obs_CompraNF
	,tblCompraNF.Serie_CompraNF
	,tblCompraNF.Sit_CompraNF
	,tblCompraNF.TPNF_CompraNF
	,tblCompraNF.VTotICMS_CompraNF
	,tblCompraNF.VTotNF_CompraNF
	,tblCompraNF.VTotProd_CompraNF
	-- delete 
FROM tblCompraNF;
-- 42210307872326000158550040001546611011035203



/* 

UPDATE tblCompraNF
SET tblCompraNF.BaseCalcICMS_CompraNF = tblCompraNF.BaseCalcICMS_CompraNF/100
WHERE tblCompraNF.BaseCalcICMS_CompraNF > 0 ;


*/