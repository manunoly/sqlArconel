﻿SELECT 
  fecha.anno as IdProcesoRecoleccion, 
  empresa_ubicacion.idempresa as IdEmpresa,
  empresa_ubicacion.empresa,
  fecha.fechainformacion as FechaInformacion, 
  fecha.idmes as IdMes, 
  fecha.mes as Mes, 
  abonado.cuenta, 
  abonado.medidor, 
  abonado_oficial.inergy,
  --abonado_oficial.inergy_nuevo as inergy,
  empresa_ubicacion.idprovincia as IdProvincia, 
  empresa_ubicacion.provincia as Provincia, 
  empresa_ubicacion.idcanton as IdCanton, 
  empresa_ubicacion.canton as Canton, 
  empresa_ubicacion.idparroquia as IdParroquia, 
  empresa_ubicacion.parroquia as Parroquia,
  abonado.nombreabonado, 
  abonado.ubicacionabonado, 
  abonado.fechanacimientoabonado,
  abonado.esterceraedad, 
  abonado.cedulaabonado,
  consumo.nivelvoltaje as NivelVoltaje, 
  consumo.grupoconsumo as GrupoConsumo,
  consumo.codgrupoconsumo as CodGrupoConsumo,
  consumo.tarifa as Tarifa,
  abonado.descripciontarifa as Desc_Tarifa, 
  abonado.tipocliente as TipoCliente, 
  consumo.energia as Energia, 
  consumo.subsidiocruzadocalculado, 
  consumo.subsidiosolidariocalculado, 
  consumo.subsidiosolidarioaplicado, 
  consumo.subsidioterceraedad, 
  consumo.subsidiotarifadignidad,
  consumo.energia0722 as Energia0722, 
  consumo.energia2207 as Energia2207, 
  consumo.energia0818lv as Energia0818LV, 
  consumo.energia1822lv as Energia1822LV, 
  consumo.energia2208lv as Energia2208LV,
  consumo.energia1822sdf as Energia1822SDF,
  consumo.demandamaxima as DemandaMaxima, 
  consumo.demandahoraspico as DemandaHorasPico, 
  consumo.demandafacturable as DemandaFacturable, 
  consumo.energiareactiva as EnergiaReactiva, 
  consumo.valorcomercializacion as ValorComercializacion, 
  consumo.impuestoalumbradopublico, 
  consumo.impuestorecoleccionbasura, 
  consumo.impuestobomberos, 
  consumo.facturaservicioelectrico as FacturaServicioElectrico, 
  consumo.facturaelectrica, 
  consumo.facturatotal, 
  consumo.valorrefacturacion, 
  consumo.energiarefacturacion, 
  consumo.interesmorarefacturacion, 
  consumo.mesesadeudados, 
  consumo.recaudacionservicioelectrico, 
  consumo.recaudaciontotal, 
  consumo.sistemavalorenergia, 
  consumo.sistemavalorcomercializacion, 
  consumo.sistemafacturacionservicioelectrico, 
  consumo.sistemarecibesubsidiocruzado,
  consumo.sistemaaplicasubsidioterceraedad, 
  consumo.sistemaaplicasubsidiotarifadignidad, 
  consumo.sistemasubsidioterceraedad, 
  consumo.sistemasubsidiocruzadonominal, 
  consumo.sistemasubsidiocruzado, 
  consumo.sistemasubsidiocruzadosaldo, 
  consumo.sistematotalfacturasintarifadignidad, 
  consumo.sistematotalfacturacontarifadignidad, 
  consumo.sistemasubsidiotarifadignidad, 
  consumo.sistematotalfactura,
  --falta cliente
  consumo.tipomedidor as TipoMedidor, 
  consumo.transformador, 
  consumo.subsidioleydiscapacitado, 
  consumo.lineabase, 
  consumo.kwhsubsidio, 
  consumo.equipamiento, 
  consumo.valorsubsidiadopec, 
  consumo.consumoresidencial, 
  consumo.fechaingresosiscomercial, 
  consumo.energiaelectrica as EnergiaElectrica, 
  consumo.factorcorreccion as FactorCorreccion, 
  consumo.cargodemanda as CargoDemanda, 
  consumo.penalizacionbajofactorpotencia as PenalizacionBajoFactorPotencia, 
  consumo.factorpotencia as FactorPotencia, 
  consumo.financiamientococinainduccion, 
  consumo.instalacioncircuitoexpreso, 
  consumo.subsidiotarifaelectrica, 
  consumo.facturadodamnificadovolcantungurahua,
  abonado_oficial.nombreabonado as nombreabonado_oficial_selecionado,
  abonado_oficial.cuenta as cuenta_oficial_selecionada,
  abonado_oficial.ubicacionabonado as ubicacionabonado_oficial_selecionado,
  split_part(abonado_oficial.inergy_nuevo, '-', 2) as tipo_oficial_selecionado, 
  abonado_oficial.no_de_edificio,
  abonado_oficial.coord_x, 
  abonado_oficial.coord_y,
  consumo.id_consumo,
  abonado_oficial.area
FROM public.empresa_ubicacion, 
  public.consumo,
  public.fecha,
  public.abonado inner join public.abonado_oficial on (abonado.cuenta = abonado_oficial.cuenta and abonado.id_empresa = abonado_oficial.id_empresa)
WHERE 
  consumo.id_abonado = abonado.id_abonado AND
  consumo.id_fecha = fecha.fechainformacion AND
  empresa_ubicacion.id_empresa_ubicacion = abonado.id_empresa_ubicacion 
--   and empresa_ubicacion.idempresa != '81'
  and abonado.id_abonado < 3538 
  and abonado_oficial.ultimasreas is not null
  and abonado.cuenta not in ('1559485-3','1598326-4','1599578-5','1604306-0')
--   and abonado.medidor = '1483999-ITR-AT'
--   and abonado.cuenta in ('1549449')
  and (abonado.cantidaderror = 0 or abonado.cantidaderror = 10 or abonado.cantidaderror = 20 or abonado.cantidaderror = 30 or abonado.cantidaderror = 99  or abonado.cantidaderror = 100)
  order by empresa_ubicacion.idempresa,
  split_part(abonado_oficial.inergy_nuevo, '-', 2),
  abonado.cuenta,
  abonado.medidor,
  fecha.fechainformacion