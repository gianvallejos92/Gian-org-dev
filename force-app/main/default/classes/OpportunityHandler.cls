/**
 * Class OpportunityHandler
 * @description Trigger on Opportunity
 * @author: Gian Vallejos
 * @date: 29-08-2024
 * v.1. - Gian Vallejos
 * 
 */
public with sharing class OpportunityHandler {
    private static String CLOSED_WON_STATUS = 'Closed Won';
    private static String CLOSED_LOST_STATUS = 'Closed Lost';

    /**
     * Método principal, llamado desde el TriggerHandler de Oportunidad para crear un negocio al cerrar oportunidades
     * @param newOpss: Oportunidades con valores actuales
     * @param oldOppsMap: Valores de la Oportunidad antes de actualizar
     */
    public static void crearNegociosDesdeOportunidadesCerradas (List <Opportunity> newOpps, Map <Id, Opportunity> oldOppsMap) {       
        Set <Opportunity> closedOpps = obtenerOportunidadesCerradas(newOpps, oldOppsMap);
        crearNegociosDesdeOportunidades(closedOpps); 
    }

    /**
     * Obtiene las oportunidades que han sido cerradas en la transacción del trigger Opportunity
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
                    esOportunidadCerrada(curOpp.StageName)
                ) { 
                    closedOpps.add(curOpp); 
                }
            }
        }
        return closedOpps;
    }

    private static boolean esOportunidadCerrada(String StageName) {
        return (StageName == CLOSED_WON_STATUS || StageName == CLOSED_LOST_STATUS);
    }

    private static void crearNegociosDesdeOportunidades (Set <Opportunity> closedOpps) {
        List <Negocio__c> newNegocios = new List <Negocio__c> ();
        for (Opportunity curOpp : closedOpps) {
            Negocio__c curNegocio = new Negocio__c();
            curNegocio.Account__c = curOpp.AccountId;
            curNegocio.Tipo_de_Negocio__c = obtenerEstadoDeNegocioDesdeOportunidad(curOpp.StageName);
            curNegocio.Monto_Total_Ganado__c = curOpp.Account.Monto_Total_Oportunidades_Ganadas__c;
            curNegocio.Monto_Total_Perdido__c = curOpp.Account.Monto_Total_Oportunidades_Perdidas__c;
            newNegocios.add(curNegocio);
        }
        insertarListasDeNegocios(newNegocios);
    }

    private static String obtenerEstadoDeNegocioDesdeOportunidad(String StageName) {
        return (StageName == CLOSED_WON_STATUS) ? 'Ganada' : 'Perdida';
    }

    private static void insertarListasDeNegocios (List <Negocio__c> newNegocios) {
        try {
            insert newNegocios;  
        } catch (Exception ex) {
            System.debug('Ocurrió un error: ' + ex);
        }
    }
}