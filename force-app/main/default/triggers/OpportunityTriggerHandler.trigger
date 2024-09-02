trigger OpportunityTriggerHandler on Opportunity (before insert, before update, after insert, after update) {
  if (Trigger.isAfter) {
    if (Trigger.isUpdate) {      
      OpportunityHandler.OnAfterUpdate(Trigger.New, Trigger.OldMap);
    }
  }
}