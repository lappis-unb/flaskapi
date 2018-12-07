SELECT interessado.Uf, FORMAT(SUM(Aprovado), 'C')
FROM SAC.dbo.vwPlanilhaAprovada as aprovado
       INNER JOIN SAC.dbo.Projetos as projetos
                  ON projetos.IdPRONAC = aprovado.idPronac
       INNER JOIN SAC.dbo.Interessado as interessado
                  ON interessado.CgcCpf = projetos.CgcCpf
WHERE projetos.IdPRONAC in (
       SELECT projetos.IdPRONAC
       FROM SAC.dbo.Captacao as capt
)
GROUP BY interessado.Uf



SELECT interessado.Uf, FORMAT(SUM(Aprovado), 'C') AS aprovado
FROM SAC.dbo.Projetos as projetos
       INNER JOIN SAC.dbo.vwPlanilhaAprovada as aprovado
                  ON projetos.IdPRONAC = aprovado.idPronac
       INNER JOIN SAC.dbo.Interessado as interessado
                  ON interessado.CgcCpf = projetos.CgcCpf
WHERE projetos.IdPRONAC in (
  SELECT projetos.IdPRONAC
  FROM SAC.dbo.Projetos as projetos
         INNER JOIN SAC.dbo.Interessado as interessado
                    ON interessado.CgcCpf = projetos.CgcCpf
         INNER JOIN SAC.dbo.Captacao as capt
                    ON (capt.AnoProjeto = projetos.AnoProjeto AND
                        capt.Sequencial = projetos.Sequencial)
)
GROUP BY interessado.Uf;

SELECT interessado.Uf, FORMAT(SUM(CaptacaoReal), 'C') AS captado, FORMAT(SUM(Aprovado), 'C') AS aprovado
FROM SAC.dbo.Projetos as projetos
       INNER JOIN SAC.dbo.Interessado as interessado
                  ON interessado.CgcCpf = projetos.CgcCpf
       LEFT JOIN SAC.dbo.vwPlanilhaAprovada as aprovado
                 ON CONCAT(capt.AnoProjeto, capt.Sequencial) = aprovado.idPronac
     --               WHERE CaptacaoReal >= 0
GROUP BY interessado.Uf;

SELECT interessado.Uf, COUNT(DISTINCT interessado.CgcCPf)
FROM SAC.dbo.Projetos as projetos
       INNER JOIN SAC.dbo.Interessado as interessado
                  ON interessado.CgcCpf = projetos.CgcCpf
       INNER JOIN SAC.dbo.Captacao as capt
                  ON (capt.AnoProjeto = projetos.AnoProjeto AND capt.Sequencial = projetos.Sequencial)
WHERE interessado.Uf = 'RR'
GROUP BY interessado.Uf;



SELECT SUM(Aprovado), interessado.CgcCpf
FROM SAC.dbo.Projetos as projetos
       INNER JOIN SAC.dbo.vwPlanilhaAprovada as aprovado
                  ON projetos.IdPRONAC = aprovado.idPronac
       INNER JOIN SAC.dbo.Interessado as interessado
                  ON interessado.CgcCpf = projetos.CgcCpf
WHERE interessado.Uf = 'RR'
    --                 and interessado.CgcCpf != '18865119268'and interessado.CgcCpf !=   '31795335874' and interessado.CgcCpf !=  '01892955000163' and interessado.CgcCpf !=  '84039734000174'

GROUP BY interessado.CgcCpf;

SELECT *
from SAC.dbo.vwPlanilhaAprovada as aprovado
WHERE PRONAC = '020326'

SELECT *
from SAC.dbo.Captacao
WHERE CaptacaoReal > 0

SELECT *
from SAC.dbo.Interessado as interessados
WHERE CgcCpf = '07896550000180'

SELECT *
from SAC.dbo.Projetos as projetos
WHERE IdPRONAC = '218530'

SELECT *
FROM SAC.dbo.tbPlanilhaAprovacao
WHERE IdPRONAC = 55704

SELECT *
FROM SAC.dbo.vwPlanilhaAprovada
Where idFonte != 109

SELECT *
from SAC.dbo.projetos
WHERE AnoProjeto >= 50

SELECT COUNT(DISTINCT projetos.CgcCpf), interessado.Uf
FROM SAC.dbo.Projetos as projetos
       INNER JOIN SAC.dbo.Interessado as interessado
                  On projetos.CgcCPf = interessado.CgcCpf
       INNER JOIN SAC.dbo.Captacao as capt
                  ON (capt.AnoProjeto = projetos.AnoProjeto AND capt.Sequencial = projetos.Sequencial)
WHERE CaptacaoReal > 0
GROUP BY interessado.Uf

SELECT interessados.Uf, SUM(vlUnitario)
FROM SAC.dbo.tbPlanilhaAprovacao as aprovados
       inner join SAC.dbo.Projetos as projetos
                  ON projetos.IdPRONAC = aprovados.IdPRONAC
       INNER JOIN SAC.dbo.Interessado as interessados
                  ON projetos.CgcCpf = interessados.CgcCpf
GROUP BY interessados.Uf

SELECT COUNT(idPronac) as quant, idPlanilhaAprovacao
from SAC.dbo.vwPlanilhaAprovada
Group By idPlanilhaAprovacao



SELECT interessado.Uf, FORMAT(SUM(Aprovado), 'C') AS aprovado, FORMAT(SUM(CaptacaoReal), 'C') AS captado
FROM SAC.dbo.Projetos as projetos
       INNER JOIN SAC.dbo.Interessado as interessado
                  ON interessado.CgcCpf = projetos.CgcCpf
       INNER JOIN SAC.dbo.Captacao as capt
                  ON (capt.AnoProjeto = projetos.AnoProjeto AND capt.Sequencial = projetos.Sequencial)
       INNER JOIN SAC.dbo.vwPlanilhaAprovada as aprovado
                  ON CONCAT(capt.AnoProjeto, capt.Sequencial) = aprovado.PRONAC
GROUP BY interessado.Uf
ORDER BY interessado.Uf;


SELECT CONCAT(projetos.AnoProjeto,
              projetos.Sequencial)              AS ProjetosPronac,
       CONCAT(capt.AnoProjeto, capt.Sequencial) AS CaptPronac,
       aprovado.PRONAC                          AS AprovadoPronac,
       interessado.CgcCpf
FROM SAC.dbo.Projetos as projetos
       INNER JOIN SAC.dbo.Interessado as interessado
                  ON interessado.CgcCpf = projetos.CgcCpf
       INNER JOIN SAC.dbo.Captacao as capt
                  ON (capt.AnoProjeto = projetos.AnoProjeto AND capt.Sequencial = projetos.Sequencial)
       INNER JOIN SAC.dbo.vwPlanilhaAprovada as aprovado
                  ON CONCAT(capt.AnoProjeto, capt.Sequencial) = aprovado.PRONAC
WHERE interessado.Uf = 'AC'
    --GROUP BY interessado.Uf
ORDER BY interessado.Uf;



SELECT interessado.Uf, FORMAT(SUM(Aprovado), 'C') AS aprovado, FORMAT(SUM(CaptacaoReal), 'C') AS captado
FROM SAC.dbo.Captacao as capt

       INNER JOIN SAC.dbo.Projetos as projetos
                  ON (capt.AnoProjeto = projetos.AnoProjeto AND capt.Sequencial = projetos.Sequencial)

       INNER JOIN SAC.dbo.vwPlanilhaAprovada as aprovado
                  ON CONCAT(capt.AnoProjeto, capt.Sequencial) = aprovado.PRONAC

       INNER JOIN SAC.dbo.Interessado as interessado
                  ON interessado.CgcCpf = projetos.CgcCpf

GROUP BY interessado.Uf
ORDER BY interessado.Uf;


SELECT COUNT(DISTINCT CONCAT(capt.AnoProjeto, capt.Sequencial)) AS CaptPronac
FROM SAC.dbo.Captacao as capt

       INNER JOIN SAC.dbo.Projetos as projetos
                  ON (capt.AnoProjeto = projetos.AnoProjeto AND capt.Sequencial = projetos.Sequencial)

       INNER JOIN SAC.dbo.vwPlanilhaAprovada as aprovado
                  ON CONCAT(capt.AnoProjeto, capt.Sequencial) = aprovado.PRONAC

       INNER JOIN SAC.dbo.Interessado as interessado
                  ON interessado.CgcCpf = projetos.CgcCpf

--GROUP BY interessado.Uf
--ORDER BY interessado.Uf
;

SELECT COUNT(DISTINCT CONCAT(capt.AnoProjeto, capt.Sequencial)) AS CaptPronac
from SAC.dbo.Captacao AS capt;