/**
 * Clase Handler del trigger OpportunityTriggerHandler. Hasta el momento, sólo incluye el método OnAfterUpdate.
 * @author Gian Vallejos
 * @version 1.1 - 30/08/2024 - Buenas prácticas de código limpio aplicadas.
 * @since 1.0 - 29/08/2024 - Primera versión sin buenas prácticas de programación
 */
public with sharing class OpportunityHandler {

    /** Crea negocios desde las oportunidades que han sido cerradas en el trigger
     * @param newOpps Lista de oportunidades nuevas
     * @param oldOppsMap Mapa de oportunidades antiguas
     */
    public static void OnAfterUpdate (List <Opportunity> newOpps, Map <Id, Opportunity> oldOppsMap) {
        CrearCustomNegocio.crearNegociosDesdeOportunidadesCerradas(newOpps, oldOppsMap);
    }

}