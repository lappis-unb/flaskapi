SELECT UfProjeto, CaptacaoReal
FROM SAC.dbo.Captacao capt
       INNER JOIN SAC.dbo.Projetos proj ON (capt.AnoProjeto = proj.AnoProjeto AND capt.Sequencial = proj.Sequencial)