trigger OpportunityTriggerHandler on Opportunity (before insert, before update, after insert, after update) {
  if (Trigger.isAfter && Trigger.isUpdate) {      
    OpportunityHandler.iniciar(Trigger.New, Trigger.OldMap);
  }
}