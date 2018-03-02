SELECT
  abonado_oficial.inergy_nuevo as "INERGY", 
  fecha.anno as "IdProcesoRecoleccion", 
  empresa_ubicacion.idempresa as "IdEmpresa",
  fecha.fechainformacion as "FechaInformacion", 
  fecha.idmes as "IdMes", 
  fecha.mes as "Mes", 
  empresa_ubicacion.idprovincia as "IdProvincia", 
  empresa_ubicacion.provincia as "Provincia", 
  empresa_ubicacion.idcanton as "IdCanton", 
  empresa_ubicacion.canton as "Canton", 
  empresa_ubicacion.idparroquia as "IdParroquia", 
  empresa_ubicacion.parroquia as "Parroquia",
  consumo.nivelvoltaje as "NivelVoltaje", 
  consumo.grupoconsumo as "GrupoConsumo",
  consumo.codgrupoconsumo as "CodGrupoConsumo",
  consumo.tarifa as "Tarifa",
  abonado.descripciontarifa as "Desc_Tarifa", 
  abonado.tipocliente as "TipoCliente", 
  consumo.energia as "Energia",
  consumo.energia0722 as "Energia0722", 
  consumo.energia2207 as "Energia2207", 
  consumo.energia0818lv as "Energia0818LV", 
  consumo.energia1822lv as "Energia1822LV", 
  consumo.energia2208lv as "Energia2208LV",
  consumo.energia1822sdf as "Energia1822SDF",
  consumo.demandamaxima as "DemandaMaxima", 
  consumo.demandahoraspico as "DemandaHorasPico", 
  consumo.demandafacturable as "DemandaFacturable", 
  consumo.energiareactiva as "EnergiaReactiva", 
  consumo.valorcomercializacion as "ValorComercializacion", 
  consumo.facturaservicioelectrico as "FacturaServicioElectrico",
  consumo.tipomedidor as "TipoMedidor",
  consumo.energiaelectrica as "EnergiaElectrica", 
  consumo.factorcorreccion as "FactorCorreccion", 
  consumo.cargodemanda as "CargoDemanda", 
  consumo.penalizacionbajofactorpotencia as "PenalizacionBajoFactorPotencia", 
  consumo.factorpotencia as "FactorPotencia"
FROM public.empresa_ubicacion, 
  public.consumo,
  public.fecha,
  public.abonado inner join public.abonado_oficial on (abonado.cuenta = abonado_oficial.cuenta and abonado.id_empresa = abonado_oficial.id_empresa)
WHERE 
  consumo.id_abonado = abonado.id_abonado AND
  consumo.id_fecha = fecha.fechainformacion AND
  empresa_ubicacion.id_empresa_ubicacion = abonado.id_empresa_ubicacion 
  and abonado.medidor in ('190221011','198521011','1983','110243','12011047','2013905296','12011081','1827','5219643','8025931','12011095','12010045','50053202','12011116','1598983','2013903948','12011117','12011030','1599472','110888','185921011','12011120','197221011','12010003','12010043','3816571','4681483','3600662','1598378','12010019','7604774','1598910','2013905089','110243','12011096','12010023','12011119')
  and empresa_ubicacion.idempresa = '81'
  and abonado_oficial.area is not null
--   and abonado_oficial.inergy_nuevo is not null
--   and abonado.id_abonado in (select id_abonado from consumo group by id_abonado having count(*) = 17)
  and (abonado.cantidaderror = 0 or abonado.cantidaderror = 10 or abonado.cantidaderror = 20 or abonado.cantidaderror = 30 or abonado.cantidaderror = 99  or abonado.cantidaderror = 100)
order by empresa_ubicacion.idempresa,
  split_part(abonado_oficial.inergy_nuevo, '-', 2),
  abonado.cuenta,
  abonado.medidor,
  fecha.fechainformacion