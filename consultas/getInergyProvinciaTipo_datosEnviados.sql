SELECT 
  abonado_oficial.inergy, 
  abonado_oficial.tipo, 
  emp.provincia
FROM 
  public.abonado_oficial left join (select idempresa, provincia from public.empresa_ubicacion group by idempresa, provincia) as emp on (abonado_oficial.id_empresa = emp.idempresa)
WHERE
  inergy_nuevo is null
  and area is null
--   and tipo = inergy like '%tipo%'