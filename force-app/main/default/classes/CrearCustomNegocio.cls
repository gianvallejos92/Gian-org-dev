/**
 * Creación de negocios desde las oportunidades que han sido cerradas en el trigger.
 * @author Gian Vallejos
 * @version 1.1 - 30/08/2024 - Buenas prácticas de código limpio aplicadas.
 * @since 1.0 - 29/08/2024 - Primera versión sin buenas prácticas de programación
 */
public with sharing class CrearCustomNegocio {

    /**
     * Método principal, llamado desde la clase OpportunityHandler para crear negocios a partir de las oportunidades cerradas.
     * @param newOpss: Oportunidades con valores actuales
     * @param oldOppsMap: Valores de la Oportunidad antes de actualizar
     */
    public static void crearNegociosDesdeOportunidadesCerradas (List <Opportunity> newOpps, Map <Id, Opportunity> oldOppsMap) {       
        Set <Opportunity> closedOpps = obtenerOportunidadesCerradas(newOpps, oldOppsMap);
        List <Negocio__c> newNegocios = crearNegociosDesdeOportunidades(closedOpps);         
        UtilityClass.insertarListasDeNegocios(newNegocios);
    }

    /**
     * Obtiene las oportunidades que han sido cerradas en el trigger
     * @param newOpss: Oportunidades con valores actuales
     * @param oldOppsMap: Valores de la Oportunidad antes de actualizar
     * @return Conjunto de las oportunidades que han sido modificadas al estado "Closed Won" o "Closed Lost"
     */
    private static Set <Opportunity> obtenerOportunidadesCerradas(List <Opportunity> newOpps, Map <Id, Opportunity> oldOppsMap) {
        Set <Opportunity> closedOpps = new Set <Opportunity> ();
        for (Opportunity curOpp : newOpps) {
            if (oldOppsMap.containsKey(curOpp.Id)) {
                String oldOppStage = oldOppsMap.get(curOpp.Id).StageName;
                if (
                    curOpp.StageName != oldOppStage && 
                    UtilityClass.esOportunidadCerrada(curOpp.StageName)
                ) { 
                    closedOpps.add(curOpp); 
                }
            }
        }
        return closedOpps;
    }

    /**
     * Prepara una lista de Negocios a partir de los datos de la Oportunidad
     * @param closedOpps: Conjunto de Oportunidades que han sido cerradas en el trigger.
     * @return Lista de Negocios a insertar en base de datos
     */
    private static List <Negocio__c> crearNegociosDesdeOportunidades (Set <Opportunity> closedOpps) {
        List <Negocio__c> newNegocios = new List <Negocio__c> ();
        for (Opportunity curOpp : closedOpps) {
            Negocio__c curNegocio = new Negocio__c();
            curNegocio.Name = curOpp.Name;
            curNegocio.Account__c = curOpp.AccountId;
            curNegocio.Tipo_de_Negocio__c = obtenerEstadoDeNegocioDesdeOportunidad(curOpp.StageName);
            curNegocio.Monto_Total_Ganado__c = curOpp.Cuenta_Total_Ganadas__c;
            curNegocio.Monto_Total_Perdido__c = curOpp.Cuenta_Total_Perdidas__c;
            newNegocios.add(curNegocio);
        }
        return newNegocios;
    }

    /**
     * Verifica que el estado de la oportunidad sea "Closed Won" para enviar el valor del picklist de Negocio__c.Tipo_de_Negocio__c
     * @param StageName: Estado de la oportunidad actual
     * @return 'Ganada' si la oportunidad tiene el estado "Closed Won", 'Perdida' en caso contrario
     */
    private static String obtenerEstadoDeNegocioDesdeOportunidad(String StageName) {
        return (StageName == UtilityClass.OPP_CLOSED_WON_STATUS) ? UtilityClass.NEGOCIO_TIPO_GANADO : UtilityClass.NEGOCIO_TIPO_PERDIDO;
    }
}