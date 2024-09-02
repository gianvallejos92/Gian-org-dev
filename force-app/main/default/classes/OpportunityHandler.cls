public with sharing class OpportunityHandler {
    public static void crearNegociosDesdeOportunidadesCerradas (List <Opportunity> newOpps, Map <Id, Opportunity> oldOppsMap) {
        Set <Opportunity> closedOpps = obtenerOportunidadesCerradas(newOpps, oldOppsMap);
        List <Negocio__c> newNegocios = crearNegociosDesdeOportunidades(closedOpps); 
        insert newNegocios;
    }

    private static void obtenerOportunidadesCerradas(List <Opportunity> newOpps, Map <Id, Opportunity> oldOppsMap) {
        Set <Opportunity> closedOpps = new Set <Opportunity> ();
        for (Opportunity curOpp : newOpps) {
            if (oldOppsMap.containsKey(curOpp.Id)) {
                String oldOppStage = oldOppsMap.get(curOpp.Id).StageName;
                if (curOpp.StageName != oldOppStage && esOportunidadCerrada(curOpp.StageName)) { 
                    closedOpps.add(curOpp);
                }
            }
        }
        return closedOpps;
    }

    private static boolean esOportunidadCerrada (String StageName) {
        return (StageName == 'Closed Won' || StageName == 'Closed Lost');
    }

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

    private static boolean obtenerEstadoDeNegocioDesdeOportunidad(String StageName) {
        return (StageName == 'Closed Won') ? 'Ganada' : 'Perdida';
    }
}