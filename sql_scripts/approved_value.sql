SELECT Item,
       VlSolicitado,
       VlSugerido,
       Aprovado,
       JustParecerista,
       Unidade,
       QtItem,
       nrOcorrencia,
       VlUnitario,
       QtDias,
       UF,
       Municipio,
       JustComponente,
       UfProjeto,
       SolicitadoReal
FROM SAC.dbo.vwPlanilhaAprovada as aprovado
       LEFT JOIN SAC.dbo.Projetos as projetos
                 ON aprovado.idPronac = projetos.IdPRONAC;