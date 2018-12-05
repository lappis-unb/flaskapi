SELECT UfProjeto, SUM(Aprovado)
FROM SAC.dbo.vwPlanilhaAprovada as aprovado
       LEFT JOIN SAC.dbo.Projetos as projetos
                 ON aprovado.idPronac = projetos.IdPRONAC
                            GROUP BY UfProjeto;