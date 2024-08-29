public with sharing class OpportunityHandler {
    public static void iniciar (List <Opportunity> nuevo, Map <Id, Opportunity> viejo) {
        System.debug('Esto es un inicio');
        Set <Opportunity> validas = new Set <Opportunity> ();
        for (Opportunity opp : nuevo) {
            if (viejo.containsKey(opp.Id)) {
                String estado2 = viejo.get(opp.Id).StageName;
                if (opp.StageName != estado2 && (opp.StageName == 'Closed Won' || opp.StageName == 'Closed Lost')) { validas.add(opp); }
            }
        }
        List <Negocio__c> sets = new List <Negocio__c> ();
        for (Opportunity opp2 : validas) {
            Negocio__c val = new Negocio__c();
            val.Account__c = opp2.AccountId; //Acc.Id
            val.Tipo_de_Negocio__c = (opp2.StageName == 'Closed Won') ? 'Ganada' : 'Perdida'; //Ganado o Perdido según la Opp.StageName
            val.Monto_Total_Ganado__c = opp2.Account.Monto_Total_Oportunidades_Ganadas__c; //Acc.
            val.Monto_Total_Perdido__c = opp2.Account.Monto_Total_Oportunidades_Perdidas__c;
            sets.add(val);
        }
        insert sets;        
    }
}