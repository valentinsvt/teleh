package teleh

class PreguntaEntrevista {

    Convocatoria convocatoria

    String tipo
    Integer orden //orden de las preguntas
    Integer numero  //si es de verificacion son letras: 1->A...
    String pregunta
    String valoracion
    Double positivo
    Double negativo

    static constraints = {
        tipo(blank: false, nullable: false, inList: ["Verificacion", "Entrevista con puntaje", "Entrevista sin puntaje"])
        orden(blank: false, nullable: false)
        numero(blank: false, nullable: false)
        pregunta(blank: false, nullable: false)
        valoracion(blank: false, nullable: false)
        positivo(blank: false, nullable: false, default: 0)
        negativo(blank: false, nullable: false, default: 0)
    }

    static mapping = {
        table 'pren'

        id column: 'pren__id'

        convocatoria column: 'conv__id'
        tipo column: 'prentipo'
        orden column: 'prenordn'
        numero column: 'prennmro'
        pregunta column: 'prenprgn'
        valoracion column: 'prenvlrc'
        positivo column: 'prenpstv'
        negativo column: 'prenngtv'
    }

    /*
    insert into pren (convocatoria_id, conv__id, version, pren__id, prentipo, prennmro, prenprgn, prenvlrc, prenpstv, prenngtv) values


insert into pren (convocatoria_id, conv__id, version, pren__id, prentipo, prennmro, prenprgn, prenvlrc, prenpstv, prenngtv) values (1,1, 0, 1 , 'Valoracion' , 1 , 'Expresión y comunicación' , 'Observe y valore como positivo si durante la entrevista se ha expresado con respeto, claridad, elocuencia, tranquilidad, firmeza y ha sido fácil comprender lo que indica.' , 0.25 , 0 );
insert into pren (convocatoria_id, conv__id, version, pren__id, prentipo, prennmro, prenprgn, prenvlrc, prenpstv, prenngtv) values (1,1, 0, 2 , 'Valoracion' , 2 , 'Presentación personal' , 'Se valora como positivo si se observa aseo personal.' , 0.25 , 0 );
insert into pren (convocatoria_id, conv__id, version, pren__id, prentipo, prennmro, prenprgn, prenvlrc, prenpstv, prenngtv) values (1,1, 0, 3 , 'Valoracion' , 3 , 'Verificacion de titulo original ( SENECYT)' , 'Se valora con 0,50 puntos a la verificacion que se haga del titulo universitario' , 0,50. , 0 );
insert into pren (convocatoria_id, conv__id, version, pren__id, prentipo, prennmro, prenprgn, prenvlrc, prenpstv, prenngtv) values (1,1, 0, 4 , 'Entrevista con puntaje' , 1 , '¿Le aburre hacer el mismo trabajo una y otra vez?' , 'Se aburre. Le gusta innovar, crear, hacer cosas diferentes con fines determinados' , 0.25 , 0 );
insert into pren (convocatoria_id, conv__id, version, pren__id, prentipo, prennmro, prenprgn, prenvlrc, prenpstv, prenngtv) values (1,1, 0, 5 , 'Entrevista con puntaje' , 2 , '¿Le gusta trabajar con otras personas?' , 'Que si le gusta compartir con otras personas, socializar, comunicarse, dialogar, trabajar en equipo' , 0.25 , 0 );
insert into pren (convocatoria_id, conv__id, version, pren__id, prentipo, prennmro, prenprgn, prenvlrc, prenpstv, prenngtv) values (1,1, 0, 6 , 'Entrevista sin puntaje' , 3 , '¿Se aburre con los detalles?' , 'Que le gusta fijarse en los detalles, es meticuulosa, y perseverante.' , 0 , 0 );
insert into pren (convocatoria_id, conv__id, version, pren__id, prentipo, prennmro, prenprgn, prenvlrc, prenpstv, prenngtv) values (1,1, 0, 7 , 'Entrevista con puntaje' , 4 , '¿Cómo encara usted las tareas que le disgustan?' , 'Que lo hace con disposición y tratando de hacerlo bien. Enfrentandolo como un reto.' , 0.25 , 0 );
insert into pren (convocatoria_id, conv__id, version, pren__id, prentipo, prennmro, prenprgn, prenvlrc, prenpstv, prenngtv) values (1,1, 0, 8 , 'Entrevista sin puntaje' , 5 , '¿Cuál es su idea sobre el éxito?' , 'Que es superación personal, profesional, familiar. Lograr los objetivos propuestos. Ser feliz.' , 0 , 0 );
insert into pren (convocatoria_id, conv__id, version, pren__id, prentipo, prennmro, prenprgn, prenvlrc, prenpstv, prenngtv) values (1,1, 0, 9 , 'Entrevista con puntaje' , 6 , '¿Qué tipo de personas le desagradan?' , 'Quienes no tengan una actitud positiva, propositiva, que construya relaciones interpersonales.' , 0.25 , 0 );
insert into pren (convocatoria_id, conv__id, version, pren__id, prentipo, prennmro, prenprgn, prenvlrc, prenpstv, prenngtv) values (1,1, 0, 10 , 'Entrevista con puntaje' , 7 , '¿Cuál es el problema más difícil de comunicación que haya tenido con sus colegas?' , 'Que tiene claridad en cuanto a la importancia de la comunicación y menciona acciones que promuevan una comunicación interpersonal.' , 0.25 , 0 );
insert into pren (convocatoria_id, conv__id, version, pren__id, prentipo, prennmro, prenprgn, prenvlrc, prenpstv, prenngtv) values (1,1, 0, 11 , 'Entrevista con puntaje' , 8 , 'Si pudiera hacer otra cosa. ¿Qué haría?' , 'Trabajo con niños, niñas, familias o comunidad' , 0.25 , 0 );
insert into pren (convocatoria_id, conv__id, version, pren__id, prentipo, prennmro, prenprgn, prenvlrc, prenpstv, prenngtv) values (1,1, 0, 12 , 'Entrevista con puntaje' , 9 , '¿Qué ha aprendido de sus errores?' , 'Una enseñanza importante para su vida, si se muestra sinsera, sin mayor discurso.' , 0.25 , 0 );
insert into pren (convocatoria_id, conv__id, version, pren__id, prentipo, prennmro, prenprgn, prenvlrc, prenpstv, prenngtv) values (1,1, 0, 13 , 'Entrevista sin puntaje' , 11 , '¿Prefiere trabajar con números o con palabras?' , 'Que prefiere trabajar con palabras o directamente con las personas.' , 0 , 0 );
insert into pren (convocatoria_id, conv__id, version, pren__id, prentipo, prennmro, prenprgn, prenvlrc, prenpstv, prenngtv) values (1,1, 0, 14 , 'Entrevista con puntaje' , 12 , '¿Qué hace cuando tiene dificultades para resolver un problema?' , 'Que solicita apoyo a otras personas, reconociendo sus capacidades, puede indicar que es perseverante o que no huye de los problemas y los enfrenta.' , 0.5 , 0 );
insert into pren (convocatoria_id, conv__id, version, pren__id, prentipo, prennmro, prenprgn, prenvlrc, prenpstv, prenngtv) values (1,1, 0, 15 , 'Entrevista sin puntaje' , 13 , '¿Qué haría si en un momento todas las personas de su departamento se reportaran enfermas?' , 'Que cubriría en lo posible las actividades de otras personas dependiendo de la prioridad, que solicitaría ayuda a otras personas o dependencia para cubrir los requerimientos más prioritarios o que haría todo lo posible para atender a los diferentes procesos.' , 0 , 0 );
insert into pren (convocatoria_id, conv__id, version, pren__id, prentipo, prennmro, prenprgn, prenvlrc, prenpstv, prenngtv) values (1,1, 0, 16 , 'Entrevista con puntaje' , 17 , '¿Con qué grupos de edad de niños le gustaría trabajar?' , 'Que refiere trabajar con niños y niñas de 0 a 3 años de edad o hasta 5 años.' , 1 , 0 );
insert into pren (convocatoria_id, conv__id, version, pren__id, prentipo, prennmro, prenprgn, prenvlrc, prenpstv, prenngtv) values (1,1, 0, 17 , 'Entrevista con puntaje' , 18 , '¿Cree estar totalmente preparada para el trabajo con niños y niñas menores de 3 años?' , 'Que no está preparada totalmente y que es necesario investigar, capacitarse aunque tenga un título que avala su preparación' , 0.25 , 0 );
insert into pren (convocatoria_id, conv__id, version, pren__id, prentipo, prennmro, prenprgn, prenvlrc, prenpstv, prenngtv) values (1,1, 0, 18 , 'Entrevista con puntaje' , 20 , '¿Podría trabajar fuera del horario de labores?' , 'Que es posible siempre y lo que requeriría es organizarse.' , 0.5 , 0 );
insert into pren (convocatoria_id, conv__id, version, pren__id, prentipo, prennmro, prenprgn, prenvlrc, prenpstv, prenngtv) values (1,1, 0, 19 , 'Entrevista con puntaje' , 21 , '¿Le gusta trabajar a presión?' , 'Que si le gusta o que puede manejar varias acciones, actividades y que el resultado es positivo.' , 1 , 0 );
insert into pren (convocatoria_id, conv__id, version, pren__id, prentipo, prennmro, prenprgn, prenvlrc, prenpstv, prenngtv) values (1,1, 0, 20 , 'Entrevista con puntaje' , 22 , '¿Le gusta trabajar con familias? ¿lo ha hecho? ¿de qué manera?' , 'Si le gusta, ha trabajado con ellas promoviendo su desarrollo como personas, profesionales, en los roles de familia, sobre derechos, o en temas o procesos que denoten superación.' , 1 , 0 );
insert into pren (convocatoria_id, conv__id, version, pren__id, prentipo, prennmro, prenprgn, prenvlrc, prenpstv, prenngtv) values (1,1, 0, 21 , 'Entrevista con puntaje' , 23 , '¿Le gusta trabajar con actores comunitarios? ¿lo ha hecho? ¿de qué manera?' , 'Si le gusta, ha trabajado con ellos promoviendo su desarrollo como personas, profesionales o en su rol dentro de la comunidad, trabajando sobre derechos, o en temas o procesos que denoten superación de la comunidad.' , 0.25 , 0 );
insert into pren (convocatoria_id, conv__id, version, pren__id, prentipo, prennmro, prenprgn, prenvlrc, prenpstv, prenngtv) values (1,1, 0, 22 , 'Entrevista con puntaje' , 24 , '¿Ha realizado actividades de coordinación intersectorial?' , 'Que si lo ha hecho, puede haber participado o generado esta articulación.' , 0.25 , 0 );
insert into pren (convocatoria_id, conv__id, version, pren__id, prentipo, prennmro, prenprgn, prenvlrc, prenpstv, prenngtv) values (1,1, 0, 23 , 'Entrevista con puntaje' , 26 , '¿Tendría algún inconveniente en trabajar con grupos de personas adultas?' , 'Que no tiene ningún problema. Que le gusta, que ha tenido experiencia' , 0.25 , 0 );
insert into pren (convocatoria_id, conv__id, version, pren__id, prentipo, prennmro, prenprgn, prenvlrc, prenpstv, prenngtv) values (1,1, 0, 24 , 'Entrevista con puntaje' , 27 , 'Si una persona adulta tiene dificultad en comprender el mensaje que usted le indica, ¿qué hace?' , 'Busca otras formas de explicarle ya que el objetivo es que la otra persona comprenda. No se da porvencida' , 0.25 , 0 );
insert into pren (convocatoria_id, conv__id, version, pren__id, prentipo, prennmro, prenprgn, prenvlrc, prenpstv, prenngtv) values (1,1, 0, 25 , 'Entrevista con puntaje' , 28 , 'El trabajo es en los sectores, requiere trasladarse de una vivienda a otra, ¿requeriría usted transporte para realizar el trabajo?' , 'Que no requeriría ya que le gusta caminar.' , 0.5 , 0 );
insert into pren (convocatoria_id, conv__id, version, pren__id, prentipo, prennmro, prenprgn, prenvlrc, prenpstv, prenngtv) values (1,1, 0, 26 , 'Entrevista con puntaje' , 29 , '¿Usted estaría dispuesta a caminar lo que se necesite aunque los estados del tiempo sean cambiantes y las distancias sean considerables?' , 'Que no habría ningún problema ya que le gusta caminar y los estados del clima no impedirían ejecutar su trabajo' , 1 , 0 );
insert into pren (convocatoria_id, conv__id, version, pren__id, prentipo, prennmro, prenprgn, prenvlrc, prenpstv, prenngtv) values (1,1, 0, 27 , 'Entrevista con puntaje' , 30 , 'Tiene algún inconveniente en su salud que le impida caminar largas distancias o permanecer bajo los estados cambiantes del clima?' , 'Que no tiene ningún problema de salud.' , 0.5 , 0 );



    
     */

}
