select count(*), cuenta, medidor, nombreabonado, nombreabonadooficial, ubicacionabonado, ubicacionabonadooficial from (select empresa, cuenta, medidor, canton, parroquia, nombreabonado, nombreabonadooficial, ubicacionabonado, ubicacionabonadooficial
from(select eu.empresa, ao.cuenta, ao.medidor, eu.canton, eu.parroquia, a.nombreabonado, ao.nombreabonado as nombreabonadooficial, a.ubicacionabonado, ao.ubicacionabonado as ubicacionabonadooficial, row_number() 
over( partition by a.cuenta, a.medidor, a.nombreabonado  order by a.cuenta, a.medidor, a.nombreabonado) as rno 
from empresa_ubicacion eu inner join abonado a on (a.id_empresa = eu.idempresa), abonado_oficial ao
where a.cuenta = ao.cuenta and a.id_empresa = ao.id_empresa and (ao.cnel = 1 or catalina_full = 1)) as table1
where table1.rno <= 2
order by empresa, cuenta,medidor, nombreabonado) as b group by cuenta, medidor, nombreabonado, nombreabonadooficial, ubicacionabonado, ubicacionabonadooficial order by count(*) desc