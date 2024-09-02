public with sharing class OpportunityHandler {
    public static void OnAfterUpdate (List <Opportunity> newOpps, Map <Id, Opportunity> oldOppsMap) {
        CrearCustomNegocio.crearNegociosDesdeOportunidadesCerradas(newOpps, oldOppsMap);
    }
}