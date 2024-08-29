trigger OpportunityTriggerHandler on Opportunity (before insert, before update, after insert, after update) {
  if (Trigger.isAfter && Trigger.isUpdate) {      
    OpportunityHandler.crearNegociosDesdeOportunidadesCerradas(Trigger.New, Trigger.OldMap);
  }
}