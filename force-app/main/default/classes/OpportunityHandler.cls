public with sharing class OpportunityHandler {
    public static void crearNegociosDesdeOportunidadesCerradas (List <Opportunity> newOpps, Map <Id, Opportunity> oldOppsMap) {
        Set <Opportunity> closedOpps = new Set <Opportunity> ();
        for (Opportunity curOpp : newOpps) {
            if (oldOppsMap.containsKey(curOpp.Id)) {
                String oldOppStage = oldOppsMap.get(curOpp.Id).StageName;
                if (curOpp.StageName != oldOppStage && (curOpp.StageName == 'Closed Won' || curOpp.StageName == 'Closed Lost')) { closedOpps.add(curOpp); }
            }
        }
        List <Negocio__c> newNegocios = new List <Negocio__c> ();
        for (Opportunity curOpp : closedOpps) {
            Negocio__c curNegocio = new Negocio__c();
            curNegocio.Name = curOpp.Name;
            curNegocio.Account__c = curOpp.AccountId;
            curNegocio.Tipo_de_Negocio__c = (curOpp.StageName == 'Closed Won') ? 'Ganada' : 'Perdida';
            curNegocio.Monto_Total_Ganado__c = curOpp.Account.Monto_Total_Oportunidades_Ganadas__c;
            curNegocio.Monto_Total_Perdido__c = curOpp.Account.Monto_Total_Oportunidades_Perdidas__c;
            newNegocios.add(curNegocio);
        }
        insert newNegocios;        
    }
}