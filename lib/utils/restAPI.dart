import 'package:alcaldia/components/Simbolos/simbolos.dart';
import 'package:flutter/material.dart';
import 'package:alcaldia/model/dependenciaModel.dart';
import 'package:get/get.dart';

class RESTAPI {
  List<DependenciaModel> dummyFeatured = [
    DependenciaModel(
      id: 2,
      depTitulo: "Mi Municipio",
      depDescripcion: " Enjoy the best experience with us!",
      imgUrl: "assets/diseño_interfaz/MiMunicipio.jpeg",
      depEncargado: "Ladakh, India",
    ),
    DependenciaModel(
      id: 1,
      depTitulo: "Nuestros Simbolos",
      depDescripcion:
          "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
      imgUrl: "assets/diseño_interfaz/cultu.png",
      depEncargado: "Honshu, Japan",
    ),
    DependenciaModel(
      id: 3,
      depTitulo: "Nuestra Alcaldia",
      depDescripcion:
          "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
      imgUrl: "assets/diseño_interfaz/MiAlcaldia.jpeg",
      depEncargado: "Yolima Rangel",
    ),
    DependenciaModel(
      id: 4,
      depTitulo: "¿Como llegar?",
      depDescripcion:
          "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
      imgUrl: "assets/diseño_interfaz/Panoramica.jpg",
      depEncargado: "Honshu, Japan",
    )
  ];

  List<DependenciaModel> dummyAllDependencias = [
    DependenciaModel(
        depTitulo: "Despacho Alcaldía",
        depDescripcion:
            "Dirigir, controlar y evaluar la acción administrativa mediante la formulación o adopción de políticas, planes, programas y proyectos, en concordancia de la función administrativa.\n\nGarantizar la eficiente prestación de los servicios mediante la gestión del sistema integrado de gestión de calidad, el sistema de desarrollo administrativo y de gestión del riesgo de corrupción.\n\nImplementar planes de mejoramiento continuo, con fundamento en los indicadores de gestión administrativa.\n\nEstablecer la reglamentación pertinente en materia de orden público, en concordancia con las recomendaciones de la Secretaria de Convivencia y Seguridad Ciudadana, la Inspección de Policía y las Fuerzas Armadas.\n\nExpedir las licencias, permisos, autorizaciones, certificados y/o conceptos cuando en la normatividad existente se le haya asignado ia competencia a la Administración Central del Municipio.\n\nExpedir los actos administrativos que aseguren el cumplimiento de las funciones contenidas en la constitución y la ley.\n\nServir de segunda instancia en los procesos disciplinarios adelantados en contra de ios servidores públicos del nivel central del Municipio.     ",
        imgUrl: "assets/image/pic2.jpg",
        depEncargado: "Celso Moreno Borrero"),
    DependenciaModel(
        depTitulo: "Régimen Subsidiado",
        depDescripcion:
            "Afiliaciones en el sector de la salud\n\nVerificacion del sisben \n\n Cumplir en forma oportuna y veraz con la información requerida por las demás dependencias, superior inmediato y entes de control con la periodicidad establecidos. \n\n Preparar y presentar los informes sobre las actividades desarrolladas, con la oportunidad y periodicidad requerida. \n\n Consolidar y enviar los informes del manejo de cuentas del régimen subsidiado, según resolución 1021 de 2009 (SISPRO). \n\n Fomentar la evaluación de los beneficiarios y evaluar el desarrollo del régimen subsidiado en el Municipio.",
        imgUrl: "assets/image/pic2.jpg",
        depEncargado: "Yolima Rangel"),
    DependenciaModel(
      depTitulo: "Tesoreria",
      depDescripcion:
          "1. Recaudar las rentas e ingresos determinados en el presupuesto del municipio.\n\n2. Realizar el pago de las obligaciones contraídas por el municipio, conforme a norma legal vigente.\n\n3. Llevar el libro de caja, bancos, control de presupuesto y los demás libros auxiliares que sean necesarios para el desarrollo y control respectivos.\n\n4. Manejar y controlar las cuentas bancarias donde se encuentran depositados los recursos del municipio.\n\n5. Realizar los análisis necesarios sobre la tendencia de flujo de caja y efectivo.\n\n6. Consignar diariamente en las cuentas los recursos que perciba la dependencia por concepto de impuestos, tasas o contribuciones.\n\n7. Planear, programar, coordinar y controlar, los procesos y procedimientos tendientes al recaudo, administración y custodia de las rentas, aportes, transferencias, auxilios y demás ingresos establecidos en el presupuesto del municipio y en las disposiciones legales vigentes. Así mismo realizar el pago de los gastos de nómina, contratos y demás obligaciones contraídas por el municipio.",
      imgUrl: "assets/image/pic3.jpg",
      depEncargado: "Yaneris Cudris",
    ),
    DependenciaModel(
      depTitulo: "Adulto Mayor",
      depDescripcion:
          "1. Orientar, vincular y supervisar el programa “Adulto mayor”.\n\n2. Atención al ciudadano.\n\n3. Acompañamiento e información referente al programa “Adulto mayor”.\n\n4. Quejas, reclamos y pagos referentes al programa “Adulto mayor”.",
      imgUrl: "assets/image/pic1.jpg",
      depEncargado: "Laura Martinez",
    ),
    DependenciaModel(
      depTitulo: "Oficina Juridica",
      depDescripcion:
          "1. Ordenar los gastos y celebrar los contratos y convenios municipales de acuerdo con el plan de desarrollo económico, social y con el presupuesto, observando las normas jurídicas aplicables.\n\n2. Gestionar todo lo referente a contrataciones, obras, convenios, prestación de servicios, adjudicaciones, derechos de petición, Etc.\n\n3. Apoyar con recursos humanos y materiales el buen funcionamiento de las juntas administradoras locales.\n\n4. Dirigir las actividades representación judicial y de apoyo jurídico de carácter municipal.\n\n5. Gestionar y evaluar el proceso de contratación administrativa, de acuerdo a la normatividad vigente en la materia.6. Asistir al alcalde en sus relaciones con los demás organismos y mantenerlo informado de las tareas administrativas que se relacionen con las actividades propias de su despacho.\n\n27. Dirigir, coordinar y controlar los recursos o talentos humanos que prestan servicios a la administración municipal. \n\n28. Coordinar la elaboración del plan anual de compras, verificando que se incorporen los planes por cada dependencia. \n\n29. Dirigir y coordinar los procesos de adquisición de bienes y servicios que las diferentes dependencias requieran.\n\n210. Ejercer la función de Jefe de Personal de los empleados vinculados al municipio de Chimichagua.\n\n211. Suministrar los bienes muebles, equipos y papelería que se requieran.\n\n212. Coordinar la acción del gobierno en sus relaciones con el Concejo Municipal y sustentar y velar porque los proyectos de acuerdo presentados por el gobierno, se desarrollen con arreglo a los principios de economía, eficacia y celeridad, y Desarrollar procesos de gestión humana con pertinencia en las normas que rigen el trabajo en las entidades públicas colombianas.",
      imgUrl: "assets/image/pic4.jpg",
      depEncargado: "Jose Gabriel Florez Robles",
    ),
    DependenciaModel(
      depTitulo: "Secretaria de Gobierno",
      depDescripcion:
          "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
      imgUrl: "assets/image/pic2.jpg",
      depEncargado: "Honshu, Japan",
    ),
    DependenciaModel(
      depTitulo: "Servicios Sociales",
      depDescripcion:
          "1. Planear, programar, y desarrollar proyectos encaminados al fortalecimiento de institucional, en la salud, educación, cultura y el deporte del municipio.\n\n2. Velar por el cumplimiento oportuno de la calidad y cobertura educativa en las instituciones de educación, la promoción de la cultura, la recreación y el deporte y el aprovechamiento del tiempo libre, acorde con las competencias legales.\n\n3. Formular planes, programas y proyectos de desarrollo social armónico y progresivo de la comunidad, en materia de educación, deporte y recreación, con prioridad de los grupos de población vulnerable.\n\n4. Planear y desarrollar programas y actividades que permitan fomentar la práctica del deporte, la recreación, el aprovechamiento del tiempo libre, la cultura y la educación física.\n\n5. Formular, ejecutar y evaluar planes, programas y proyectos de salud en armonía con las políticas y disposiciones del orden nacional y departamental.\n\n6. Gestionar el recaudo, flujo y ejecución de los recursos de destinación específica para la salud del municipio, y administrar los recursos del Fondo Local de Salud.\n\n7. Gestionar y supervisar el acceso a la prestación de los servicios de salud para la población de la jurisdicción.\n\n8. impulsar mecanismos para la adecuada participación social y el ejercicio pleno de los deberes y derechos de los ciudadanos en materia de salud y de seguridad social en salud.\n\n9.Adoptar, administrar e implementar el sistema integral de información en salud, así como generar y reportar la información requerida por el sistema.\n\n10. Promover planes, programas, estrategias y proyectos en salud y seguridad social en salud para su inclusión en los planes y programas departamentales y nacionales.",
      imgUrl: "assets/image/pic3.jpg",
      depEncargado: "Lesly Tatiana Sanjuán Esparragoza",
    ),
    DependenciaModel(
      depTitulo: "Secretaria de planeación",
      depDescripcion:
          "1. Coordinar y apoyar a la Administración en el alistamiento y elaboración del plan de desarrollo municipal con pertinencia en las normas, leyes y procedimientos que dispone el estado para tal fin.\n\n2. Asesorar a las demás dependencias en la formulación de programas, planes y proyectos para ser ejecutados conforme al plan de desarrollo.\n\n3. Coordinar y verificar el establecimiento de los indicadores establecidos en los programas y proyectos del plan de desarrollo municipal\n\n4. Definir con los directivos de la entidad la metodología para llevar a cabo los planes de acción de cada programa que tiene bajo su responsabilidad.\n\n5. Coordinar la Planificación del desarrollo del municipio a partir de las características del territorio, de los factores económicos, sociales, culturales que en él se manifiestan, a través de la gestión administrativa.",
      imgUrl: "assets/image/pic1.jpg",
      depEncargado: "María Fernández Lima",
    ),
    DependenciaModel(
      depTitulo: "Secretaria de hacienda",
      depDescripcion:
          "1. Planear, dirigir, coordinar y controlar los diferentes planes, programas y proyectos referentes a la gestión financiera, tributaria, contable y presupuestal, para el desarrollo y aseguramiento de la política fiscal del municipio.\n\n2. Estructurar el presupuesto del municipio en armonía con las leyes y normas que lo soportan.\n\n3. Informar permanente al representante de la entidad la dinámica de la ejecución del presupuesto.\n\n4. Verificar con la oficina de planeación que los indicadores pre establecidos en el plan indicativo en la ejecución de programas y proyectos se esté cumpliendo.\n\n5. Reportar la información que exige la contaduría del estado.\n\n6. Establecer y operar las medidas necesarias para garantizar que el sistema de contabilidad del Municipio este diseñado para que su operación facilite la fiscalización de los activos, pasivos, ingresos y gastos, avance en la ejecución de programas y en general de manera que permitan medir la eficacia y eficiencia del gasto público.",
      imgUrl: "assets/image/pic4.jpg",
      depEncargado: "Yuranis Moreno castro",
    ),
    DependenciaModel(
      depTitulo: "Comisaria de familia",
      depDescripcion:
          "1.Apoyar, programar, ejecutar y controlar los procesos relacionados con la protección de los menores la mujer y ancianos que se hallen en situación irregular e intervenir en situaciones de Violencia intrafamiliar en el municipio, para y garantizar, proteger, restablecer y reparar los derechos de los menores y la familia, en atención al objetivo de colaboración con el ICBF y con las demás autoridades competentes.\n\n2. Garantizar, proteger, restablecer y reparar los derechos de los miembros de la familia transgredidos por situaciones de violencia intrafamiliar.\n\n3. Atender orientar a los niños, las niñas y los adolescentes y demás miembros del grupo familiar en el ejercicio y restablecimiento de sus derechos.\n\n4.Recibir denuncias y adoptar las medidas de emergencia y de protección necesarias en casos de delitos contra los niños, las niñas y los adolescentes.",
      imgUrl: "assets/image/pic2.jpg",
      depEncargado: "Yesid Morón León",
    ),
    DependenciaModel(
      depTitulo: "Oficina de victimas",
      depDescripcion:
          "1. Dirigir y coordinar las políticas y las acciones para el manejo y atención de la población víctima del conflicto armado.\n\n2. Gestión de proyectos y programas en beneficio a las personas afectadas por el conflicto armado.\n\n3. Gestionar con las distintas entidades del sistema nacional de atención a víctimas las ofertas y programas que contribuyan a las personas afectadas a la superación de dicha vulnerabilidad.\n\n4. Gestionar el registro de víctimas y acompañar a las personas afectadas en la superación de su  vulnerabilidad.\n\n5. Retorno y reubicaciones familiares y comunitarias.\n\n6. Gestionar con la unidad de víctimas para verificar cumplimientos y requisitos.",
      imgUrl: "assets/image/pic3.jpg",
      depEncargado: "Luis Mariano Olivero",
    ),
    DependenciaModel(
      depTitulo: "Recaudo",
      depDescripcion:
          "1. Realizar las actividades, acciones de apoyo administrativo, complementarias de las tareas propias de los niveles superiores para el desarrollo de la gestión administrativa de la dependencia a la cual se encuentra asignado, teniendo en cuenta la aplicación de la normatividad vigente, la tecnología, la misión y políticas institucionales vigentes.\n\n2.Recibir, revisar, clasificar, radicar, distribuir y controlar documentos, datos, elementos y correspondencia, relacionados con los asuntos de competencia de la secretaría la que se encuentra asignado.\n\n3. Llevar y mantener actualizados los registros de carácter técnico, Administrativo y financiero y responder por la exactitud de los mismos.",
      imgUrl: "assets/image/pic1.jpg",
      depEncargado: "Catalina Caro Caro",
    ),
    DependenciaModel(
      depTitulo: "Sisben",
      depDescripcion:
          "1. Realizar trámites para identificar a las familias potenciales beneficiarías de programas Sociales en el sistema de información diseñado por el Gobierno Nacional -SISBEN.\n\n2. Actualizacion de datos.\n\n3. Inclucion de nuevos miembros en los nucleos.\n\n4. Retiro de fallecidos y personas con cambio de municipio.\n\n5. Solicitud de encuestas e información referente a la salud, educación, programas de ingreso solidarios y adulto mayor.",
      imgUrl: "assets/image/pic4.jpg",
      depEncargado: "Onafi Arias",
    )
  ];

  Future<List<DependenciaModel>> getFeaturedDependencias([String text]) async {
    await Future.delayed(Duration(milliseconds: 750));
    
    return dummyFeatured;
  }

  Future<List<DependenciaModel>> getAllDependencias([String text='']) async {
    await Future.delayed(Duration(milliseconds: 100));
    if (text.length > 1) {
      List<DependenciaModel> copiaDependencias=[];
      dummyAllDependencias.forEach((element) {
        if (element.depTitulo.toLowerCase().contains(text.toLowerCase())) {
          if(element!=null){
            copiaDependencias.add(element);
          }
        }
      });
      return copiaDependencias;
    }else{
      return dummyAllDependencias;
    }
    
  }
}
